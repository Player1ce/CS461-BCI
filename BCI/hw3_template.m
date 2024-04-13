global globalTotalEpochs
globalTotalEpochs = 109;

global globalSampleRate
globalSampleRate = 220;

global dataSetName;
dataSetName = 'p1.set';

global beginningDataSetName;
beginningDataSetName = 'p1';
 
% EEGData = loadData(dataSetName);
global EEG;
EEG = loadData(dataSetName);

saveEpochs(1,2)
compareBandPower(32)
getHighestAlpha()

function EEGDataOutput = loadData(fileName, filePath) 
    if nargin < 3, filePath = pwd; end
    % Importing EEG Data
    EEGDataOutput = pop_loadset('filename', fileName, 'filepath', filePath);

    % Edit Channels
    EEGDataOutput = pop_chanedit(EEGDataOutput, 'changefield',{1 'labels' 'TP9'}, 'changefield',{2 'labels' 'AF7'},'changefield',{3 'labels' 'AF8'}, 'changefield', {4 'labels' 'TP10'});
end

function epoch = getEpoch(EEGData, channelNumber, epochIndex) 
    epoch = EEGData.data(channelNumber,:,epochIndex);
end

function plotEpoch(epoch, sampleRate) 
    global globalSampleRate;
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

function plotBandPower(powers, powerNames, channelNumber)
    % Plot Band Power (Bar Plot)
    x = categorical(powerNames);
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
function saveEpochsInput(EEGData, numEpochs, numChannels)
    global dataSetNameBeginning;
    for i = 1:numChannels
        for j = 1:numEpochs
        epoch = getEpoch(EEGData, i, j);
        plotEpoch(epoch, globalSampleRate);
        plotName = append(dataSetNameBeginning,"_ch", i, "_ep", j,".png");
        savePlot(plotName);
        end
    end
end

function saveEpochs(numEpochs, numChannels)
    global EEG;
    global globalSampleRate;
    global dataSetName;
    for i = 1:numChannels
        for j = 1:numEpochs
        epoch = getEpoch(EEG, i, j);
        plotEpoch(epoch, globalSampleRate);
        plotName = append(string(dataSetName),'-ch', string(i), '-ep', string(j),'.png');
        savePlot(plotName);
        end
    end
end



% Complete the function below to generate 4 bar plots that compares delta, theta, alpha, and beta band
% power of 1 epoch. Each bar plot should reflect a different channel.
function compareBandPower(epochNumber)
    global EEG;
    global globalSampleRate;
    epoch = getEpoch(EEG, 1, epochNumber);
    delta = getBandPower(epoch, 1, 3, globalSampleRate);
    theta = getBandPower(epoch, 4, 8, globalSampleRate);
    alpha = getBandPower(epoch, 9, 14, globalSampleRate);
    beta = getBandPower(epoch, 15,30, globalSampleRate);

    plotBandPower([delta, theta, alpha, beta], string(['Delta', 'Theta', 'Alpha', 'Beta']), 1);
end

% Create a matlab function that finds the epoch with the highest alpha
% power in channel. The function should print out the epoch number and
% alpha value.
function getHighestAlpha()
    global EEG;
    global globalTotalEpochs;
    global globalSampleRate;

    maxAlpha = 0;
    maxEpoch = 0;

    for i = 1:globalTotalEpochs
        alpha = getBandPower(getEpoch(EEG, 1, i), 9, 14, globalSampleRate);
        if alpha > maxAlpha
            maxAlpha = alpha;
            maxEpoch = i;
        end
    end
    disp([num2str(maxEpoch) '   ' num2str(maxAlpha)])
end