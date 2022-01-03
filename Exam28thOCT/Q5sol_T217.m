%Lakshmikanth Akurathi ---19991213-T217
clear all
clc
close all
%Q5a)
[X,y,b,bint,r,rint]=q5sim(0.95,1); %this gives us the values of 95%CI.

%Q5b)
%as you explained i understood ,the red lines in the residual case
%order plot represents the outliers. Which are the values in the rint where
%the values are greater than 0. that is they does not go through 0. so we
%can say that the interval of thar residue is not in the confidence
%interval range.i'll try using if loop by telling that, if the values in rint
%are >0 then freq+1.

% iam not that sure on how to find and get the values of the outliers, ill try using an find function. 
%b)
freq=[];tpb=[];
for k=1:500
    [X,y,b,bint,r,rint]=q5sim(0.95,0);
    tpb=[tpb;find(rint(:,1)>0)];% finds the values where the lower limit is greater than 0 which gives the outliers.
end
freqa=length((tpb))/mean(rint(tpb));% i am trying to findout number of occurances of outliers 
% for whole 500 iterations.
proba=mean(rint(tpb))/500; % i think this gives us the occurance frequency of outliers for all 500 iterations.

%c)
freq=[];tpc=[];
for k=1:500
    [X,y,b,bint,r,rint]=q5sim(0.90,0);
    tpc=[tpb;find(rint(:,1)>0)];
end
freqb=length(rint(tpc))/mean(rint(tpc));
probb=mean(rint(tpc))/500;

% i maybe wrong but i thought that tpa or tpb gives the indexes of the
% outliers in rint for each iteration and puts it in a matrix. so i thought
% that i can find the length of matrix and find the frequency of occurence
% of outliers for the whole 500 iterations.












