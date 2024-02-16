function [e,wt,Yfit,Ypred]=RLS_filter(lambda,B,Y,X0,time_interval)
    M=size(B,2); %�˲�������
    w=zeros(M,1);
    %w=inv(B(1:4,:)'*B(1:4,:))*B(1:4,:)'*Y(1:4,:);
    delta = 1e-7;
    % lambda = 0.9; %��������
    Pk=eye(M)/delta; % eye(M)����M*M��λ����
    Y=Y(:); % �ź�
    % input signal length
    N=length(Y);
    hk=[1;time_interval];
    % error vector
    % e=d.';
    % Step2: Loop, RLS
    for i=1:N
        uk=B(i,:)';
        e(i)=Y(i)-w'*uk;  % ����źţ���һ�μ���ȡֵ w=[0;0]
        Kk=lambda^(-hk(i))*Pk*uk/(1+lambda^(-hk(i))*uk'*Pk*uk);
        Pk=lambda^(-hk(i))*Pk-lambda^(-hk(i))*Kk*uk'*Pk;
        w=w+Kk*conj(e(i)); % conj(e(n))���� e ��ÿ��Ԫ�صĸ����� 
        wt(i,:)=w';
    end
    e=e(:);
    % ������ѡ����õ�lambda
    Yfit=sum(wt.*B,2);
    Ypred=sum(wt(1:end-1,:).*B(2:end,:),2);
    Ypred=[X0(1:2,1);Ypred(2:end,:)];
end
