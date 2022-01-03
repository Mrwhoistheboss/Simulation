%Lakshmikanth Akurathi--19991213-T217
clear all
clc

%Q2a)
syms x
b=@(x) (1.5/2*(x.^0.5).*exp(-0.5*(x.^1.5)));
a=integral(b,0,inf);

%Qb)
%if it is a pdf then i'm thinking, by just changing the limits i can get it.
Qb=integral(b,0.45,2.25);
%This is the value for P(0.45<X<=2.25)

%Qc)
% i dont think there will be any change in mean or variance. 
run=[];qc=[];
for r=1:100
    Qc=integral(b,0.45,2.25);
    qc=[qc;Qc];
end
mea=mean(qc);va=var(qc);
%Mean will be the same and so is the variance in this case.
