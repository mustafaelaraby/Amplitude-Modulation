%% ============================ Contact =================================%%

% this code is written by:
%     Mustafa Elaraby.        Tel: +201097646496

%% ============================= clear ==================================%%

clear;
close all;
clc;

%% ================ generate message and carrier signals =============== %%
import inverseSinc.*

B = 1000;
fc = 10000;
fs = 100000;
dt = 1 / fs;
t = -0.005:dt:0.005 - dt;
t2 = 0:dt:0.01 - dt;
m = sinc(B * t);

%% =========================== Modulation ===============================%%

USB = ssbmod(m, fc, fs, 0, "upper");
LSB = ssbmod(m, fc, fs, 0);

figure(1);

subplot(3, 1, 1)
plot(t, m, LineWidth = 1);
title('Message')
xlabel('Time(sec)')
ylabel('m(t)')
ylim([-0.5 1.1])
grid on;

subplot(3, 1, 2)
plot(t, USB);
title('USB Modulated')
xlabel('Time(sec)')
ylabel('USB')
grid on;

subplot(3, 1, 3)
plot(t, LSB);
title('LSB Modulated')
xlabel('Time(sec)')
ylabel('LSB')
grid on;

%% ======================= Frequancy Spectrum ===========================%%

M_spectr = abs(fftshift(fft(m)));
USB_Spectr = abs(fftshift(fft(USB)));
LSB_Spectr = abs(fftshift(fft(LSB)));

f = -fs / 200:1:fs / 200 - dt;

figure(2)

subplot(3, 1, 1)
plot(f / 10, M_spectr);
title('Message Frequancy Spectrum')
xlabel('Frequancy(kHz)')
ylabel('M(f)')
grid on;

subplot(3, 1, 2)
plot(f / 10, USB_Spectr);
title('USB Modulated Frequancy Spectrum')
xlabel('Frequancy(kHz)')
ylabel('USB')
grid on;

subplot(3, 1, 3)
plot(f / 10, LSB_Spectr);
title('LSB Modulated Frequancy Spectrum')
xlabel('Frequancy(kHz)')
ylabel('LSB')
grid on;

%% ========================== Demodulation ==============================%%

% Local carrier frequency at the receiver is fc.
USB_Demod = ssbdemod(USB, fc, fs, 0);
LSB_Demod = ssbdemod(LSB, fc, fs, 0);

figure(3);

subplot(3,3, 1)
plot(t, m, LineWidth = 1);
title('Message')
xlabel('Time(sec)')
ylabel('m(t)')
ylim([-0.5 1.1])
grid on;

subplot(3, 3, 4)
plot(t, USB_Demod, LineWidth = 1);
title('USB Demodulated with fc')
xlabel('Time(sec)')
ylabel('m(t)')
ylim([-0.5 1.1])
grid on;

subplot(3, 3, 7)
plot(t, LSB_Demod, LineWidth = 1);
title('LSB demodulated with fc')
xlabel('Time(sec)')
ylabel('m(t)')
ylim([-0.5 1.1])
grid on;


% Local carrier frequency at the receiver is f1 = fc + 0.1B.
f1 = fc + 0.1*B;
USB_Demod_f1 = inverseSinc(ssbdemod(USB, f1, fs, 0));
LSB_Demod_f1 = inverseSinc(ssbdemod(LSB, f1, fs, 0));




subplot(3, 3, 2)
plot(t, m, LineWidth = 1);
title('Message')
xlabel('Time(sec)')
ylabel('m(t)')
ylim([-0.5 1.1])
grid on;

subplot(3, 3, 5)
plot(t, USB_Demod_f1, LineWidth = 1);
title('USB Demodulated with f1 = fc + 0.1B')
xlabel('Time(sec)')
ylabel('m(t)')
ylim([-0.5 1.1])
grid on;

subplot(3, 3, 8)
plot(t, LSB_Demod_f1, LineWidth = 1);
title('LSB Demodulated with f1 = fc + 0.1B')
xlabel('Time(sec)')
ylabel('m(t)')
ylim([-0.5 1.1])
grid on;


% Local carrier frequency at the receiver is f1 = fc - 0.1B.
f2 = fc - 0.1*B;
USB_Demod_f2 = inverseSinc(ssbdemod(USB, f2, fs,0));
LSB_Demod_f2 = inverseSinc((ssbdemod(LSB, f2, fs,0)));


subplot(3, 3, 3)
plot(t, m, LineWidth = 1);
title('Message')
xlabel('Time(sec)')
ylabel('m(t)')
ylim([-0.5 1.1])
grid on;

subplot(3, 3, 6)
plot(t, USB_Demod_f2, LineWidth = 1);
title('USB Demodulated with f2 = fc - 0.1B')
xlabel('Time(sec)')
ylabel('m(t)')
ylim([-0.5 1.1])
grid on;

subplot(3, 3, 9)
plot(t, LSB_Demod_f2, LineWidth = 1);
title('LSB Demodulated with f2 = fc - 0.1B')
xlabel('Time(sec)')
ylabel('m(t)')
ylim([-0.5 1.1])
grid on;




%% ============================ Compare =================================%%

figure(4)

subplot(3,1,1)
plot(t, m, 'b', t, USB_Demod, 'r-.', t, LSB_Demod, 'g:', LineWidth = 1.5);
legend('Original Signal', 'Demodulation of Upper Sideband', 'Demodulation of Lower Sideband');
title('Demodulation with fc')
xlabel('Time(sec)')
ylabel('m(t)')
ylim([-0.5 1.1])
grid on;


subplot(3,1,2)
plot(t, m, 'b', t, USB_Demod_f1, 'r-.', t, LSB_Demod_f1, 'g:', LineWidth = 1.5);
legend('Original Signal', 'Demodulation of Upper Sideband', 'Demodulation of Lower Sideband');
title('Demodulation with f1 = fc + 0.1B')
xlabel('Time(sec)')
ylabel('m(t)')
ylim([-0.5 1.1])
grid on;


subplot(3,1,3)
plot(t, m, 'b', t, USB_Demod_f2, 'r-.', t, LSB_Demod_f2, 'g:', LineWidth = 1.5);
legend('Original Signal', 'Demodulation of Upper Sideband', 'Demodulation of Lower Sideband');
title('Demodulation with f2 = fc - 0.1B')
xlabel('Time(sec)')
ylabel('m(t)')
ylim([-0.5 1.1])
grid on;

%% ============================ Exports =================================%%
Message = [t2' m'];

