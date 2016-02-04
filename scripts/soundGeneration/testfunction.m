% freq=[440*(1+zeros(1,2000)), 415.2*(1+zeros(1,2000)),392*(1+zeros(1,2000))];
% music=freqgen(freq, 8000);
% soundsc(music, 8000);
% 
% C=tonegen(261.63, 8000, 2);
% E=tonegen(329.63, 8000, 2);
% G=tonegen(783.99, 8000, 2);
% B=tonegen(987.77, 8000, 2);
% soundsc(C+E+G+B, 8000);
y=chirp(0:0.001:5,0,5,500); %construct a frequency chirp
z=[y, y(length(y):-1:1),y]; %make a zig-zag
f=abs(fft(z, 8192));
plot(f(1:4096));
s=spectrogram(z, 1024);
waterfall(abs(s)'); % may take some time to process