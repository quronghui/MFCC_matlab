clear all;
fileFolder = 'E:\�о���\��ҵ���\MFCC\Emo-DBwav';
saveInput = 'E:\�о���\��ҵ���\MFCC\file_path\filePath.txt';
dirOutput=dir( fileFolder );
fileNames={dirOutput.name}';
fid = fopen(saveInput,'a+');%���ݱ������㵱ǰ���ļ����£��ļ���ΪData.txt
for i=3:size(dirOutput,1)
     fileName = char(fileNames{i,1});
%      strName = regexp(fileName, '_', 'split');
%      emotionIndex = isEmotionIndex(char(strName(1))); 
     subfileFolder=sprintf('%s%s%s',fileFolder,'\',fileName);
     jpgOutput=dir(fullfile(subfileFolder,'*.jpg'));
     %Ϊÿ����������·��
     addStr = sprintf('%s%s%s%d%s%d','903 - Baby laugh\',fileName,' ',size(jpgOutput,1),' ',3);
     fprintf(fid,'%s\n',addStr);
    
end
fclose(fid);