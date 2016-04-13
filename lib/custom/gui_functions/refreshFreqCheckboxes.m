function [ FDomainIsWindowed ] = refreshFreqCheckboxes( checkBoxHandle )
%refreshTimeCheckboxes Refreshes the time-domain analysis selection boxes
%   
FDomainAnas={'Power Spectrogram', 'Formant Ratios','IPA Coherences',...
    'Discrete Wavelet Transform Coefficients','MFCCs',...
    'Delta-MFCCs','Delta-Delta-MFCCs', ...
    'Use RASTA filtering on the following:', '     PLPs', '     Delta-PLPs','     Delta-Delta-PLPs' };
FDomainIsWindowed=[1 1 1 1 1 1 1 1 1 1 1];
FDefaultAnas=[1:length(FDomainAnas)];



checkBoxHandle.Min=1;
checkBoxHandle.Max=length(FDomainAnas);
checkBoxHandle.String=FDomainAnas;
checkBoxHandle.Value=FDefaultAnas;

end

