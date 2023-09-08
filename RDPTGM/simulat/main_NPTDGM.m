function [mape,par,X0F] = main_NPTDGM(param,X0,nf,time_data)
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
for i=1:n
    B(i,:)=[X1(i,1),time_data(i).^[q-floor(q):q],1];
end
Y=X0(1:end,1);
W=regress(Y,B);
%% ����Ԥ����
X0F=B*W;
tmp=X1(end);
for i=1:nf
    X0F(end+1,1)=tmp*W(1)/(1-W(1)*time_interval(n+i-1))+...
        (time_data(n+i).^[q-floor(q):q]*W(2:end-1))/(1-W(1)*time_interval(n+i-1))+...
        W(end)/(1-W(1)*time_interval(n+i-1));
    tmp=tmp+X0F(end)*time_interval(n+i-1);
end
mape = mean(abs(X0(1:n,:)-X0F(1:n,:))./X0(1:n,:));
par=[param(:);W];
end

