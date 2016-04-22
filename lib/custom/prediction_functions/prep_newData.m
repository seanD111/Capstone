function [ full_languageInputs, windowed_languageInputs ] = prep_newData( bothChannels, sr, featureList )
%PREP_NEWDATA Prepares inputted signal (and sampling freq) and a 16x1
%matrix of the required features to extract
%   Detailed explanation goes here
FDomainAnas={'Power Spectrogram'; 'Formant Ratios';'IPA Coherences';...
    'Discrete Wavelet Transform Coefficients';'MFCCs';...
    'Delta-MFCCs';'Delta-Delta-MFCCs'; ...
    'Use RASTA filtering on the following:'; 'PLPs'; 'Delta-PLPs';'Delta-Delta-PLPs' };
full_languageInputs=0;
windowed_languageInputs=0;
TDomainAnas={'Mean';  'RMS Power'; 'Pitch Period'; 'IPA Cross-Correlation'};

    wintime = 0.025;
    steptime = 0.010;
   fInd=1;
    full_rowInd=1;
    windowed_rowInd=1;
    windowed_colEnd=1;
    %%Get SoundClip
   try
        
        [~, numChannels]=size(bothChannels);
        if numChannels==2
         d=((bothChannels(:,1)+bothChannels(:,2))/2)';
        else 
            d=bothChannels(:,1)';
        end
         
         if (length(d)>500000)
             d=d(1, 1:500000);
         end
         
         %%Time Domain Analysis%%
    if(any(strcmp(featureList, 'Mean')))
        full_languageInputs(full_rowInd)=mean(d);
        full_rowInd=full_rowInd+1;
    end
    if(any(strcmp(featureList, 'RMS Power')))
        full_languageInputs(full_rowInd)=rms(d);
        full_rowInd=full_rowInd+1;
    end
    if(any(strcmp(featureList, 'Pitch Period')))
        full_languageInputs(full_rowInd)=pitchperiod(d, sr);
        full_rowInd=full_rowInd+1;
    end
    if(any(strcmp(featureList, 'IPA Cross-Correlation')))
        %selectedFeature{fInd,1}=TDomainAnas{5,1};
        %fInd=fInd+1;
    end
    
    %calculating the number of frames;for windowed analysis
    winpts = round(wintime*sr);
    steppts = round(steptime*sr);
  
    WINDOW = [hanning(winpts)'];
    % hanning gives much less noisy sidelobes
    NOVERLAP = winpts - steppts;
    [numFrames, ~]=size(enframe(d, WINDOW,steppts));
    
    
    %%Frequency Analysis
    if(any(strcmp(featureList, 'Power Spectrogram')))
        tempPowSpec=powspec(d, sr);
        [numRows, ~]=size(tempPowSpec);
        windowed_languageInputs(windowed_rowInd:(windowed_rowInd+numRows-1), windowed_colEnd:(windowed_colEnd+numFrames-1))=tempPowSpec;
        windowed_rowInd=windowed_rowInd+numRows;
    end
    if(any(strcmp(featureList, 'Formant Ratios')))
        tempFormants=formants(d, sr);
        [numRows, ~]=size(tempFormants);
        windowed_languageInputs(windowed_rowInd:(windowed_rowInd+numRows-1), windowed_colEnd:(windowed_colEnd+numFrames-1))=tempFormants;
%         windowed_languageInputs(windowed_rowInd+numRows, :)=tempFormPow;
        windowed_rowInd=windowed_rowInd+numRows;

    end
    if(any(strcmp(featureList, 'IPA Coherences')))

    end
    if(any(strcmp(featureList, 'Discrete Wavelet Transform Coefficients')))

    end
    if(any(strcmp(featureList,'MFCCs')))
        tempMFCCs = melfcc(d*3.3752, sr);
        [numRows, ~]=size(tempMFCCs);
        windowed_languageInputs(windowed_rowInd:(windowed_rowInd+numRows-1), windowed_colEnd:(windowed_colEnd+numFrames-1))=tempMFCCs;
        windowed_rowInd=windowed_rowInd+numRows;
    end
    if(any(strcmp(featureList, 'Delta-MFCCs')))
        tempMFCCs = melfcc(d*3.3752, sr);
        tempDMFCCs=deltas(tempMFCCs);
        [numRows, ~]=size(tempDMFCCs);
        windowed_languageInputs(windowed_rowInd:(windowed_rowInd+numRows-1), windowed_colEnd:(windowed_colEnd+numFrames-1))=tempDMFCCs;
        windowed_rowInd=windowed_rowInd+numRows;
    end
    if(any(strcmp(featureList, 'Delta-Delta-MFCCs')))
        tempMFCCs = melfcc(d*3.3752, sr);
        tempDDMFCCs=deltas(deltas(tempMFCCs,5),5);
        [numRows, ~]=size(tempDMFCCs);
        windowed_languageInputs(windowed_rowInd:(windowed_rowInd+numRows-1), windowed_colEnd:(windowed_colEnd+numFrames-1))=tempDDMFCCs;
        windowed_rowInd=windowed_rowInd+numRows;

    end
    if(any(strcmp(featureList, 'Use RASTA filtering on the following:')))
           if(any(strcmp(featureList, 'PLPs')))
                tempPLPs = rastaplp(d, sr);
                [numRows, ~]=size(tempPLPs);
                windowed_languageInputs(windowed_rowInd:(windowed_rowInd+numRows-1), windowed_colEnd:(windowed_colEnd+numFrames-1))=tempPLPs;
                windowed_rowInd=windowed_rowInd+numRows;
            end
            if(any(strcmp(featureList, 'Delta-PLPs')))

                tempPLPs = rastaplp(d, sr);
                del = deltas(tempPLPs);
                [numRows, ~]=size(del);
                windowed_languageInputs(windowed_rowInd:(windowed_rowInd+numRows-1), windowed_colEnd:(windowed_colEnd+numFrames-1))=del;
                windowed_rowInd=windowed_rowInd+numRows;

            end
            if(any(strcmp(featureList, 'Delta-Delta-PLPs')))


                tempPLPs = rastaplp(d, sr);
                ddel = deltas(deltas(tempPLPs,5),5);
                [numRows, ~]=size(ddel);
                windowed_languageInputs(windowed_rowInd:(windowed_rowInd+numRows-1), windowed_colEnd:(windowed_colEnd+numFrames-1))=ddel;
                windowed_rowInd=windowed_rowInd+numRows;

            end        
    else
           if(any(strcmp(featureList, 'PLPs')))

                tempPLPs = rastaplp(d, sr, 0, 12);
                [numRows, ~]=size(tempPLPs);
                windowed_languageInputs(windowed_rowInd:(windowed_rowInd+numRows-1), windowed_colEnd:(windowed_colEnd+numFrames-1))=tempPLPs;
                windowed_rowInd=windowed_rowInd+numRows;

            end
            if(any(strcmp(featureList, 'Delta-PLPs')))

                tempPLPs = rastaplp(d, sr, 0, 12);
                del = deltas(tempPLPs);
                [numRows, ~]=size(del);
                windowed_languageInputs(windowed_rowInd:(windowed_rowInd+numRows-1), windowed_colEnd:(windowed_colEnd+numFrames-1))=del;
                windowed_rowInd=windowed_rowInd+numRows;

            end
            if(any(strcmp(featureList, 'Delta-Delta-PLPs')))

                tempPLPs = rastaplp(d, sr, 0, 12);
                ddel = deltas(deltas(tempPLPs,5),5);
                [numRows, ~]=size(ddel);
                windowed_languageInputs(windowed_rowInd:(windowed_rowInd+numRows-1), windowed_colEnd:(windowed_colEnd+numFrames-1))=ddel;
                windowed_rowInd=windowed_rowInd+numRows;

            end
            
    end 
    
    windowed_colEnd=windowed_colEnd+numFrames;
    catch err
        err
    end

end

