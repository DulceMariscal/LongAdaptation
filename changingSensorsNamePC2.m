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
text=[];
text{19}=Channels(19,1:25);
text{19}=insertAfter(text{19},':','                  ');
for i=[20:22 26:28]
text{i}=Channels(i,1:27);
text{i}=insertAfter(text{i},':','                ');
end
for  i=23:25
text{i}=Channels(i,1:28);
text{i}=insertAfter(text{i},':','               ');
end
for i=19:28
Channels(i,:)=text{i}
end

for i=19:28
xx=convertCharsToStrings(text{i});
xx=regexprep(xx,'\W*[: .]',' ');
xx=regexprep(xx,'\s','_')
end
%%
text=[];
text{57}=Channels(57,1:27);
text{57}=insertAfter(text{57},':','                ');
for i=[58:60 64:66]
text{i}=Channels(i,1:29);
text{i}=insertAfter(text{i},':','              ');
end
for  i=61:63
text{i}=Channels(i,1:30);
text{i}=insertAfter(text{i},':','             ');
end
for i=57:66
Channels(i,:)=text{i}
end

for i=57:66
xx=convertCharsToStrings(text{i});
xx=regexprep(xx,'\W*[: .]',' ');
xx=regexprep(xx,'\s','_')
end

