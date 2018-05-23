emotions = {'anger', 'disgust', 'anxiety', 'happiness', 'sadness', 'boredom', 'neutral'};
fileFolder = fullfile('E:\研究生\毕业设计\MFCC\wavpicture\');
persons = {'03', '08', '09', '10', '11', '12', '13', '14', '15', '16'};

for n=1:length(persons)
    
    path = strcat('E:\txts\', persons(n));
    
    if ~exist(char(path))
        mkdir(char(path))
    end
    saveInput = sprintf('%s%s%s','E:\txts\', char(persons(n)), '\train.txt');
    
    saveTest = sprintf('%s%s%s','E:\txts\', char(persons(n)), '\test.txt');
    
    saveTrainData = sprintf('%s%s%s','E:\txts\', char(persons(n)), '\train_data.txt');
    
    saveTestData = sprintf('%s%s%s','E:\txts\', char(persons(n)), '\test_data.txt');
    
    dirOutput=dir(fileFolder);
    fileNames={dirOutput.name}';

    fid = fopen(saveInput,'a+');
    ftest = fopen(saveTest, 'a+');
    ftraindata = fopen(saveTrainData, 'a+');
    ftestdata = fopen(saveTestData, 'a+');

    for i=3:size(dirOutput,1)
        fileName = fileNames{i,1};
        emotion = regexp(fileName, '_', 'split');
        emotion = emotion(6);

        id = ismember(emotions, emotion);
        id = find(id==1);

        subfileFolder=sprintf('%s%s',fileFolder,fileName);
        jpgOutput=dir(fullfile(subfileFolder,'*.jpg'));
        jpgfilename={jpgOutput.name};

        person = fileName(1:2);
        
        if ~strcmp(persons(n),person)
            addStr = sprintf('%s%s%d',fileName,' ',id-1);
            fprintf(ftraindata,'%s\n',addStr);
        
            %为每张图片生成路径  train
            for j = 1 : size(jpgOutput,1)
                addStr = sprintf('%s%s%s%s%d',fileName,'\',char(jpgfilename(j)),' ',id-1);
                fprintf(fid,'%s\n',addStr);
            end
            
        else
            addStr = sprintf('%s%s%d',fileName,' ',id-1);
            fprintf(ftestdata,'%s\n',addStr);
            
            %为每张图片生成路径  test
            for j = 1 : size(jpgOutput,1)
                addStr = sprintf('%s%s%s%s%d',fileName,'\',char(jpgfilename(j)),' ',id-1);
                fprintf(ftest,'%s\n',addStr);
            end
        end

    end
    
end

fclose(fid);
fclose(ftest);
fclose(ftraindata);
fclose(ftestdata);