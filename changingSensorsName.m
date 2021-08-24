%replce IM on sensor name
%%


% for i=1%:10%19:28
% % text{i}=eraseBetween(Channels(i,:),'EMG 1','(IM)');
% text{i}Channels(i,1:20);
% text{i}=erase(Channels(i,:),'(IM)');
% % text{i}=erase(text{i},' ');
% text{i}=insertAfter(text{i},':','    ');
% Channels(i,:)=text{i}
%
% end
% xx=convertCharsToStrings(Channels(1,:))
% load('Names.mat')

% Trial=[5:7 11:1];
for Trial=[1 3:8 12:24]
    
    if Trial<10
        load(['Trial0' num2str(Trial) '.mat'])
    else
        load(['Trial' num2str(Trial) '.mat'])
    end
    text=[];
    text{1}=Channels(1,1:25);
    text{1}=insertAfter(text{1},':','                  ');
    for i=[2:4 8:10]
        text{i}=Channels(i,1:27);
        text{i}=insertAfter(text{i},':','                ');
    end
    for  i=5:7
        text{i}=Channels(i,1:28);
        text{i}=insertAfter(text{i},':','               ');
    end
    for i=1:10
        Channels(i,:)=text{i}
    end
    
    for i=1:10
        xx=convertCharsToStrings(text{i});
        xx=regexprep(xx,'\W*[: .]',' ');
        xx=regexprep(xx,'\s','_')
    end
    if Trial<10
        save(['Trial0' num2str(Trial) '.mat'],'Channels','Data','Fs')
    else
        save(['Trial' num2str(Trial) '.mat'],'Channels','Data','Fs')
    end
end