function tq=Q5(n,m,lambda,mu)
%Simulate a system of m parallel servers, capacity of each server is 1.
%Each server has an own queue with FIFO discipline.
%Customers arrive according to a stationary Poisson process and always 
%choose the shortest queue. If the same number of customers are present
%at both servers, the server is chosen randomly. 
%
%n          simulate until n customers have left the system.
%lambda     arrival rate of customers.
%mu         [1xm] vector of service rates
%
%tq         the average queueing delay of customers is returned

ua=rng;          %Generator state for arrivals
ud=rng;          %Generator state for service delays
uc=rng;          %Generator state for choosing between servers

%First arrival
ua=rng;
rng(ua)
ta = exprnd(1/lambda);

%Departure times of customers at each server
td=ones(1,m)*inf;   
queue=cell(1,m);    %Queued customers
n_in=0;             %Number of customer arrivals
n_out=0;            %Number of customer departures
tq=0;               %Queueing delay of customers
t=0;                %Simulation clock 
%The main simulation loop
while n_out<n
    if ta<min(td)                    %Next event is arrival
        %Update statistics
        n_in = n_in+1;    
        for j=1:m            
            tq=tq+length(queue{j})*(ta-t);
        end
        %Each customer will use same random number seeds across
        %replications        
        ua=rng;       
        ud=rng;       
        uc=rng;
        
        %Find server with least customers present        
        i=1;        
        y=length(queue{i})+(td(i)<inf);
        for j=2:m
            if length(queue{j})+(td(j)<inf)<y 
                i=j;                
                y=length(queue{j})+(td(j)<inf);
            elseif length(queue{j})+(td(j)<inf)==i(1) 
                i=[i j];
            end
        end
        %If ties exist, select randomly
        rng(uc)%rand('state',uc);        
        I=i(unidrnd(length(i)));
        
        %Service delay        
        rng(ud) 
        z=exprnd(1/mu(I));
        
        %Add either to server or queue
        if td(I)==inf                       %Server is idle       
            td(I)=ta+z;
        else
            queue{I} = [queue{I} z];        %Service delay is stored
        end
            %Update simulation clock
            t = ta;
            
            %Next arrival        
            rng(ua)        
            ta = t+exprnd(1/lambda);
    else           %Next event is departure
            %Update statistics        
            n_out=n_out+1;
            for j=1:m            
                tq=tq+length(queue{j})*(min(td)-t);end
            
            %Update simulation clock        
            t = min(td);
            
            %Get the index i of the server with the smallest departure time 
            [z,i]=min(td);
            
            %Take next customer from queue at server i, if any exist
            if length(queue{i})>0            
                td(i)=t+queue{i}(1);            
                queue{i} = queue{i}(2:end);
            else
                td(i)=inf;
        
            end
    end
end
%Average queuing delay per customer
tq=tq/n_in;
        
        
        