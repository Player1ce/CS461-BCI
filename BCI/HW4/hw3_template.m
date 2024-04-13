global globalTotalEpochs
globalTotalEpochs = 109;

global globalSampleRate
globalSampleRate = 220;

dataSetName = "p1.set";

EEGData = loadData(dataSetName, pwd);

saveEpochs(1,1)
%compareBandPower(32)
%getHighestAlpha()

function EEGData = loadData(fileName, filePath) 
    if nargin < 3, filePath = pwd; end
    % Importing EEG Data
    EEGData = pop_loadset('filename', fileName, 'filepath', filePath);

    % Edit Channels
    EEG = pop_chanedit(EEG, 'changefield',{1 'labels' 'TP9'}, 'changefield',{2 'labels' 'AF7'},'changefield',{3 'labels' 'AF8'}, 'changefield', {4 'labels' 'TP10'});
end

function epoch = getEpoch(EEGData, channelNumber, epochIndex) 
    epoch = EEGData.data(channelNumber,:,epochIndex);
end

function plotEpoch(epoch, sampleRate) 
    if nargin < 4, sampleRate = globalSampleRate; end
    
    % Plot the Epoch
    x = (1:sampleRate)*(1000/sampleRate);

    figure
    plot(x, epoch)
end

function power = getBandPower(epoch, lowerFreq, upperFreq, sampleRate)
    if nargin < 4, sampleRate = globalSampleRate; end

    [pxx, freq] = pwelch(epoch, [],[], [], sampleRate);

    % Get Alpha Power
    power = bandpower(pxx, freq, [lowerFreq, upperFreq] , 'psd');
end

function plotBandPower(powers, channelNames, channelNumber)
    % Plot Band Power (Bar Plot)
    x = categorical(channelNames);
    y = powers;
    
    % Create Figure
    figure
    bar(x,y)
    title(['Channel ' num2str(channelNumber)])
end

function savePlot(fileName)
    saveas(gcf, fileName)
end


% Create a MATLAB function that generates and saves line plots of multiple 
% epochs and channels. The numEpochs parameter should determine the number of
% epochs to save. The numChannels parameter should determine the number of 
% channels to save. 
function saveEpochs(numEpochs, numChannels)
    for i = 0:numChannels
        for j = 0:numEpochs
        epoch = getEpoch(EEG, i, j);
        plotEpoch(epoch, globalSampleRate);
        plotName = append(dataSetName,"_ch", i, "_ep", j,".png");
        savePlot(plotName);
        end
    end
end



% Complete the function below to generate 4 bar plots that compares delta, theta, alpha, and beta band
% power of 1 epoch. Each bar plot should reflect a different channel.
function compareBandPower(epochNumber)

end

% Create a matlab function that finds the epoch with the highest alpha
% power in channel. The function should print out the epoch number and
% alpha value.
function getHighestAlpha()

end
