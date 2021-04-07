% clear; close all;

% load('/Users/samirsherlekar/Desktop/emg/Data/normalizedYoungEmgData.mat');
% load('C:/Users/dum5/Box/11_Research_Projects/GeneralizationStudy Data/NormalizedFastYoungEMGData.mat')
load('/Users/dulcemariscal/Box/11_Research_Projects/GeneralizationStudy Data/NormalizedFastYoungEMGData.mat')
%deleting existing norm values
ss =normalizedTMFullAbrupt.adaptData{1}.data.getLabelsThatMatch('^Norm');
s2 = regexprep(ss,'^Norm','dsjrs');
normalizedTMFullAbrupt=normalizedTMFullAbrupt.renameParams(ss,s2);

muscleOrder={'TA','MG','SEMT','VL','RF'};
n_muscles = length(muscleOrder);
useLateAdaptAsBaseline=false;



n_subjects = 7;
extremaMatrixYoung = NaN(n_subjects,n_muscles * 2,2);


ep=defineEpochYoung('nanmean');
% ep=defineEpochYoung('nanmedian');
refEp = defineReferenceEpoch('Base',ep);
% refEp = defineReferenceEpoch('Fast',ep);

newLabelPrefix = defineMuscleList(muscleOrder);

normalizedTMFullAbrupt = normalizedTMFullAbrupt.normalizeToBaselineEpoch(newLabelPrefix,ep(3,:));
   

ll=normalizedTMFullAbrupt.adaptData{1}.data.getLabelsThatMatch('^Norm');
%ll = normalizedTMFullAbrupt.adaptData{1}.data.getLabelsThatMatch('^(s|f)[A-Z]+_s');

l2=regexprep(regexprep(ll,'^Norm',''),'_s','s');
   
normalizedTMFullAbrupt=normalizedTMFullAbrupt.renameParams(ll,l2);


fh=figure('Units','Normalized','OuterPosition',[0 0 1 1]);
ph=tight_subplot(1,length(ep)+1,[.03 .005],.04,.04);
flip=true;

summFlag='median';
normalizedTMFullAbrupt.plotCheckerboards(regexprep(newLabelPrefix,'_s','s'),refEp,fh,ph(1,1),[],flip); %First, plot reference epoch:   
[~,~,labels,dataE{1},dataRef{1}]=normalizedTMFullAbrupt.plotCheckerboards(regexprep(newLabelPrefix,'_s','s'),ep,fh,ph(1,2:end),refEp,flip,summFlag);%Second, the rest:



set(ph(:,1),'CLim',[-1 1]);
set(ph(:,2:end),'YTickLabels',{},'CLim',[-1 1]);
set(ph,'FontSize',8)
pos=get(ph(1,end),'Position');
axes(ph(1,end))
colorbar
set(ph(1,end),'Position',pos);

   
minEffectSize2=0.1;
fdr=.1;
for k=1 %:length(groups)
    for i=1:length(ep)+1
        if i>1
            dd=reshape(dataE{k}(:,:,i-1,:),size(dataE{k},1)*size(dataE{k},2),size(dataE{k},4));
        else
            dd=reshape(dataRef{k}(:,:,i,:),size(dataRef{k},1)*size(dataRef{k},2),size(dataRef{k},4));
        end
        %effects that are significantly larger than the minEffectSize (MES)
        %[~,pR]=ttest(dd',minEffectSize,'tail','right');
        %[~,pL]=ttest(dd',-minEffectSize,'tail','left');
        %p2=nan(size(pL));
        [~,p2]=ttest(dd');
        for j=1:size(dd,1)
           %[pR(j)]=signrank(dd(j,:),minEffectSize,'tail','right','method','exact');
           %[pL(j)]=signrank(dd(j,:),-minEffectSize,'tail','left','method','exact');
           [p2(j)]=signrank(dd(j,:),0,'method','exact');
        end
        %p=2*min(pR,pL); %Two-tailed test for effect larger than MES: taking twice the minimum of the two p-values
        p=p2;
        [h,pTh]=BenjaminiHochberg(p,fdr); %Conservative mult-comparisons: Benjamini & Hochberg approach
        h(abs(median(dd'))<minEffectSize2)=0; %Conservative approach to Bonferroni: not reporting small effects
        %Add to plot:
        subplot(ph(k,i))
        hold on
        ss=findobj(gca,'type','Surface');
        h1=nan(size(h));
        h1(h==1)=10;
        if i>1
            plot3(repmat([ss.XData(1:end-1)+diff(ss.XData)/2]',1,length(ss.YData)-1),repmat(ss.YData(1:end-1)+diff(ss.YData)/2,length(ss.XData)-1,1),reshape(h1,[length(ss.XData)-1,length(ss.YData)-1])','ko','MarkerFaceColor','k','MarkerSize',4)
            aux=num2str(round(1e3*pTh)/1000,2);
            ph(k,i).Title.String=[{ph(k,i).Title.String}; {['p=' aux(2:end)]}];
        else
            aux2=num2str(round(1e2*fdr)/1e2,2);
            aux3=num2str(round(1e2*minEffectSize2)/1e2,2);
            ph(k,i).Title.String=[{ph(k,i).Title.String}; {['FDR=' aux2 '; min Eff.=' aux3]}];
        end
    end
end

%saveas(fh,'./Figures/CheckerboardRefEpFast.png')