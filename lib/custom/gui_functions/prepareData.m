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



selectedFeature=cell(16,1);

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
        full_languageInputs(full_rowInd, i)=mean(d);
        full_rowInd=full_rowInd+1;
        fInd=fInd+1;
    end
    if(any(handles.timeDomain.Value==2))
        selectedFeature{fInd,1}=TDomainAnas{2,1};
        full_languageInputs(full_rowInd, i)=rms(d);
        full_rowInd=full_rowInd+1;
        fInd=fInd+1;
    end
    if(any(handles.timeDomain.Value==3))
        selectedFeature{fInd,1}=TDomainAnas{3,1};
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
        tempPowSpec=powspec(d, sr);
        [numRows, ~]=size(tempPowSpec);
        windowed_languageInputs(windowed_rowInd:(windowed_rowInd+numRows-1), :)=tempPowSpec;
        windowed_rowInd=windowed_rowInd+numRows;
        fInd=fInd+1;
    end
    if(any(handles.freqDomain.Value==2))
        selectedFeature{fInd,1}=FDomainAnas{2,1};
        tempFormants=formants(d, sr);
        [numRows, ~]=size(tempFormants);
        windowed_languageInputs(windowed_rowInd:(windowed_rowInd+numRows-1), :)=tempFormants;
%         windowed_languageInputs(windowed_rowInd+numRows, :)=tempFormPow;
        windowed_rowInd=windowed_rowInd+numRows;
        fInd=fInd+1;
    end
    if(any(handles.freqDomain.Value==3))
        selectedFeature{fInd,1}=FDomainAnas{3,1};
        fInd=fInd+1;
    end
    if(any(handles.freqDomain.Value==4))
        selectedFeature{fInd,1}=FDomainAnas{4,1};
        fInd=fInd+1;
    end
    if(any(handles.freqDomain.Value==5))
        selectedFeature{fInd,1}=FDomainAnas{5,1};
        fInd=fInd+1;
    end
    if(any(handles.freqDomain.Value==6))
        selectedFeature{fInd,1}=FDomainAnas{6,1};
        fInd=fInd+1;
    end
    if(any(handles.freqDomain.Value==7))
        selectedFeature{fInd,1}=FDomainAnas{7,1};
        fInd=fInd+1;
    end
    if(any(handles.freqDomain.Value==8))

            if(any(handles.freqDomain.Value==9))
                selectedFeature{fInd,1}=FDomainAnas{9,1};
                fInd=fInd+1;
            end
            if(any(handles.freqDomain.Value==10))
                selectedFeature{fInd,1}=FDomainAnas{10,1};
                fInd=fInd+1;
            end
            if(any(handles.freqDomain.Value==11))
                selectedFeature{fInd,1}=FDomainAnas{11,1};
                fInd=fInd+1;
            end        
    else
            if(any(handles.freqDomain.Value==9))
                selectedFeature{fInd,1}=FDomainAnas{9,1};
                fInd=fInd+1;
            end
            if(any(handles.freqDomain.Value==10))
                selectedFeature{fInd,1}=FDomainAnas{10,1};
                fInd=fInd+1;
            end
            if(any(handles.freqDomain.Value==11))
                selectedFeature{fInd,1}=FDomainAnas{11,1};
                fInd=fInd+1;
            end 
    end
    
    catch err
        err
    end


end
languageTargets
selectedFeature
