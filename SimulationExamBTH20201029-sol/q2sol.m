%Q1sol
clear all
close all
clc
%%%%%%%%%%%%%%%%%%%%%
lambda=8;mu=10;endtime=1500;quezise=10;
[numberOfCustomersInsystem,customersTimeInSystem,LossRatio]=Q2sim(lambda,mu,endtime,quezise);
figure,plot(LossRatio)
figure,plot(numberOfCustomersInsystem)
figure,plot(customersTimeInSystem)
%%%%%%%%%%%%%%%%%%%%%
%considering the warming upp (with app. 500 sec duration)
Nx=numberOfCustomersInsystem(501:end);
figure,plot(Nx)
Tx=customersTimeInSystem(501:end);
figure,plot(Tx)
Lx=LossRatio(501:end);
figure,plot(Lx)
%%%%%%%%%%%%%%%%%%%%%
N = size(Tx,2);     % Number of ‘Experiments’ In Data Set
TxMu = mean(Tx)	 % Mean Of All Experiments At Each Value Of ‘x’
s = sqrt( (1/(N-1)) * (sum((Tx-TxMu).^2)) )
TxStd = s/sqrt(N);	% Compute ‘Standard Error Of The Mean’ Of All Experiments At Each Value Of ‘x’
CI95 = tinv(0.975, N-1)	% Calculate 95% Probability Intervals Of t-Distribution
Tx_CI95U = TxMu + CI95*TxStd
Tx_CI95L = TxMu - CI95*TxStd
Tx_relativHalfSize=(CI95*TxStd/TxMu)*100,
figure
plot(TxMu,'o')	% Plot Mean Of All Experiments
hold on
yline(TxMu,'r','linewidth',2),grid minor
yline(Tx_CI95U,'g','linewidth',2)
yline(Tx_CI95L,'g','linewidth',2)
%%%%%%%%%%%%%%%%%%%%%%
Tx=customersTimeInSystem; %without considering the warmup
N = size(Tx,2);     % Number of ‘Experiments’ In Data Set
TxMu = mean(Tx)	 % Mean Of All Experiments At Each Value Of ‘x’
s = sqrt( (1/(N-1)) * (sum((Tx-TxMu).^2)) )
TxStd = s/sqrt(N);	% Compute ‘Standard Error Of The Mean’ Of All Experiments At Each Value Of ‘x’
CI95 = tinv(0.975, N-1)	% Calculate 95% Probability Intervals Of t-Distribution
Tx_CI95U = TxMu + CI95*TxStd
Tx_CI95L = TxMu - CI95*TxStd
Tx_relativHalfSize=(CI95*TxStd/TxMu)*100,
figure
plot(TxMu,'o')	% Plot Mean Of All Experiments
hold on
yline(TxMu,'r','linewidth',2),grid minor
yline(Tx_CI95U,'g','linewidth',2)
yline(Tx_CI95L,'g','linewidth',2)



