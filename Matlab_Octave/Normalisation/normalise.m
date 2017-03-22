function [ contour_norm ] = normalise( contour )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
average = mean(contour); % compute the average of the contour
contour_norm = contour - average; % substract the average value

end

