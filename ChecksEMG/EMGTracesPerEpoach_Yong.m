%%Traces from example subject to show how data is summarized
%% Load data
% load('.../GYAAT_01.mat');

%% Align it
% conds={'TM Base','Adap'};
% conds={'TM slow','TM fast','TM base','adap','TM post','Short split positivo','Short split negativo'};
conds={'TM Baseline'};
events={'RHS','LTO','LHS','RTO'};
alignmentLengths=[16,32,16,32];
% muscle={'MG','RF','VL','SEMT','TA'};
muscle={'TA', 'PER', 'SOL', 'LG', 'MG', 'BF', 'SEMB', 'SEMT', 'VM', 'VL', 'RF', 'TFL', 'GLU', 'ADM', 'HIP'};
lm=1:2:35;
for s=5
% load(['SCB0',num2str(s), '.mat'])
fh=figure('Units','Normalized');
for m=1:length(muscle)

% RBaseSlow=expData.getAlignedField('procEMGData',conds(1),events,alignmentLengths).getPartialDataAsATS({['R' muscle{m}]});
% LBaseSlow=expData.getAlignedField('procEMGData',conds(1),events([3,4,1,2]),alignmentLengths).getPartialDataAsATS({['L' muscle{m}]});

% RBaseFast=expData.getAlignedField('procEMGData',conds(2),events,alignmentLengths).getPartialDataAsATS({['R' muscle{m}]});
% LBaseFast=expData.getAlignedField('procEMGData',conds(2),events([3,4,1,2]),alignmentLengths).getPartialDataAsATS({['L' muscle{m}]});
% 
RBase=expData.getAlignedField('procEMGData',conds(1),events,alignmentLengths).getPartialDataAsATS({['R' muscle{m}]});
LBase=expData.getAlignedField('procEMGData',conds(1),events([3,4,1,2]),alignmentLengths).getPartialDataAsATS({['L' muscle{m}]});
% 
% RAdap=expData.getAlignedField('procEMGData',conds(4),events,alignmentLengths).getPartialDataAsATS({['R' muscle{m}]});
% LAdap=expData.getAlignedField('procEMGData',conds(4),events([3,4,1,2]),alignmentLengths).getPartialDataAsATS({['L' muscle{m}]});
% 
% RPost=expData.getAlignedField('procEMGData',conds(5),events,alignmentLengths).getPartialDataAsATS({['R' muscle{m}]});
% LPost=expData.getAlignedField('procEMGData',conds(5),events([3,4,1,2]),alignmentLengths).getPartialDataAsATS({['L' muscle{m}]});
% 
% 
% RPosi=expData.getAlignedField('procEMGData',conds(6),events,alignmentLengths).getPartialDataAsATS({['R' muscle{m}]});
% LPosi=expData.getAlignedField('procEMGData',conds(6),events([3,4,1,2]),alignmentLengths).getPartialDataAsATS({['L' muscle{m}]});
% 
% 
% RNeg=expData.getAlignedField('procEMGData',conds(7),events,alignmentLengths).getPartialDataAsATS({['R' muscle{m}]});
% LNeg=expData.getAlignedField('procEMGData',conds(7),events([3,4,1,2]),alignmentLengths).getPartialDataAsATS({['L' muscle{m}]});


% % 
% %  % Save, to avoid dealing with the whole file again
% save([ expData.subData.ID,'EMG_',muscle{m}],'RBaseSlow','LBaseSlow','RBase','LBase','RAdap','LAdap','RPost','LPost')

% load(['GYAAT_10PNormOGEMG_',muscle{m}])
% subject='GYAAT_10';
% load([subject, 'PNormOGEMG_',muscle{m},'.mat'])
%% Create plots
% close all;
poster_colors;
colorOrder=[p_red; p_orange; p_fade_green; p_fade_blue; p_plum; p_green; p_blue; p_fade_red; p_lime; p_yellow; [0 0 0]];
condColors=colorOrder;

% fh=figure('Units','Normalized','Position',[0 0 .45 .2]);



for l=1:2
    switch l
        case 1
            
            B=RBase.getPartialStridesAsATS(find(RBase.Data(end-40:end)));
%             A=RAdap.getPartialStridesAsATS(find(RAdap.Data(end-40:end)));
%             S=RBaseSlow.getPartialStridesAsATS(find(RBaseSlow.Data(end-40:end)));%23:73 03 range 
%             F=RBaseFast.getPartialStridesAsATS(find(RBaseFast.Data(end-40:end)));
%             P=RPost.getPartialStridesAsATS(find(RPost.Data(end-40:end)));
%             Pos=RPosi.getPartialStridesAsATS(find(RPosi.Data(2:10)));
%             N=RNeg.getPartialStridesAsATS(find(RNeg.Data(2:10)));
            tit=['R' muscle{m}];
        case 2
            B=LBase.getPartialStridesAsATS(find(LBase.Data(end-40:end))); % young 110:150
%             A=LAdap.getPartialStridesAsATS(find(LAdap.Data(end-40:end))); %young 900-50:898
%             S=LBaseSlow.getPartialStridesAsATS(find(LBaseSlow.Data(end-40:end))); %young 60:95
%             F=LBaseFast.getPartialStridesAsATS(find(LBaseFast.Data(end-40:end)));
%             P=LPost.getPartialStridesAsATS(find(LPost.Data(end-40:end))); %young 300-50:300
%             Pos=LPosi.getPartialStridesAsATS(find(LPosi.Data(2:10)));
%             N=LNeg.getPartialStridesAsATS(find(LNeg.Data(2:10)));
            tit=['L' muscle{m}];       

    end

condColors=colorOrder;
% ph=[];
ph1=[];
prc=[16,84];
MM=sum(alignmentLengths);
M=cumsum([0 alignmentLengths]);
xt=sort([M,M(1:end-1)+[diff(M)/2]]);
phaseSize=8;
xt=[0:phaseSize:MM];
%xt=[0:8:MM];s
fs=16; %FontSize

    ph=subplot(5,6,lm(m)+l-1);
    set(gcf,'color','w');
%     set(ph,'Position',[.07 .48 .35 .45]);
    hold on

%     S.plot(fh,ph,condColors(3,:),[],0,[-49:0],prc,true);
%     F.plot(fh,ph,condColors(4,:),[],0,[-49:0],prc,true);
    B.plot(fh,ph,condColors(1,:),[],0,[-49:0],prc,true);
%     A.plot(fh,ph,condColors(2,:),[],0,[-49:0],prc,true);
%     P.plot(fh,ph,condColors(5,:),[],0,[-49:0],prc,true);
%     Pos.plot(fh,ph,condColors(6,:),[],0,[-49:0],prc,true);
%     N.plot(fh,ph,condColors(7,:),[],0,[-49:0],prc,true);
    
    axis tight
    ylabel('')
    ylabel(tit)
    set(ph,'YTick',[0,1],'YTickLabel',{'0%','100%'})
    grid on
    ll=findobj(ph,'Type','Line');
%     legend(ll(end:-1:4-3),conds{1:5})
%     title([subject,' late'])
%  
% %     %Add rectangles quantifying activity
% % %     for j=1:3
% % %         k=3:4;
% % %         ph1(j)=axes;
% % %         set(ph1(j),'Position',[.07 .25+(j-1)*-.11 .35 .09]);  
% % %         drawnow
% % %         pause(1)
% % %         da=randn(1,12);
% % %         gamma=.5;
% % %         ex1=condColors(j,:);
% % %         map=niceMap(ex1,gamma);
% % %         switch j
% % %             case 1
% % %             aux=nanmedian(B.Data,3)';
% % %             tt='B';
% % %             case 2
% % %             aux=nanmedian(A.Data,3)';
% % %             tt='lA';
% % %             case 3
% % %             aux=1*(nanmedian(A.Data,3)'-nanmedian(B.Data,3)') +.5*max(nanmedian(B.Data,3));
% % %             figuresColorMap;
% % %             tt='lA_B';
% % %         end
% % %         clear aux2
% % %         for k=1:length(xt)-1
% % %             aux2(k)=mean(aux(xt(k)+1:xt(k+1)));
% % %         end
% % %         I=image(size(map,1)*aux2/max(nanmedian(B.Data,3)));
% % %         I.Parent.Colormap=flipud(map);
% % %         rectangle('Position',[.5 .5 12 1],'EdgeColor','k')
% % %         set(ph1(j),'XTickLabel','','YTickLabel','','XTick','','YTick','')
% % %         text(-.4-.1*(j-1)^2.6,1,tt,'Clipping','off','FontSize',14,'FontWeight','bold')
% % %     end
% % %     drawnow
% % %     %
% % % 
% % % 
% % %     axes(ph)
% % %     ll=findobj(ph,'Type','Line');
% % %     set(ll,'LineWidth',3)
% % %     set(ph,'FontSize',fs,'YTickLabel','','XTickLabel','','XTick',xt,'YTick','')
% % %     a=axis;
% % %     yOff=a(3)-.5*(a(4)-a(3));
% % %     %Add labels:
% % %     text(.25*2*phaseSize,yOff,'DS','Clipping','off','FontSize',fs)
% % %     text(1.15*2*phaseSize,yOff,{'STANCE'},'Clipping','off','FontSize',fs)
% % %     text(3.225*2*phaseSize,yOff,'DS','Clipping','off','FontSize',fs)
% % %     text(4.25*2*phaseSize,yOff,{'SWING'},'Clipping','off','FontSize',fs)
% % %     axis(a)
% % %     hold on
% % %     yOff=a(3)-.05*(a(4)-a(3));
% % %     %Add lines:
% % %     plot([.1 .9]*2*phaseSize,[1 1]*yOff,'Color',0*ones(1,3),'LineWidth',4,'Clipping','off')
% % %     plot([1.1 2.9]*2*phaseSize,[1 1]*yOff,'Color',0*ones(1,3),'LineWidth',4,'Clipping','off')
% % %     plot([3.1 3.9]*2*phaseSize,[1 1]*yOff,'Color',0*ones(1,3),'LineWidth',4,'Clipping','off')
% % %     plot([4.1 5.9]*2*phaseSize,[1 1]*yOff,'Color',0*ones(1,3),'LineWidth',4,'Clipping','off')
% % % %     legend(ll(end:-1:end-1),{'Baseline','Adaptation'})
% % %     
% % %     set(fh,'Position',[0 0 .45 .2])
% end
%     saveFig(fh,'./',['Fig1B_' num2str(l)],1)
end
end
legend(ll(end:-1:1),conds{1:7})
end%%
