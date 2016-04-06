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

colnames={'Speech File Count', 'Include In Analysis'};
colformat = {'numeric','logical'};
rowcount=0;
for i=1:length(corpusList)
    rowcount=rowcount+1+corpusList(i).langCount;
    
end
rownames=cell(1, rowcount);
rowdata=cell(rowcount, 2);
rowend=1;
for i=1:length(corpusList)
    rownames(rowend)={corpusList(i).name};
    rowColors(rowend, :)=[0.9 0.9 0.9];
    rowdata(rowend, :)={sum(corpusList(i).clipCount) true};
    rowend=rowend+1;
    for j=1:corpusList(i).langCount
        rownames(rowend)=corpusList(i).languages(j);
        rowColors(rowend, :)=[1 1 1];
        rowdata(rowend, :)={corpusList(i).clipCount(j) true};
        rowend=rowend+1;
    end

end

tableHandle.ColumnName=colnames;
tableHandle.RowName=rownames;
tableHandle.Data=rowdata;
tableHandle.ColumnEditable=[false true];
tableHandle.BackgroundColor=rowColors;

end

