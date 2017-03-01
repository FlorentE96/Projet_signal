%% Extract the contour of a sound signal.

[y, Fs] = audioread('Pange_Lingua.wav');

y = y(0.5*Fs:Fs*3.5); % first 3 seconds of sound (skip silence at beginning)

figure(1),
plot(y);