
%% ============================ Contact =================================%%

% this code is written by:
%     1. Karim Ehab.             Tel: +201278328761
%     2. Mustafa Elaraby.        Tel: +201097646496
%     3. Yasmina Amr.            Tel: +201278219694

%% ============================= clear ==================================%%

clear;
close all;
clc;

%% ================ generate message and carrier signals =============== %%

Fs = 1000;                                                                  % sampling frequency.
dt = 1/Fs;                                                                  % sample period. 
t = 0:dt:1-dt;                                                              % time interval
fc = 100;                                                                   % carrier frequency in 10^2 Hz
m_t = sawtooth((4*pi*t)+pi,0);                                              % message signal
c_t = 1*cos(2*pi*fc*t);                                                     % carrier signal.

%% ============================ Modulation  ============================ %%

Ka1 = 0.5;                                                                  % modulation index == 0.5 ==
Ka2 = 1;                                                                    % modulation index == 1.0 ==
Ka3 = 2;                                                                    % modulation index == 1.0 ==

s1_t = (1 + (Ka1.*m_t)).*c_t;                                               % modulated signal
s2_t = (1 + (Ka2.*m_t)).*c_t;                                               % modulated signal
s3_t = (1 + (Ka3.*m_t)).*c_t;                                               % modulated signal


%% ============================ Exports  ============================ %%

Message = [t' ,m_t'];
Carrier = [t', c_t'];



%% ============================== plots  =============================== %%

figure(1)

% plot message signal.
subplot(2,1,1)
plot(t,m_t,"LineWidth",2);
ylim([-1.1 1.1])
xlabel('Time(ms)')
ylabel('Amplitude(V)')
title('Message Signal')
grid on

% plot carrier signal.
subplot(2,1,2)
plot(t*10,c_t,"LineWidth",2);
xlim([0 1])
xlabel('Time(ms)')
ylabel('Amplitude(V)')
title('carrier Signal')
grid on


figure(2)

% plot modulated signal with Ka = 0.5.
subplot(3,1,1)
plot(t,s1_t,Color=[0 0.6 0]);
xlabel('Time(s)')
ylabel('Amplitude(V)')
title('Modulated Signal with Ka = 0.5')
grid on

% plot modulated signal with Ka = 1.0.
subplot(3,1,2)
plot(t,s2_t,Color=[0 0.6 0]);
xlabel('Time(s)')
ylabel('Amplitude(V)')
title('Modulated Signal with Ka = 1.0')
grid on

% plot modulated signal with Ka = 2.0.
subplot(3,1,3)
plot(t,s3_t,Color=[1 0 0]);
xlabel('Time(s)')
ylabel('Amplitude(V)')
title('Modulated Signal with Ka = 2.0')
grid on


figure(3)

% plot frequancy spectrum of the message signal.
M_s = fft(m_t);
M_Shifted = fftshift(M_s);
f = -Fs/2:1:Fs/2-1;
subplot(2,1,1)
plot(f/10,abs(M_Shifted)/Fs);
title('Message Freq. spectrum')
xlabel('Frequency (kHz)')
ylabel('Magnitude')
grid on

% plot frequancy spectrum of the carrier signal.
C_s = fft(c_t);
C_Shifted = fftshift(C_s);
subplot(2,1,2)
plot(f/10,abs(C_Shifted)/Fs);
title('Carrier Freq. spectrum')
xlabel('Frequency (kHz)')
ylabel('Magnitude')
grid on


figure(4)

% plot frequancy spectrum of the modulated signal with Ka = 0.5.
S1_s = fft(s1_t);
S1_Shifted = fftshift(S1_s);
subplot(3,1,1)
plot(f/10,abs(S1_Shifted)/Fs);
title('Freq. Spectrum of Modulated Signal with Ka = 0.5')
xlabel('Frequency (kHz)')
ylabel('Magnitude')
grid on


% plot frequancy spectrum of the modulated signal with Ka = 1.0.
S2_s = fft(s2_t);
S2_Shifted = fftshift(S2_s);
subplot(3,1,2)
plot(f/10,abs(S2_Shifted)/Fs);
title('Freq. Spectrum of Modulated Signal with Ka = 1.0')
xlabel('Frequency (kHz)')
ylabel('Magnitude')
grid on

% plot frequancy spectrum of the modulated signal with Ka = 2.0.
S3_s = fft(s3_t);
S3_Shifted = fftshift(S3_s);
subplot(3,1,3)
plot(f/10,abs(S3_Shifted)/Fs,Color=[1 0 0]);
title('Freq. Spectrum of Modulated Signal with Ka = 2.0')
xlabel('Frequency (kHz)')
ylabel('Magnitude')
grid on

%% =============================== LPF  ================================ %%

figure(5)


% passing the signal modulated with Ka = 0.5 through LPF.
n = 5;
Wn = 2*fc/Fs;
pos_envelop1 = abs(s1_t);
[b,a] = butter(n,Wn);
filtered_signal1 = filter(b,a,pos_envelop1);
filtered_signal_s1 = fft(filtered_signal1);
filtered_signal_Shifted1 = fftshift(filtered_signal_s1);

subplot(3,1,1)
plot(f/10,abs(filtered_signal_Shifted1)/Fs);
title('Freq. Spectrum of Demodulated Signal with Ka = 0.5')
xlabel('Frequency (kHz)')
ylabel('Magnitude')
grid on


% passing the signal modulated with Ka = 1.0 through LPF.
n = 5;
Wn = 2*fc/Fs;
pos_envelop2 = abs(s2_t);
[b,a] = butter(n,Wn);
filtered_signal2 = filter(b,a,pos_envelop2);
filtered_signal_s2 = fft(filtered_signal2);
filtered_signal_Shifted2 = fftshift(filtered_signal_s2);

subplot(3,1,2)
plot(f/10,abs(filtered_signal_Shifted2)/Fs);
title('Freq. Spectrum of Demodulated Signal with Ka = 1.0')
xlabel('Frequency (kHz)')
ylabel('Magnitude')
grid on


% passing the signal modulated with Ka = 2.0 through LPF.
n = 5;
Wn = 2*fc/Fs;
pos_envelop3 = abs(s3_t);
[b,a] = butter(n,Wn);
filtered_signal3 = filter(b,a,pos_envelop3);
filtered_signal_s3 = fft(filtered_signal3);
filtered_signal_Shifted3 = fftshift(filtered_signal_s3);

subplot(3,1,3)
plot(f/10,abs(filtered_signal_Shifted3)/Fs,Color=[1 0 0]);
title('Freq. Spectrum of Demodulated Signal with Ka = 2.0')
xlabel('Frequency (kHz)')
ylabel('Magnitude')
grid on




figure(6)

subplot(2,3,1)
plot(t,pos_envelop1);
xlabel('Time(ms)')
ylabel('Amplitude(V)')
title('Envelope of Modulated Signal with Ka = 0.5')

grid on
subplot(2,3,4)
plot(t,filtered_signal1)
xlabel('Time(s)')
ylabel('Amplitude(v)')
title('Demodulated Signal with Ka = 0.5')
grid on

subplot(2,3,2)
plot(t,pos_envelop2);
xlabel('Time(ms)')
ylabel('Amplitude(V)')
title('Envelope of Modulated Signal with Ka = 1.0')

grid on
subplot(2,3,5)
plot(t,filtered_signal2)
xlabel('Time(s)')
ylabel('Amplitude(v)')
title('Demodulated Signal with Ka = 1.0')
grid on

subplot(2,3,3)
plot(t,pos_envelop3,Color=[1 0 0]);
xlabel('Time(ms)')
ylabel('Amplitude(V)')
title('Envelope of Modulated Signal with Ka = 2.0')

grid on
subplot(2,3,6)
plot(t,filtered_signal3,Color=[1 0 0])
xlabel('Time(s)')
ylabel('Amplitude(v)')
title('Demodulated Signal with Ka = 2.0')
grid on

