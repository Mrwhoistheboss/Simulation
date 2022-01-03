function [A,D,Tp]= p3q2( T, lam )
% Single-Server Q Simulation
% Input is total time T and arrival rate lam
% Returns arrival times in A,
% departure times in D, and
% overtime (time past T for last service) in Tp
%

t = 0; na = 0; nd = 0; n = 0;
ta = -log(rand)/lam; td = inf;
while ta <= T % time left for more arrivals
    if ta <= td 
        t = ta; 
        n = n + 1; % new arrival
        na = na + 1; 
        A(na) = t;
        ta = t - log(rand)/lam;
        if n == 1 
            td = t + G; 
        end
    else 
        t = td; 
        n = n - 1; % departure
        nd = nd + 1; D(nd) = t;
        if n > 0 
            td = t + G;
        else, 
            td = inf;
        end
    end
end % no more arrivals, empty the Q
while n > 0 
    t = td; 
    nd = nd + 1;
    n = n - 1; 
    td = t + G;
    D(nd) = t;
end 
Tp = max(t-T,0);
% end snglsv
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Y = G  % Y ~ Uniform(.2,.3)
Y = .2 + .1*rand;
% end G = Uniform(.2,.3)