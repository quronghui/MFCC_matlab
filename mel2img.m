clc;
clear;
% clear all : clear all Variable about memory
%big process wav.file
fileFolder=fullfile('E:\研究生\毕业设计\MFCC\Emo-DBwav\');
dirOutput=dir(fullfile(fileFolder,'*.wav'));
saveInput='E:\研究生\毕业设计\MFCC\wavpicture\';
fileNames={dirOutput.name}';
for inum=1:size(dirOutput,1)
     fileName=char(fileNames{inum,1});
     filename = fileName(1:length(fileName)-4);
     mkdir(saveInput,filename);       %% read input wav.file
     findfileName=sprintf('%s%s%s',fileFolder,fileName);
     
     %初始化，将语音加载进来
     [haha, fs]= audioread(findfileName);
     % 预加重
     seq = Preaccentuation(haha);
     % yujiazhong just for drawing.
     t = 1:length(seq);
     plot(seq)
     
     p = 64;    % window length
     pov = 34;
     framelength_s = 25;    % length = 25ms;
     frameincrement_s = 10; 	% overlap = 10ms
     framelength = fs/1000*framelength_s;   % seconds  length of a frame
     frameincrement = fs/1000*frameincrement_s;% second increment of a frame
    % seq = mean(seq,2);% average of seq
    % 分帧
     wavdata = enframe(seq,hanning(framelength),frameincrement);
     
     %设置每个保存的文件名
     fileName=sprintf('%s%s%s%s',saveInput,filename,'\');
     
     %对每段语音进行初始化
     col = size(wavdata,1);
     i = 1;
%      while(p*i-pov*(i-1)<=col)
%      30帧重叠，64帧为一张图片，所以每次间隔为34帧
%      每次取64帧计算MFCC
     while((p+(p-pov)*(i-1))<=col)   
         startN = (i-1)*(p-pov);
         spect = wavdata((startN+1):(startN+64),:);
         spec3d = melspectrogramcomputing(spect);

         % 归一化spec3d
         for k = 1:3
             FlattenedData = spec3d(:,:,k)'; % 展开矩阵为一列，然后转置为一行。
             MappedFlattened = mapminmax(FlattenedData, 0, 1); % 归一化。
             MappedData = reshape(MappedFlattened, size(spec3d(:,:,k)));
             spec3d(:,:,k)=MappedData;
         end
         
         tempstr = sprintf('%s%d%s',fileName,i,'_static.jpg');
         B = imresize(spec3d,[64 64]);
         imwrite(B,tempstr);
         i=i+1;
     end
end