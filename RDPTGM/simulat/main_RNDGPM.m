function [mape,par,X0F]=main_RNDGPM(param,X0,nf,time_data)
X0=X0(:);
n=numel(X0);
time_interval=time_data(2:end,1)-time_data(1:end-1,1);
time_interval=time_interval(:);
%计算累加序列
X1=cumsum(X0.*[1;time_interval(1:n-1,1)]);
lambda=param(1);
p=param(2);
q=param(3);
%% 拟合计算
for i=1:n
    B(i,:)=[X1(i,1)*time_data(i).^[p-floor(p):p],time_data(i).^[q-floor(q):q],1];
end
Y=X0(1:end,1);
[e,wt,Xfit,X0F]=RLS_filter(lambda,B,Y,X0,time_interval);
%% 计算预测结果
W=wt(end,:)';
tmp=X1(end);
for i=1:nf
    X0F(end+1,1)=tmp*(time_data(n+i).^[p-floor(p):p]*W(1:numel([p-floor(p):p])))/(1-(time_data(n+i).^[p-floor(p):p]*W(1:numel([p-floor(p):p])))*time_interval(n+i-1))+...
        (time_data(n+i).^[q-floor(q):q]*W(numel([p-floor(p):p])+1:end-1))/(1-(time_data(n+i).^[p-floor(p):p]*W(1:numel([p-floor(p):p])))*time_interval(n+i-1))+...
        W(end)/(1-(time_data(n+i).^[p-floor(p):p]*W(1:numel([p-floor(p):p])))*time_interval(n+i-1));
    tmp=tmp+X0F(end);
end
mape = mean(abs(X0(1:n,:)-X0F(1:n,:))./X0(1:n,:));
par=[param(:);W];
end