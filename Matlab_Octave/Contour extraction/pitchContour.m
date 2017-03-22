function [ freq, seg ] = pitchContour( audio_file, Fs,  win_length)
%contour Analyses the pitch contour of a sound file using self-correlation.
%   Returns a times serie of the pitch of audio sample, with a window of 70ms
%   audio_file is a time series, Fs is the audio_file's rate, win_sz is the
%   window size in s.


% -------------------------- Variables ---------------------
    Ts = 1/Fs;
    thres_t1 = floor(1/50*Fs); % 50 Hz
    thres_t2 = ceil(1/1000*Fs); % 1500 Hz
    thres_amp = 0.65;
    win_sz = floor(Fs * win_length);
    win_index=1;

    clear freq
    for win_index=1:win_sz:length(audio_file)-win_sz
      [scorr, lag] = xcorr(audio_file(win_index:win_index+win_sz), 'biased'); % compute self-corr
      scorr = scorr./scorr(lag==0); % normalize

      [val_max, ind_max] = max(scorr(find(lag==thres_t2):find(lag==thres_t1)));
      ind_max = ind_max + find(lag==thres_t2);
      n=ceil(win_index/win_sz); % normalized index of the windows

      seg(n) = val_max<thres_amp; % detect transient
      freq(n) = 1 / (lag(ind_max) / Fs); % measure frequency
    end
end

