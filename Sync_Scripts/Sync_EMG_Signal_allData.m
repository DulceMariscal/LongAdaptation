%Comparing Signals
% cd('C:\Users\dum5\OneDrive - University of Pittsburgh\aResearch_Studies\Young_LongAdaptation\YL03\New Session')
cd('Y:\Dulce\R01_Nimbus2021\NimG_Boyan\New Session2')
close all
clear all
t=17;
R=2;
ini=1;
data_PC1=[];
data_PC2=[];
forcedataall=[];
if t<10
    H=btkReadAcquisition(['Trial0',num2str(t),'.c3d']);
else
    H=btkReadAcquisition(['Trial',num2str(t),'.c3d']);
end
[analogs,analogsInfo]=btkGetAnalogs(H);

column=61;

tt=1;

for i=1:tt
    
    % forcedata= expData.data{2}.GRFData.Data(1:300000,3);
    
    if i<tt
        forcedata= analogs.Raw_Pin_3(ini:ini+300000)- mean(analogs.Raw_Pin_3(ini:ini+300000));
        %         forcedata= analogs.Raw_Pin_3(ini:end)- mean(analogs.Raw_Pin_3(ini:end));
    else
        forcedata= analogs.Raw_Pin_3(ini:end)- mean(analogs.Raw_Pin_3(ini:end));
    end
    % forcedata= analogs.Raw_Pin_3(300001:300001+300000)- mean(analogs.Raw_Pin_3(1:300000));
    
    %     load(['C:\Users\dum5\OneDrive - University of Pittsburgh\aResearch_Studies\Young_LongAdaptation\YL01\PC1\YL01\YL01_\EMG_Trial02_',num2str(i),'.mat'])
    
    %     load(['C:\Users\dum5\OneDrive - University of Pittsburgh\aResearch_Studies\Young_LongAdaptation\YL03\PC1\EMG_Trial04_',num2str(i),'.mat'])
    if t<10
        load(['Y:\Dulce\R01_Nimbus2021\NimG_Boyan\EMG\Session 2\PC1\Rename\EMG_Trial0',num2str(t),'_',num2str(i),'.mat'])
    else
        load(['Y:\Dulce\R01_Nimbus2021\NimG_Boyan\EMG\Session 2\PC1\Rename\EMG_Trial',num2str(t),'_',num2str(i),'.mat'])
    end
    % EMG_PC2=EMGdata(:,end);
    % EMG_PC2=EMG_PC2(1:R:end);
    
    aux1=EMGdata2;%- mean(EMGdata(:,end))
    aux1=aux1(1:R:end,:);
    
    %     load(['C:\Users\dum5\OneDrive - University of Pittsburgh\aResearch_Studies\Young_LongAdaptation\YL03\PC2\EMG_Trial04_',num2str(i),'.mat'])
    if t<10
        load(['Y:\Dulce\R01_Nimbus2021\NimG_Boyan\EMG\Session 2\PC2\Rename\EMG_Trial0',num2str(t),'_',num2str(i),'.mat'])
    else
        load(['Y:\Dulce\R01_Nimbus2021\NimG_Boyan\EMG\Session 2\PC2\Rename\EMG_Trial',num2str(t),'_',num2str(i),'.mat'])
    end
    % EMG_PC1=EMGdata(:,end);
    % EMG_PC1=EMG_PC1(1:R:end);
    aux2=EMGdata2;%- mean(EMGdata(:,end));
    aux2=aux2(1:R:end,:);
    
    
    
    
    %     if i<8
    [~,~,lagInSamplesA,~] = matchSignals(forcedata,aux1(:,column));
    aux1 = resampleShiftAndScale(aux1,1,lagInSamplesA,1);
    %     end
    
    
    [~,~,lagInSamplesB,~] = matchSignals(forcedata,aux2(:,column));
    aux2 = resampleShiftAndScale(aux2,1,lagInSamplesB,1);
    
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
    
    
    ini=ini+length(aux1);
    figure()
    % subplot(2,1,1)
    plot(aux1(:,column)-mean(aux1(:,column)))
    hold on
    plot(aux2(:,column)-mean(aux2(:,column)))
    hold on
    plot(forcedata,'--')
    legend('PC1','PC2','Pin3')
    if t<10
        title(['Trial0',num2str(t)])
    else
        title(['Trial',num2str(t)])
    end
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
