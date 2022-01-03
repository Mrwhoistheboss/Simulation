%q4sol
close all
clear all
clc
%%%%%%%%%%%%%%%%%
endtime=1500;
sysType=1;
[N,T, arrivals, services]=Q4sim(sysType,endtime);
%%%%%
c=arrivals(500:end);
figure,plot(c)
[bins,p]=acNhist2(c,0);
figure,plot(bins,p,'k','LineWidth',2); 
grid minor; 
title('Distrubution of disturbed arrrival') 
%%%%%%
c=services(500:end);
figure,plot(c)
[bins,p]=acNhist2(c,0);
figure,plot(bins,p,'k','LineWidth',2); 
grid minor; 
title('Distrubution of serivice time') 
%%%%%%
c=N(500:end);
figure,plot(c)
[bins,p]=acNhist2(c,0);
figure,plot(bins,p,'k','LineWidth',2); 
grid minor; 
title('Distrubution of Number of customers') 
%%%%%%
c=T(500:end);
figure,plot(c)
[bins,p]=acNhist2(c,0);
figure,plot(bins,p,'k','LineWidth',2); 
grid minor; 
title('Distrubution of customers time in system') 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
endtime=1500;
sysType=2;
[N,T, arrivals, services]=Q4sim(sysType,endtime);
%%%%%
c=arrivals(500:end);
figure,plot(c)
[bins,p]=acNhist2(c,0);
figure,plot(bins,p,'k','LineWidth',2); 
grid minor; 
title('Distrubution of disturbed arrrival') 
%%%%%%
c=services(500:end);
figure,plot(c)
[bins,p]=acNhist2(c,0);
figure,plot(bins,p,'k','LineWidth',2); 
grid minor; 
title('Distrubution of serivice time') 
%%%%%%
c=N(500:end);
figure,plot(c)
[bins,p]=acNhist2(c,0);
figure,plot(bins,p,'k','LineWidth',2); 
grid minor; 
title('Distrubution of Number of customers') 
%%%%%%
c=T(500:end);
figure,plot(c)
[bins,p]=acNhist2(c,0);
figure,plot(bins,p,'k','LineWidth',2); 
grid minor; 
title('Distrubution of customers time in system') 

