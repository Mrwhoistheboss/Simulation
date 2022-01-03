%Q5A

N = 1000; 
U = rand(1,N)*0.5; X = exp(2*U);
disp([mean(X) std(X) 2*std(X)/sqrt(N)])

%CRN method
U = rand(1,N/2)*0.5; X = exp(2*U);
U = rand(1,N/2)*0.5; X = X-exp(2*U);
disp([mean(X) std(X) 2*std(X)/sqrt(N/2)])

%VAT method
U = rand(1,N/2)*0.5; X = (exp(2*U) + exp(1-2*U) )/2;
disp([mean(X) std(X) 2*std(X)/sqrt(N/2)])

%%%%%%%%%%%%%%%%%%%%%%%%%%'
mu1=[];
mu2=[];
mu3=[];
N = 1000; 
for K = 1:100
    U = rand(1,N)*0.5; X = exp(2*U);
    disp([mean(X) std(X) 2*std(X)/sqrt(N)])

    mu1=[mu1,mean(X)];
    %CRN method
    U = rand(1,N/2)*0.5; X = exp(2*U);
    U = rand(1,N/2)*0.5; X = X-exp(2*U);
    disp([mean(X) std(X) 2*std(X)/sqrt(N/2)])
    mu2=[mu2,mean(X)];
    %VAT method
    U = rand(1,N/2)*0.5; X = (exp(2*U) + exp(1-2*U) )/2;
    disp([mean(X) std(X) 2*std(X)/sqrt(N/2)])
    mu3=[mu3,mean(X)];
end  

pd1 = fitdist(mu1','Normal') %95%
ci1 = paramci(pd1,'Alpha',.01)%Compute the 99% confidence interval for the distribution parameters. 

pd2 = fitdist(mu2','Normal') %95%
ci2 = paramci(pd2,'Alpha',.01)

pd3 = fitdist(mu3','Normal') %95%
ci3 = paramci(pd3,'Alpha',.01)


