function [X0]=generating_data(para,data_length)
w=para(3:end);
% tspan=linspace(1,data_length,data_length);
% opts = odeset('RelTol',1e-12,'AbsTol',1e-14);
% [t,y]=ode45(@(t,y) w(1)*t^0*y+w(2)*t^1*y+w(3)*t^0.4+w(4)*t^1.4+w(5),tspan,1,opts);
% x=[y(1);y(2:end,1)-y(1:end-1,1)];
p=para(1);q=para(2);W=w(:);
Y(1)=1;   X0(1)=1;
for i=2:data_length
    m1=1-(i.^[p-floor(p):p]*W(1:numel([p-floor(p):p])));
    m2=i.^[p-floor(p):p]*W(1:numel([p-floor(p):p]));
    m3=i.^[q-floor(q):q]*W(numel([p-floor(p):p])+1:end-1);
    X0(i)=m2/m1*Y(i-1)+m3/m1+w(end)/m1;
    Y(i,1)=Y(i-1)+X0(i);
end
