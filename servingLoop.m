format LONGG
y=0;
while y >= 0
    
    incoming_data=getAllFiles('incoming_data/');
    for i = 1:length(incoming_data)
         if ~isempty(incoming_data) 
            if isempty(strfind(incoming_data{i, 1}, '.gitignore'))
                                        
                try
                    [signal, fs]=audioread(incoming_data{i,1});
                    [predictRatios, predictLanguages]=give_prediction(signal, fs, 7);

                    save(strcat('data/user_inputs/', incoming_data{i,1}, '.mat'), 'predictRatios', 'predictLanguages', 'signal', 'fs')
                    delete(incoming_data{i,1})
                        [sortedRatios, sortI]=sort(predictRatios, 'descend');
                        x.ratios=sortedRatios;
                        x.languages=predictLanguages(sortI);
                        savejson('',x,'matlab_node/matlabData.json');
                catch err
                end
            end
        end
        
    end
end