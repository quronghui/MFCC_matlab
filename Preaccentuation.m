function un = Preaccentuation( x )
%UNTITLED3 此处显示有关此函数的摘要
%   此处显示详细说明
% ee=x(1500:1755);  
% https://blog.csdn.net/liusandian/article/details/51933339
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
end

