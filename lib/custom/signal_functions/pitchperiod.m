function [ pitchPeriod ] = pitchperiod( signal, Fs )
%pitchperiod Finds the fundamental pitch period of an inputted signal 
%   Outputs a double from an inputted signal and sampling frequency
%   Must be done on the full non-windowed signal
%   Usage: [ pitchPeriod ] = pitchperiod( signal, Fs )
%     frequencyRange=[40 600];
%     timeSpacing=[1/frequencyRange(2) 1/frequencyRange(1)];
%     
%     [autoCor, lags]=xcorr(signal, 'unbiased');
%     T=1/Fs;
%     t=T.*lags;
%     
%     %normAuto=abs(autoCor)/max(abs(autoCor));
%     normAuto=autoCor;
%     [peaks, pkLocs]=findpeaks(normAuto, 'MinPeakHeight', 0.1,...
%         'MinPeakProminence', 0.2);
%     %plot(t, normAuto)
%     %hold on
%     peakTimes=(pkLocs+lags(1)-1)*T;
%     %plot(peakTimes, normAuto(pkLocs), 'rx')   
%     pitchPeriod=mean(peakTimes(3:end)-peakTimes(2:end-1));
    %axis([-3*pitchPeriod 3*pitchPeriod -0.55 0.55])
    [fx,tt]=fxrapt(signal,Fs, '~');
    pitchPeriod=mean(fx');
    
end

