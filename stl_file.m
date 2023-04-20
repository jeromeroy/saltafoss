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

ff = transpose(f(1:950,:))./x;
aa = a(1:950,:)*15;
tt = transpose(t);

% grab every 2nd element
F = ff(:,1:5:end);
A = aa(1:5:end,1:5:end);
T = tt(:,1:5:end);

% Write ascii STL from gridded data
%stlwrite('test.stl',tt,ff,aa,'mode','ascii')
stlwrite('test_comp.stl',T,F,A,'mode','ascii')



%% TEST STL

% Write ascii STL from gridded data
[X,Y] = deal(1:50);             % Create grid reference
Z = peaks(50);                  % Create grid height
stlwrite('test.stl',X,Y,Z,'mode','ascii')