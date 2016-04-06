function [ tableHandle_out ] = refreshPhonemeTable( tableHandle )
%REFRESHPHONEMETABLE Display all the phoneme directories and ipa in the
%phonemes directory
%   Call the function with the table handle you wish to update
rootDir='data/phonemes/';
dirlist=dir(rootDir);
phonemeList=struct('ipaLib', {}, 'phonemes', {}, 'clipCount', []);
allFiles=getAllFiles(rootDir);
for i=1:length(dirlist)
    if dirlist(i).name(1)~='.'
        phonemeList(end+1, 1).ipaLib=dirlist(i).name;
        ipaDir=dir(strcat(rootDir, phonemeList(end, 1).ipaLib));
        
        for j=1:length(ipaDir)
            if ipaDir(j).name(1)~='.'
                phonemeList(end, 1).phonemes{end+1, 1}=ipaDir(j).name;
                
                
                
            end
        end
        
    end
end

for i=1:length(phonemeList)
    [phonemeList(i).clipCount, ~]=size(phonemeList(i).phonemes);

    


end

colnames={'IPA Lib Count', 'Include In Analysis'};
colformat = {'numeric','logical'};
rowcount=0;
for i=1:length(phonemeList)
    rowcount=rowcount+1;
    
end
rownames=cell(1, rowcount);
rowdata=cell(rowcount, 2);
rowend=1;
for i=1:length(phonemeList)
    rownames(rowend)={phonemeList(i).ipaLib};
    rowColors(rowend, :)=[0.9 0.9 0.9];
    rowdata(rowend, :)={sum(phonemeList(i).clipCount) true};
    rowend=rowend+1;


end

tableHandle.ColumnName=colnames;
tableHandle.RowName=rownames;
tableHandle.Data=rowdata;
tableHandle.ColumnEditable=[false true];
tableHandle.BackgroundColor=rowColors;

end

