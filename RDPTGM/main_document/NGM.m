function [ X0F] = NGM(  )
global X0 n nf time_interval time_data
X0=X0(:);
time_interval=time_interval(:);
%计算累加序列
X1=cumsum(X0.*[1;time_interval(1:n-1,1)]);
%拟合计算
Zr=(X1(1:n-1,:)+X1(2:n,:))/2;
B=ones(n-1,2);
Y=ones(n-1,1);
B(:,1)=-Zr(:,1);
Y(:,1)=X0(2:n,:);
P=inv(B'*B)*B'*Y;
%计算系数
a=P(1);b=P(2);
%% 拟合
XRF(1,1)=X1(1);
for k=2:n+nf
    XRF(k,1)=(XRF(1)-b/a)*exp(-a*(time_data(k)-time_data(1)))+b/a; %此处设定了t1=1,算出来的hat_x(1)=x(1)时的常数C.
end
X0F=[XRF(1,1);XRF(2:end,1)-XRF(1:end-1,1)]./[1;time_interval];
end

