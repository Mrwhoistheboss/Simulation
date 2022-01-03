%Q4
clear all
close all
clc
%%%%%%%%%%%%%%%%%%%%
x=0:(pi/100):pi/2;
F=sin(x); % an always growing curve
pdf=cos(x); % the derivative of F

%generation of random varite data

N=20000; % number of data
y=rand(1,N); %uniform distribution

%random data generation (ITM)

z=asin(y); %the inverse of F

figure,
subplot(1,2,1),plot (x,F,'k')
xlabel('x'),ylabel('F'),title('CDF function, F=sin(x)')
subplot(1,2,2),plot(x,pdf,'k')
xlabel('x'),ylabel('f'),title('pdf function, f=cos(x)')

figure,
hist(z,30);colormap('cool')
xlabel('z'),ylabel('pdf(z)'),title('histogram of the generated data, z=asin(y)')






