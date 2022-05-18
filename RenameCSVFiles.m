%script to rename the csv and hpf files from EMGWorks to match the trial
%IDs from Vicon.
%Parameters to change:
%-- subjectDir: this is the parent folder where the data is
%---- the code assumes the data from vicon is loaded under
%subjectDir\Vicon\ and files in format TrialXX.x1d. The code also assumes
%EMG files are under subjectDir\PC1 and subjectDir\PC2
%-- trial: this should be an array of the trials numbers to process
clc;

subjectDir = 'X:\Shuqi\NirsAutomaticityStudy\Data\AUF10\V04\' %change this to match your directory
allfiles = dir([subjectDir 'Vicon' filesep]);
%e.g.: vicon file folder: X:\Shuqi\NirsAutomaticityStudy\Data\AUF09\V03\Vicon
viconFileNames = {allfiles(:).name};
diffs = [];
for PC = 1:2
    emgDir = [subjectDir 'PC' num2str(PC) filesep]
    %e.g.: X:\Shuqi\NirsAutomaticityStudy\Data\AUF09\V03\PC2
    cd(emgDir);
    pc1filesRaw = dir(emgDir);
    pc1files = struct2cell(pc1filesRaw);
    pc1fileDates = datetime(pc1files(3,:));

    for trial = 8:21 %change this to match your trial number
        x1dFileName = sprintf('Trial%02d.x1d',trial);
        [~,idx] = ismember(x1dFileName,viconFileNames);
        x1dFileDate = allfiles(idx).date;
        timeDiff = seconds(pc1fileDates - x1dFileDate); %pc1 should be saved before vicon (negative diff)

        % find file created in close time
        idx = find(timeDiff >=-24 & timeDiff <=0); %assume emg file saved within 24 seconds before vicon creation time.
        diffs(end+1) = timeDiff(idx);
        if length(idx) ~= 1
            warnining(sprintf('Too many or 0 files found mathcing vicon creation time. Skip trial %d',trial))
            fprintf('Skip trial %d',trial)
        else
            fileNameToRename = pc1files(1,idx);
            fileNameToRename = fileNameToRename{1}
            movefile(fileNameToRename,sprintf('Trial%02d.hpf',trial)) %this renames the hpf file as well. If don't wnat to rename hpf, comment this line out
            movefile([fileNameToRename(1:end-3) 'csv'],sprintf('Trial%02d.csv',trial))
        end
    end
end
