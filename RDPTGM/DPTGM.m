function [ mape,X0F ] = DPTGM( param )
% 微分方程转化为离散方程
%   求解利用递推公式
global X0 n nf time_interval time_data
X0=X0(:);
time_interval=time_interval(:);
%计算累加序列
X1=cumsum(X0.*[1;time_interval(1:n-1,1)]);
q=param(1);
%% 拟合计算
for i=1:n
    B(i,:)=[X1(i,1),time_data(i).^[q-floor(q):q],1];
end
Y=X0(1:end,1);
W=regress(Y,B);
%% 计算预测结果
X0F=B*W;
tmp=X1(end);
for i=1:nf
    X0F(end+1,1)=tmp*W(1)/(1-W(1)*time_interval(n+i-1))+...
        (time_data(n+i).^[q-floor(q):q]*W(2:end-1))/(1-W(1)*time_interval(n+i-1))+...
        W(end)/(1-W(1)*time_interval(n+i-1));
    tmp=tmp+X0F(end)*time_interval(n+i-1);
end
%plot(X0);hold on;plot(X0F)
global error_style
error_style='MAPE';
mape = calculate_error(X0,X0F);
end

