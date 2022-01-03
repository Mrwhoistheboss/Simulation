function Q5sol

tmax=1200;
lambda=0.95;

for N =[100 1000]
    ST=[];
    for i=1:N 
       [systtime,jumptimes, systsize] = Q5(tmax, lambda);
       ST=[ST,mean(systtime)];
    end
    
    %%%%%%%%%%%%%
    %a
    figure,plot(ST)
    
    hist(ST,30)
    h.FaceColor = [1 1 1];
    h.EdgeColor = 'b';
    
    pd = fitdist(ST','Normal'),
    
    %%%%%%%%%%%%%%%
    M=mean(ST),
    V=var(ST),
    S=std(ST),
    
    pd = makedist('Normal');
    X= icdf(pd,[.025,.975])
    ciHalfSize_95=X(2)*S/sqrt(N)
    
    Mp=M+ciHalfSize_95;
    Mn=M-ciHalfSize_95;
    disp(['The mean of ST for',num2str(N),' bactches is ', num2str(Mn),' to ', num2str(Mp)])
    
    [xc,lags] = xcorr(ST-mean(ST),1,'coeff');
    disp(['autocorrelation is ',num2str(xc(1))]),
end
