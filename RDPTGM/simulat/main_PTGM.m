function [mape,par,X0F] = main_PTGM(param,X0,nf,time_data)
% ΢�ַ���ת��Ϊ��ɢ����
%   ������õ��ƹ�ʽ
X0=X0(:);
n=numel(X0);
time_interval=time_data(2:end,1)-time_data(1:end-1,1);
time_interval=time_interval(:);
%�����ۼ�����
X1=cumsum(X0.*[1;time_interval(1:n-1,1)]);
lambda=param(1);
p=param(2);
q=param(3);
%% ��ϼ���
for i=1:n-1
    B(i,:)=[-0.5*(X1(i,1)+X1(i+1,1)),1,time_data(i+1).^[q-floor(q):q]];
end
Y=X0(2:end,1);
W=regress(Y,B);
%% ����Ԥ����
X1F(1)=X0(1);
X1F(1)=X1(1);
for i=2:n+nf
    X1F(i,1)=(1/time_interval(i-1)-0.5*W(1))/(1/time_interval(i-1)+0.5*W(1))*X1F(i-1,1)+1/(1/time_interval(i-1)+0.5*W(1))*(W(2)+time_data(i).^[q-floor(q):q]*W(3:end));
end
X0F=[X1F(1,1);X1F(2:end,1)-X1F(1:end-1,1)]./[1;time_interval];
mape = mean(abs(X0(1:n,:)-X0F(1:n,:))./X0(1:n,:));
par=[param(:);W];
end