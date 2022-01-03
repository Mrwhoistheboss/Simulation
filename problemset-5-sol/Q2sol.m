function Q2sol

%Q2a
% The results of 10 replications using independent and correlated sampling for
% configurations p=0.3 and p=0.8
%%%%%%%%%%%%%%%

% Now, to perform 10 independent replications with p=0.3, for instance, you could write
% (each replication requires far less than, say, 1000 random numbers):
y1=zeros(10,1);
y2=zeros(10,1);
for i=1:10 %independent
    y1(i)=Q2(100,1,1/0.7,1/0.9,0.3,(i-1)*1000,0);
    y2(i)=Q2(100,1,1/0.7,1/0.9,0.8,20000+(i-1)*1000,0);
end
%%%%%%%
figure,plot(y1, 'b'),hold on
plot(y2, 'k'),title('Expected average total waiting in both queues-Indepedent random numbers')
legend('P=0.3', 'p=0.8');

compMean=mean(y1-y2)
compVar=var(y1-y2)
%%%%%%%%%%%%%%%%
y1=zeros(10,1);
y2=zeros(10,1);
for i=1:10 %CRN (correlated)
    y1(i)=Q2(100,1,1/0.7,1/0.9,0.3,(i-1)*1000,0);
    y2(i)=Q2(100,1,1/0.7,1/0.9,0.8,(i-1)*1000,0);
end
%%%%%%%
figure,plot(y1, 'b'),hold on
plot(y2, 'k'),title('Expected average total waiting in both queues-CRN')
legend('P=0.3', 'p=0.8');

compMean=mean(y1-y2)
compVar=var(y1-y2)
% Variance reduction in this case is modest. Note, however, that this result is based on
% a rather limited sample size and is affected by the particular random number streams
% that were used in sampling. The results that you get may be different.

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Q2b

y1=zeros(5,1);
y2=zeros(5,1);
for i=1:5
    y1(i)=Q2(100,1,1/0.7,1/0.9,0.3,(i-1)*1000,0);
    y2(i)=Q2(100,1,1/0.7,1/0.9,0.3,20000+(i-1)*1000,0);
end

figure,plot(y1, 'b'),hold on
plot(y2, 'k'),title('Expected average total waiting in both queues-CRN')
legend('P=0.3', 'p=0.3 &Independet');
compMean=mean(y1-y2)
compVar=var(y1-y2)
%%%%%%%%%
y1=zeros(5,1);
y2=zeros(5,1);
for i=1:5
    y1(i)=Q2(100,1,1/0.7,1/0.9,0.3,(i-1)*1000,0);
    y2(i)=Q2(100,1,1/0.7,1/0.9,0.3,20000+(i-1)*1000,1);%antithetic
end

figure,plot(y1, 'b'),hold on
plot(y2, 'k'),title('Expected average total waiting in both queues-CRN')
legend('P=0.3', 'p=0.3 &antithetic');
compMean=mean(y1-y2)
compVar=var(y1-y2)
%Significant Variance reduction by antithetic 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [y,n_in,n_out]=Q2(N,lambda,mu1,mu2,p,rstate,antithetic)
%N          number of customers to simulate
%lambda     arrival rate
%mu1        service rate at srever 1
%mu2        service rate at server 2
%p          customers leave system after server 1 with probability p,
%           otherwise leave the system
%rstate     state of random number generator
%antithetic 1 turns on antithetic variates, 0 turn them off  
%
%
%All times exponentially distributed
t=0;        %Simulation clock
n_in=0;     %Counter
n_out=0;    %Counter
ta=0;       %Next arrival
td1=inf;    %Next departure at server 1
td2=inf;    %Next departure at server 2

ua=rstate;  %Generator state for arrivals
ud1=rstate+2*N;  %Generator state for service delays at server 1
ud2=ud1+2*N;     %Generator state for service delays at server 2
up=ud2+2*N;      %Generator state for entering server 2

s1=0;       %Customer service at server 1
s2=0;       %Customer service at server 2
nq1=0;      %Number in queue at server 1
nq2=0;      %Number in queue at server 2
tq=0;       %Total queueing time in the system

%First arrival
ua=ua+1;
rand('state',ua);
z=rand;
if antithetic==1
    z=1-z;
end

ta = -(1/lambda)*log(z);

%The main simulation loop
while n_out<N
    if ta<min(td1,td2)     %Next event is arrival
        n_in=n_in+1;
        tq=tq+nq1*(ta-t)+nq2*(ta-t);
        t=ta;
        if s1==0           %Server is idle
            ud1=ud1+1;
            rand('state',ud1);
            z=rand;
            if antithetic==1
                z=1-z;
            end
        
            td1=t-(1/mu1)*log(z);
            s1=1;
        else    %Server is busy
            nq1=nq1+1;
        end
        ua=ua+1;    %Next arrival
        rand('state',ua);
        z=rand;
        if antithetic==1
            z=1-z;
        end
        
        ta=t-(1/lambda)*log(z);
    elseif td1<min(ta,td2)     %Next event is departure at server 1
        tq=tq+nq1*(td1-t)+nq2*(td1-t);
        t=td1;
        up=up+1;
        rand('state',up);
        z=rand;
        if antithetic==1
            z=1-z;
        end
        if z>p            %Customer enters server 2
            if s2==0      %Server is idle
                ud2=ud2+1;
                rand('state',ud2);
                z=rand;
                if antithetic==1
                    z=1-z;
                end

                td2=t-(1/mu2)*log(z);
                s2=1;
            else        %Server is busy
                nq2=nq2+1;
            end
        else            %Customer leaves the system
            n_out=n_out+1;
        end
        if nq1>0        %Waiting customers exist at server 1
            nq1=nq1-1;
            ud1=ud1+1;
            rand('state',ud1);
            z=rand;
            if antithetic==1
                z=1-z;
            end

            td1=t-(1/mu1)*log(z);
            s1=1;
        else
            s1=0;
            td1=inf;
        end
    elseif td2<min(ta,td1)   %Next event is departure at server 2
        tq=tq+nq1*(td2-t)+nq2*(td2-t);
        t=td2;
        n_out=n_out+1;
        if nq2>0             %Waiting customers exist at server 2
            nq2=nq2-1;
            ud2=ud2+1;
            rand('state',ud2);
            z=rand;
            if antithetic==1
                z=1-z;
            end
            td2=t-(1/mu2)*log(z);
            s2=1;
        else
            s2=0;
            td2=inf;
        end
    end
end
y=tq/n_in;    
%Return average total waiting time per customer            


