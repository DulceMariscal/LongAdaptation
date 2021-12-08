%cvs2mat EMG data 

dir1='S:\Shared\Dulce\EMG_Generalization\ATS03\PC1';
dir2='S:\Shared\Dulce\EMG_Generalization\ATS03\PC2';
trials= [3:16];
% trials=[19];
Getting_EMGdata_Csv2mat(dir1, trials)
Getting_EMGdata_Csv2mat(dir2, trials)


