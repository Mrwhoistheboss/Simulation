%Q4sol
clear all
% close all
clc
%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Q4A-c
P1rate=0.01;
P2rate=0.05;
N=2000;

k=200;% 50, 100, 150 % number of the seats (obs: to answer the question C, just change the seat numbers)
%%%%%%%%%
aroundCount=1;
NN=[];
NN=[NN,N];
while N>0
    PP1=[];
    P1Prob=1-exp(-P1rate); % probability of leaving of passanger in first station
    PP1=[PP1,round(P1Prob*k)];% number of the people who left the first staion is included to PP1
    for g=2:18
        kk=k-sum(PP1(1:g-1)); %number of avalable seats before arriving a station seats 
        P1=1-exp(-P1rate*g);
        PP1=[PP1,round(kk*P1rate)];  % number of the people who are getting off in each station are gathered in PP1
    end
    
    totPP1=sum(PP1); % total number of the peopole who left the bus in a round
    P2Prob=1-exp(-P2rate*aroundCount); % probability of reduction of passenger in central station
    totPP2=round((k-totPP1)*P2Prob);  % number of the people who go off in central station in a round

    N=N-totPP1-totPP2; %remaining number of tourists after a round
    NN=[NN,N];
    aroundCount=aroundCount+1;
end
figure,plot(NN(1:end-1),'LineWidth',2)
title('number of passangers in central station')
NumberOfNecessaryRounds=aroundCount-1,
%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Q4c as code
P1rate=0.01;
P2rate=0.05;
%%%%%%%%%
NNm=[];
NNmlen=[];
for k=50:10:500, % variation of number of searts
    N=2000;
    aroundCount=1;
    NN=[];
    NN=[NN,N];
    while N>0
        PP1=[];
        P1Prob=1-exp(-P1rate); % probability of leaving of passanger in first station
        PP1=[PP1,round(P1Prob*k)];% number of the people who left the first staion is included to PP1
        for g=2:18
            kk=k-sum(PP1(1:g-1)); %number of avalable seats before arriving a station seats 
            P1=1-exp(-P1rate*g);
            PP1=[PP1,kk*P1rate];  % number of the people who are getting off in each station are gathered in PP1
        end

        totPP1=sum(PP1); % total number of the peopole who left the bus in a round
        P2Prob=1-exp(-P2rate*aroundCount); % probability of reduction of passenger in central station
        totPP2=(k-totPP1)*P2Prob;  % number of the people who go off in central station in a round

        N=N-totPP1-totPP2; %remaining number of tourists after a round
        NN=[NN,N];
        aroundCount=aroundCount+1;
    end
%     figure,plot(NN(1:end-1))
    NNm=[NNm,NN];
    NNmlen=[NNmlen,length(NN)];
end

figure,plot(50:10:500,NNmlen,'LineWidth',2)
xlabel(' Number of seats'), ylabel(' Around number')
title('The relation of around number to number of seats')








