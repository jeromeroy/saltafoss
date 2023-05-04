%% Saltafoss
% Desciption:   This code exports audio files into STL files using 3D graphs
% Author:       Jérôme Roy
% Date:         10.04.23
% Update:       04.05.23


% TEST COMMIT

%% SECTION 1:   READ AUDIO FILE & SAVE TO .MAT FILE
clc
clear all

tic;
folder_path = uigetdir();
file_list = dir(fullfile(folder_path,'*.mp3'));

for i = 1:length(file_list)
    % load audio file
    filename = file_list(i).name;
    fullpath = fullfile(folder_path, filename);
    [y, Fs] = audioread(fullpath);
    y = mean(y,2); % convert stereo to mono
    mat_filename = sprintf('%s.mat', filename);
    save(fullfile(folder_path, mat_filename),"y","Fs",'-v7.3')
end
toc;
%% SECTION 2:   LOAD .MAT FILE INTO WORKSPACE
tic;
clc
clear all
folder_path = uigetdir();
file_list = dir(fullfile(folder_path,'*.mat'));

for i = 1:length(file_list)
    filename = file_list(i).name;
    fullpath = fullfile(folder_path, filename);
    load(fullpath)
end
toc;
%% SECTION 3:   CALCULATE SPECTROGRAM
tic;
    % calculate spectrogram
    [p,f,t] = pspectrum(y,Fs,'spectrogram','Leakage',0.1);
toc;

%% SECTION 4:   EXPORT SPECTROGRAM (GENERATE STL)
tic; 
    % select frequency range and compress data
    c = 1;          % "compression" of the mesh
    HC = 885;       % High-Cut frequencies
    amplitude = 800;    % Amplitude multiplicator


    % calculate scaling factor to print in 2/3 ratio (20x30cm)
    a = sqrt(p.*f*3);
    ff = transpose(f(1:HC,:)); 
    aa = a(1:HC,:)*amplitude;

    F = ff(:,1:c:end);
    A = aa(1:c:end,1:c:end);
    x = (F(end)*(1/2))/t(end,:);
    T = t.*x;
    
    % divide the area in 12 tiles, arranged in a 4x3 matrix
    ratio = length(F(end))/length(T(end));
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
toc;
