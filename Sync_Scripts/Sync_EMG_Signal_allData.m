%Comparing Signals
cd('Z:\Users\Dulce\Nexus\EMG05\New Session')
close all
clear all
R=2;
ini=1;
data_PC1=[];
data_PC2=[];
forcedataall=[];
H=btkReadAcquisition('Trial05.c3d');
[analogs,analogsInfo]=btkGetAnalogs(H);

column=61;

for i=1:9
    
    % forcedata= expData.data{2}.GRFData.Data(1:300000,3);
    
    if i<8
        forcedata= analogs.Raw_Pin_3(ini:ini+300000)- mean(analogs.Raw_Pin_3(ini:ini+300000));
%         forcedata= analogs.Raw_Pin_3(ini:end)- mean(analogs.Raw_Pin_3(ini:end));
    else
        forcedata= analogs.Raw_Pin_3(ini:end)- mean(analogs.Raw_Pin_3(ini:end));
    end
    % forcedata= analogs.Raw_Pin_3(300001:300001+300000)- mean(analogs.Raw_Pin_3(1:300000));
    
%     load(['C:\Users\dum5\OneDrive - University of Pittsburgh\aResearch_Studies\Young_LongAdaptation\YL01\PC1\YL01\YL01_\EMG_Trial02_',num2str(i),'.mat'])
    
    load(['Z:\Users\Dulce\Nexus\EMG05\PC1\EMG05\EMG_Trial05_',num2str(i),'.mat'])
    % EMG_PC2=EMGdata(:,end);
    % EMG_PC2=EMG_PC2(1:R:end);
   
    aux1=EMGdata;%- mean(EMGdata(:,end))
    aux1=aux1(1:R:end,:);
    
    load(['Z:\Users\Dulce\Nexus\EMG05\PC2\EMG05\EMG_Trial05_',num2str(i),'.mat'])
    % EMG_PC1=EMGdata(:,end);
    % EMG_PC1=EMG_PC1(1:R:end);
    aux2=EMGdata;%- mean(EMGdata(:,end));
    aux2=aux2(1:R:end,:);
    
    
    
    
%     if i<8
        [~,~,lagInSamplesA,~] = matchSignals(forcedata,aux1(:,column));
        aux1 = resampleShiftAndScale(aux1,1,lagInSamplesA,1);
%     end
    
    
%     [~,~,lagInSamplesB,~] = matchSignals(forcedata,aux2(:,column));
%     aux2 = resampleShiftAndScale(aux2,1,lagInSamplesB,1);
    
%     if i==8
%         aux1=[zeros(50,64); aux1];
%     end
    
    if length(aux1)~=length(aux2)
        [aux1,aux2] = truncateToSameLength(aux1,aux2);
    end
    
    if length(aux1)~=length(forcedata)
        [forcedata, aux1] = truncateToSameLength(forcedata,aux1);
    
    end
    
    if length(aux2)~=length(forcedata)
        [forcedata, aux2] = truncateToSameLength(forcedata,aux2);
    end
    % [aux1,EMG_PC1] = truncateToSameLength(aux1,EMG_PC1);
    % [aux2,EMG_PC2] = truncateToSameLength(aux2,EMG_PC2);
    
    
    ini=ini+length(aux1);
    figure()
    % subplot(2,1,1)
    plot(aux1(:,column)-mean(aux1(:,column)))
    hold on
    plot(aux2(:,column)-mean(aux2(:,column)))
    hold on
    plot(forcedata,'--')
    legend('PC1','PC2','Pin3')
    % subplot(2,1,2)
    % plot(EMG_PC1-EMG_PC2)
    
 
    data_PC1=[data_PC1;aux1];
    data_PC2=[data_PC2;aux2];
    forcedataall=[forcedataall;forcedata];
end
%%
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
