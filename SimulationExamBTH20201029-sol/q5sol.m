%q5sol
close all
clear all
clc
%%%%%%%%%%%%%%%%%

lambdaX=7;
lambdaY=10;
%%%%%%%%%%%%
% xxS=exprnd(lambdaX, 5000,1);
% yyS=exprnd(lambdaY, 5000,1);
% A=[xxS,yyS];
% save q5.mat A
load q5.mat
xxS=A(:,1);
yyS=A(:,2);
%%%%%%%%%%%%%%%%
xx=xxS(xxS<=7);
yy=yyS(yyS<=10);


%%%%%%%%%%%
TH=min(length(xx),length(yy));
xx=xx(1:TH); yy=yy(1:TH);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

z=sqrt(xx.^2+yy.^2);
% maxDist=sqrt(7^2+20^2);

[bins,p]=acNhist2(z,0);
figure,plot(bins,p,'k','LineWidth',2); 
grid minor; 
title('Distrubution of serivice time') 
%%%%%%%%%%%%%%%
zAcum=cumsum(p);
figure,plot(bins,zAcum,'k','LineWidth',2); 
grid minor; 
title('Distrubution of serivice time') 
%%%%%%%%
pp = interp(zAcum,10);
upLevel=max(z);
lowLevel=min(z);
bb=lowLevel:(upLevel-lowLevel)/length(pp):upLevel;
figure,plot(bb(1:end-1),pp,'k','LineWidth',2); 
grid minor; 
title('Distrubution of serivice time') 
%%%%%%%%%%%%%%%%%
upLevel=max(pp);
lowLevel=min(pp);
rgN=lowLevel+rand(5000,1)*(upLevel-lowLevel);

rvtG=[];
for kk=1:5000,
    tt=abs((pp-rgN(kk)));
    kd=min(tt);
    tp=find(tt==kd);
    %pp(tp),
    rvtG=[rvtG,bb(tp(1))];
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
seeds=[1234,2345,3456,4567,5678];
rvtGSeeds=[];
rvtGSeedsAutocorr=[];
for kk=1:length(seeds)
    rng(seeds(kk));       
       
    rgN=lowLevel+rand(5000,1)*(upLevel-lowLevel);

    rvtG=[];
    for kk=1:5000,
        tt=abs((pp-rgN(kk)));
        kd=min(tt);
        tp=find(tt==kd);
        %pp(tp),
        rvtG=[rvtG,bb(tp(1))];
    end
    rvtGSeeds=[rvtGSeeds,rvtG'];
    %%%%
    [acf,lags,bounds] = autocorr(rvtG,'NumLags',20);

     acf(2) %lag1
    figure,autocorr(rvtG,'NumMA',2) 
    rvtGSeedsAutocorr=[rvtGSeedsAutocorr,acf(2)];
    %%%%%
    [bins,p]=acNhist2(rvtG,0);
    figure,plot(bins,p,'k','LineWidth',2); 
    grid minor; 
    title('Distrubution of serivice time') 

end

%%%%%%%%%%%
cc=nchoosek(1:6,2);
for kk=1:size(cc,1)
    [c,lags]=xcorr(rvtGSeeds(:,cc(kk,1))-mean(rvtGSeeds(:,cc(kk,1))),...
        rvtGSeeds(:,cc(kk,2))-mean(rvtGSeeds(:,cc(kk,2))),'coeff');
    figure,stem(lags,c)
    tp=find(lags==0);
    c(tp)
end


