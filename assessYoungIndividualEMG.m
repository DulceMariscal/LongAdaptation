% clear; close all;

% load('/Users/samirsherlekar/Desktop/emg/Data/normalizedYoungEmgData.mat');
% load('C:\Users\dum5\Box\GeneralizationStudy Data\NormalizedFastYoungEMGData.mat')
sub={'YL01paramsNewConditions'};

normalizedTMFullAbrupt=adaptationData.createGroupAdaptData(sub);

ss =normalizedTMFullAbrupt.adaptData{1}.data.getLabelsThatMatch('^Norm');

% ss =TMFullAbrupt.adaptData{1}.data.getLabelsThatMatch('^Norm'); %Dulce 
s2 = regexprep(ss,'^Norm','dsjrs');
normalizedTMFullAbrupt=normalizedTMFullAbrupt.renameParams(ss,s2);
% normalizedTMFullAbrupt=studyData.TMFullAbrupt.renameParams(ss,s2);

% muscleOrder={'TA','MG','SEMT','VL','RF'};
muscleOrder={'TA', 'PER', 'SOL', 'LG', 'MG', 'BF', 'SEMB', 'SEMT', 'VM', 'VL', 'RF', 'TFL', 'GLU', 'ADM'};
n_muscles = length(muscleOrder);
useLateAdaptAsBaseline=false;

n_subjects = 1;
extremaMatrixYoung = NaN(n_subjects,n_muscles * 2,2);


ep=defineEpochYoungLongAdaptation('nanmean');
refEp = defineReferenceEpoch('Base',ep);
% refEp = defineEpochYoungLongAdaptation('Fast',ep);

newLabelPrefix = defineMuscleList(muscleOrder);

normalizedTMFullAbrupt = normalizedTMFullAbrupt.normalizeToBaselineEpoch(newLabelPrefix,ep(3,:));

ll=normalizedTMFullAbrupt.adaptData{1}.data.getLabelsThatMatch('^Norm');
%ll = normalizedTMFullAbrupt.adaptData{1}.data.getLabelsThatMatch('^(s|f)[A-Z]+_s');

l2=regexprep(regexprep(ll,'^Norm',''),'_s','s');
normalizedTMFullAbrupt=normalizedTMFullAbrupt.renameParams(ll,l2);

newLabelPrefix = regexprep(newLabelPrefix,'_s','s');

for i = 1:n_subjects
    

    adaptDataSubject = normalizedTMFullAbrupt.adaptData{1, i}; 

    fh=figure('Units','Normalized','OuterPosition',[0 0 1 1]);
    ph=tight_subplot(1,length(ep)+1,[.03 .005],.04,.04);
    flip=true;

    adaptDataSubject.plotCheckerboards(newLabelPrefix,refEp,fh,ph(1,1),[],flip); %First, plot reference epoch:   
    [~,~,labels,dataE{1},dataRef{1}]=adaptDataSubject.plotCheckerboards(newLabelPrefix,ep,fh,ph(1,2:end),refEp,flip);%Second, the rest:
    
    
    set(ph(:,1),'CLim',[-1 1]);
    set(ph(:,2:end),'YTickLabels',{},'CLim',[-1 1]*2);
    set(ph,'FontSize',8)
    pos=get(ph(1,end),'Position');
    axes(ph(1,end))
    colorbar
    set(ph(1,end),'Position',pos);
    
   
    
    extremaMatrixYoung(i,:,1) =  min(dataRef{1});
    extremaMatrixYoung(i,:,2) =  max(dataRef{1});
    
end