clc;
clear;
close all;
load('ground_truth.mat');
% --------------------- Signal generation ------------------
[sample, Fs] = audioread('Pange_Lingua.wav');
% -------------------------- Variables ---------------------
Ts = 1/Fs;
trim_time = 5*Fs; % trimming time in seconds
sample_trim = sample(1:trim_time); % first 3 seconds of sound (skip silence at beginning)
thres_t1 = floor(1/50*Fs); % 80 Hz
thres_t2 = ceil(1/1000*Fs); % 1500 Hz
thres_amp = 0;
win_sz = floor(Fs * 70e-3);%:floor(Fs * 10e-3) :floor(Fs * 50e-3);
%% ############ Methode 2 : self(-correlation ##############
win_index=1;

for i=1:1:length(win_sz)
    clear freq
    for win_index=1:win_sz(i):length(sample_trim)-win_sz(i)
      [scorr, lag] = xcorr(sample_trim(win_index:win_index+win_sz(i)), 'biased'); % compute self-corr
      scorr = scorr./scorr(lag==0); % normalize
      
      [val_max, ind_max] = max(scorr(find(lag==thres_t2):find(lag==thres_t1)));
      ind_max = ind_max + find(lag==thres_t2);
      n=ceil(win_index/win_sz(i)); % normalized index of the windows

      seg(n) = val_max<thres_amp; % detect transient
      freq(n) = 1 / (lag(ind_max) / Fs); % measure frequency
    end
    
    time_axis = 0:win_sz(i)*Ts:n*win_sz(i)*Ts-win_sz(i)*Ts;
    time_axis_sig = 0:Ts:(length(sample_trim)-1)*Ts;
    figure(1),
    subplot(2,1,1);
    hold on
    plot(time_axis,freq)
    %legend('contour of hummed query');
    stem(time_axis, seg.*300)
    ylim([100 250]);
    plot(time_axis_true, freq_true)
    legend('contour of hummed query','segmentation of the hummed query','ground truth');
    title('contour extraction, win\_size = 70ms ; amp\_thres = 0.8');
    subplot(2,1,2);
    % hold on
    plot(time_axis_sig, sample_trim);
    title('query signal');
    % plot(time_axis_sig_true, sample_trim_true, 'r');
end