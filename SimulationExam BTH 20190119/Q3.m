function [Y,rej,c]=Q3(N)
%Generates N half normal random variates using acceptance/rejection
%method
%Output:
%Y    Generated sample 
%rej  Number of rejected points  

%Define the target density f and alternative sampling distribution g
f = @(x)(2/sqrt(2*pi))*exp(-(x^2)/2);
g = @(x)exp(-x);

c = sqrt(2*exp(1)/pi);%Constant sup(f/g)
Y=[];
rej=0;
for i=1:N
    test = 0;
    while test == 0
        X=exprnd(1);%Generate X having pdf g 
        U=rand; %Generate U~U(0,1)

        if U < f(X)/(c*g(X)) %Check whether U <= f(X)/(c*g(X))
            test=1;
            Y=[Y;X];
        else
            rej=rej+1;
        end
    end
end
