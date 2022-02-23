%cvs2mat EMG data (Create the EMG mat files from the csv files)

dir1='Y:\Marcela\Perception Studies\Weber Perception\Data\WP01\Session 1\EMG';
% dir2='S:\Shared\Dulce\EMG_Generalization\ATS03\PC2';
trials= [6:12];
% trials=[19];
Getting_EMGdata_Csv2mat(dir1, trials)
% Getting_EMGdata_Csv2mat(dir2, trials)


