function [X,y,b,bint,r,rint]=q5sim(cIlevel,figFlag)

[X,y]=generateSim;

[b,bint,r,rint] = regress(y,X,1-cIlevel);

if figFlag==1
    rcoplot(r,rint);%Residual case order plot

    figure,plot(y,'o'),hold on,plot(1:100,b(2)*(1:100)+b(1))
end