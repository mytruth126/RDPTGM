function [D]=accumulation(n,r)
global accumulation_method chuchu1;
switch accumulation_method
    case '选择累加算子'
        errordlg('请选择累加算子','Setting Error');%建立一个默认参数的错误对话框
        return
    case '一阶累加'
        D=One_AG0(n);
        chuchu1='刘思峰, 党耀国, 方志耕, 等. 灰色系统理论及其应用[M]. 北京：科学出版社.';
    case 'CF累加' % Conformable fractional accumualtion
        D=CF(n,r);
        chuchu1='Ma X, Wu W Q, Zeng B, et al. The conformable fractional grey system model[J]. ISA Transactions, 2020, 96: 255-271.';
    case '分数阶累加' % Fractional accumualtion
        D=F(n,r);
        chuchu1='Wu L F, Liu S F, Yao L G, et al. Grey system model with the fractional order accumulation[J]. Communications in Nonlinear Science and Numerical Simulation, 2013, 18(7): 1775-1785.';
    case '邻近累加' % 师姐的那篇
        D=A(n,r);
        chuchu1='Zhao H, Wu L,Forecasting the non-renewable energy consumption by an adjacent accumulation grey model[J]. Journal of Cleaner Production, 2020, 275, 124113.';
    case 'HF累加' % Hausdorf fractional accumualtion
        D=HF(n,r);
        chuchu1='Chen Y, Wu L, Liu L, et al. Fractional Hausdorff grey model and its properties[J]. Chaos, Solitons & Fractals, 2020, 138: 109915.';
    case 'NIP累加' % 新息优先累加
        D=NIP(n,r);
        chuchu1='周伟杰, 张宏如, 党耀国, 等. 新息优先累加灰色离散模型的构建及应用[J]. 中国管理科学, 2017, 25(08): 140-148.';
    case '阻尼累加' % 阻尼累加
        D=DA(n,r);
        chuchu1='Liu L, Chen Y, Wu L, The damping accumulated grey model and its application[J]. Communications in Nonlinear Science and Numerical Simulation, 2020, 95: 105665.';
end
end

function D=One_AG0(n)
D=zeros(n,n);
for i=1:n
    for j=1:i
        D(i,j)=1;
    end
end
end

function D=CF(n,r)
D=zeros(n,n);
for i=1:n
    for j=1:i
        D(i,j)=1./(j^(ceil(r)-r)).*gamma(i-j+ceil(r)-1+1)/(gamma(i-j+1)*gamma(ceil(r)-1+1));
    end
end
end

function D=F(n,r)
D=zeros(n,n);
for i=1:n
    for j=1:i
        D(i,j)=gamma(i-j+r-1+1)/(gamma(i-j+1)*gamma(r-1+1));
    end
end
end

function D=A(n,r)
D=zeros(n,n);
for i=1:n
    D(i,i)=1;
end
for i=2:n
    D(i,i-1)=r;
end
end

function D=HF(n,r)
D=zeros(n,n);
for i=1:n
    D(i,i)=1;
end
for i=2:n
    for j=1:i
        D(i,j)=j^r-(j-1)^r;
    end
end
end

function D=NIP(n,r)
D=zeros(n,n);
for i=1:n
    D(i,i)=1;
end
for i=2:n
    for j=1:i
        D(i,j)=r^(i-j);
    end
end
end

function D=DA(n,r)
D=zeros(n,n);
for i=1:n
    for j=1:i
        D(i,j)=1/(r^(j-1));
    end
end
end