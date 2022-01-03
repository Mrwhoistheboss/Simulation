%Lakshmikanth Akurathi--19991213-T217
clear all
close all
clc
%%%%%%%%%%%%%%%%%%%%%
%Q3a)
% Batch-Mean method
SizeofBatchesa=100;
NumberOfBatchesa=40; %one batch is not considred according to the warmup
lambda=7.5;mu=10;endtime=SizeofBatchesa*NumberOfBatchesa;
[numberOfCustomersInsystem,customersTimeInSystem]=Qx(lambda,mu,endtime);
figure,plot(numberOfCustomersInsystem)
figure,plot(customersTimeInSystem)

batchdataNa=zeros(NumberOfBatchesa,SizeofBatchesa);
batchdataTa=zeros(NumberOfBatchesa,SizeofBatchesa);
for kk=0:SizeofBatchesa:endtime-SizeofBatchesa
  batchdataNa(1+kk/SizeofBatchesa,:)=numberOfCustomersInsystem(kk+1:kk+SizeofBatchesa);
  batchdataTa(1+kk/SizeofBatchesa,:)=customersTimeInSystem(kk+1:kk+SizeofBatchesa); 
end

SojournTa=mean(batchdataTa');
SojournTmeana=mean(SojournTa); % Mean of sojourn time of customers.
Na=size(SojournTa,2); 
SampleStda=sqrt((1/(Na-1))*(sum((SojournTa-SojournTmeana).^2))); %this is the sample standard deviation of the aquired data.
StandardErrora = SampleStda/sqrt(Na); %this is Standard error which is standard deviation/root of N.
ConfidenceInterval95a = tinv(0.975, Na-1)
CI95_Uppera = SojournTmeana + ConfidenceInterval95a*StandardErrora;
CI95_Lowera = SojournTmeana - ConfidenceInterval95a*StandardErrora;
RelativeSizea=ConfidenceInterval95a*StandardErrora/SojournTmeana; %relative confidence level which is absolute size/mean.

figure
plot(SojournTmeana,'o')	% Plot Mean Of All Experiments
hold on
yline(SojournTmeana,'r','linewidth',2),grid minor
yline(CI95_Uppera,'g','linewidth',2)
yline(CI95_Lowera,'g','linewidth',2)

%--------------------------------------------------------------
%Q3b) change the size and number of batches to 500 and 40 respectively.

SizeofBatchesb=500;
NumberOfBatchesb=40; %one batch is not considred according to the warmup
lambda=7.5;mu=10;endtime=SizeofBatchesb*NumberOfBatchesb;
[numberOfCustomersInsystem,customersTimeInSystem]=Qx(lambda,mu,endtime);
figure,plot(numberOfCustomersInsystem)
figure,plot(customersTimeInSystem)

batchdataNb=zeros(NumberOfBatchesb,SizeofBatchesb);
batchdataTb=zeros(NumberOfBatchesb,SizeofBatchesb);
for kk=0:SizeofBatchesb:endtime-SizeofBatchesb
  batchdataNb(1+kk/SizeofBatchesb,:)=numberOfCustomersInsystem(kk+1:kk+SizeofBatchesb);
  batchdataTb(1+kk/SizeofBatchesb,:)=customersTimeInSystem(kk+1:kk+SizeofBatchesb); 
end

SojournTb=mean(batchdataTb');
SojournTmeanb=mean(SojournTb); % Mean of sojourn time of customers.
Nb=size(SojournTb,2); 
SampleStdb=sqrt((1/(Nb-1))*(sum((SojournTb-SojournTmeanb).^2))); %this is the sample standard deviation of the aquired data.
StandardErrorb = SampleStdb/sqrt(Nb); %this is Standard error which is standard deviation/root of N.
ConfidenceInterval95b = tinv(0.975, Nb-1)
CI95_Upperb = SojournTmeanb + ConfidenceInterval95b*StandardErrorb;
CI95_Lowerb = SojournTmeanb - ConfidenceInterval95b*StandardErrorb;
RelativeSizeb=ConfidenceInterval95b*StandardErrorb/SojournTmeanb; %relative confidence level which is absolute size/mean.
 
disp(RelativeSizea)
disp(RelativeSizeb)

%as we have done in the project i can say that there isnt much difference
%in the confidence levels we can see that relative size of a is 0.1315 and
%relativesize of b is 0.1093.

%Q3d)
tpa=find(SojournTa(1,:)<=4000)
tpb=find(SojournTb(1,:)<=4000)
