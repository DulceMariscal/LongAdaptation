%Double check EMG signals 


conds={'TM Baseline'};

% eventsr={'RHS','LTO','LHS','RTO'};
eventsr={'LHS','RTO','RHS','LTO'};
alignmentLengths=[17,34,17,33];
% muscle={'MG','RF','BF','SEMT','TA'};
% mOrder={'RRF','RBF','RSEMT','RTA','RMG','RGLU','RVL'};
% muscle={'LRF','LBF','LSEMT','LTA','LMG','LGLU','LVL'};
% mOrder={'RTA', 'RPER', 'RSOL', 'RLG', 'RMG', 'RBF', 'RSEMB', 'RSEMT', 'RVM', 'RVL', 'RRF', 'RHIP', 'RTFL', 'RGLU', 'RADM'};

% mOrder={'LADM','LHIP'};
mOrder={'LTA', 'LPER', 'LSOL', 'LLG', 'LMG', 'LBF', 'LSEMB', 'LSEMT', 'LVM', 'LVL', 'LRF', 'LADM', 'LTFL', 'LGLU'};%, 'LHIP'
poster_colors;
colorOrder=[p_red; p_orange; p_fade_green; p_fade_blue; p_plum; p_green; p_blue; p_fade_red; p_lime; p_yellow; [0 0 0]];
condColors=colorOrder;

EMG=expData.getAlignedField('procEMGData',conds(1),eventsr,alignmentLengths).getPartialDataAsATS(mOrder);
% EMG=rawExpData.getAlignedField('procEMGData',conds(1),eventsr,alignmentLengths).getPartialDataAsATS(mOrder);
allmuscle=EMG.getPartialStridesAsATS(1:size(EMG.Data,3));
allmuscle=allmuscle.removeStridesWithNaNs;
norm2=max(allmuscle.Data);
allmuscle.Data=bsxfun(@rdivide,allmuscle.Data,norm2);
allmuscle.plot
gcf()
title(conds)