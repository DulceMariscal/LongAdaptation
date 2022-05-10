function [Y,Yasym,Ycom,U,Ubreaks]=groupDataToMatrixFormLongAdapt(subjIdx,sqrtFlag)
%% Load real data:
fName='dynamicsDataYL02.h5';
EMGdata=h5read(fName,'/EMGdata');
SLA=h5read(fName,'/SLA');
speedDiff=h5read(fName,'/speedDiff');
breaks=h5read(fName,'/breaks');
labels=hdf5read(fName,'/labels');

%%
U=speedDiff;
Ubreaks=breaks;

%% Some pre-proc
if nargin<1
    subjIdx=2:16; %Excluding C01 only
end
% muscPhaseIdx=1:360; %All muscles
muscPhaseIdx=1:336; %14 muscles ignoring ADM
% Y=EMGdata(:,muscPhaseIdx,subjIdx);
Y=EMGdata(:,muscPhaseIdx);
Y=nanmedian(Y,3); %Median across subjs
if nargin>1 && sqrtFlag
    Y=sqrt(Y);
end
Yasym=Y-fftshift(Y,2);
Ycom=Y-Yasym;
Yasym=Yasym(:,1:size(Yasym,2)/2,:);
Ycom=Ycom(:,1:size(Ycom,2)/2,:);
end
