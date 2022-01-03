%Q3sol
clear all
close all
clc
%%%%%%%%%%%%%%%%%%%%%
% Bact-Mean method
batchSize=500;
numOfBatches=41; %one batch is not considred according to the warmup
lambda=8;mu=10;endtime=batchSize*numOfBatches;
[numberOfCustomersInsystem,customersTimeInSystem]=Qx(lambda,mu,endtime);
figure,plot(numberOfCustomersInsystem)
figure,plot(customersTimeInSystem)
%%%%%%%%%%%%
bacthdataN=zeros(numOfBatches,batchSize);
bacthdataT=zeros(numOfBatches,batchSize);

for kk=0:batchSize:endtime-batchSize
  bacthdataN(1+kk/batchSize,:)=numberOfCustomersInsystem(kk+1:kk+batchSize);
  bacthdataT(1+kk/batchSize,:)=customersTimeInSystem(kk+1:kk+batchSize); 
end
%%%%%%%%%%%%
% b)
[TxMu,s,halfSize]=calculateCI(bacthdataT)



Tx=mean(bacthdataT'); %customersTimeInSystem
Tx=Tx(2:end);
N = size(Tx,2);     % Number of ‘Experiments’ In Data Set
TxMu = mean(Tx)	 % Mean Of All Experiments At Each Value Of ‘x’
s = sqrt( (1/(N-1)) * (sum((Tx-TxMu).^2)) )
TxStd = s/sqrt(N);	% Compute ‘Standard Error Of The Mean’ Of All Experiments At Each Value Of ‘x’
CI95 = tinv(0.975, N-1)	% Calculate 95% Probability Intervals Of t-Distribution
CI99 = tinv(0.995, N-1)	% Calculate 99% Probability Intervals Of t-Distribution
CI90 = tinv(0.950, N-1)	% Calculate 90% Probability Intervals Of t-Distribution
Tx_CI95U = TxMu + CI95*TxStd,Tx_CI99U = TxMu + CI99*TxStd,Tx_CI90U = TxMu + CI90*TxStd,
Tx_CI95L = TxMu - CI95*TxStd,Tx_CI99L = TxMu - CI99*TxStd,Tx_CI90L = TxMu - CI90*TxStd
figure
plot(TxMu,'o')	% Plot Mean Of All Experiments
hold on
yline(TxMu,'r','linewidth',2),grid minor
yline(Tx_CI95U,'g','linewidth',2)
yline(Tx_CI95L,'g','linewidth',2)

yline(Tx_CI99U,'b','linewidth',2)
yline(Tx_CI99L,'b','linewidth',2)

yline(Tx_CI90U,'k','linewidth',2)
yline(Tx_CI90L,'k','linewidth',2)
%%%%%%%%%%%
Tx=mean(bacthdataN'); %numberOfCustomersInsystem
Tx=Tx(2:end);
N = size(Tx,2);     % Number of ‘Experiments’ In Data Set
TxMu = mean(Tx)	 % Mean Of All Experiments At Each Value Of ‘x’
s = sqrt( (1/(N-1)) * (sum((Tx-TxMu).^2)) )
TxStd = s/sqrt(N);	% Compute ‘Standard Error Of The Mean’ Of All Experiments At Each Value Of ‘x’
CI95 = tinv(0.975, N-1)	% Calculate 95% Probability Intervals Of t-Distribution
CI99 = tinv(0.995, N-1)	% Calculate 99% Probability Intervals Of t-Distribution
CI90 = tinv(0.950, N-1)	% Calculate 90% Probability Intervals Of t-Distribution
Tx_CI95U = TxMu + CI95*TxStd,Tx_CI99U = TxMu + CI99*TxStd,Tx_CI90U = TxMu + CI90*TxStd,
Tx_CI95L = TxMu - CI95*TxStd,Tx_CI99L = TxMu - CI99*TxStd,Tx_CI90L = TxMu - CI90*TxStd
figure
plot(TxMu,'o')	% Plot Mean Of All Experiments
hold on
yline(TxMu,'r','linewidth',2),grid minor
yline(Tx_CI95U,'g','linewidth',2)
yline(Tx_CI95L,'g','linewidth',2)

yline(Tx_CI99U,'b','linewidth',2)
yline(Tx_CI99L,'b','linewidth',2)

yline(Tx_CI90U,'k','linewidth',2)
yline(Tx_CI90L,'k','linewidth',2)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all
clc
%%%%%
% Replication-delition method
batchSize=500;
numOfBatches=40; 
lambda=8;mu=10;endtime=batchSize*2;
% bacthdataN=zeros(numOfBatches,batchSize);
% bacthdataT=zeros(numOfBatches,batchSize);
for kk=1:numOfBatches-1
  [numberOfCustomersInsystem,customersTimeInSystem]=Qx(lambda,mu,endtime);
  bacthdataN(kk)=mean(numberOfCustomersInsystem(batchSize+1:end));%one batch is not considred according to the warmup
  bacthdataT(kk)=mean(customersTimeInSystem(batchSize+1:end)); %one batch is not considred according to the warmup
end
%%%%%%%%%%%
Tx=bacthdataT; %customersTimeInSystem
Tx=Tx(2:end);
N = size(Tx,2);     % Number of ‘Experiments’ In Data Set
TxMu = mean(Tx)	 % Mean Of All Experiments At Each Value Of ‘x’
s = sqrt( (1/(N-1)) * (sum((Tx-TxMu).^2)) )
TxStd = s/sqrt(N);	% Compute ‘Standard Error Of The Mean’ Of All Experiments At Each Value Of ‘x’
CI95 = tinv(0.975, N-1)	% Calculate 95% Probability Intervals Of t-Distribution
CI99 = tinv(0.995, N-1)	% Calculate 99% Probability Intervals Of t-Distribution
CI90 = tinv(0.950, N-1)	% Calculate 90% Probability Intervals Of t-Distribution
Tx_CI95U = TxMu + CI95*TxStd,Tx_CI99U = TxMu + CI99*TxStd,Tx_CI90U = TxMu + CI90*TxStd,
Tx_CI95L = TxMu - CI95*TxStd,Tx_CI99L = TxMu - CI99*TxStd,Tx_CI90L = TxMu - CI90*TxStd
figure
plot(TxMu,'o')	% Plot Mean Of All Experiments
hold on
yline(TxMu,'r','linewidth',2),grid minor
yline(Tx_CI95U,'g','linewidth',2)
yline(Tx_CI95L,'g','linewidth',2)

yline(Tx_CI99U,'b','linewidth',2)
yline(Tx_CI99L,'b','linewidth',2)

yline(Tx_CI90U,'k','linewidth',2)
yline(Tx_CI90L,'k','linewidth',2)
%%%%%%%%%%%
Tx=bacthdataT; %numberOfCustomersInsystem
Tx=Tx(2:end);
N = size(Tx,2);     % Number of ‘Experiments’ In Data Set
TxMu = mean(Tx)	 % Mean Of All Experiments At Each Value Of ‘x’
s = sqrt( (1/(N-1)) * (sum((Tx-TxMu).^2)) )
TxStd = s/sqrt(N);	% Compute ‘Standard Error Of The Mean’ Of All Experiments At Each Value Of ‘x’
CI95 = tinv(0.975, N-1)	% Calculate 95% Probability Intervals Of t-Distribution
CI99 = tinv(0.995, N-1)	% Calculate 99% Probability Intervals Of t-Distribution
CI90 = tinv(0.950, N-1)	% Calculate 90% Probability Intervals Of t-Distribution
Tx_CI95U = TxMu + CI95*TxStd,Tx_CI99U = TxMu + CI99*TxStd,Tx_CI90U = TxMu + CI90*TxStd,
Tx_CI95L = TxMu - CI95*TxStd,Tx_CI99L = TxMu - CI99*TxStd,Tx_CI90L = TxMu - CI90*TxStd
figure
plot(TxMu,'o')	% Plot Mean Of All Experiments
hold on
yline(TxMu,'r','linewidth',2),grid minor
yline(Tx_CI95U,'g','linewidth',2)
yline(Tx_CI95L,'g','linewidth',2)

yline(Tx_CI99U,'b','linewidth',2)
yline(Tx_CI99L,'b','linewidth',2)

yline(Tx_CI90U,'k','linewidth',2)
yline(Tx_CI90L,'k','linewidth',2)








