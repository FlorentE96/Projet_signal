clear;
clc;
close all;

Fs = 8000;

GT = zeros(48, 400000);

for i=1:48
    if(i == 42)
        continue;
    end
    filename = strcat('000', sprintf('%02d',i), '.mid')
    contour_temp = normalise(get_midi_contour(filename, Fs));
    if(length(contour_temp)>length(GT(1,:)))
        contour_temp = contour_temp(1:length(GT(1,:)));
    end
    GT(i, :) = padarray(contour_temp, [0 (length(GT(i,:))-length(contour_temp))], 'post');
    clear contour_temp
end

% win_length = 256;
% win_sz = win_length/Fs;

%GT_trim(i) = GT(i, 1:win_length:length(query)*win_length);

% [sample, Fs] = audioread('00001.wav');
% sample = sample(1*Fs:end);
% 
% [query, seg] = pitchContour(sample, Fs, win_sz);
% 
% query = normalise(query);

%%
figure,
plot(query);
hold on;
plot(GT_trim);