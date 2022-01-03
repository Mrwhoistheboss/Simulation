%Q1sol
clear all
close all
clc
%%%%%%%%%%%%
NN=1000;
x1=[];
x2=[];
for kk=1:NN
    
    % function [Y1,Y2]=Q1(mu,sigma)
    W = 10;
    while W > 1    
        U1 = rand;    
        U2 = rand;    
        V(1) = 2*U1-1;    
        V(2) = 2*U2-1;    
        W = sum(V.^2);
    end
    Y=sqrt(-2*log(W)/W);
    x1 = [x1,V(1)*Y];
    x2 = [x2,V(2)*Y];

end
[xc1,lags1] = xcorr(x1',1,'coeff');
[xc2,lags2] = xcorr(x2',1,'coeff');
xc1, xc2, %these values are small then they are idd
%%%%%%%%%%%%%%%%%%
mu=10, sigma=1
y1=mu+sigma*x1;
y2=mu+sigma*x2;
figure,plot(x1,'b'),hold on, plot(x2,'r')
figure,plot(y1,y2,'o')
%%%%%%%%
k1=acNhist(y1);
k2=acNhist(y2);
%showing tw gaussian random numbers
% the algorithm simulating rotationa Guassian random generation
