clear;clc;close all
warning off;
global X0 time_interval time_data error_style n nf;
nf=1; %预测外推值的个数
%% 导入数据
[X,time_data]=Input_data();
time_interval=time_data(2:end,1)-time_data(1:end-1,1);
time_interval=time_interval./mean(time_interval);
time_data=cumsum([1;time_interval]);
% X0=xlsread('数据.xlsx'); %导入xlsx的数据
n=numel(X)-nf;
X0=X(1:n,1);
%% 计算结果
SearchAgents_no=50;Max_iteration=500;dim=3;
fobj=@RDPTGM;
lb=[0,0];ub=[1,n-4];dim=2;
[~,param,Convergence_curve,Bestpos_curve]=WOA(SearchAgents_no,Max_iteration,lb,ub,dim,fobj);
[~,X0F]=fobj(param);
error_style='MAPE';         %可选填 'MAPE','MAE','RMSE','R2'
mape=[calculate_error(X(1:n,1),X0F(1:n,1)),calculate_error(X(n+1:end,1),X0F(n+1:end,1))];

