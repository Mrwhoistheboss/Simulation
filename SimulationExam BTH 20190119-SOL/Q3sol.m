function Q3sol

average_number_of_variatesV=[];
for i=1:10
    [Y,rej,c,average_number_of_variates]=myQ3(1000);
    average_number_of_variatesV=[average_number_of_variatesV,average_number_of_variates];
end
figure,plot(average_number_of_variatesV)
after_10_samples=mean(average_number_of_variatesV),
c,

% Based   on   10   independent   samples,   each   of   size   1000,   the   average   number   of
% variates X~g(x)required to generate an accepted variate Y~f(x) is 1.31. 
% We notice that this   is   the   value   of  c.
% In   fact,   it   can   be   shown   that   this   is   generally   true   for   the
% acceptance/rejection method. Our lesson is that selecting  g close to  f will  make  
% c small, which  can improve  the efficiency of the algorithm. We should, however, keep
% in mind the cost of generating
% from g. 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% To verify the code, we can view the density-histogram overplot 
% of the generated sample and the target density f
 
f = @(x)(2/sqrt(2*pi))*exp(-(x.^2)/2);
pp=0:5/100:5-5/100;
%%%%%%%%
h=histogram(Y);
h.Normalization = 'probability';
h.BinWidth = 0.3;
h.FaceColor = [1 1 1];
h.EdgeColor = 'b';
hold on,plot(pp,f(pp)./max(f(pp)).*max(h.Values),'r'),

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [Y,rej,c,average_number_of_variates]=myQ3(N)
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
countVariateV=[];
for i=1:N
    test = 0;
    if i>2
        countVariateV=[countVariateV,countVariate];
    end
    countVariate=0;
    while test == 0
        X=exprnd(1);%Generate X having pdf g 
        U=rand; %Generate U~U(0,1)
        countVariate=countVariate+1;
        if U < f(X)/(c*g(X)) %Check whether U <= f(X)/(c*g(X))
            test=1;
            Y=[Y;X];
        else
            rej=rej+1;
        end
    end
end
average_number_of_variates=mean(countVariateV);

