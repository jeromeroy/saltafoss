%% spectrogram x rizzo prova

[X,Y] = meshgrid(-5:.1:5);
Z = Y.*sin(X) - X.*cos(Y);
p = waterfall(X,Y,Z)

%% test audio
clc
clear all

[y, Fs] = audioread('audio.wav'); 
t = 0.6; % duration of window in seconds
n = t*Fs; % number of samples in window
w = length(y)/n; % number of windows


for i = 1:w
H{i} = fft(y(n*i:n*i+n));
end
f = (0:n-1)*Fs/n;

figure(1)
semilogx(f(f>=20 & f<=20000),abs(H{1}(f>=20 & f<=20000)))
xlabel('Frequency (Hz)');
ylabel('Amplitude');

figure(2)
semilogx(f(f>=20 & f<=20000), abs(H{i}(f>=20 & f<=20000)));
xlabel('Frequency (Hz)');
ylabel('Amplitude');
set(gca,'XTick',logspace(1,4,4),'XTickLabel',{'10^1','10^2','10^3','10^4'});

[p,f,t] = pspectrum(y(:,1),20000,'spectrogram');
waterfall(f,t,p');
xlabel('Frequency (Hz)')
ylabel('Time (seconds)')
zlabel('Magnitude (V^2)')
title(['Frequency waterfall']);
xlim([0 2e5])
colorbar
wtf = gca;
wtf.XDir = 'reverse';
view([45 45])   


%% prova 2
clc
clear all

fs = 1e3;
t = 0:1/(2*fs):2;
yc = chirp(t,100,1,200,"quadratic");
[y, Fs] = audioread('audio.wav');
yvec = y(:,1);
yt = transpose(yvec);
[sp,fp,tp] = pspectrum(yc,fs,"spectrogram");

waterfall(fp,tp,sp')
set(gca,XDir="reverse",View=[60 60])
ylabel("Time (s)")
xlabel("Frequency (Hz)")

%% Waterfall Graph of an audio file, axis: frequency, amplitude and time
clc
clear all



[y, Fs] = audioread('La Primavera - Allegro.mp3');

y = mean(y,2); % convert stereo to mono
[p,f,t] = pspectrum(y,Fs,'spectrogram');
a = sqrt(p.*f*3);
figure;
%waterfall(f,t,10*log10(p.'));
waterfall(f,t,a.');
set(gca,'XScale','log')
xlabel('Frequency (Hz)');
ylabel('Time (seconds)');
%zlabel('Power Spectral Density (dB)');
zlabel('Amplitude');
view([30 45]);

%% prova 4 (with amplitude)
clc
clear all


[y, Fs] = audioread('audio.wav');
y = mean(y,2); % convert stereo to mono
[S,F,T] = spectrogram(y,hann(N),N-s,N,Fs);
waterfall(F,T,abs(S));




