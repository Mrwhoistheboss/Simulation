%Q2
clear
close all
clc
%%%%%%%%%%%
for K = [100 1000]
    for i=1:K 
        [A,D,OT(i)] = p3q2C(8,4); % Change lam
        ST(i) = mean(D-A); 
        L(i)=length(D);
    end
    figure,plot(ST)
    figure,hist(ST,30) 
    pd = fitdist(ST','Normal') %Compute the 95% confidence interval for the distribution parameters. 
    
    ci = paramci(pd,'Alpha',.01)%Compute the 99% confidence interval for the distribution parameters. 
    
    [xc,lags] = xcorr(ST'-mean(ST),10,'coeff'); % limitation of lag computation is 1 here; you can change to any number
    disp(xc(1)),
end

figure,plot(lags,xc)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Q2 (another solution) 
clc,clear all,close all

lambda = 4;
T = 8;
batch = 1000;
ST = [];
meanST=[];
for i = 1:batch
    [A,D,Tp] = p3q2C( T, lambda );
    st = D - A;
    meanST = [meanST; mean(st)];
end
% hist(meanST)
acNhist2(meanST,1);

N = size(meanST,1);     % Number of ‘Experiments’ In Data Set
STMean = mean(meanST)	 % Mean Of All Experiments At Each Value Of ‘x’
s = sqrt( (1/(N-1)) * (sum((meanST-STMean).^2)) )
STSEM = s/sqrt(N);	% Compute ‘Standard Error Of The Mean’ Of All Experiments At Each Value Of ‘x’
CI95 = tinv(0.975, N-1)	% Calculate 95% Probability Intervals Of t-Distribution
STCI95U = STMean + CI95*STSEM
STCI95L = STMean - CI95*STSEM
(CI95*STSEM/STMean)*100
figure
plot(meanST,'o')	% Plot Mean Of All Experiments
hold on
yline(STMean,'r','linewidth',2),grid minor
yline(STCI95U,'g','linewidth',2)
yline(STCI95L,'g','linewidth',2)