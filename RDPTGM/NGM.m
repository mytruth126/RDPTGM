function [ X0F] = NGM(  )
global X0 n nf time_interval time_data
X0=X0(:);
time_interval=time_interval(:);
%�����ۼ�����
X1=cumsum(X0.*[1;time_interval(1:n-1,1)]);
%��ϼ���
Zr=(X1(1:n-1,:)+X1(2:n,:))/2;
B=ones(n-1,2);
Y=ones(n-1,1);
B(:,1)=-Zr(:,1);
Y(:,1)=X0(2:n,:);
P=inv(B'*B)*B'*Y;
%����ϵ��
a=P(1);b=P(2);
%% ���
XRF(1,1)=X1(1);
for k=2:n+nf
    XRF(k,1)=(XRF(1)-b/a)*exp(-a*(time_data(k)-time_data(1)))+b/a; %�˴��趨��t1=1,�������hat_x(1)=x(1)ʱ�ĳ���C.
end
X0F=[XRF(1,1);XRF(2:end,1)-XRF(1:end-1,1)]./[1;time_interval];
end

