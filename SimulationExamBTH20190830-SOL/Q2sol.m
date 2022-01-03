%Q2sol
a=1,b=10,c=2
% function y=trirnd(a,b,c)
%Generates a triangularly distributed random number 
%a  minimum
%b  maximum
%c  mode
NN=10000;
Y=[];
for kk=1:NN
    t = 2/(b-a);
    r = (2/(b-a))/2;
    accept = 0;
    while accept == 0
        y = unifrnd(a,b);
        U = rand;
        if y <= c
            f = 2*(y-a)/((b-a)*(c-a));
        else
            f = 2*(b-y)/((b-a)*(b-c));
        end
        if U < f/t
            accept=1;
        end
    end
    Y=[Y,y];
end
figure,plot(Y)
k1=acNhist(Y);
%%%%%%%%%%%%%%%%%%%%