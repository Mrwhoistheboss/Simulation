%Q4
x=0:(pi/100):pi/2;
F=cos(x); % an always growing curve
pdf=-sin(x); % the derivative of F

%generation of random varite data

N=2000; % number of data
y=rand(1,N); %uniform distribution

%random data generation (ITM)

z=acos(y); %the inverse of F

figure,
subplot(1,2,1),plot (x,F,'k')
xlabel('x'),title('desired distribution function')
subplot(1,2,2),plot(x,pdf,'k')
xlabel('x'),title('desired PDF')

figure,
hist(z,30);colormap('cool')
xlabel('x'),title('histogram of the generated data')






