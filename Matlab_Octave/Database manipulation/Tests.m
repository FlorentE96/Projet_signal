clear;
clc;
close all;
load('matlab_database.mat');

[sample, Fs] = audioread('00002.wav');
sample = sample(1*Fs:end);

win_length = 256;
win_sz = win_length/Fs;

[query, seg] = pitchContour(sample, Fs, win_sz);

query = normalise(query);

test = GT(2,:);
GT_trim = test(1:win_length:length(query)*win_length);


%%
figure,
plot(query);
hold on;
plot(GT_trim);