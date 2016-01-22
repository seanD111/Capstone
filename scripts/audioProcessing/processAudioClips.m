function [ clipsInfoOut ] = addMFCCs( clipsInfoIn )
%addMFCCs add MFCCs to the sound clip structure
%   Detailed explanation goes here
clipsStruct=clipsInfoIn{1,1};
clipsStructEnd=clipsInfoIn{1,2};
languages=clipsInfoIn{1,3};

windowLen=0.04;
numMFCCs=200;
languageInputsClass(13, clipsStructEnd*(numMFCCs+5))=0;
languageInputs_word(13, clipsStructEnd*(numMFCCs+5))=0;
languageTargetsClass(length(languages), clipsStructEnd*(numMFCCs+5))=0;
languageTargets_word(2, clipsStructEnd*(numMFCCs+5))=0;
for i=1:length(clipsStruct) 
    try
        [d,sr] = audioread(clipsStruct(i).name);
        windowHop=(length(d)/sr)/numMFCCs-(windowLen/numMFCCs)  ;

        [mm,aspc] = melfcc(d*3.3752, sr, 'maxfreq', sr/2, 'numcep', 13, 'nbands', 26, 'fbtype', 'fcmel', 'dcttype', 1, 'usecmp', 1, 'wintime', windowLen, 'hoptime', windowHop, 'preemph', 0, 'dither', 0);

        clipsStruct(i).MFCCs=mm;
        
        
    catch except
        'Error loading file';
    end
end
for i=1:clipsStructEnd-1
    languageInputsClass(:, (numMFCCs*(i-1)+1):(numMFCCs*i))=clipsStruct(i).MFCCs(:, 1:numMFCCs);
    
    languageTargets_word(1, (numMFCCs*(i-1)+1):(numMFCCs*i))=clipsStruct(i).languageId;
    languageTargets_word(2, (numMFCCs*(i-1)+1):(numMFCCs*i))=clipsStruct(i).phraseId;
    languageTargetsClass(clipsStruct(i).languageId, (numMFCCs*(i-1)+1):(numMFCCs*i))=1;
end
% languageInputs_word=languageInputsClass;
% save('NeuralNetworkVars', 'clipsStruct', 'languageInputsClass', 'languageTargetsClass', 'languageInputs_word', 'languageTargets_word' )
%%number of mfcc samples:%%
% #mfcc=(length(d)/sr)/windowHop)-windowLength/windowHop
% 
clipsInfoOut=clipsInfoIn;
clipsInfoOut{1,1}=clipsStruct;

end

