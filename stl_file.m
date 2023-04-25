%% Saltafoss
% Desciption:   This code exports audio files in STL files using 3D graphs
% Author:       Jérôme Roy
% Date:         10.04.23
% Update:       25.04.23

clc
clear all

tic;
folder_path = uigetdir(); % select folder containing mp3 files
file_list = dir(fullfile(folder_path, '*.mp3'));

for i = 1:length(file_list)
    % load audio file
    filename = file_list(i).name;
    fullpath = fullfile(folder_path, filename);
    [y, Fs] = audioread(fullpath);
    y = mean(y,2); % convert stereo to mono
    
    % calculate spectrogram
    [p,f,t] = pspectrum(y,Fs,'spectrogram');
    a = sqrt(p.*f*3);
    
    % calculate scaling factor to make frequency and time axes roughly equal
    x = 2/3*(f(end)/t(end));
    
    % select frequency range and compress data
    ff = transpose(f(1:800,:))./x;
    aa = a(1:800,:)*400;
    c = 2; % how much should i compress?
    F = ff(:,1:c:end);
    A = aa(1:c:end,1:c:end);
    
    % create time axis
    T = transpose(linspace(0, length(y)/Fs, size(A,2)));
    
    % write ascii STL file
    stl_filename = [filename(1:end-4) '.stl'];
    stlwrite(fullfile(folder_path, stl_filename),T,F,A,'mode','ascii')
end
toc;
