% This is for image, convert to path
clear all;
fileFolder = 'E:\�о���\��ҵ���\MFCC\wavpicture';
saveInput = 'E:\�о���\��ҵ���\MFCC\file_path\imgPath.txt';
dirOutput=dir( fileFolder );
fileNames={dirOutput.name}';
fid = fopen(saveInput,'a+');%���ݱ������㵱ǰ���ļ����£��ļ���ΪData.txt
for i=3:size(dirOutput,1)
     fileName = char(fileNames{i,1});
%      strName = regexp(fileName, '_', 'split');
%      emotionIndex = isEmotionIndex(char(strName(1))); 
     subfileFolder=sprintf('%s%s%s',fileFolder,'\',fileName);
     jpgOutput=dir(fullfile(subfileFolder,'*.jpg'));
     jpgfilename={jpgOutput.name}';
     %Ϊÿ��ͼƬ����·��
     for j = 1 : size(jpgOutput,1)
          addStr = sprintf('%s%s%s%s%s%d','903 - Baby laugh\',fileName,'\',char(jpgfilename{j,:}),' ',3);
          fprintf(fid,'%s\n',addStr);
     end
end
fclose(fid);