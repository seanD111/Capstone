function [ output_args ] = prepareData( handles )
%PREPAREDATA Formats all the features into a format usable by prediction
%   Detailed explanation goes here
FDomainAnas={'Power Spectrogram'; 'Formant Ratios';'IPA Coherences';...
    'Discrete Wavelet Transform Coefficients';'MFCCs';...
    'Delta-MFCCs';'Delta-Delta-MFCCs'; ...
    'Use RASTA filtering on the following:'; 'PLPs'; 'Delta-PLPs';'Delta-Delta-PLPs' };

TDomainAnas={'Mean';  'RMS Power'; 'Pitch Period'; 'IPA Cross-Correlation'};

%windowsize in ms
windowSize=25;
hoptime=10;

rowsSelected=handles.corpusSelect.Data(:, 2)
allSelectedClips=cell(2,10000);
for i=1:length(allSelectedClips)*2
      allSelectedClips{i}='';

end
currInd=1;
for i=1:length(rowsSelected)
    if rowsSelected{i, 1}==1

        for j=1:length(handles.allFilesByRow{i, 1})
            tempfiles=handles.allFilesByRow{i,1};
            allSelectedClips{1, currInd}=tempfiles{j, 1};
            templang=handles.allFilesByRow{i, 2};
            allSelectedClips{2, currInd}=templang{1};
            currInd=currInd+1;
        end
    end
end
allSelectedClips;
[allClips,ia, ic]=unique(allSelectedClips(1,:));
temp2=allSelectedClips(2, :);
allSelLangs = temp2(ia);


uniqueSelectedClips=allClips(2:end);
uniqueSelectedLangs=allSelLangs(2:end);



selectedFeature=cell(16,2);

for i=1:length(uniqueSelectedClips)
    fInd=1;
    full_rowInd=1;
    windowed_rowInd=1;
    
    allLangs=handles.allLanguages;
    for h=1:length(allLangs)
        languageTargets(h,i)=strcmp(uniqueSelectedLangs{1,i}, allLangs{1,h});          
       
    end

    %%Get SoundClip
    try
        
        [bothChannels,sr] = audioread(uniqueSelectedClips{1, i});
         d=((bothChannels(:,1)+bothChannels(:,2))/2)';
         d=d(1, 1:500000);



    %%Time Domain Analysis%%
    if(any(handles.timeDomain.Value==1))
        selectedFeature{fInd,1}=TDomainAnas{1,1};
        selectedFeature{fInd,2}=full_rowInd;
        full_languageInputs(full_rowInd, i)=mean(d);
        full_rowInd=full_rowInd+1;
        fInd=fInd+1;
    end
    if(any(handles.timeDomain.Value==2))
        selectedFeature{fInd,1}=TDomainAnas{2,1};
        selectedFeature{fInd,2}=full_rowInd;
        full_languageInputs(full_rowInd, i)=rms(d);
        full_rowInd=full_rowInd+1;
        fInd=fInd+1;
    end
    if(any(handles.timeDomain.Value==3))
        selectedFeature{fInd,1}=TDomainAnas{3,1};
        selectedFeature{fInd,2}=full_rowInd;
        full_languageInputs(full_rowInd, i)=pitchperiod(d, sr);
        full_rowInd=full_rowInd+1;
        fInd=fInd+1;
    end
    if(any(handles.timeDomain.Value==4))
        %selectedFeature{fInd,1}=TDomainAnas{5,1};
        %fInd=fInd+1;
    end
    
    %%Frequency Analysis
    if(any(handles.freqDomain.Value==1))
        selectedFeature{fInd,1}=FDomainAnas{1,1};
        selectedFeature{fInd,2}=windowed_rowInd;
        tempPowSpec=powspec(d, sr);
        [numRows, ~]=size(tempPowSpec);
        windowed_languageInputs(windowed_rowInd:(windowed_rowInd+numRows-1), :)=tempPowSpec;
        windowed_rowInd=windowed_rowInd+numRows;
        fInd=fInd+1;
    end
    if(any(handles.freqDomain.Value==2))
        selectedFeature{fInd,1}=FDomainAnas{2,1};
        selectedFeature{fInd,2}=windowed_rowInd;
        tempFormants=formants(d, sr);
        [numRows, ~]=size(tempFormants);
        windowed_languageInputs(windowed_rowInd:(windowed_rowInd+numRows-1), :)=tempFormants;
%         windowed_languageInputs(windowed_rowInd+numRows, :)=tempFormPow;
        windowed_rowInd=windowed_rowInd+numRows;
        fInd=fInd+1;
    end
    if(any(handles.freqDomain.Value==3))
        selectedFeature{fInd,1}=FDomainAnas{3,1};
        selectedFeature{fInd,2}=windowed_rowInd;
        fInd=fInd+1;
    end
    if(any(handles.freqDomain.Value==4))
        selectedFeature{fInd,1}=FDomainAnas{4,1};
        selectedFeature{fInd,2}=windowed_rowInd;
        fInd=fInd+1;
    end
    if(any(handles.freqDomain.Value==5))
        selectedFeature{fInd,1}=FDomainAnas{5,1};
        selectedFeature{fInd,2}=windowed_rowInd;
        tempMFCCs = melfcc(d*3.3752, sr);
        [numRows, ~]=size(tempMFCCs);
        windowed_languageInputs(windowed_rowInd:(windowed_rowInd+numRows-1), :)=tempMFCCs;
        windowed_rowInd=windowed_rowInd+numRows;
        fInd=fInd+1;
    end
    if(any(handles.freqDomain.Value==6))
        selectedFeature{fInd,1}=FDomainAnas{6,1};
        selectedFeature{fInd,2}=windowed_rowInd;
        tempMFCCs = melfcc(d*3.3752, sr);
        tempDMFCCs=deltas(tempMFCCs);
        [numRows, ~]=size(tempDMFCCs);
        windowed_languageInputs(windowed_rowInd:(windowed_rowInd+numRows-1), :)=tempDMFCCs;
        windowed_rowInd=windowed_rowInd+numRows;
        fInd=fInd+1;
    end
    if(any(handles.freqDomain.Value==7))
        selectedFeature{fInd,1}=FDomainAnas{7,1};
        selectedFeature{fInd,2}=windowed_rowInd;
        tempMFCCs = melfcc(d*3.3752, sr);
        tempDDMFCCs=deltas(deltas(tempMFCCs,5),5);
        [numRows, ~]=size(tempDMFCCs);
        windowed_languageInputs(windowed_rowInd:(windowed_rowInd+numRows-1), :)=tempDDMFCCs;
        windowed_rowInd=windowed_rowInd+numRows;
        fInd=fInd+1;
    end
    if(any(handles.freqDomain.Value==8))
            if(any(handles.freqDomain.Value==9))
                selectedFeature{fInd,1}=FDomainAnas{9,1};
                selectedFeature{fInd,2}=windowed_rowInd;
                tempPLPs = rastaplp(d, sr);
                [numRows, ~]=size(tempPLPs);
                windowed_languageInputs(windowed_rowInd:(windowed_rowInd+numRows-1), :)=tempPLPs;
                windowed_rowInd=windowed_rowInd+numRows;
                fInd=fInd+1;
            end
            if(any(handles.freqDomain.Value==10))
                selectedFeature{fInd,1}=FDomainAnas{10,1};
                selectedFeature{fInd,2}=windowed_rowInd;
                tempPLPs = rastaplp(d, sr);
                del = deltas(tempPLPs);
                [numRows, ~]=size(del);
                windowed_languageInputs(windowed_rowInd:(windowed_rowInd+numRows-1), :)=del;
                windowed_rowInd=windowed_rowInd+numRows;
                fInd=fInd+1;
            end
            if(any(handles.freqDomain.Value==11))
                selectedFeature{fInd,1}=FDomainAnas{11,1};
                selectedFeature{fInd,2}=windowed_rowInd;
                tempPLPs = rastaplp(d, sr);
                ddel = deltas(deltas(tempPLPs,5),5);
                [numRows, ~]=size(ddel);
                windowed_languageInputs(windowed_rowInd:(windowed_rowInd+numRows-1), :)=ddel;
                windowed_rowInd=windowed_rowInd+numRows;
                fInd=fInd+1;
            end        
    else
            if(any(handles.freqDomain.Value==9))
                selectedFeature{fInd,1}=FDomainAnas{9,1};
                selectedFeature{fInd,2}=windowed_rowInd;
                tempPLPs = rastaplp(d, sr, 0, 12);
                [numRows, ~]=size(tempPLPs);
                windowed_languageInputs(windowed_rowInd:(windowed_rowInd+numRows-1), :)=tempPLPs;
                windowed_rowInd=windowed_rowInd+numRows;
                fInd=fInd+1;
            end
            if(any(handles.freqDomain.Value==10))
                selectedFeature{fInd,1}=FDomainAnas{10,1};
                selectedFeature{fInd,2}=windowed_rowInd;
                tempPLPs = rastaplp(d, sr, 0, 12);
                del = deltas(tempPLPs);
                [numRows, ~]=size(del);
                windowed_languageInputs(windowed_rowInd:(windowed_rowInd+numRows-1), :)=del;
                windowed_rowInd=windowed_rowInd+numRows;
                fInd=fInd+1;
            end
            if(any(handles.freqDomain.Value==11))
                selectedFeature{fInd,1}=FDomainAnas{11,1};
                selectedFeature{fInd,2}=windowed_rowInd;
                tempPLPs = rastaplp(d, sr, 0, 12);
                ddel = deltas(deltas(tempPLPs,5),5);
                [numRows, ~]=size(ddel);
                windowed_languageInputs(windowed_rowInd:(windowed_rowInd+numRows-1), :)=ddel;
                windowed_rowInd=windowed_rowInd+numRows;
                fInd=fInd+1;
            end
    end
    
    catch err
        err.stack
    end


end

selectedFeature
