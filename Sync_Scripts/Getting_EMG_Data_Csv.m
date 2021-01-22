%% Import data from text file
% Script for importing data from the following text file:
%
%    filename: C:\Users\dum5\OneDrive - University of Pittsburgh\aResearch_Studies\Young_LongAdaptation\YL01\PC1\YL01\YL01_\YL01_Trial001_Plot_and_Store_Rep_2.5.csv
%
% Auto-generated by MATLAB on 19-Jan-2021 15:42:29

%% Setup the Import Options
opts = delimitedTextImportOptions("NumVariables", 128);

% Specify column names and types
opts.VariableNames = ["Xs", "Avantisensor1EMG1", "Xs1", "Avantisensor1ACCX1", "Xs2", "Avantisensor1ACCY1", "Xs3", "Avantisensor1ACCZ1", "Xs4", "Avantisensor2EMG2", "Xs5", "Avantisensor2ACCX2", "Xs6", "Avantisensor2ACCY2", "Xs7", "Avantisensor2ACCZ2", "Xs8", "Trignosensor3EMG3", "Xs9", "Trignosensor3Acc3X", "Xs10", "Trignosensor3Acc3Y", "Xs11", "Trignosensor3Acc3Z", "Xs12", "Trignosensor4EMG4", "Xs13", "Trignosensor4Acc4X", "Xs14", "Trignosensor4Acc4Y", "Xs15", "Trignosensor4Acc4Z", "Xs16", "Trignosensor5EMG5", "Xs17", "Trignosensor5Acc5X", "Xs18", "Trignosensor5Acc5Y", "Xs19", "Trignosensor5Acc5Z", "Xs20", "Avantisensor6EMG6", "Xs21", "Avantisensor6ACCX6", "Xs22", "Avantisensor6ACCY6", "Xs23", "Avantisensor6ACCZ6", "Xs24", "Avantisensor7EMG7", "Xs25", "Avantisensor7ACCX7", "Xs26", "Avantisensor7ACCY7", "Xs27", "Avantisensor7ACCZ7", "Xs28", "Trignosensor8EMG8", "Xs29", "Trignosensor8Acc8X", "Xs30", "Trignosensor8Acc8Y", "Xs31", "Trignosensor8Acc8Z", "Xs32", "Trignosensor9EMG9", "Xs33", "Trignosensor9Acc9X", "Xs34", "Trignosensor9Acc9Y", "Xs35", "Trignosensor9Acc9Z", "Xs36", "Avantisensor10EMG10", "Xs37", "Avantisensor10ACCX10", "Xs38", "Avantisensor10ACCY10", "Xs39", "Avantisensor10ACCZ10", "Xs40", "Trignosensor11EMG11", "Xs41", "Trignosensor11Acc11X", "Xs42", "Trignosensor11Acc11Y", "Xs43", "Trignosensor11Acc11Z", "Xs44", "Trignosensor12EMG12", "Xs45", "Trignosensor12Acc12X", "Xs46", "Trignosensor12Acc12Y", "Xs47", "Trignosensor12Acc12Z", "Xs48", "Trignosensor13EMG13", "Xs49", "Trignosensor13Acc13X", "Xs50", "Trignosensor13Acc13Y", "Xs51", "Trignosensor13Acc13Z", "Xs52", "Trignosensor14EMG14", "Xs53", "Trignosensor14Acc14X", "Xs54", "Trignosensor14Acc14Y", "Xs55", "Trignosensor14Acc14Z", "Xs56", "Trignosensor15EMG15", "Xs57", "Trignosensor15Acc15X", "Xs58", "Trignosensor15Acc15Y", "Xs59", "Trignosensor15Acc15Z", "Xs60", "TrignoAnalogInputAdapter16Analog16A", "Xs61", "TrignoAnalogInputAdapter16Analog16B", "Xs62", "TrignoAnalogInputAdapter16Analog16C", "Xs63", "TrignoAnalogInputAdapter16Analog16D"];
opts.VariableTypes = ["double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double"];
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";

for i=1:600000:6643001
    
    
% Specify range and delimiter
opts.DataLines = [i, 600000+i];
opts.Delimiter = ",";

% Import the data
 EMGdata= readtable("C:\Users\dum5\OneDrive - University of Pittsburgh\aResearch_Studies\Young_LongAdaptation\YL01\PC1\YL01\YL01_\YL01_Trial001_Plot_and_Store_Rep_2.5.csv", opts);

 saveas(EMGdata, ['YL01_adapt_',num2str(i)])
end

%% Clear temporary variables
clear opts