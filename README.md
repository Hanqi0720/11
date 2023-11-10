# Speech Emotion Recognition Using Spectrograms with CNN-LSTM

## Overview
This project aims to recognize emotions from speech using spectrograms analyzed by a combined Convolutional Neural Network (CNN) and Long Short-Term Memory (LSTM) approach. It includes MATLAB scripts for generating spectrograms from audio data and a deep learning model for emotion classification.

## Prerequisites
Before you begin, ensure you have met the following requirements:
- MATLAB (version R20XX or newer)
- Signal Processing Toolbox
- Deep Learning Toolbox

## Files Description
- `Spectrogram.m`: This script generates spectrograms from audio files provided in the `CASIA_dataset`.
- `CNN_LSTM.m`: This script contains the CNN-LSTM model that is used to classify emotions based on the spectrograms.

## Getting Started
To get a local copy up and running, follow these simple steps:
1. Clone the repository to your local machine:
   ```shell
   git clone https://github.com/Hanqi0720/Speech Emotion Recognition.git
(A shorter version of the spectrogram function accomplishes the same thing)
Navigate to the directory where you cloned the repository.

Run the Spectrogram.m script to generate spectrograms. Ensure you have the CASIA_dataset directory in the same directory as the script.

After generating spectrograms, run the CNN_LSTM.m script to train and evaluate the emotion recognition model.

Usage
Use Spectrogram.m to generate spectrograms from .wav files.
Use CNN_LSTM.m to train the emotion recognition model with the generated spectrograms.
Contributing
Contributions to improve the project are welcome. Feel free to fork the repository and create a pull request.

License
Distributed under the MIT License. See LICENSE for more information.
