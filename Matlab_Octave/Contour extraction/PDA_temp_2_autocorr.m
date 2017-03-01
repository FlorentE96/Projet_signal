%% Extracts the contour of a sound signal.
clear; clc; close all;
load('matlab.mat');
% --------------------- Signal generation ------------------
[sample, Fs] = audioread('Pange_Lingua_midi_vow.wav');
% -------------------------- Variables ---------------------
Ts = 1/Fs;
trim_time = 6*Fs; % trimming time in seconds
sample_trim = sample(1:trim_time); % first 3 seconds of sound (skip silence at beginning)
thres_t1 = 1/80*Fs; % 80 Hz
thres_t2 = 1/1500*Fs; % 1500 Hz
thres_amp = 0.4;
win_sz = floor(Fs * 100e-3);%:floor(Fs * 10e-3) :floor(Fs * 50e-3);

%% ############ Methode 2 : self-correlation ##############
win_index=1;
freq_true(1)=0;

    clear freq
    for win_index=1:win_sz(1):length(sample_trim)-win_sz(1)
      [scorr, lag] = xcorr(sample_trim(win_index:win_index+win_sz(1)), 'unbiased'); % compute self-corr
      scorr = abs(scorr)./abs(scorr(lag==0)); % normalize
      scorr(lag<thres_t2)=0; % | time thresholds
      scorr(lag>thres_t1)=0; % |
      n=ceil(win_index/win_sz(1)); % normalized index of the windows
      [peaks, peaks_indices] = findpeaks(scorr); % detect the peaks of the self-corr function
      if (length(peaks_indices) > 1)
          seg(n) = peaks(2)<thres_amp; % detect transient
          freq_true(n) = 1 / (lag(peaks_indices(2)) / Fs); % measure frequency
      else
          freq_true(n) = 0;
%           if(length(freq)>1)
%               freq(n)=freq(n-1);
%           else
%               freq(n)=0;
%           end
      end
    end
%%
clear sample, 
clear Fs, 
clear sample_trim
% --------------------- Signal generation ------------------
[sample, Fs] = audioread('Pange_Lingua.wav');
% -------------------------- Variables ---------------------
Ts = 1/Fs;
trim_time = 5*Fs; % trimming time in seconds
sample_trim = sample(1:trim_time); % first 3 seconds of sound (skip silence at beginning)
thres_t1 = 1/80*Fs; % 80 Hz
thres_t2 = 1/1000*Fs; % 1500 Hz
thres_amp = 0.3;

%% ############ Methode 2 : self-correlation ##############
win_index=1;
freq(1)=0;

for i=1:1:length(win_sz)
    clear freq
    for win_index=1:win_sz(i):length(sample_trim)-win_sz(i)
      [scorr, lag] = xcorr(sample_trim(win_index:win_index+win_sz(i)), 'unbiased'); % compute self-corr
      scorr = abs(scorr)./abs(scorr(lag==0)); % normalize
      scorr(lag<thres_t2)=0; % | time thresholds
      scorr(lag>thres_t1)=0; % |
      n=ceil(win_index/win_sz(i)); % normalized index of the windows
      [peaks, peaks_indices] = findpeaks(scorr); % detect the peaks of the self-corr function
      if (length(peaks_indices) > 1)
          seg(n) = peaks(2)<thres_amp; % detect transient
          freq(n) = 1 / (lag(peaks_indices(2)) / Fs); % measure frequency
      else
          freq(n) = 0;
%           if(length(freq)>1)
%               freq(n)=freq(n-1);
%           else
%               freq(n)=0;
%           end
      end
    end
    time_axis1 = 0:win_sz(i)*Ts:n*win_sz(i)*Ts-win_sz(i)*Ts;
    time_axis2 = 0:Ts:(length(sample_trim)-1)*Ts;
    win_size_true = floor(Fs * 30e-3);
    size_true = length(freq_true)/win_size_true;
    time_axis3 = 0:win_size_true*Ts:(length(freq_true)-1)*win_size_true*Ts;
    figure(1),
    subplot(2,1,1);
    hold on
    plot(time_axis1,freq)
    %plot(time_axis1, seg.*500)
    plot(time_axis3, freq_true)
    subplot(2,1,2);
    plot(time_axis2, sample_trim);
end