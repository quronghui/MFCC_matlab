function un = Preaccentuation( x )
%UNTITLED3 此处显示有关此函数的摘要
%   此处显示详细说明
% ee=x(1500:1755);  
% https://blog.csdn.net/liusandian/article/details/51933339

% 固定FFT的数据为1024，x<1024--pad zero;x>1024--截断
r=fft(x,1024);  
r1=abs(r);  
pinlv=(0:1:255)*8000/512;  % 16khz
yuanlai=20*log10(r1);       
signal(1:256)=yuanlai(1:256);  

% 定义高通滤波
[h1,f1]=freqz([1,-0.98],[1],256,4000);  
pha=angle(h1);  % 相位
H1=abs(h1);     % 幅值
r2(1:256)=r(1:256);  
u=r2.*h1';      %%  将信号频域与高通滤波器频域相乘 相当于在时域的卷积 
u2=abs(u);  
u3=20*log10(u2);  
un=filter([1,-0.98],[1],x);     %un 为经过高频提升后的时域信号
end

