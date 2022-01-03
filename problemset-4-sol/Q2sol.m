%Q4A
close all
clear all
clc
%%%%%%%%%%%%%%%%%
t = 1:1000000;
z = 1/5*t + t.*randn(size(t));
figure,plot(t,z)
figure,plot(t,z,'o')

[bins,p]=acNhist2(z,0);
figure,plot(bins,p,'b','LineWidth',2); % it is used to plot the envelope of the histogram.
grid minor; 

z2=detrend(z);
figure,plot(t,z2)
[bins,p]=acNhist2(z2,0);
figure,plot(bins,p,'b','LineWidth',2); % it is used to plot the envelope of the histogram.
grid minor; 

for kk=1:3
    [bins,p]=acNhist2(z2(1:1000*10^kk),0);
    figure,plot(bins,p,'b','LineWidth',2); % it is used to plot the envelope of the histogram.
    grid minor; 
    title(['index of partition =',num2str(kk)])
end

[bins,p]=acNhist2(z2(1000:50000),0);
figure,plot(bins,p,'b','LineWidth',2); % it is used to plot the envelope of the histogram.
grid minor; 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% when the ratio between mean and sigma is a certain factor
ratio=[1/2, 1/3,1/4,1/5];
for k=ratio
    sigma = randi(10,1,1);
    mu = sigma*k;

    x=-3*sigma:3*sigma;
    y = pdf('Normal',x,mu,sigma);
    figure,plot(y)
    title(['mu=',num2str(mu),'  sigma=',num2str(sigma)])
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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