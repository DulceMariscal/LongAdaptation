% Script to concatenate individual EMG trial data and force data seperately
% Include trial number as t
% Include number of subdivisions of data that you are trying to concatenate
% in tt
% Created 5/24/2021
% Last Updated 7/9/2021

close all;
clear all;
clc

% update subject ID
subID = 'PATR06'; 

% Assign locations of data
nexus=['Z:\Shared\Dulce\EMG_Generalization\',subID,'\New Session'];
PC1=['Z:\Shared\Dulce\EMG_Generalization\',subID,'\PC1'];
PC2=['Z:\Shared\Dulce\EMG_Generalization\',subID,'\PC2'];

cd(nexus)
%% Data info
% update t and tt
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

% column_PC1=55;
% column_PC2=67;

%% Concatenate EMG Trial Data
% sampled at 2000 Hz, so need to cut data down by half (R = 2) to get at
% same sampling frequency as force data (1000 Hz)

%% PC1 trial concatenation
switch tt
    case(1)
        load([PC1,'\EMG_Trial',num2str(t,'%02d'),'_1']);
        EMGDataPC1_1 = EMGdata;
        data_PC1 = EMGDataPC1_1;
%         column_PC1= size(EMGDataPC1_1,2)-3;
        
    case(2)
        load([PC1,'\EMG_Trial',num2str(t,'%02d'),'_1']);
        EMGDataPC1_1 = EMGdata;
        load([PC1,'\EMG_Trial',num2str(t,'%02d'),'_2']);
        EMGDataPC1_2 = EMGdata;
        data_PC1 = [EMGDataPC1_1;EMGDataPC1_2];
%         column_PC1= size(EMGDataPC1_1,2)-3;
    case(3)
        load([PC1,'\EMG_Trial',num2str(t,'%02d'),'_1']);
        EMGDataPC1_1 = EMGdata;
        load([PC1,'\EMG_Trial',num2str(t,'%02d'),'_2']);
        EMGDataPC1_2 = EMGdata;
        load([PC1,'\EMG_Trial',num2str(t,'%02d'),'_3']);
        EMGDataPC1_3 = EMGdata;
        data_PC1 = [EMGDataPC1_1;EMGDataPC1_2;EMGDataPC1_3];
%         column_PC1= size(EMGDataPC1_1,2)-3;
    case(4)
        load([PC1,'\EMG_Trial',num2str(t,'%02d'),'_1']);
        EMGDataPC1_1 = EMGdata;
        load([PC1,'\EMG_Trial',num2str(t,'%02d'),'_2']);
        EMGDataPC1_2 = EMGdata;
        load([PC1,'\EMG_Trial',num2str(t,'%02d'),'_3']);
        EMGDataPC1_3 = EMGdata;
        load([PC1,'\EMG_Trial',num2str(t,'%02d'),'_4']);
        EMGDataPC1_4 = EMGdata;
%         column_PC1= size(EMGDataPC1_1,2)-3;
        data_PC1 = [EMGDataPC1_1;EMGDataPC1_2;EMGDataPC1_3;EMGDataPC1_4];
    case(5)
        load([PC1,'\EMG_Trial',num2str(t,'%02d'),'_1']);
        EMGDataPC1_1 = EMGdata;
        load([PC1,'\EMG_Trial',num2str(t,'%02d'),'_2']);
        EMGDataPC1_2 = EMGdata;
        load([PC1,'\EMG_Trial',num2str(t,'%02d'),'_3']);
        EMGDataPC1_3 = EMGdata;
        load([PC1,'\EMG_Trial',num2str(t,'%02d'),'_4']);
        EMGDataPC1_4 = EMGdata;
        load([PC1,'\EMG_Trial',num2str(t,'%02d'),'_5']);
        EMGDataPC1_5 = EMGdata;
        %         column_PC1= size(EMGDataPC1_1,2)-3;
        data_PC1 = [EMGDataPC1_1;EMGDataPC1_2;EMGDataPC1_3;EMGDataPC1_4;EMGDataPC1_5];
end

%% PC2
switch tt
    case(1)
        load([PC2,'\EMG_Trial',num2str(t,'%02d'),'_1']);
        EMGDataPC2_1 = EMGdata;
        data_PC2 = EMGDataPC2_1;
    case(2)
        load([PC2,'\EMG_Trial',num2str(t,'%02d'),'_1']);
        EMGDataPC2_1 = EMGdata;
        load([PC2,'\EMG_Trial',num2str(t,'%02d'),'_2']);
        EMGDataPC2_2 = EMGdata;
        data_PC2 = [EMGDataPC2_1;EMGDataPC2_2];
    case(3)
        load([PC2,'\EMG_Trial',num2str(t,'%02d'),'_1']);
        EMGDataPC2_1 = EMGdata;
        load([PC2,'\EMG_Trial',num2str(t,'%02d'),'_2']);
        EMGDataPC2_2 = EMGdata;
        load([PC2,'\EMG_Trial',num2str(t,'%02d'),'_3']);
        EMGDataPC2_3 = EMGdata;
        data_PC2 = [EMGDataPC2_1;EMGDataPC2_2;EMGDataPC2_3];
    case(4)
        load([PC2,'\EMG_Trial',num2str(t,'%02d'),'_1']);
        EMGDataPC2_1 = EMGdata;
        load([PC2,'\EMG_Trial',num2str(t,'%02d'),'_2']);
        EMGDataPC2_2 = EMGdata;
        load([PC2,'\EMG_Trial',num2str(t,'%02d'),'_3']);
        EMGDataPC2_3 = EMGdata;
        load([PC2,'\EMG_Trial',num2str(t,'%02d'),'_4']);
        EMGDataPC2_4 = EMGdata;
        data_PC2 = [EMGDataPC2_1;EMGDataPC2_2;EMGDataPC2_3;EMGDataPC2_4];
    case(5)
        load([PC2,'\EMG_Trial',num2str(t,'%02d'),'_1']);
        EMGDataPC2_1 = EMGdata;
        load([PC2,'\EMG_Trial',num2str(t,'%02d'),'_2']);
        EMGDataPC2_2 = EMGdata;
        load([PC2,'\EMG_Trial',num2str(t,'%02d'),'_3']);
        EMGDataPC2_3 = EMGdata;
        load([PC2,'\EMG_Trial',num2str(t,'%02d'),'_4']);
        EMGDataPC2_4 = EMGdata;
        load([PC2,'\EMG_Trial',num2str(t,'%02d'),'_5']);
        EMGDataPC2_5 = EMGdata;
        data_PC2 = [EMGDataPC2_1;EMGDataPC2_2;EMGDataPC2_3;EMGDataPC2_4;EMGDataPC2_5];
end
load([PC1,'\EMG_Trial',num2str(t,'%02d'),'_1']);
Channels1=Channels;
Fs1=Fs;
column_PC1= size(EMGDataPC1_1,2)-3;
load([PC2,'\EMG_Trial',num2str(t,'%02d'),'_1']);
Channels2=Channels;
Fs2=Fs;
column_PC2= size(EMGDataPC2_1,2)-3;
       
aux1 = data_PC1;%- mean(EMGdata(:,end));
    aux1=aux1(1:R:end,:);
    

aux2=data_PC2;%- mean(EMGdata(:,end));
    aux2=aux2(1:R:end,:);

%% Force Data
% Pin 3 contains force data (analogs.Raw_Pin_3)
% sampled at 1000 Hz

forcedata = analogs.Raw_Pin_3;

%% Match signals and truncate data to same length

[~,~,lagInSamplesA,~] = matchSignals(forcedata,aux1(:,column_PC1));
    aux1 = resampleShiftAndScale(aux1,1,lagInSamplesA,1);
    
[~,~,lagInSamplesB,~] = matchSignals(forcedata,aux2(:,column_PC2));
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
plot(data_PC1(:,column_PC1)- mean(data_PC1(:,column_PC1)))
hold on
plot(data_PC2(:,column_PC2)- mean(data_PC2(:,column_PC2)))
legend('Force','PC1','PC2')

figure()
plot(data_PC1(:,column_PC1)- mean(data_PC1(:,column_PC1))-(data_PC2(:,column_PC2)- mean(data_PC2(:,column_PC2))))
ylim([-0.25 0.2])
ylabel('PC1 - PC2 (mV)')

cd(PC1)
% load('Names.mat')
Data=data_PC1';
Channels=Channels1;
Fs=Fs1;
if t<10
    save(['Trial0', num2str(t)],'Channels','Data','Fs')
else
    save(['Trial', num2str(t)],'Channels','Data','Fs')
end

cd(PC2)

% load('Names.mat')
Data=data_PC2';
Channels=Channels2;
Fs=Fs2;
if t<10
    save(['Trial0', num2str(t)],'Channels','Data','Fs')
else
    save(['Trial', num2str(t)],'Channels','Data','Fs')
end
cd(PC1)


