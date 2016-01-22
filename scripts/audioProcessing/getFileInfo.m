function [ clipInfos ] = getFileInfo( directory )
%getFileInfo Fetches the information of each sound clip in the given
%directory
%   getFileInfo goes into each directory (which are named based on
%   language), and creates a structure containing the relative directory to
%   each file and names the phrase based on its title information.
%   The function returns the entire structure containing the soundclips,
%   its length, the languages of the soundclips, and how many languages
%   there are in total.
%   Directory must have foldernames that start with three letter language
%   tags (ie 'fra', 'eng', or 'ukr').
%Example: soundclips stored in: directory/fra/flac/*.flac
%   [soundClips, soundClips_count, languages, languages_count ] =  getFileInfo('SoundClips')

list = dir(strcat(directory, '/*')); % reading all the files one by one .
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
        
        clipsList=dir(strcat(directory, '/', list(i).name, '/', 'flac/*.flac'))
        for j=1:length(clipsList)

            clipsStruct(clipsStructEnd, 1).name=strcat(directory, '/', list(i).name, '/', 'flac/',clipsList(j).name);
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

clipInfos={clipsStruct, clipsStructEnd-1, languages, languages_count};
end

