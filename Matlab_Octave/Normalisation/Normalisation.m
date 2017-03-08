%% Normalisation of the contour time series
% Make the absolute inaccuracies invariant under
% pitch shifting and time scaling.
clc;
clear;
close all;
load('Contour.mat');
load('Contour_ground_truth.mat');

%% Absolute pitch normalisation
% ** ABSTRACT** : 
% The query contour will be hummed at a different root pitch from the
% ground-truth.
% To normalise it, we remove the average component.

average = mean(contour); % compute the average of the contour
contour = contour - average; % substract the average value

%% Uniform Time Warping
