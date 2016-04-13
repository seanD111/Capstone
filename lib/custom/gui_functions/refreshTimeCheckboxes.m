function [ TDomainIsWindowed ] = refreshTimeCheckboxes( checkBoxHandle )
%refreshTimeCheckboxes Refreshes the time-domain analysis selection boxes
%   
TDomainAnas={'Mean', 'Variance', 'RMS Power', 'Pitch Period', 'IPA Cross-Correlation'};
TDomainIsWindowed=[0 0 0 0 0];
TDefaultAnas=[3 4 5];

checkBoxHandle.Min=1;
checkBoxHandle.Max=length(TDomainAnas);
checkBoxHandle.String=TDomainAnas;
checkBoxHandle.Value=TDefaultAnas;

end

