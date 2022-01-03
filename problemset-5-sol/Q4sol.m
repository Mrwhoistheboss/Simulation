%Q4sol

clear all
close all
clc
%%%%%%%%%%%%%
N=1000000;
norm_mean=0;
norm_var=0.025;
x1=norm_mean+sqrt(norm_var)*randn(1,N);
x2=norm_mean+sqrt(norm_var)*randn(1,N);
h=x1+1i*x2;%complex gaussian
z=abs(h);
[bins,p]=acNhist2(z,0);  
figure,plot(bins,p,'k','LineWidth',2); 
grid minor; 
title('Pdf of  arrrival') 

figure,plot(bins,cumsum(p),'k','LineWidth',2); 
grid minor; 
title('CDF of arrrival') 

%%%%%%%%%%%%%%%%%%%
[N1,T1]=Q4sim(7,10,10000);
figure,plot(N1,'k','LineWidth',2),title('N1 ') 
figure,plot(T1,'b','LineWidth',2),title('T1 ')

[N2,T2]=Q4sim(z,10,10000);
figure,plot(N2,'k','LineWidth',2),title('N2')
figure,plot(T2,'b','LineWidth',2),title('T2')

%%%%%%%%%%%%%%%
[bins1,p1]=acNhist2(N1,0);  
figure,plot(bins1,p1,'k','LineWidth',2); 
grid minor; 
title('N1') 
%%%%%%%
[bins2,p2]=acNhist2(N2,0); 
figure,plot(bins2,p2,'k','LineWidth',2); 
grid minor; 
title('N2') 
%%%%%%%%%%%%
[bins3,p3]=acNhist2(T1,0); 
figure,plot(bins3,p3,'k','LineWidth',2); 
grid minor; 
title('T1') 
%%%%%%%
[bins4,p4]=acNhist2(T2,0);  
figure,plot(bins4,p4,'k','LineWidth',2); 
grid minor; 
title('T2') 
%%%%%%%%%%%
figure,plot(bins1,cumsum(p1),'k','LineWidth',2); 
grid minor; 
title('N1') 
%%%%%%
figure,plot(bins2,cumsum(p2),'k','LineWidth',2); 
grid minor; 
title('N2') 
%%%%%%%%%%%
figure,plot(bins3,cumsum(p3),'k','LineWidth',2); 
grid minor; 
title('T1') 
%%%%%%
figure,plot(bins4,cumsum(p4),'k','LineWidth',2); 
grid minor; 
title('T2') 
%%%%%%%%%%%%



% hold on
% figure,plot(bins2,cumsum(p2),'r','LineWidth',2);
% 
% figure,plot(abs(cumsum(p1)-cumsum(p2)),'b','LineWidth',2);


%%%%%
% LT=min(length(T1),length(T2));
% T1=T1(1:LT);T2=T2(1:LT);
% LN=min(length(N1),length(N2));
% N1=N1(1:LN);N2=N2(1:LN);




