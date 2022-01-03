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
rand('state',ua); %rand('state',N) for integer N in the closed interval [0 2^32-1] initializes the generator to the Nth integer state.
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
