y=0;
while y >= 0
    
    incoming_data=getAllFiles('incoming_data/');
    if ~isempty(incoming_data)        
        try
            [signal, fs]=audioread(incoming_data{1,1});
            [predictRatios, predictLanguages]=give_prediction(signal, fs, 6);
            
            save(strcat('data/user_inputs/', incoming_data{1,1}, '.mat'), 'predictRatios', 'predictLanguages', 'signal', 'fs')
            delete(incoming_data{1,1})
                x.ratios=predictRatios;
                x.languages=predictLanguages;
                savejson('',x,'matlab_node/matlabData.json');
        catch err
        end
    end

end