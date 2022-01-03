%Q1sol
clear all
close all
clc
%%%%%%%%%%%%%%%%%%%%%
lambda=6;mu=10;endtime=3000;
[N,T,ro]=Q1sim(lambda,mu,endtime);
figure,plot(ro)
freqCount=0;
for kk=1:1000
    lambda=8;mu=10;endtime=100;
    [N,T,ro]=Q1sim(lambda,mu,endtime);
    disp(ro(1:10))
    if sum(ro(1:10)>1)>0
        freqCount=freqCount+1;
    end
end
prob=freqCount/1000 *100; %procent of prob


