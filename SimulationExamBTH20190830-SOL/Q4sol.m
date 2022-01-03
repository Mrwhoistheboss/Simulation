%Q4sol
close all
clear all
clc
%%%%%%%%%%%%%%%%%%%%%%%%%%
mu=[];
st=[];
N = 1000; 
for K = 1:100
    U = 0.2+rand(1,N)*0.7; X = 5*exp(U).^2;
%     disp([mean(X) std(X) 2*std(X)/sqrt(N)])
    mu=[mu,mean(X)];
    st=[st,std(X)];
end  
MU = fitdist(mu','Normal') %95%
[xcMU,lags] = xcorr(mu-mean(mu),1,'coeff');
lag1Corr=xcMU(1),

ST = fitdist(st','Normal') %95%
[xcST,lags] = xcorr(st-mean(st),1,'coeff');
lag1Corr=xcST(1),

