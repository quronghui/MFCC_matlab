clc;
clear;
% clear all : clear all Variable about memory
%big process wav.file
% upload 文件夹，构成地址字符串
% dir:列出该文件夹下所有.wav格式文件（其中包括文件的名字、日期、像素等）
% 输出保存地址
fileFolder=fullfile('E:\Graduation_Code_Design\MFCC_Extract\Emo-DBwav\');
dirOutput=dir(fullfile(fileFolder,'*.wav'));
saveInput='E:\Graduation_Code_Design\MFCC_Extract\wavpicture\';
fileNames={dirOutput.name}';

% main function，进行批量处理
for inum=1:size(dirOutput,1)
    % define saveinput filename
     fileName=char(fileNames{inum,1});
     filename = fileName(1:length(fileName)-4);     % 提取文件名
     mkdir(saveInput,filename);       %% read input wav.file
     findfileName=sprintf('%s%s%s',fileFolder,fileName);
     
     % init read .wav file;return datamatrix=haha and rate=16khz
     [haha, fs]= audioread(findfileName);
     % 预加重
     seq = Preaccentuation(haha);
     % yujiazhong just for drawing.
     t = 1:length(seq);
     plot(seq);title('高通滤波后频谱图');
     
     % 分帧加窗
     % 定义窗长和覆盖
     p = 64;    % window length
     pov = 34;
     framelength_s = 25;    % length = 25ms;
     frameincrement_s = 10; 	% overlap = 10ms； fs=16khz
     framelength = fs/1000*framelength_s;   % seconds length of a frame=400
     frameincrement = fs/1000*frameincrement_s;% second increment of a frame
    % seq = mean(seq,2);% average of seq
    % hanning 返回针长度对称的汉明窗，window or window length
    % enframe :split signal frames;
    % wavdata :enframed data - one frame per row 已编码数据，一行一帧
     wavdata = enframe(seq,hanning(framelength),frameincrement);
     
     %设置每个保存的文件名
     fileName=sprintf('%s%s%s%s',saveInput,filename,'\');
     %对每段语音进行初始化
     col = size(wavdata,1);
     i = 1;
    % while(p*i-pov*(i-1)<=col)
    % 30帧重叠，64帧为一张图片，所以每次间隔为34帧
    % 每次取64帧计算MFCC
     while((p+(p-pov)*(i-1)) <= col )   
         startN = (i-1)*(p-pov);
         spect = wavdata((startN+1):(startN+64),:); 
         spec3d = melspectrogramcomputing(spect);

         % 归一化spec3d，形成数据矩阵
         for k = 1:3
             FlattenedData = spec3d(:,:,k)'; % 展开矩阵为一列，然后转置为一行。
             MappedFlattened = mapminmax(FlattenedData, 0, 1); % 归一化,只留正值
             MappedData = reshape(MappedFlattened, size(spec3d(:,:,k)));
             spec3d(:,:,k)=MappedData;
         end
         
         % 进行图片的保存
         tempstr = sprintf('%s%d%s',fileName,i,'_static.jpg');
         B = imresize(spec3d,[64 64]);
         imwrite(B,tempstr);
         i=i+1;
     end
end