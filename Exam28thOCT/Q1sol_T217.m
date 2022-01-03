%Lakshmikanth Akurathi--19991213-T217
%Q1a)
clear all
clc
N= 2000;
x = 4 + randn(N,1);
gen = (1.5/2)*(x.^0.5).*exp(-0.5*(x.^1.5));
figure,
hist(gen,30);colormap('cool')
xlabel('y'),ylabel('pdf(y)'),title('histogram of generated data')
[bins,p]=acNhist2(gen,0);
figure,plot(bins,p,'k','LineWidth',2); 
grid minor; 
title('Distrubution of serivice time')

%Q1b)
syms x
z=@(x) (1.5/2)*(x.^0.5).*exp(-0.5*(x.^1.5));
int=integral(z,0,inf)
% by this i can say that the generated data has a pdf because the integral
% of pdf has to be equal to 1.
%Q1c)
%[acf,lags] = autocorr(gen,'NumLags',10);
figure,
autocorr(gen,10); %which gives the autocorrelation with 10 lags.