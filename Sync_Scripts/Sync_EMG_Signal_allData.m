%Comparing Signals
clc
close all
clear all

% Define the required variables
subID = 'WP01';

nexus=['Y:\Marcela\Perception Studies\Weber Perception\Data\',subID,'\Session 1'];
PC1=['Y:\Marcela\Perception Studies\Weber Perception\Data\',subID,'\Session 1\EMG'];

% Leave empty if you only use one computer
PC2=[];

ts = [6 7 8 9 10 11 12];

% Determine how many files per trial are there in the PC folders

tts=[];
for i=ts
    
    if i<10
        matches = strfind({dir(PC1).name},['EMG_Trial0' num2str(i) '_']);
    else
        matches = strfind({dir(PC1).name},['EMG_Trial' num2str(i) '_']);
    end
    
    tts=[tts length(find(~cellfun(@isempty,matches)))];
    
end


%% Sync EMG Signals

for tIndex = 1:length(ts)
    cd(nexus)
    % t=4; %trial number
    % tt=2; %# of mat files for this trial
    t =ts(tIndex);
    tt = tts(tIndex);
    R=2;
    ini=1;
    data_PC1=[];
    data_PC2=[];
    forcedataall=[];
    if t<10
        H=btkReadAcquisition(['Trial0',num2str(t),'.c3d']);
        disp(['Processing Trial 0' num2str(t)])
    else
        H=btkReadAcquisition(['Trial',num2str(t),'.c3d']);
        disp(['Processing Trial ' num2str(t)])
    end
    [analogs,analogsInfo]=btkGetAnalogs(H);
    
    % both 61 for our sensors
    % col_PC1=55 and col_PC2=67 for loaner sensors
    
    
    for i=1:tt
        
        % forcedata= expData.data{2}.GRFData.Data(1:300000,3);
        
        if i<tt
            forcedata= analogs.Raw_Pin_3(ini:ini+300000)- mean(analogs.Raw_Pin_3(ini:ini+300000));
            %                  forcedata= analogs.Raw_Pin_3(ini:end)- mean(analogs.Raw_Pin_3(ini:end));
        else
            forcedata= analogs.Raw_Pin_3(ini:end)- mean(analogs.Raw_Pin_3(ini:end));
        end
        % forcedata= analogs.Raw_Pin_3(300001:300001+300000)- mean(analogs.Raw_Pin_3(1:300000));
        
        %     load(['C:\Users\dum5\OneDrive - University of Pittsburgh\aResearch_Studies\Young_LongAdaptation\YL01\PC1\YL01\YL01_\EMG_Trial02_',num2str(i),'.mat'])
        
        %     load(['C:\Users\dum5\OneDrive - University of Pittsburgh\aResearch_Studies\Young_LongAdaptation\YL03\PC1\EMG_Trial04_',num2str(i),'.mat'])
        if t<10
            load([PC1,'\EMG_Trial0',num2str(t),'_',num2str(i),'.mat'])
        else
            load([PC1,'\EMG_Trial',num2str(t),'_',num2str(i),'.mat'])
        end
        
        if ~isempty(PC2)
            EMG_PC2=EMGdata(:,end);
            EMG_PC2=EMG_PC2(1:R:end);
        end
        
        column_PC1= size(EMGdata,2)-3;
        Channels1=Channels;
        Fs1=Fs;
        aux1=EMGdata;%- mean(EMGdata(:,end))
        aux1=aux1(1:R:end,:);
        
        if ~isempty(PC2)
            %     load(['C:\Users\dum5\OneDrive - University of Pittsburgh\aResearch_Studies\Young_LongAdaptation\YL03\PC2\EMG_Trial04_',num2str(i),'.mat'])
            if t<10
                load([PC2,'\EMG_Trial0',num2str(t),'_',num2str(i),'.mat'])
            else
                load([PC2,'\EMG_Trial',num2str(t),'_',num2str(i),'.mat'])
            end
            % EMG_PC1=EMGdata(:,end);
            % EMG_PC1=EMG_PC1(1:R:end);
            aux2=EMGdata;%- mean(EMGdata(:,end));
            aux2=aux2(1:R:end,:);
            column_PC2= size(EMGdata,2)-3;
            Channels2=Channels;
            Fs2=Fs;
            aux1=aux1(1:length(forcedata),:); %not sure if this one should be defined outside too MGR
            aux2=aux2(1:length(forcedata),:);            
        end
        
        
        
        
        %     if i<8
        [~,~,lagInSamplesA,~] = matchSignals(forcedata,aux1(:,column_PC1));
        aux1 = resampleShiftAndScale(aux1,1,lagInSamplesA,1);
        %     end
        
        if ~isempty(PC2)
            [~,~,lagInSamplesB,~] = matchSignals(forcedata,aux2(:,column_PC2));
            aux2 = resampleShiftAndScale(aux2,1,lagInSamplesB,1);
            
            if i==8
                aux1=[zeros(50,64); aux1];
            end
            
            if length(aux1)~=length(aux2)
                [aux1,aux2] = truncateToSameLength(aux1,aux2);
            end
            
        end
        
        if length(aux1)~=length(forcedata)
            [forcedata, aux1] = truncateToSameLength(forcedata,aux1);
            
        end
        
        if ~isempty(PC2)
            if length(aux2)~=length(forcedata)
                [forcedata, aux2] = truncateToSameLength(forcedata,aux2);
            end
            
        end
        
        ini=ini+length(aux1);
        %     figure('units','normalized','outerposition',[0 0 0.5 0.5])
        %     % subplot(2,1,1)
        %     plot(aux1(:,column_PC1)-mean(aux1(:,column_PC1)))
        %     hold on
        % %     plot(aux2(:,column_PC2)-mean(aux2(:,column_PC2)))
        % %     hold on
        %     plot(forcedata,'--')
        % %     legend('PC1','Pin3')
        %     legend('PC1','PC2','Pin3')
        %         if t<10
        %             title(['Trial0',num2str(t)])
        %         else
        %             title(['Trial',num2str(t)])
        %         end
        % subplot(2,1,2)
        %     plot(EMG_PC1-EMG_PC2)        
        
        data_PC1=[data_PC1;aux1];
        if ~isempty(PC2)
            data_PC2=[data_PC2;aux2];
        end
        forcedataall=[forcedataall;forcedata];
    end
    %%
    % figure('units','normalized','outerposition',[0 0 0.5 0.5])
    % plot(analogs.Raw_Pin_3-mean(analogs.Raw_Pin_3))
    % hold on
    % plot(forcedataall)
    % title(['Trial0',num2str(t)])
    
    figure('units','normalized','outerposition',[0 0 0.5 0.5])
    plot(analogs.Raw_Pin_3-mean(analogs.Raw_Pin_3))
    hold on
    plot(data_PC1(:,column_PC1)- mean(data_PC1(:,column_PC1)))
    hold on
    if ~isempty(PC2)
        plot(data_PC2(:,column_PC2)- mean(data_PC2(:,column_PC2)))
        legend('Force','PC1','PC2')
    else
        legend('Force','PC1')
    end
    
    if t<10
        title(['Trial0',num2str(t)])
    else
        title(['Trial',num2str(t)])
    end
   
    
    % figure('units','normalized','outerposition',[0 0 0.5 0.5])
    % plot(data_PC1(:,column_PC1)- mean(data_PC1(:,column_PC1))-(data_PC2(:,column_PC2)- mean(data_PC2(:,column_PC2))))
    % ylim([-0.25 0.2])
    % ylabel('PC1 - PC2 (mV)')
    % title(['Trial0',num2str(t)])
    
    
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
    
    if ~isempty(PC2)
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
        cd(PC2)
    end
end