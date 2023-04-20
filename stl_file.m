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
a = sqrt(p.*f*3);
%select first 789 elements of a to make it in ratio 3/2

%TODO: Remove ratio limiter of 526, instead divide highest value in freq by
%highest value in time. to obtain a square. then rethink how to calibrate
%in ratio 2/3
x = (2/3)*(f(end)/t(end));

ff = transpose(f)./x;
aa = a*10;
tt = transpose(t);

% Write ascii STL from gridded data
[X,Y] = deal(1:40);             % Create grid reference
Z = peaks(40);                  % Create grid height
stlwrite('test.stl',tt,ff,aa,'mode','ascii')

%% TEST STL

% Write ascii STL from gridded data
[X,Y] = deal(1:10);             % Create grid reference
Z = peaks(10);                  % Create grid height
stlwrite('test.stl',X,Y,Z,'mode','ascii')