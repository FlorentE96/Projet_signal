clc;
clear;
close all;
load('Contour_ground_truth_00001.mat');
% --------------------- Signal generation ------------------
[sample, Fs] = audioread('00001.wav');
% -------------------------- Variables ---------------------
trim_time = 5*Fs; % trimming time in seconds
Ts = 1/Fs;
sample_trim = sample(1*Fs:trim_time); % first 3 seconds of sound (skip silence at beginning)
win_length = 256/Fs;
win_sz = floor(Fs * win_length);
[freq, seg] = pitchContour(sample_trim, Fs, win_length);

freq = normalise(freq);
freq_true = normalise(freq_true);

time_axis = 0:win_sz*Ts:(length(freq)-1)*win_sz*Ts;
time_axis_sig = 0:Ts:(length(sample_trim)-1)*Ts;
figure(1),
subplot(2,1,1);
hold on
plot(time_axis,freq)
%legend('contour of hummed query');
%stem(time_axis, seg.*300)
%ylim([80 200]);
plot(time_axis_true, freq_true)
legend('contour of hummed query','ground truth');
title('contour extraction, win\_size = 32ms ; amp\_thres = 0.65');
subplot(2,1,2);
% hold on
plot(time_axis_sig, sample_trim);
title('query signal');
% plot(time_axis_sig_true, sample_trim_true, 'r');