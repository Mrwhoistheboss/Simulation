%Q4A

t = 1:10000;
z = 1/2*t + t.*randn(size(t));
figure,plot(t,z)

p=acNhist(z)

% A=1.2;                      %amplitude of the signal
% alfa=0.5;
% beta=10;
% Fs=100;                     %sampling rate        
% Ts=1/Fs;                    %sampling period
% t=0:Ts:10;                  %time vector
% y=A*exp(-alfa*t).*sin(beta*t)+ rand(size(t));
% plot(t(1:1000),y(1:1000),'k','LineWidth',2),grid on
% title('Random non-stationary continuous signal','FontWeight','Bold','FontSize',14)
% xlabel('time t(second)','FontWeight','normal','FontSize',12)
% ylabel('amplitude u(volt)','FontWeight','normal','FontSize',12)
% 
% 
% mean(Y)
% std(A)
% 
% 
% figure,subplot(2,1,1)
% autocorr(Y)
% subplot(2,1,2)
% parcorr(Y)