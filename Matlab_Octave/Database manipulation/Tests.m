clc;
clear;
close all;
[sample, Fs] = audioread('00001.wav');
sample = sample(1*Fs:end);

win_length = 70e-3;
win_sz = 256;%floor(Fs * win_length);
[freq, seg] = pitchContour(sample, Fs, 32e-3);

data=load('00001.pv');
data=data(30:end);
%GT = readmidi('00001.mid');
subplot(2,1,1)
plot(data);
subplot(2,1,2)
plot(freq);