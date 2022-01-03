function Q1sol

%Q1b
d=queue1(100,1,0.9);

%Q1c

for i=1:100
    d=queue1(100,1,0.9);
    D(i)=mean(d); 
end

figure,plot(D)
CI=mean(D)+tinv(0.975,99)*sqrt(var(D)/100),

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Qa
function d=queue1(n,lambda,mu)
%Simulate delays in queue for single server queuing model (M/M/1)
%n the number of customers
%lambda the arrival rate of customers
%mu the service rate
t=exprnd(lambda*ones(n-1,1)); 
%inter-arrival times
s=exprnd(mu*ones(n-1,1));     
%service timese
d=zeros(n,1);
d(1)=0; %waiting time for customer 1 equals 0
for i=2:n
    d(i)=max(d(i-1)+s(i-1)-t(i-1),0);
end
d=d';