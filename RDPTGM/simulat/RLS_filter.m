function [e,wt,Yfit,Ypred]=RLS_filter(lambda,B,Y,X0,time_interval)
    M=size(B,2); %滤波器长度
    w=zeros(M,1);
    %w=inv(B(1:4,:)'*B(1:4,:))*B(1:4,:)'*Y(1:4,:);
    delta = 1e-7;
    % lambda = 0.9; %遗忘因子
    Pk=eye(M)/delta; % eye(M)返回M*M单位矩阵
    Y=Y(:); % 信号
    % input signal length
    N=length(Y);
    hk=[1;time_interval];
    % error vector
    % e=d.';
    % Step2: Loop, RLS
    for i=1:N
        uk=B(i,:)';
        e(i)=Y(i)-w'*uk;  % 输出信号，第一次计算取值 w=[0;0]
        Kk=lambda^(-hk(i))*Pk*uk/(1+lambda^(-hk(i))*uk'*Pk*uk);
        Pk=lambda^(-hk(i))*Pk-lambda^(-hk(i))*Kk*uk'*Pk;
        w=w+Kk*conj(e(i)); % conj(e(n))返回 e 中每个元素的复共轭 
        wt(i,:)=w';
    end
    e=e(:);
    % 检验以选择最好的lambda
    Yfit=sum(wt.*B,2);
    Ypred=sum(wt(1:end-1,:).*B(2:end,:),2);
    Ypred=[X0(1:2,1);Ypred(2:end,:)];
end
