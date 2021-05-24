% Script to concatenate individual EMG trial data and force data seperately
% Created 5/24/2021
% Last Updated 5/24/2021

close all;
clear all;
clc
% cd('Y:\Dulce\R01_Nimbus2021\NimG_Boyan\New Session2')

% Assign locations of data
nexus='Y:\Dulce\R01_Nimbus2021\CTR_01\New Session';
PC1='Y:\Dulce\R01_Nimbus2021\CTR_01\PC1';
PC2='Y:\Dulce\R01_Nimbus2021\CTR_01\PC2';

cd(nexus)
%% Data info
t=13;
tt=2;
R=2;
ini=1;
data_PC1=[];
data_PC2=[];
forcedataall=[];

if t<10     %Trial number is less than 10 so 0 before number
    H=btkReadAcquisition(['Trial0',num2str(t),'.c3d']);
else        %Trial numbers above 10 don't have 0 before trial number
    H=btkReadAcquisition(['Trial',num2str(t),'.c3d']);
end
[analogs,analogsInfo]=btkGetAnalogs(H);

column=61;

%% Concatenate EMG Trial Data
% sampled at 2000 Hz, so need to cut data down by half (R = 2) to get at
% same sampling frequency as force data (1000 Hz)

load([PC1,'\EMG_Trial13_1']);
EMGDataPC1_1 = EMGdata;
load([PC1,'\EMG_Trial13_2']);
EMGDataPC1_2 = EMGdata;
data_PC1 = [EMGDataPC1_1;EMGDataPC1_2];

aux1 = data_PC1;%- mean(EMGdata(:,end));
    aux1=aux1(1:R:end,:);
    
load([PC2,'\EMG_Trial13_1']);
EMGDataPC2_1 = EMGdata;
load([PC2,'\EMG_Trial13_2']);
EMGDataPC2_2 = EMGdata;
data_PC2 = [EMGDataPC2_1;EMGDataPC2_2];

aux2=data_PC2;%- mean(EMGdata(:,end));
    aux2=aux2(1:R:end,:);

%% Force Data
% Pin 3 contains force data (analogs.Raw_Pin_3)
% sampled at 1000 Hz

forcedata = analogs.Raw_Pin_3;

%% Match signals and truncate data to same length

[~,~,lagInSamplesA,~] = matchSignals(forcedata,aux1(:,column));
    aux1 = resampleShiftAndScale(aux1,1,lagInSamplesA,1);
    
[~,~,lagInSamplesB,~] = matchSignals(forcedata,aux2(:,column));
    aux2 = resampleShiftAndScale(aux2,1,lagInSamplesB,1);

if length(aux1)~=length(aux2)
    [aux1,aux2] = truncateToSameLength(aux1,aux2);
end
    
if length(aux1)~=length(forcedata)
    [forcedata, aux1] = truncateToSameLength(forcedata,aux1);
end

if length(aux2)~=length(forcedata)
    [forcedata, aux2] = truncateToSameLength(forcedata,aux2);
end

data_PC1=aux1;
 
data_PC2=aux2;

%% Plot figures
figure()
plot(analogs.Raw_Pin_3-mean(analogs.Raw_Pin_3))
hold on
plot(forcedataall)

figure()
plot(analogs.Raw_Pin_3-mean(analogs.Raw_Pin_3))
hold on
plot(data_PC1(:,column)- mean(data_PC1(:,column)))
hold on
plot(data_PC2(:,column)- mean(data_PC2(:,column)))
legend('Force','PC1','PC2')

figure()
plot(data_PC1(:,column)- mean(data_PC1(:,column))-(data_PC2(:,column)- mean(data_PC2(:,column))))
ylim([-0.25 0.2])
ylabel('PC1 - PC2 (mV)')

cd(PC1)
load('Names.mat')
Data=data_PC1';
if t<10
    save(['Trial0', num2str(t)],'Channels','Data','Fs')
else
    save(['Trial', num2str(t)],'Channels','Data','Fs')
end

cd(PC2)
load('Names.mat')
Data=data_PC2';
if t<10
    save(['Trial0', num2str(t)],'Channels','Data','Fs')
else
    save(['Trial', num2str(t)],'Channels','Data','Fs')
end
cd(PC1)


