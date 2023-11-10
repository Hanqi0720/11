
%% Parameter Setting
fs = 16000;  % Sampling rate
window_size = 256;  % Size of the window for spectrogram
noverlap_size = 128;  % Number of overlapping samples in spectrogram
nfft_size = 512;  % Number of FFT points for spectrogram
min_freq = 0;  % Minimum frequency for spectrogram
max_freq = fs/2;  % Maximum frequency for spectrogram
color_map = jet(256);  % Color map for spectrogram images
image_size = [224, 224];  % Size of the saved spectrogram images
emotions = {'angry', 'fear', 'happy', 'neutral', 'sad', 'surprise'};  % Emotion categories
input_folder = 'CASIA_dataset';  % Folder containing audio files
output_folder = 'Spectrograms';  % Folder to save spectrogram images

%% Batch Generation of Spectrograms
mkdir(output_folder);
for i = 1:length(emotions)
    emotion = emotions{i};
    generateSpectrograms(emotion, input_folder, output_folder, fs, window_size, noverlap_size, nfft_size, min_freq, max_freq, color_map, image_size);
end

function generateSpectrograms(emotion, input_folder, output_folder, fs, window_size, noverlap_size, nfft_size, min_freq, max_freq, color_map, image_size)
    % Construct input and output paths
    input_path = fullfile(input_folder, emotion);
    output_path = fullfile(output_folder, emotion);
    mkdir(output_path);

    % Get the list of audio files
    file_list = dir(fullfile(input_path, '*.wav'));
    num_files = length(file_list);

    % Define the window function for spectrogram
    window = hann(window_size);
    
    % Process each audio file
    for i = 1:num_files
        % Read the audio file
        [x, fs] = audioread(fullfile(file_list(i).folder, file_list(i).name));
        
        % Calculate the spectrogram
        [S, F, ~] = spectrogram(x, window, noverlap_size, nfft_size, fs);
        S = abs(S);
        S = S(max_freq>=F & F>=min_freq, :);
        
        % Convert the magnitude spectrogram to decibels
        S = 20*log10(S + eps);
        
        % Normalize the spectrogram values to the range [0, 255]
        S = (S - min(S(:))) / (max(S(:)) - min(S(:))) * 255;
        
        % Convert the spectrogram to a RGB image
        S = ind2rgb(round(S), color_map);
        
        % Resize the image
        S = imresize(S, image_size);
        
        % Save the image
        imwrite(S, fullfile(output_path, [emotion num2str(i) '.png']));
    end
    fprintf('%s processing completed\n', emotion);
end
