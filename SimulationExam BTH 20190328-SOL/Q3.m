%Q3
close all
clear all
clc
%%%%%%%%%%%%%%%%%%%
tmax=1500;
lambda=0.95;

arrtime=-log(rand)/lambda;  % Poisson arrivals
i=1;                  
  while (min(arrtime(i,:))<=tmax)
    arrtime = [arrtime; arrtime(i, :)-log(rand)/lambda];  
    i=i+1;
  end
n=length(arrtime);           % arrival times t_1,...t_n         

%%%%%%%%%%
%system1
%%%%%%%%%%
arrsubtr=arrtime-(0:n-1)';           % t_k-(k-1)
arrmatrix=arrsubtr*ones(1,n);        
deptime=(1:n)+max(triu(arrmatrix));  % departure times 
                                     % u_k=k+max(t_1,..,t_k-k+1)
				     
B=[ones(n,1) arrtime ; -ones(n,1) deptime']; 
Bsort=sortrows(B,2);                 % sort jumps in order
jumps=Bsort(:,1);
jumptimes=[0;Bsort(:,2)];
systsize=[0;cumsum(jumps)];                 % M/D/1 process
systtime=deptime-arrtime';                  % system times 

figure(1)
stairs(jumptimes,systsize);
xmax=max(systsize)+5;
axis([0 tmax 0 xmax]);
grid

figure(2)
% plot a histogram of system times
hist(systtime,30);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%     
%system2
%%%%%%%%%%
servtime=2.*rand(1,n);          % service times s_1,...,s_k
cumservtime=cumsum(servtime);

arrsubtr=arrtime-[0 cumservtime(:,1:n-1)]';           % t_k-(k-1)
arrmatrix=arrsubtr*ones(1,n);        
deptime=cumservtime+max(triu(arrmatrix));  % departure times 
                                        % u_k=k+max(t_1,..,t_k-k+1)   

% Output is system size process N and system waiting 
% times W.
B=[ones(n,1) arrtime ; -ones(n,1) deptime']; 
Bsort=sortrows(B,2);                 % sort jumps in order
jumps=Bsort(:,1);
jumptimes=[0;Bsort(:,2)];
systsize=[0;cumsum(jumps)];          % size of M/G/1 queue
systtime=deptime-arrtime';            % system times 

figure(3)
stairs(jumptimes,systsize);
xmax=max(systsize)+5;
axis([0 tmax 0 xmax]);
grid

figure(4)
hist(systtime,30);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%system2
%%%%%%%%%%
clear all
n=500;
lambda=0.95;
mu=1;

i=0;     %initial value, start on level i
tjump(1)=0;  %start at time 0
systsize(1)=i;  %at time 0: level i

for k=2:n
     if i==0
       mutemp=0;
     else 
       mutemp=mu;
     end
      
     time=-log(rand)/(lambda+mutemp);   % Inter-step times:
                                        % Exp(lambda+mu)-distributed
     if rand<lambda/(lambda+mutemp)
       i=i+1;     %jump up: a customer arrives
     else
       i=i-1;     %jump down: a customer is departing
     end          %if

     systsize(k)=i;      %system size at time i
     tjump(k)=time;      
end             %for i

tjump=cumsum(tjump);    %cumulative jump times
  
figure(5)
stairs(tjump,systsize);