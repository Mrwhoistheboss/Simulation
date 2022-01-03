function Q4sol


%Q4A
%%%%%%%%%%%%%%%%%%%%
% These parallel versus series connections can be tested by generating two  random
% numbers   for   each   round   of   simulation.   If   the   uniform   number  
% is   below   0.125,the component will fail. This is coded in failure_mc
% function.
[ser,par] = failure_mc(1000);
%a)
% par,
%b)
% ser,


%Q4B
%%%%%%%%%%%%%%%%%%%%%
n=50;
k=9;
%a)
  p = Q4b(rand(n,1),k);
%   we reject the hypothesis of the sample being uniformly distributed, if the P-
%   value is less than the confidence level we have chosen (e.g. 0.05).
  if p<0.05,
     not_uniform=1,
  else
     uniform=1,
  end
%%%%%
%b)
p=zeros(100,1);
for i = 1:100
    p(i) = Q4b(rand(n,1),k);
end
y = find(p<0.05);
y2 = length(y)/n;
%The proportion of rejected cases should be somewhere near the confidence level.
disp(['proportion of rejected cases =',num2str(y2)])
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [ser,par] = failure_mc(N)
p = 0.125;
rand('state',0);
x = rand(N,2);
%Failures
ser = (x(:,1)<p | x(:,2)<p);
par = (x(:,1)<p & x(:,2)<p);
for i=1:N
    P_ser(i,1)= sum(ser(1:i))/i;
    P_par(i,1)= sum(par(1:i))/i;
end
%plot development of failure probability
figure,plot(P_ser, 'r'),hold on
plot(P_par, 'b');title('Development of failure probability')
legend('Series', 'Parallel');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function y = Q4b(x,k)
% chitest
%%%%%%%%%%%%%%
%First, calculate the sample size
N=length(x);
% In the context of random number generation, the idea of the chi-square test is
% assess, whether a generated random sample is uniformly distributed on the interval
% [0,1]. In the test, [0,1] is divided into  
% k subintervals. Then, the number of random numbers that lie within each subinterval and
% the number of points we would expect to lie within each interval are calculated to define 
% the test statistic. Essentially we are comparing the observed probability distribution to the one we are trying to create.
%The subintervals of [0,1] are ](i-1)/k,i/k], i=1,2,...,k. To calculate the observed values
%within each of these:
f=zeros(k,1);
for i = 1:k
    f(i) = length(find(x>(i-1)/k & x<=i/k));    
end
%The test statistic becomes
X2 = sum(((f-N/k).^2)./(N/k));
%The P-value of the test is the tail probability of the chi-square distribution at X2
y = 1-chi2cdf(X2,k-1);
