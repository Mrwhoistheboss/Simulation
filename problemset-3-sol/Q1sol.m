%Q1
clear all
close all
clc
%%%%%%%
mu1=0.3;
mu2=0.35;
X=exprnd(mu1,1000,1);
Y=exprnd(mu2,1000,1);
Z=X+Y;
figure,plot(Z)
%%%%%%%%%%%%%%
t=0:0.01:34.95;
t1=exp(-mu1*t);
t2=exp(-mu2*t);

figure,plot(t1), hold on
plot(t2,'r')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Z=X+Y   (thik about AND operation)
% fz(z)=integral of (fy(z-x)*fx(x)dx )
% this is the same as convollution of fy and fx
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
t3=conv(t1,t2,'same');

figure,plot(t,t1,'b', t,t2,'k',t,t3,'r')
%%%%%%%%%%%%%%
pdTeo = fitdist(t3','exponential') %theoretical
pd = fitdist(Z,'exponential') %simulation according theoretical model (i.e. having exponential)
%%%%%%%%%%%%%%
x_values = 0:0.05:1;
y = pdf(pdTeo,x_values);
figure,plot(x_values,y,'LineWidth',2),hold on
plot(x_values,y,'ro','LineWidth',2)
title('Theoretical pdf, convolution')
pause(2)
%%%%%%%
y = pdf(pd,x_values);
plot(x_values,y,'k','LineWidth',2),hold on
plot(x_values,y,'g+','LineWidth',2)
title('Simulation pdf')





