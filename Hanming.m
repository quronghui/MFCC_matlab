function Hanming
clc
close all

% Ts = 0.001;
% Fs = 1/Ts;
% %% ԭʼ�ź�
% t = 0:Ts:pi/2;
% yt = sin(2*pi*5*t) + sin(2*pi*10*t) + sin(2*pi*15*t);


[yt,sr]=audioread('E:\�о���\��ҵ���\MFCC\Emo-DBwav\03a01Fa.wav');  %srΪ����Ƶ��  
Fs = sr;
Ts = 1/sr;
t = 1:length(yt);

[Yf, f] = Spectrum_Calc(yt, Fs);

figure(3)
subplot(211)
plot(t, yt)
xlabel('t')
ylabel('y')
title('ԭʼ�ź�')
subplot(212)
plot(f, Yf)
xlabel('f')
ylabel('|Yf|')
xlim([0 100])
ylim([0 1])
title('ԭʼ�ź�Ƶ��')


%% �Ӵ��ź�,������
win = hann(length(t));
win1 = hann(length(t)*0.228623731);
cy2 = zeros(length(t),1);
% cy(floor(0.4*length(t)):floor(0.8*length(t)),:)=ones(floor(0.8*length(t)-0.4*length(t)),1)
win1 = cy2(floor(0.4*length(t)/3.5):floor(1.2*length(t)/3.5));

yt1 = yt'.*cy2';
[Yf1, f1] = Spectrum_Calc(yt1, Fs);

figure(1)
subplot(311)
plot(t, yt1)
xlabel('t')
ylabel('y')
title('�Ӵ��ź�')
subplot(312)
plot(f1, 2*Yf1) % 2��ʾ����ϵ��
xlabel('f')
ylabel('|Yf|')
xlim([0 100])
ylim([0 1])
title('�Ӵ��ź�Ƶ��')
subplot(313)
plot(t,cy2)
title('��')


cy = zeros(length(t),1);
% cy(floor(0.4*length(t)):floor(0.8*length(t)),:)=ones(floor(0.8*length(t)-0.4*length(t)),1)
cy(floor(0.4*length(t)/3.5):floor(1.2*length(t)/3.5),:)=1;
yt2 = yt'.*cy';
[Yf2, f2] = Spectrum_Calc(yt2, Fs);
figure(2)
subplot(211)
plot(t, yt2)
xlabel('t')
ylabel('y')
title('ֱ�ӽض��ź�')
subplot(212)
plot(f2, 2*Yf2) % 2��ʾ����ϵ��
xlabel('f')
ylabel('|Yf|')
xlim([0 100])
ylim([0 1])
title('ֱ�ӽض��ź�Ƶ��')

win = hann(length(t));
yt3 = yt2.*win';
[Yf3, ~] = Spectrum_Calc(yt3, Fs);
figure(4)
subplot(311)
plot(t, yt3)
xlabel('t')
ylabel('y')
title('�ضϺ��ټӴ��ź�')
subplot(312)
plot(f2, 2*Yf3) % 2��ʾ����ϵ��
xlabel('f')
ylabel('|Yf|')
xlim([0 100])
ylim([0 1])
title('�ضϺ��ټӴ��ź�Ƶ��')
subplot(313)
plot(t,cy2)
title('��')
end

%% ��ȡƵ��
function [Yf, f] = Spectrum_Calc(yt, Fs)
L = length(yt);

NFFT = 2^nextpow2(L);
Yf = fft(yt,NFFT)/L;

Yf = 3000*abs(Yf(1:NFFT/2+1));
f = Fs/2*linspace(0,1,NFFT/2+1);
end