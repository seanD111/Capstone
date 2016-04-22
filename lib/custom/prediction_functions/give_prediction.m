function [ predictionRatios, predictionLangs ] = give_prediction( bothChannels, sr, configNumber)
%GIVE_PREDICTION Outputs the likeliness that the input signal and frequency
%are classified as each language based on  a configuration
%   Detailed explanation goes here
load(strcat('data\processed\configuration', num2str(configNumber),'.mat'));
fstr = strcat('config', num2str(configNumber), '_prediction');
predictionFn = str2func(fstr);

[full_inputs, windowed_inputs]=prep_newData(bothChannels, sr, selectedFeature(:, 1));

windowed_out=predictionFn(windowed_inputs);

predictionRatios=mean(windowed_out');
predictionLangs=allLangs;
end

