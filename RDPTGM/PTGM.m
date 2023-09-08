function [ mape,X0F ] = PTGM( param )
% ΢�ַ���ת��Ϊ��ɢ����
%   ������õ��ƹ�ʽ
global X0 n nf time_interval time_data
X0=X0(:);
time_interval=time_interval(:);
%�����ۼ�����
X1=cumsum(X0.*[1;time_interval(1:n-1,1)]);
q=param(1);
%% ��ϼ���
for i=1:n-1
    B(i,:)=[-0.5*(X1(i,1)+X1(i+1,1)),1,time_data(i+1).^[q-floor(q):q]];
end
Y=X0(2:end,1);
W=regress(Y,B);
%% ����Ԥ����
X1F(1)=X1(1);
for i=2:n+nf
    X1F(i,1)=(1/time_interval(i-1)-0.5*W(1))/(1/time_interval(i-1)+0.5*W(1))*X1F(i-1,1)+1/(1/time_interval(i-1)+0.5*W(1))*(W(2)+time_data(i).^[q-floor(q):q]*W(3:end));
end
X0F=[X1F(1,1);X1F(2:end,1)-X1F(1:end-1,1)]./[1;time_interval];

% plot(X0);hold on;plot(X0F)
global error_style
error_style='MAPE';
mape = calculate_error(X0,X0F);
end

