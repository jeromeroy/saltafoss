%% Saltafoss
% Desciption:   This code exports audio files into STL files using 3D graphs
% Author:       Jérôme Roy
% Date:         10.04.23
% Update:       26.04.23

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
    
    % calculate scaling factor to print in 2/3 ratio (20x30cm)
    x = 2/3*(f(end)/t(end));
    
    % select frequency range and compress data
    ff = transpose(f(1:800,:))./x; 
    aa = a(1:800,:)*400;
    c = 1; % how much should i "compress" the mesh?
    F = ff(:,1:c:end);
    A = aa(1:c:end,1:c:end);

    % create time axis
    T = transpose(linspace(0, length(y)/Fs, size(A,2)));
    
    % divide the area in 12 tiles, arranged in a 4x3 matrix

    length_F = length(F)/4;
    length_T = length(T)/3;
    input_text = "piastrella"; % Replace with your desired text input

    for i = 1:4
        for g = 1:3
            
            X = F(:,length_F*(i-1)+1:1:length_F*i-1);
            Y = T(length_T*(g-1)+1:1:length_T*g-1,:);
            Z = A(length_F*(i-1)+1:1:length_F*i-1,length_T*(g-1)+1:1:length_T*g-1);

            stl_filename = sprintf('%s_%d_%d.stl', input_text, i, g);
            stlwrite(fullfile(folder_path, stl_filename),Y,X,Z,'mode','ascii')
            
        end
    end

end
toc;
