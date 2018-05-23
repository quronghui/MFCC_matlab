% This is for image, convert to path
clear all;
fileFolder = 'E:\研究生\毕业设计\MFCC\wavpicture';
saveInput = 'E:\研究生\毕业设计\MFCC\file_path\imgPath.txt';
dirOutput=dir( fileFolder );
fileNames={dirOutput.name}';
fid = fopen(saveInput,'a+');%数据保存在你当前的文件夹下，文件名为Data.txt
for i=3:size(dirOutput,1)
     fileName = char(fileNames{i,1});
%      strName = regexp(fileName, '_', 'split');
%      emotionIndex = isEmotionIndex(char(strName(1))); 
     subfileFolder=sprintf('%s%s%s',fileFolder,'\',fileName);
     jpgOutput=dir(fullfile(subfileFolder,'*.jpg'));
     jpgfilename={jpgOutput.name}';
     %为每张图片生成路径
     for j = 1 : size(jpgOutput,1)
          addStr = sprintf('%s%s%s%s%s%d','903 - Baby laugh\',fileName,'\',char(jpgfilename{j,:}),' ',3);
          fprintf(fid,'%s\n',addStr);
     end
end
fclose(fid);