clc;
clear;
% clear all : clear all Variable about memory
%big process wav.file
fileFolder=fullfile('E:\�о���\��ҵ���\MFCC\Emo-DBwav\');
dirOutput=dir(fullfile(fileFolder,'*.wav'));
saveInput='E:\�о���\��ҵ���\MFCC\wavpicture\';
fileNames={dirOutput.name}';
for inum=1:size(dirOutput,1)
     fileName=char(fileNames{inum,1});
     filename = fileName(1:length(fileName)-4);
     mkdir(saveInput,filename);       %% read input wav.file
     findfileName=sprintf('%s%s%s',fileFolder,fileName);
     
     %��ʼ�������������ؽ���
     [haha, fs]= audioread(findfileName);
     % Ԥ����
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
    % ��֡
     wavdata = enframe(seq,hanning(framelength),frameincrement);
     
     %����ÿ��������ļ���
     fileName=sprintf('%s%s%s%s',saveInput,filename,'\');
     
     %��ÿ���������г�ʼ��
     col = size(wavdata,1);
     i = 1;
%      while(p*i-pov*(i-1)<=col)
%      30֡�ص���64֡Ϊһ��ͼƬ������ÿ�μ��Ϊ34֡
%      ÿ��ȡ64֡����MFCC
     while((p+(p-pov)*(i-1))<=col)   
         startN = (i-1)*(p-pov);
         spect = wavdata((startN+1):(startN+64),:);
         spec3d = melspectrogramcomputing(spect);

         % ��һ��spec3d
         for k = 1:3
             FlattenedData = spec3d(:,:,k)'; % չ������Ϊһ�У�Ȼ��ת��Ϊһ�С�
             MappedFlattened = mapminmax(FlattenedData, 0, 1); % ��һ����
             MappedData = reshape(MappedFlattened, size(spec3d(:,:,k)));
             spec3d(:,:,k)=MappedData;
         end
         
         tempstr = sprintf('%s%d%s',fileName,i,'_static.jpg');
         B = imresize(spec3d,[64 64]);
         imwrite(B,tempstr);
         i=i+1;
     end
end