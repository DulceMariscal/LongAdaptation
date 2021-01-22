%Comparing Signals
close all
clear all
R=2;
ini=1;
data_PC1=[];
data_PC2=[];
forcedataall=[];
% H=btkReadAcquisition('Trial02.c3d');
% [analogs,analogsInfo]=btkGetAnalogs(H);

for i=1:7
    
    % forcedata= expData.data{2}.GRFData.Data(1:300000,3);
    
%     if i<8
%         forcedata= analogs.Raw_Pin_3(ini:ini+300000)- mean(analogs.Raw_Pin_3(ini:ini+300000));
%     else
%         forcedata= analogs.Raw_Pin_3(ini:end)- mean(analogs.Raw_Pin_3(ini:end));
%     end
    % forcedata= analogs.Raw_Pin_3(300001:300001+300000)- mean(analogs.Raw_Pin_3(1:300000));
    
    load(['C:\Users\dum5\OneDrive - University of Pittsburgh\aResearch_Studies\Young_LongAdaptation\YL01\PC1\YL01\YL01_\EMG_Trial02_',num2str(i),'.mat'])
    % EMG_PC2=EMGdata(:,end);
    % EMG_PC2=EMG_PC2(1:R:end);
    
    aux1=EMGdata(:,end);%- mean(EMGdata(:,end));
    aux1=aux1(1:R:end);
    
    load(['C:\Users\dum5\OneDrive - University of Pittsburgh\aResearch_Studies\Young_LongAdaptation\YL01\PC2\YL01_Trial01\EMG_Trial02_',num2str(i),'.mat'])
    % EMG_PC1=EMGdata(:,end);
    % EMG_PC1=EMG_PC1(1:R:end);
    
    aux2=EMGdata(:,end);%- mean(EMGdata(:,end));
    aux2=aux2(1:R:end);
    
    
    
%     
%     if i<8
%         [~,~,lagInSamplesA,~] = matchSignals(forcedata,aux1);
%         aux1 = resampleShiftAndScale(aux1,1,lagInSamplesA,1);
%     end
%     
%     
%     [~,~,lagInSamplesB,~] = matchSignals(forcedata,aux2);
%     aux2 = resampleShiftAndScale(aux2,1,lagInSamplesB,1);
%     
%     if length(aux1)~=length(aux2)
%         [aux1,aux2] = truncateToSameLength(aux1,aux2);
%     end
%     
%     if length(aux1)~=length(forcedata)
%         [forcedata, aux1] = truncateToSameLength(forcedata,aux1);
%     
%     end
%     
%     if length(aux2)~=length(forcedata)
%         [forcedata, aux2] = truncateToSameLength(forcedata,aux2);
%     end
    % [aux1,EMG_PC1] = truncateToSameLength(aux1,EMG_PC1);
    % [aux2,EMG_PC2] = truncateToSameLength(aux2,EMG_PC2);
    
%     ini=ini+length(aux1);
    figure()
    % subplot(2,1,1)
    plot(aux1-mean(aux1))
    hold on
    plot(aux2-mean(aux2))
    hold on
%     plot(forcedata,'--')
    legend('PC1','PC2')
    % subplot(2,1,2)
    % plot(EMG_PC1-EMG_PC2)
    
    
    data_PC1=[data_PC1;aux1];
    data_PC2=[data_PC2;aux2];
%     forcedataall=[forcedataall;forcedata];
end
%%
% figure()
% plot(analogs.Raw_Pin_3-mean(analogs.Raw_Pin_3))
% hold on
% plot(forcedataall)

figure()
% plot(analogs.Raw_Pin_3-mean(analogs.Raw_Pin_3))
hold on
plot(data_PC1- mean(data_PC1))
hold on
plot(data_PC2- mean(data_PC2))
legend('Force','PC1','PC2')

figure()
plot(data_PC1- mean(data_PC1)-(data_PC2- mean(data_PC2)))
% ylim([-0.25 0.2])
ylabel('PC1 - PC2 (mV)')