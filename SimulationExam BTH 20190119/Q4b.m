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