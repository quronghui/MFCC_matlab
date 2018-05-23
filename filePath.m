clear all;
fileFolder = 'E:\研究生\毕业设计\MFCC\Emo-DBwav';
saveInput = 'E:\研究生\毕业设计\MFCC\file_path\filePath.txt';
dirOutput=dir( fileFolder );
fileNames={dirOutput.name}';
fid = fopen(saveInput,'a+');%数据保存在你当前的文件夹下，文件名为Data.txt
for i=3:size(dirOutput,1)
     fileName = char(fileNames{i,1});
%      strName = regexp(fileName, '_', 'split');
%      emotionIndex = isEmotionIndex(char(strName(1))); 
     subfileFolder=sprintf('%s%s%s',fileFolder,'\',fileName);
     jpgOutput=dir(fullfile(subfileFolder,'*.jpg'));
     %为每个语音生成路径
     addStr = sprintf('%s%s%s%d%s%d','903 - Baby laugh\',fileName,' ',size(jpgOutput,1),' ',3);
     fprintf(fid,'%s\n',addStr);
    
end
fclose(fid);