function [N,T, arrivals, services]=Q4sim2(sysType,endtime,p,rstate,antithetic)


%p          customers leave system after server 1 with probability p,
%           otherwise leave the system
%rstate     state of random number generator
%antithetic 1 turns on antithetic variates, 0 turn them off  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if sysType==1
    %M/M/1 system
    lambda=8.5; %arrival rate
    mu=10; %service rate
    ua=rstate;       %Generator state for arrivals (sysTpe 1,i.e. M/M/1)
    ud1=rstate+2*N;  %Generator state for service delays at (sysTpe 1,i.e. M/M/1)
else
   %M/U/1 system
    lambda=8.5; %arrival rate
    ua=rstate;       %Generator state for arrivals (sysTpe 2,i.e. M/U/1)
    ud2=up+2*N;      %Generator state for service delays (sysTpe 2,i.e. M/U/1)
end

arrivals=[];
services=[];
%%%%%%%%%%%%%%
t=0; %current time
tstep=1; %average time between consecutive measurement events
currcustomers=0; %current number of customers in system
event=zeros(1,3); %constructs vector to keep time for next arrival %(pos 1),next service completion (pos 2) and next% measurement event (pos 3)
%%%%%%%%%%%%%%%%%%%%%%%%%%
% event(1)=exprnd(1/lambda); %time for next arrival1
ua=ua+1;
event(1)=myExprnd(1/lambda,ua);%exprnd(1/lambda); %time for next arrival1
%%%%%%%%%%%%%%%
arrivals=[arrivals,event(1)];
%%%%%%%%%%%%%%%
event(2)=inf; %no next service completion (empty system)
event(3)=exprnd(tstep); %time for next measurement event
nbrmeasurements=0; %number of measurement events so far
nbrdeparted=0; %number of departed customers
nbrarrived=0; %number of customers that have arrived throughout the simulations

while t<endtime
    [t,nextevent]=min(event);
    if nextevent==1
        
        %%%%%%%%%%%%%%%
%         theEvent=exprnd(1/lambda); %modified
        ua=ua+1;
        theEvent=myExprnd(1/lambda,ua);
        %%%%%%%%%%%%%%
        event(1)=theEvent+t;
        arrivals=[arrivals,theEvent];
        %%%%%%%%%%%%%%%
        currcustomers=currcustomers+1;
        nbrarrived=nbrarrived+1; %one more customer has arrived to the system through the simulations
        arrivedtime(nbrarrived)=t; %the new customer arrived at time t
        if currcustomers==1
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            if sysType==1
                %%%%%%%%
%                 theEvent=exprnd(1/mu); %modified
                ud1=ud1+1;
                theEvent=myExprnd(1/mu,ud1);
                %%%%%%%%
                event(2)=theEvent+t;
            else
                %%%%%%%%%%
%                 theEvent=rand(1); %modified
                ud2=ud2+1;
                theEvent=myrnd(ud2);
                %%%%%%%%
                event(2)=theEvent+t;
            end
            services=[services,theEvent];
%             event(2)=exprnd(1/mu)+t;
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        end
    elseif nextevent==2
        currcustomers=currcustomers-1;
        timeinsystem=t-arrivedtime(nbrarrived-currcustomers);
        nbrdeparted=nbrdeparted+1; %one more customer has departed%from the system through the%simulations
        T(nbrdeparted)=timeinsystem;
        if currcustomers>0
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            if sysType==1
                %%%%%%%%
%                 theEvent=exprnd(1/mu); %modified
                ud1=ud1+1;
                theEvent=myExprnd(1/mu,ud1);
                %%%%%%%%
                event(2)=theEvent+t;
            else
                %%%%%%%%
%                 theEvent=rand(1); %modified
                ud2=ud2+1;
                theEvent=myrnd(ud2);
                %%%%%%%%
                event(2)=theEvent+t;
            end
            services=[services,theEvent];
%             event(2)=exprnd(1/mu)+t;
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        else
            event(2)=inf;
        end
    else
        nbrmeasurements=nbrmeasurements+1; %one more measurement event
        N(nbrmeasurements)=currcustomers;
        event(3)=event(3)+exprnd(tstep);
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function ta=myExprnd(mu,ux)
rand('state',ux);
z=rand;
if antithetic==1
    z=1-z;
end
ta = -mu*log(z);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function z=myrnd(ux)
rand('state',ux);
z=rand;
if antithetic==1
    z=1-z;
end



