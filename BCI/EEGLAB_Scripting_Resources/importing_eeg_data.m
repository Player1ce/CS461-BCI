eeglab

% Importing EEG Data
EEG = pop_loadset('filename', 'p1.set', 'filepath', pwd );

% Edit Channels
% EEG = pop_chanedit(EEG, 'changefield', {1 'labels' 'TP9'}, 'changefield',{2 'labels' 'AF7'},'changefield',{3 'labels' 'AF8'}, 'changefield', {4 'labels' 'TP10'});

% Edit Channels
channelList = {1, 2, 3};
% EEG = pop_chanedit(EEG, 'changechantype', channelList, 'newchantypes', 'EEG');
% EEG = pop_chanedit(EEG, 'changefield', {1 'labels' 'TP9'}, 'changefield',{2 'labels' 'AF7'},'changefield',{3 'labels' 'AF8'}, 'changefield', {4 'labels' 'TP10'});

% Load EEG Lab
eeglab("redraw")

