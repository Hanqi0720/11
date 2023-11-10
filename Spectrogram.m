%% Generate a Spectrogram for the First Signal
clear;clc;
[y,fs] = audioread('CASIA_dataset/angry/angry (1).wav');%Read the audio file
frame_size = 0.025; % Frame size of 25 ms
frame_shift = 0.01; % Frame shift of 10 ms
frame_matrix = buffer(y, frame_size*fs, frame_shift*fs);  % Frame blocking
% Apply Hamming window
window = hamming(size(frame_matrix, 1));
frame_matrix = frame_matrix.*window;
% Short-Time Fourier Transform (STFT)
NFFT = 2^nextpow2(frame_size*fs);
STFT = fft(frame_matrix, NFFT, 1);
STFT = abs(STFT(1:NFFT/2+1,:));
% Plot the Spectrogram
figure;
spectrogram(y, window, frame_shift*fs, NFFT, fs, 'yaxis');
title('Spectrogram of the First Signal');

%% Batch Generate Spectrograms
clear;clc;
% Create directories for saving the spectrograms
mkdir Spectrogram; 
mkdir Spectrogram/angry; mkdir Spectrogram/fear; mkdir Spectrogram/happy; 
mkdir Spectrogram/neutral; mkdir Spectrogram/sad; mkdir Spectrogram/surprise;
% Set parameters
fs = 16000;  % Sampling rate
window = hann(256);  % Window function
noverlap = 128;  % Overlapping window length
nfft = 512;  % FFT length
min_freq = 0;  % Minimum frequency
max_freq = fs/2;  % Maximum frequency
color_map = jet(256);  % Color map
%% Process for each emotion category
%% angry
file_list = dir('CASIA_dataset/angry/*.wav');
num_files = length(file_list);
% Loop through each file
for i = 1:num_files
    % Reading voice files
    [x, fs] = audioread(file_list(i).name);

    % Generate Spectrograms
    [S, F, T] = spectrogram(x, window, noverlap, nfft, fs);
    S = abs(S);
    S = S(max_freq>=F & F>=min_freq, :);
    S = 20*log10(S+eps);
    S = (S - min(S(:))) / (max(S(:)) - min(S(:))) * 255;
    % Convert the spectrogram to a RGB image using color map
    S = ind2rgb(round(S), color_map);

    % Saved as 224*224*3 color images
    S = imresize(S, [224, 224]);
    % Save the image to the appropriate directory
    mulu = "Spectrogram/angry/";
    imwrite(S, fullfile(mulu,['angry' num2str(i) '.png']));
end

%% fear
file_list = dir('CASIA_dataset/fear/*.wav');
num_files = length(file_list);

% Loop through each file
for i = 1:num_files
    % Reading voice files
    [x, fs] = audioread(file_list(i).name);

    % Generate Spectrograms
    [S, F, T] = spectrogram(x, window, noverlap, nfft, fs);
    S = abs(S);
    S = S(max_freq>=F & F>=min_freq, :);
    S = 20*log10(S+eps);
    S = (S - min(S(:))) / (max(S(:)) - min(S(:))) * 255;
    S = ind2rgb(round(S), color_map);

    % Saved as 224*224*3 color images
    S = imresize(S, [224, 224]);
    mulu = "Spectrogram/fear/";
    imwrite(S, fullfile(mulu,['fear' num2str(i) '.png']));
end

%% happy
file_list = dir('CASIA_dataset/happy/*.wav');
num_files = length(file_list);

% Loop through each file
for i = 1:num_files
    % Reading voice files
    [x, fs] = audioread(file_list(i).name);

    % Generate Spectrograms
    [S, F, T] = spectrogram(x, window, noverlap, nfft, fs);
    S = abs(S);
    S = S(max_freq>=F & F>=min_freq, :);
    S = 20*log10(S+eps);
    S = (S - min(S(:))) / (max(S(:)) - min(S(:))) * 255;
    S = ind2rgb(round(S), color_map);

    % Saved as 224*224*3 color images
    S = imresize(S, [224, 224]);
    mulu = "Spectrogram/happy/";
    imwrite(S, fullfile(mulu,['happy' num2str(i) '.png']));
end

%% neutral
file_list = dir('CASIA_dataset/neutral/*.wav');
num_files = length(file_list);

% Loop through each file
for i = 1:num_files
    % Reading voice files
    [x, fs] = audioread(file_list(i).name);

    % Generate Spectrograms
    [S, F, T] = spectrogram(x, window, noverlap, nfft, fs);
    S = abs(S);
    S = S(max_freq>=F & F>=min_freq, :);
    S = 20*log10(S+eps);
    S = (S - min(S(:))) / (max(S(:)) - min(S(:))) * 255;
    S = ind2rgb(round(S), color_map);

    % Saved as 224*224*3 color images
    S = imresize(S, [224, 224]);
    mulu = "Spectrogram/neutral/";
    imwrite(S, fullfile(mulu,['neutral' num2str(i) '.png']));
end

%% sad
file_list = dir('CASIA_dataset/sad/*.wav');
num_files = length(file_list);

% Loop through each file
for i = 1:num_files
    % Reading voice files
    [x, fs] = audioread(file_list(i).name);

    % Generate Spectrograms
    [S, F, T] = spectrogram(x, window, noverlap, nfft, fs);
    S = abs(S);
    S = S(max_freq>=F & F>=min_freq, :);
    S = 20*log10(S+eps);
    S = (S - min(S(:))) / (max(S(:)) - min(S(:))) * 255;
    S = ind2rgb(round(S), color_map);

    % Saved as 224*224*3 color images
    S = imresize(S, [224, 224]);
    mulu = "Spectrogram/sad/";
    imwrite(S, fullfile(mulu,['sad' num2str(i) '.png']));
end

%% surprise
file_list = dir('CASIA_dataset/surprise/*.wav');
num_files = length(file_list);

% Loop through each file
for i = 1:num_files
    % Reading voice files
    [x, fs] = audioread(file_list(i).name);

    % Generate Spectrograms
    [S, F, T] = spectrogram(x, window, noverlap, nfft, fs);
    S = abs(S);
    S = S(max_freq>=F & F>=min_freq, :);
    S = 20*log10(S+eps);
    S = (S - min(S(:))) / (max(S(:)) - min(S(:))) * 255;
    S = ind2rgb(round(S), color_map);

    % Saved as 224*224*3 color images
    S = imresize(S, [224, 224]);
    mulu = "Spectrogram/surprise/";
    imwrite(S, fullfile(mulu,['surprise' num2str(i) '.png']));
end

