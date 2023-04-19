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