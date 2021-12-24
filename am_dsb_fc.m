% INTRODUCTION INTO AMPLITUDE MODULATION DSB-FC
clear; clc; close all;

%% I. Variable
fs = 8000;
t = 0:1/fs:1;

% configurable parameters
vm = 1;         % message signal amplitude 
vc = 2;         % carrier signal amplitude
fm = 2;         % message signal frequency
fc = 10;        % carrier signal frequency

% visualization settings
msg_mod = 1;    % set to 0: just plot the modulated signal
                % set to 1: plot modulated & message together (overlap)
            
%% II. Message signal
% message signal
vmt = vm*cos(2*pi*fm*t);

% plotting signal
figure(1);
subplot(3,1,1);
plot(t,vmt);
x0=10; y0=10; width=1000; height=600;
set(gcf,'position',[x0,y0,width,height]);
title('message signal');
xlabel('time (s)');
ylabel('amplitude');
grid on;
            
%% III. Carrier signal
% carrier signal
vct = vc*cos(2*pi*fc*t);

% plotting signal
subplot(3,1,2);
plot(t,vct);
title('carrier signal');
xlabel('time (s)');
ylabel('amplitude');
grid on;
            
%% IV. Modulation index and bandwidth
Mam = vm/vc;    % modulation index
B = 2*fm;       % bandwidth

% printing resulting parameters
fprintf('modulation index : %.2f\n', Mam);
fprintf('bandwidth        : %d\n\n', B);

%% V. AM modulated signal
% AM modulated signal
vst = vc.*(1+Mam.*cos(2*pi*fm*t)).*cos(2*pi*fc*t);

% plotting signal
subplot(3,1,3);
plot(t,vst);
if msg_mod == 1
    hold on;
    plot(t,vmt+vc,'--r');
    plot(t,-vmt-vc,'--r');
    hold off;
end
grid on;
title('AM modulated signal');
xlabel('time (s)');
ylabel('amplitude');
            
%% VI. AM signal frequency spectrum
N = length(vst);
f = fs*[-N/2+0.5:N/2-0.5]/N;
X = fftshift(fft(vst,N));

% plotting spectrum
figure(2);
plot(f,abs(X)/fs);
x0=10; y0=10; width=1000; height=400;
set(gcf,'position',[x0,y0,width,height]);
title('spectrum of AM modulated signal');
xlabel('time (s)');
ylabel('amplitude');
xlim([-1.5*fc 1.5*fc]);
grid on;
grid minor;