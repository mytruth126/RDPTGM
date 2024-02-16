function [ mape,X0F ] = RNDGM( param )
% ΢�ַ���ת��Ϊ��ɢ����
%   ������õ��ƹ�ʽ
% x(t)=a*y(t)+b*t+c
global X0 n nf time_interval time_data
X0=X0(:);
time_interval=time_interval(:);
%�����ۼ�����
X1=cumsum(X0.*[1;time_interval(1:n-1,1)]);
lambda=param(1);
%% ��ϼ���
for i=1:n
    B(i,:)=[X1(i,1),time_data(i),1];
end
Y=X0(1:end,1);
[lam_er,e,wt,Xfit,X0F]=RLS_filter(lambda,B,Y,time_interval);
%% ����Ԥ����
W=wt(end,:)';
tmp=X1(end);
for i=1:nf
    X0F(end+1,1)=tmp*W(1)/(1-W(1)*time_interval(n+i-1))+...
        time_data(n+i)*W(2)/(1-W(1)*time_interval(n+i-1))+...
        W(end)/(1-W(1)*time_interval(n+i-1));
    tmp=tmp+X0F(end)*time_interval(n+i-1);
end
global error_style
error_style='MAPE';
mape = calculate_error(X0,X0F);
end

