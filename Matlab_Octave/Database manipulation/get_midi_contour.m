function [ contour ] = get_midi_contour( midi_file , Fs )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    GT = readmidi(midi_file);
    tempo = gettempo(GT);
    Fech_beat = Fs/(tempo/60); % samples/beats = (samples/sec)/(beats/s)
    gran = 1/Fech_beat; % sampling interval in beats.
    contour = midi2hz(melcontour(GT, gran));
end

