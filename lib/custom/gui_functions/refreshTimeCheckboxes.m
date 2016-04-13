function [ TDomainIsWindowed ] = refreshTimeCheckboxes( checkBoxHandle )
%refreshTimeCheckboxes Refreshes the time-domain analysis selection boxes
%   
TDomainAnas={'Mean',  'RMS Power', 'Pitch Period', 'IPA Cross-Correlation'};
TDomainIsWindowed=[0 0 0 0];
TDefaultAnas=[2 3 4];

checkBoxHandle.Min=1;
checkBoxHandle.Max=length(TDomainAnas);
checkBoxHandle.String=TDomainAnas;
checkBoxHandle.Value=TDefaultAnas;

end

