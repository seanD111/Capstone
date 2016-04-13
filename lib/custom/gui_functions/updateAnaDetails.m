function [ output_args ] = updateAnaDetails( handles )
%UPDATEANADETAILS Updates the analysis details static text
%   
string1='Analysis using Full Speech Signal:\n';
for i=1:length(handles.timeDomain.Value)
    string2=['     ', handles.timeDomain.String{handles.timeDomain.Value(i)}, '\n'];
    string1=[string1, string2];
end
string1=[string1,'\nAnalysis using Windowed Speech Signal:\n'];
for i=1:length(handles.freqDomain.Value)
    string2=['     ', handles.freqDomain.String{handles.freqDomain.Value(i)}, '\n'];
    string1=[string1, string2];
end
output_args=sprintf(string1);
handles.anaDetails.Position=[0.55 0.05 0.45 0.89];
handles.anaDetails.HorizontalAlignment='left';
end

