%% Waterfall Graph of an audio file, axis: frequency, amplitude and time



clc
clear all

[filename, pathname] = uigetfile('*.mp3');
fullpath = fullfile(pathname, filename);
data = importdata(fullpath);

[y, Fs] = audioread(filename);

y = mean(y,2); % convert stereo to mono
[p,f,t] = pspectrum(y,Fs,'spectrogram');
a = sqrt(p.*f*3);


%figure;
%waterfall(f,t,10*log10(p.'));
obj = waterfall(f,t,a.');
%{
set(gca,'XScale','log')
xlabel('Frequency (Hz)');
ylabel('Time (seconds)');
%zlabel('Power Spectral Density (dB)');
zlabel('Amplitude');
view([30 45]);
%}


figure();
subplot(231)
copyobj(obj,gca)
set(gca,'XScale','log')
xlabel('Frequency (Hz)');
ylabel('Time (seconds)');
%zlabel('Power Spectral Density (dB)');
zlabel('Amplitude');
view(90,0)

subplot(232)
copyobj(obj,gca)
set(gca,'XScale','log')
xlabel('Frequency (Hz)');
ylabel('Time (seconds)');
%zlabel('Power Spectral Density (dB)');
zlabel('Amplitude');
view(65,85)

subplot(233)
copyobj(obj,gca)
set(gca,'XScale','log')
xlabel('Frequency (Hz)');
ylabel('Time (seconds)');
%zlabel('Power Spectral Density (dB)');
zlabel('Amplitude');
view(30,45)

subplot(234)
copyobj(obj,gca)
set(gca,'XScale','log')
xlabel('Frequency (Hz)');
ylabel('Time (seconds)');
%zlabel('Power Spectral Density (dB)');
zlabel('Amplitude');
view(0,90)

subplot(235)
copyobj(obj,gca)
set(gca,'XScale','log')
xlabel('Frequency (Hz)');
ylabel('Time (seconds)');
%zlabel('Power Spectral Density (dB)');
zlabel('Amplitude');
view(0,0)

subplot(236)
copyobj(obj,gca)
set(gca,'XScale','log')
xlabel('Frequency (Hz)');
ylabel('Time (seconds)');
%zlabel('Power Spectral Density (dB)');
zlabel('Amplitude');
view(125,45)

scrsz = get(0,'ScreenSize');
set(gcf, 'Position', [1 1 scrsz(3) scrsz(4)])
print('figure_full_screen_TEST', '-dtiff', '-r600');







