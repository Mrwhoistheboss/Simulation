%Q5sol
close all
clear all
clc
%%%%%%%%%%%%%%%%%%%%%%%%%%'
lambda1=1; m1=2; mu1(1)=0.6; mu1(2)=0.6; n=100;
lambda2=1; m2=2; mu2(1)=0.3; mu2(2)=0.9; %n=100;
MU1=[];
MU2=[]; 
for K = 1:100
    tq1=Q5(n,m1,lambda1,mu1);
    tq2=Q5(n,m2,lambda2,mu2);
    MU1=[MU1,tq1];
    MU2=[MU2,tq2];
end  
figure,,plot(MU1,'b'),hold on
plot(MU2,'r')