%Q2sol

%%%%%%%%%
%A
t = 0: .01 : 6;
my_switch = (t > 2) & (t < 5); % to turn process on for 2 < t < 5, 0 else
x1 = normrnd( 0, 9, [1, length(t)] ) .* my_switch; % Gaussian noise, 1st samp. fnct
x2 = normrnd( 0, 9, [1, length(t)] ) .* my_switch; % Gaussian noise, 2nd samp. fnct
x3 = normrnd( 0, 9, [1, length(t)] ) .* my_switch; % Gaussian noise, 3rd samp. fnct
subplot(3, 1, 1), plot(t, x1)
subplot(3, 1, 2), plot(t, x2)
subplot(3, 1, 3), plot(t, x3)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
my_switch = (t < 2) | (t > 5); % to turn process on for t<2 |  t > 5, 0 else
x11 = normrnd( 0, 7, [1, length(t)] ) .* my_switch; % Gaussian noise, 1st samp. fnct
x22 = normrnd( 0, 7, [1, length(t)] ) .* my_switch; % Gaussian noise, 2nd samp. fnct
x33 = normrnd( 0, 7, [1, length(t)] ) .* my_switch; % Gaussian noise, 3rd samp. fnct
subplot(3, 1, 1), plot(t, x11)
subplot(3, 1, 2), plot(t, x22)
subplot(3, 1, 3), plot(t, x33)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
X1=x1+x11;
X2=x2+x22;
X3=x3+x33;
subplot(3, 1, 1), plot(t, X1)
subplot(3, 1, 2), plot(t, X2)
subplot(3, 1, 3), plot(t, X3)

%%%%%%%%%%
[bins1,p1]=acNhist2(X1)
[bins2,p2]=acNhist2(X2)
[bins3,p3]=acNhist2(X3)
%%%%%5555
pd1=fitdist(X1','normal'),
pd2=fitdist(X2','normal'),
pd3=fitdist(X3','normal'),
%we have non-sationary signal (not iid)






%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%