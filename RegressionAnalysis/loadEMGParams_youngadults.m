function loadEMGParams_youngadults(groupName)
%% Aux vars:
% matDataDir='../data/HPF30/';
% loadName=[matDataDir 'groupedParams'];
% loadName=[loadName '_wMissingParameters']; %Never remove missing for this script
loadName='YoungAbuptTM.mat';
load(loadName)

%%
if nargin<1 || isempty(groupName)
    group=TMFullAbrupt;
else
    eval(['group=' groupName ';']);
end
age=group.getSubjectAgeAtExperimentDate/12;

%% Define params we care about:
% mOrder={'TA', 'PER', 'SOL', 'LG', 'MG', 'BF', 'SEMB', 'SEMT', 'VM', 'VL', 'RF', 'HIP', 'ADM', 'TFL', 'GLU'};
mOrder={'TA', 'MG', 'SEMT', 'VL','RF'}; %young adults
nMusc=length(mOrder);
type='s';
labelPrefix=fliplr([strcat('f',mOrder) strcat('s',mOrder)]); %To display
labelPrefixLong= strcat(labelPrefix,['_' type]); %Actual names
baseEp=getBaseEpoch;

%Adding alternative normalization parameters:
l2=group.adaptData{1}.data.getLabelsThatMatch('^Norm');
group=group.renameParams(l2,strcat('N',l2)).normalizeToBaselineEpoch(labelPrefixLong,baseEp,true); %Normalization to max=1 but not min=0

%Renaming normalized parameters, for convenience:
ll=group.adaptData{1}.data.getLabelsThatMatch('^Norm');
l2=regexprep(regexprep(ll,'^Norm',''),'_s','s');
group=group.renameParams(ll,l2);
newLabelPrefix=strcat(labelPrefix,'s');

%% Define epochs & get data:
ep=getEpochsYoung;
baseEp=getBaseEpoch;
padWithNaNFlag=false;
[dataEMG,labels]=group.getPrefixedEpochData(newLabelPrefix,ep,padWithNaNFlag);
[BB,labels]=group.getPrefixedEpochData(newLabelPrefix,baseEp,padWithNaNFlag);
dataEMG=dataEMG-BB; %Removing base
%Flipping EMG:
dataEMG=reshape(flipEMGdata(reshape(dataEMG,size(labels,1),size(labels,2),size(dataEMG,2),size(dataEMG,3)),1,2),numel(labels),size(dataEMG,2),size(dataEMG,3));
[dataContribs]=group.getEpochData(ep,{'netContributionNorm2'},padWithNaNFlag);
dataContribs=dataContribs-dataContribs(:,strcmp(ep.Properties.ObsNames,'Base'),:); %Removing base

%% Get all the eA, lA, eP vectors
shortNames={'lB','eA','lA','lS','eP','ePS','veA','veP','veS','vePS','lP','e15A','e15P'};
longNames={'Base','early A','late A','Short','early P','early B','vEarly A','vEarly P','vShort','vEarly B','late P','early A15','early P15'};
for i=1:length(shortNames)
    aux=squeeze(dataEMG(:,strcmp(ep.Properties.ObsNames,longNames{i}),:));
    eval([shortNames{i} '=aux;']);
    aux=squeeze(dataContribs(:,strcmp(ep.Properties.ObsNames,longNames{i}),:));
    eval(['SLA_' shortNames{i} '=aux(:);']);
end
clear aux
groupName='GYAAT';
vars=[shortNames,strcat('SLA_',shortNames), {'age','labels'}];
save([groupName 'EMGsummary'],vars{:})
end