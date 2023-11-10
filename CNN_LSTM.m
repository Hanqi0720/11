clear;clc;

%% Load All Spectrograms
% Divide into training and testing sets
allImages = imageDatastore("Spectrograms2", ...
    'IncludeSubfolders', true, ...
    'LabelSource', 'foldernames'); % Load spectrogram images as an image datastore
% The imageDatastore function will automatically label the images based on folder names

rng default % For reproducibility, set the random seed to default value.
% Randomly split the images into two groups, 80% for training and the rest for validation.
[imgsTrain, imgsTest] = splitEachLabel(allImages, 0.8, 'randomized');

% Display the number of training, validation, and testing images
disp(['Number of training images: ', num2str(numel(imgsTrain.Files))]);
disp(['Number of testing images: ', num2str(numel(imgsTest.Files))]);

countEachLabel(imgsTrain) % Output the number of images per category in the training set
countEachLabel(imgsTest) % Output the number of images per category in the testing set

%% Build the CNN-LSTM Network
layers = [
    imageInputLayer([224 224 3], "Name", "imageinput")
    convolution2dLayer([5 5], 8, "Name", "conv1", "Padding", "same")
    reluLayer("Name", "relu1")
    maxPooling2dLayer([3 3], "Name", "maxpool1", "Stride", [2 2])
    convolution2dLayer([3 3], 16, "Name", "conv2")
    reluLayer("Name", "relu2")
    maxPooling2dLayer([3 3], "Name", "maxpool2", "Stride", [2 2])
    convolution2dLayer([3 3], 8, "Name", "conv3", "Padding", "same")
    reluLayer("Name", "relu3")
    maxPooling2dLayer([3 3], "Name", "maxpool3", "Stride", [2 2])
    flattenLayer("Name", "flatten")
    lstmLayer(200, "Name", "lstm1")
    lstmLayer(50, 'Name', 'lstm2')
    fullyConnectedLayer(6, "Name", "fc")
    softmaxLayer("Name", "softmax")
    classificationLayer("Name", "classoutput")];

analyzeNetwork(layers);

options = trainingOptions('sgdm', ... % Use Stochastic Gradient Descent with Momentum
    'ExecutionEnvironment', 'cpu', ... % Train on CPU, change to 'gpu' if available
    'MaxEpochs', 30, ... % Number of training epochs
    'MiniBatchSize', 10, ... % Size of mini-batch
    'Shuffle', 'once', ... % Shuffle the data only once
    'GradientThreshold', 1, ... % Gradient threshold
    'InitialLearnRate', 0.001, ... % Initial learning rate
    'Verbose', 1, ... % Display progress in command window
    'Plots', 'training-progress'); % Plot training progress

%% Start Training
CNN_LSTMnet = trainNetwork(imgsTrain, layers, options); % Train the network

% Save the trained model
% save trainedNet.mat CNN_LSTMnet;

%% Testing
y_pred = classify(CNN_LSTMnet, imgsTest); % Classify test images
Accuracy = mean(y_pred == imgsTest.Labels); % Calculate accuracy
disp(['Test set accuracy: ', num2str(100 * Accuracy), '%']);

%% Confusion Matrix
plotconfusion(imgsTest.Labels, y_pred, 'CNN-LSTM');
