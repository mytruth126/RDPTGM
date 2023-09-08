clear;clc;close all
warning off;
global X0 time_interval time_data error_style n nf;
nf=1; %Number of predicted extrapolated values
%% import data
data=xlsread('data.xlsx'); %import data from excel
X=data(:,2);time_data=data(:,1);
% [X,time_data]=Input_data();
time_interval=time_data(2:end,1)-time_data(1:end-1,1);
time_interval=time_interval./mean(time_interval);
time_data=cumsum([1;time_interval]);
n=numel(X)-nf;
X0=X(1:n,1);
%% calculation
Result=[];
SearchAgents_no=50;Max_iteration=300;

% Model 1 dy/dt=sum(ai*t^i)y+sum(bi*t^i)+c recursive estimation
fobj=@RDPTGM;
lb=[0,0];ub=[1,n-4];dim=2;
[~,param,Convergence_curve,Bestpos_curve]=WOA(SearchAgents_no,Max_iteration,lb,ub,dim,fobj);
[~,X0F]=fobj(param);
error_style='MAPE';         %selected from 'MAPE','MAE','RMSE','R2'
mape=[calculate_error(X(1:n,1),X0F(1:n,1)),calculate_error(X(n+1:end,1),X0F(n+1:end,1))];
Result=[Result,[mape';[param'];X0F]];

% Model 2 dy/dt=ay+sum(bi*t^i)+c  PTGM Application of a novel grey forecasting model with time power term to predict China’s GDP
fobj=@PTGM;
lb=[0];
ub=[n-4];
dim=1;
[~,param,Convergence_curve,Bestpos_curve]=WOA(SearchAgents_no,Max_iteration,lb,ub,dim,fobj);
[~,X0F]=fobj(param);
error_style='MAPE';         %可选填 'MAPE','MAE','RMSE','R2'
mape=[calculate_error(X(1:n,1),X0F(1:n,1)),calculate_error(X(n+1:end,1),X0F(n+1:end,1))];
Result=[Result,[mape';[0,param]';X0F]];

% Model 3 dy/dt=ay+sum(bi*t^i)+c  PTGM Application of a novel grey forecasting model with time power term to predict China’s GDP
fobj=@DPTGM;
lb=[0];
ub=[n-4];
dim=1;
[~,param,Convergence_curve,Bestpos_curve]=WOA(SearchAgents_no,Max_iteration,lb,ub,dim,fobj);
[~,X0F]=fobj(param);
error_style='MAPE';         %可选填 'MAPE','MAE','RMSE','R2'
mape=[calculate_error(X(1:n,1),X0F(1:n,1)),calculate_error(X(n+1:end,1),X0F(n+1:end,1))];
Result=[Result,[mape';[0,param]';X0F]];


% Model 4 dy/dt=ay+b
[ X0F] = NGM(  );
mape=[calculate_error(X(1:n,1),X0F(1:n,1)),calculate_error(X(n+1:end,1),X0F(n+1:end,1))];
Result=[Result,[mape';[1,0]';X0F]];

Result2=cell(size(Result,1)+1,size(Result,2)+1);
Result2(1,:)=[{''},{'RDPTGM'},{'PTGM'},{'DPTGM'},{'GM(1,1)'}];
Result2(2:5,1)=[{'in-sample mape'},{'out-sample mape'},{'r_value'},{'q_value'}];
Result2(2:end,2:end)=num2cell(Result);
