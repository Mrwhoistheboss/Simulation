%Q3sol
% A)
lambda=12;      % arrival rate
Tmax=15;         % maximum time

clear T;
T(1)=random('Exponential',1/lambda);
i=1;

while T(i) < Tmax,
  T(i+1)=T(i)+random('Exponential',1/lambda);
  i=i+1;
end

Y=zeros(1,i-1);
plot(T(1:(i-1)),Y,'.');
%%%%%%%%%%%%%%%%%%%%%%%%%
% B)
ti=diff(T);
pd= fitdist(ti','Exponential') %95%
% ci1 = paramci(pd1,'Alpha',.01)%

x_values = 0:0.01:1;
y = pdf(pd,x_values);
plot(x_values,y,'LineWidth',2)






