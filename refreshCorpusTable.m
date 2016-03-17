function [ tableHandle_out ] = refreshCorpusTable( tableHandle )
%REFRESHCORPUSTABLE Display all the corpus directories and languages in the inputted table handle
%   Call the function with the table handle you wish to update
rootDir='data/corpus/';
dirlist=dir(rootDir);
corpusList=struct('name', {}, 'langCount', [], 'languages', {}, 'clipCount', []);
allFiles=getAllFiles(rootDir);
for i=1:length(dirlist)
    if dirlist(i).name(1)~='.'
        corpusList(end+1, 1).name=dirlist(i).name;
        corpDir=dir(strcat(rootDir, corpusList(end, 1).name));
        
        for j=1:length(corpDir)
            if corpDir(j).name(1)~='.'
                corpusList(end, 1).languages{end+1, 1}=corpDir(j).name;
                
                
                
            end
        end
        
    end
end

for i=1:length(corpusList)
    [corpusList(i).langCount, ~]=size(corpusList(i).languages);
    
    for j=1:length(corpusList(i).languages)

        fileList = getAllFiles(strcat(rootDir, corpusList(i).name,'/',corpusList(i).languages{j},'/'));
        corpusList(i).clipCount(j,1)=length(fileList);
    end
    


end


end

