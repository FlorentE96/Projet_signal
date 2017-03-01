%% Extracts the contour of a sound signal.
clear; clc; close all;

% --------------------- Signal generation ------------------
%[sample, Fs] = audioread('Pange_Lingua.wav');
Fs=44100;
duration = 1; % in seconds
t=linspace(0,duration,duration*Fs); % time vector
sine_freq1 = 1250; %input('Veuillez entrer la fréquence : '); % in hertz;
sine_freq2 = 542;
sample1 = sin(sine_freq1*2*pi*t);
sample2 = sin(sine_freq2*2*pi*t);
%sample = cat(1, sample1, sample2);
% -------------------------- Variables ---------------------
Ts = 1/Fs;
sample_trim = sample1;%(1:100000); % first 3 seconds of sound (skip silence at beginning)
win_sz = floor(Fs * 0.01);
prev=0;
figure(1),
plot(sample_trim, 'markerstyle', 'o');
grid on;

%% ############ Methode 1 : zero-crossing ##############
for i = 1:win_sz:length(sample_trim)-win_sz
  % Zero detection
  sample_trim_win = sample_trim(i:i+win_sz);
  zero_crossing_list = find(diff(sample_trim>0)~=0); % linear interp => perf
  zero_crossing_times = Ts.*zero_crossing_list; % list of times for zero crossing
  win_sz = 10;
  for j = i+1:2:length(zero_crossing_times)-2
    % Frequency measurement
    %j/2
    freq(floor(j/2)) = 1/(zero_crossing_times(j+2)-zero_crossing_times(j));
  endfor;
endfor;
%freq=freq./2; % 2 zero-crossings per period
figure(1),
plot(freq)
freq_m = mean(freq)
ylim([0 2*sine_freq]);
%