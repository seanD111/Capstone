clear variables;
list = dir('Soundclips/*'); % reading all the files one by one .
clipsStruct=struct('name', [], 'phrase', [], 'phraseId', [], 'language', [], 'languageId', []);
clipsStruct(4000, 1).name=[];
clipsStructEnd=1;
languages={};
languages_count=[];
for i = 1:length(list)
    if list(i).name(1) ~= '.'
        
        lang=list(i).name(1:3);
        index=find(strcmp(languages, lang));
        
        if index
            langId=index;
        else
            languages_count(end+1, 1)=1;
            languages{end+1, 1}=lang;
            langId=length(languages);
        end
        
        clipsList=dir(strcat('Soundclips/', list(i).name, '/', 'flac/*.flac'))
        for j=1:length(clipsList)

            clipsStruct(clipsStructEnd, 1).name=strcat('Soundclips/', list(i).name, '/', 'flac/',clipsList(j).name);
            clipsStruct(clipsStructEnd, 1).phraseId=languages_count(langId, 1);
            clipsStruct(clipsStructEnd, 1).language=lang;
            clipsStruct(clipsStructEnd, 1).languageId=langId;
            languages_count(langId, 1)=languages_count(langId, 1) +1;
            clipsStructEnd=clipsStructEnd+1;
        end
    end
end 

for i = 1:length(clipsStruct)
    if clipsStruct(i).name
        filename=clipsStruct(i).name;
        info = audioinfo(filename);
        clipsStruct(i).phrase = info.Title;
    end
end 

save('clipInfos', 'clipsStruct', 'clipsStructEnd', 'languages', 'languages_count')
