clear all;  
% https://blog.csdn.net/liusandian/article/details/51933339
[x,sr]=audioread('E:\研究生\毕业设计\MFCC\Emo-DBwav\03a01Fa.wav');  %sr为采样频率  
% ee=x(1500:1755);  
r=fft(x,1024);  
r1=abs(r);  
pinlv=(0:1:255)*8000/512;  
yuanlai=20*log10(r1);  
signal(1:256)=yuanlai(1:256);  
[h1,f1]=freqz([1,-0.98],[1],256,4000);  
pha=angle(h1);  
H1=abs(h1);  
r2(1:256)=r(1:256);  
u=r2.*h1';  
u2=abs(u);  
u3=20*log10(u2);  
un=filter([1,-0.98],[1],x);  
  
figure(1);subplot(2,1,1);  
plot(f1,H1);title('高通滤波器的幅频特性');  
xlabel('频率/Hz');ylabel('幅度');  
subplot(2,1,2);plot(pha);title('高通滤波器的相频特性');  
xlabel('频率/Hz');ylabel('角度/rad');  
figure(2);subplot(2,1,1);plot(x);title('原始语音信号');  
%axis([0 256 -3*10^4 2*10^4]);  
xlabel('样点数');ylabel('幅度');  
subplot(2,1,2);plot(un);title('经高通滤波后的语音信号');  
%axis([0 256 -1*10^4 1*10^4]);  
xlabel('样点数');ylabel('幅度');  
figure(3);subplot(2,1,1);plot(pinlv,signal);title('原始语音信号频谱');  
xlabel('频率/Hz');ylabel('幅度/dB');  
subplot(2,1,2);plot(pinlv,u3);title('经高通滤波后的语音信号频谱');  
xlabel('频率/Hz');ylabel('幅度/dB');  


figure(4);plot(x);title('原始语音信号');  