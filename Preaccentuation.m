function un = Preaccentuation( x )
%UNTITLED3 �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
% ee=x(1500:1755);  
% https://blog.csdn.net/liusandian/article/details/51933339

% �̶�FFT������Ϊ1024��x<1024--pad zero;x>1024--�ض�
r=fft(x,1024);  
r1=abs(r);  
pinlv=(0:1:255)*8000/512;  % 16khz
yuanlai=20*log10(r1);       
signal(1:256)=yuanlai(1:256);  

% �����ͨ�˲�
[h1,f1]=freqz([1,-0.98],[1],256,4000);  
pha=angle(h1);  % ��λ
H1=abs(h1);     % ��ֵ
r2(1:256)=r(1:256);  
u=r2.*h1';      %%  ���ź�Ƶ�����ͨ�˲���Ƶ����� �൱����ʱ��ľ�� 
u2=abs(u);  
u3=20*log10(u2);  
un=filter([1,-0.98],[1],x);     %un Ϊ������Ƶ�������ʱ���ź�
end

