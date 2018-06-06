function spec3d = melspectrogramcomputing(seq)%seq is a raw audio sequence(mono)
    p = 64;
    framelength_s = 25;
%     frameincrement_s = 10;
    fs = 16000;  
    framelength = fs/1000*framelength_s;%seconds  length of a frame
%     frameincrement = fs/1000*frameincrement_s;% second increment of a frame
%     seq = mean(seq,2);% average of seq
    %[z tc] = enframe(seq,hamming(1200),480);
%     [z tc] = enframe(seq,framelength,frameincrement);
%     zfft=rfft(seq.');
    % Calculate the DFT of real data Y=(X,N,D)
    zfft=rfft(seq.');
    
    % plot
    figure(1);
    subplot 211;    % 图形位置
    plot(1e4*seq(1,:))
    xlabel('f/频率hz')
    ylabel('y/幅值')
    title('单帧信号时域波形')
    cy = zfft(:,1);
    subplot 212;
    plot(1e3*abs(zfft(:,1)));
    xlabel('f/频率hz')
    ylabel('fft/幅值')
    title('FFT频谱图')
    axis([0 202 0 6]);
    
    % MEl fliter array
    xmelfilters=melbankm(p,framelength,fs,20/fs,0.5);
    zmel2=xmelfilters*abs(zfft).^2+  0.01;
    figure(2);
    plot((0:floor(framelength/2))*fs/framelength,xmelfilters');
    xlabel('f/频率hz')
    ylabel('Mel_filter')
    title('Mel滤波器组')
    axis([0 8050 0 2.3]);
    
    figure(3);
    subplot 211;
    plot(1e3*abs(zfft(:,2)))
    xlabel('f/频率hz')
    ylabel('fft/幅值')
    title('FFT频谱图');
    axis([0 202 0 6]);
    
    subplot 212;
    plot(1e3*abs(zmel2(2,:)))
    xlabel('f/频率hz')
    ylabel('y/幅值')
    title('信号经过Mel滤波器后的频谱图');
    axis([0 65 9.8 10.8]);
   
    % 经过Mel_filter后的zfft
    zmelcy = xmelfilters*abs(zfft).^2+  0.01;
    figure(4)
    subplot 211;
    plot(zmelcy(2,:))
    xlabel('f/频率hz')
    ylabel('y/幅值')
    title('信号经过Mel滤波器后的频谱图');
 
    % 取自然对数和DTC倒频谱
    zmel=log(zmelcy);
    zmel=dct(zmel);                
    % take the DCT
    subplot 212;
    plot(zmel(2,:))
    xlabel('f/频率hz')
    ylabel('y/倒谱图')
    title('信号经过DCT后的倒谱图(1*64维)');
    
    % computing delta--3delta coefficients
    delta_zmel = zeros(size(zmel,1),size(zmel,2));
    delta_delta_zmel = delta_zmel;
    xpend = zeros(64,1);
    xxpend=[xpend,xpend,zmel,xpend,xpend];
    for t=3:size(zmel,2)+2
        for cn=1:64

            denom = sqrt(2*(1+4));
            nume = xxpend(cn,t+1) - xxpend(cn,t-1) + 2*(xxpend(cn,t+2) - xxpend(cn,t-2));
            cnew = nume/denom;
            delta_zmel(cn,t-2) = cnew;
        end
    end
    % exam=zeros(64,602,3);
    % for 
    %computing delta coefficients
    
    %computing delta-delta coefficients
    xxxpend=[xpend,xpend,delta_zmel,xpend,xpend];
    for t=3:size(zmel,2)+2
        for cn=1:64

            denom = 2*(1+4);
            nume = xxxpend(cn,t+1) - xxxpend(cn,t-1) + 2*(xxxpend(cn,t+2) - xxxpend(cn,t-2));
            cnew = nume/denom;
            delta_delta_zmel(cn,t-2) = cnew;
        end
    end
    spec3d=zeros(64,size(zmel,2),3);

    for nmel=1:64
        for nframe=1:size(zmel,2)
            spec3d(nmel,nframe,1) = zmel(nmel,nframe);
            spec3d(nmel,nframe,2) = delta_zmel(nmel,nframe);
            spec3d(nmel,nframe,3) = delta_delta_zmel(nmel,nframe);
        end
    end
%     countframe = size(spec3d,2);
%     template = linspace(1,countframe,countframe);
%     segmentedmatrix = enframe(template,64,30);
%     segmentindex = segmentedmatrix(:,1);
%     %segmentedmelspec = zeros(length(segmentindex),64,64,3);
%     segmentedmelspec = cell(1,length(segmentindex));
%     for i = 1:length(segmentindex)
%         segmentedmelspec{1,i} = imresize(spec3d(:,segmentindex(i):segmentindex(i)+63,:),[227,227]);
%     end
end


% FlattenedData = spec3d(:,:,3)'; % 展开矩阵为一列，然后转置为一行。
% MappedFlattened = mapminmax(FlattenedData, 0, 1); % 归一化。
% MappedData = reshape(MappedFlattened, size(spec3d(:,:,3)));
% 
% spec3d(:,:,3)=MappedData;





