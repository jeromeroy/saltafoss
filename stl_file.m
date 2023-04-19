%% Saltafoss
% Desciption:   This code exports audio files in STL files using 3D graphs
% Author:       Jérôme Roy
% Date:         10.04.23
% Update:       19.04.23

clc
clear all

[filename, pathname] = uigetfile('*.*'); %change the extension for other file formats
fullpath = fullfile(pathname, filename);
data = importdata(fullpath);

[y, Fs] = audioread(filename);

y = mean(y,2); % convert stereo to mono
[p,f,t] = pspectrum(y,Fs,'spectrogram');
a = sqrt(p.*f*3)*1000;


% Write ascii STL from gridded data
[X,Y] = deal(1:40);             % Create grid reference
Z = peaks(40);                  % Create grid height
stlwrite('test.stl',t,f,a,'mode','ascii')

%% TEST STL

% Write ascii STL from gridded data
[X,Y] = deal(1:40);             % Create grid reference
Z = peaks(40);                  % Create grid height
stlwrite('test.stl',X,Y,Z,'mode','ascii')