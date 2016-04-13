function [ letterIndices ] = extractIPA( signal, Fs, signal_ipa, Fs_ipa )
%EXTRACTIPA Finds the indices of the ipa letter inside the signal
%   Must be used on the full non-windowed signal
%   Usage: [ letterIndices ] = extractIPA( signal, Fs, signal_ipa, Fs_ipa )

    [P1,Q1] = rat(Fs_ipa/Fs);          % Rational fraction approximation

    signal = resample(signal,P1,Q1);        % Change sampling rate by rational factor

    
    [crossCor lags]=xcorr(signal, signal_ipa);
    crossCor=abs(crossCor)/max(abs(crossCor));
        [peaks, pkLocs]=findpeaks(crossCor, 'MinPeakHeight', 0.2,...
        'MinPeakProminence', 0.6);

    T=1/Fs_ipa;
    t=T.*lags;
    plot(t, crossCor)
     hold on
    peakTimes=(pkLocs+lags(1)-1)*T;
    plot(peakTimes, crossCor(pkLocs), 'rx')   
    
end

