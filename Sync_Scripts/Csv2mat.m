%cvs2mat EMG data (Create the EMG mat files from the csv files)

clc
close all
clear all


dirNexus='Y:\Marcela\Perception Studies\Weber Perception\Data\WP01\Session 1';
dir1='Y:\Marcela\Perception Studies\Weber Perception\Data\WP01\Session 1\EMG';

% Leave empty if you only use one computer
dir2=[];

trialNumber= [6:12]; % List of the trial numbers from the session

% Generate the empty mat files from the
Getting_EMGdata_Csv2mat(dir1, trialNumber)

if ~isempty(dir2)
    Getting_EMGdata_Csv2mat(dir2, trialNumber)    
end


% Syncronize EMG signals 

Sync_EMG_Signal_allData(dirNexus, dir1, dir2, trialNumber);


