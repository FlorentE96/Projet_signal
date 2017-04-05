clear;
clc;
close all;

%% Get contour
[sample, Fs] = audioread('00001.wav');
sample = sample(1*Fs:end);

win_length = 256;
win_sz = win_length/Fs;
[query, seg] = pitchContour(sample, Fs, win_sz);

query = normalise(query);

GT = normalise(get_midi_contour('00001.mid', Fs));
GT_trim = GT(1:win_length:length(query)*win_length);

clear GT;
clear sample;
clear win_length win_sz;

%% compute PAA and envelope
[Q Q_M Q_m] = PAA_enveloppe(query, 5, 10);
%clear Q;
GT = PAA(GT_trim, 5, 10);

taille_Q_M = length(Q_M);
taille_Q_m = length(Q_m);
taille_GT = length (GT);

DTW = inf(taille_Q_M+1, taille_GT+1); %Matrice de taille (W,W2) rempli de infini
DTW(1, 1) = 0;
fenetre = 5;
fenetre = max(fenetre,abs(taille_Q_M-taille_GT));

for i = 1:1:taille_Q_M
    for j = max(1,i-fenetre) : 1 : min (i+fenetre,taille_GT)
        if(abs(Q_M(i)-GT(j))<=(Q_M(i)-Q_m(i)) && abs(Q_m(i)-GT(j))<=(Q_M(i)-Q_m(i)))
            distance_euclidean = 0; % Inside envelope
        elseif(abs(Q_M(i)-GT(j)) < abs(Q_m(i)-GT(j)))
            distance_euclidean = abs(Q_M(i)-GT(j)); % above envelope
        else
            distance_euclidean = abs(Q_m(i)-GT(j)); % under envelope
        end
        DTW(i+1,j+1)= distance_euclidean + min([DTW(i+1,j) DTW(i,j+1) DTW(i,j)]);
    end
end
clear i j;
clear distance_euclidean;

DTW=DTW(2:taille_Q_M+1,2:taille_GT+1);

%% Plotting

figure(1), % figure 1 : query, envelope and ground truth
plot(Q_M, '-o')
hold on
plot(Q_m, '-o')
plot(Q, '-o')
plot(GT, '-o')
legend('Env max', 'Env min', 'query', 'Ground truth');
title('query, envelope and ground truth');
