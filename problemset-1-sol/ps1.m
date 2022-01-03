
clear all
close all
clc
%%%%%%%%%%%%%%%%%%
Num_customers=10;

interarrivals=[];
for kk=1:Num_customers-1
    a=rand(1);
    if a<=0.23
        deltaT=0;
    elseif a<=0.23+0.37
        deltaT=20;
    elseif a<=0.23+0.37+0.28
        deltaT=40;
    else
        deltaT=60;
    end
    interarrivals=[interarrivals,deltaT];
end
%%%%%%
% figure,histogram(interarrivals)
% figure,h=histogram(interarrivals,'Normalization','probability')
% h.Values
%%%%%%%%
arrivalTimes=[0,cumsum(interarrivals)]; % here we get the stamp-time of arrivals
figure,plot(arrivalTimes,'o'),grid on
title('the stamp-time of arrivals')
% here we considered the first arrival time is 0
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
ser_mean=50;
ser_stD=8;
%according to the thumb rules
maxRnExp=ser_mean+3*ser_stD;
minRnExp=ser_mean-3*ser_stD;
serviceTimes=round([25;50;ser_stD*randn(8,1)+ser_mean]);
% here we considered there is ongoing service (25 min is remained of the
% ongoing service), also there is a job (50 min) waiting in the que
% when the first customer arrives
%%%%
% serviceTimes=round([25;50;ser_stD*randn(100000,1)+ser_mean]);
% max(serviceTimes),min(serviceTimes)
% figure,histogram(serviceTimes,'Normalization','pdf')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
time_service_begins=[0;cumsum(serviceTimes(1:end-1))]; %stamp-time of services
figure,plot(time_service_begins,'o'), grid on
title('time_service_begins')
% here 9/10 serviceTimes values are considered to have info for just 10
% customers
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
waitTime_inQue=time_service_begins-arrivalTimes';
tp=find(waitTime_inQue<0);
waitTime_inQue(tp)=0;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
time_service_ends=time_service_begins+serviceTimes;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Time_customer_spends_in_system=time_service_ends-arrivalTimes';
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
idleTimeInSystem=[];
idleTimeInSystem=[idleTimeInSystem;0];
for k=2:Num_customers
    idleTimeInSystem=[idleTimeInSystem;arrivalTimes(k)-time_service_ends(k-1)+waitTime_inQue(k)];
    pause(1)
end
% see here that adding the previous waitTime_inQue makes that the idle time
% value does not become a negative value
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%customerIndex(1),interarrivals(2),arrivalTimes(3),serviceTimes(4),time_service_begins(5)
%waitTime_inQue(6),time_service_ends(7),Time_customer_spends_in_system(8),idleTimeInSystem(9)
customerIndex=1:10;

SimTab=zeros(10,9);
SimTab(:,1)=customerIndex;
SimTab(:,2)=[nan,interarrivals];
SimTab(:,3)=arrivalTimes;
SimTab(:,4)=serviceTimes;
SimTab(:,5)=time_service_begins;
SimTab(:,6)=waitTime_inQue;
SimTab(:,7)=time_service_ends;
SimTab(:,8)=Time_customer_spends_in_system;
SimTab(:,9)=idleTimeInSystem;

SimTab;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
averageInQueue=mean(waitTime_inQue);
av_processing_time=round(mean(serviceTimes));
max_time_in_system=max(Time_customer_spends_in_system);


%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%
%nicer visulasation
T=table(customerIndex',[nan,interarrivals]',arrivalTimes',serviceTimes,time_service_begins,...
    waitTime_inQue,time_service_ends,Time_customer_spends_in_system,idleTimeInSystem)

T2=table(averageInQueue,av_processing_time,max_time_in_system)

