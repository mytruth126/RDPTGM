clear;clc;close all
warning off;
nf=5;
iter_max=500;
data_length_list=[15,20,25,30,45,55];
para=[0,1.4,0.01,0.2,0.5,0.01];
%% calculation
Results=[];
tic
for data_length_index=1:6
    data_length=data_length_list(data_length_index);    
    [X]=generating_data(para,data_length);X=X(:);
    time_data=linspace(1,data_length,data_length);time_data=time_data(:);
    n=numel(X)-nf;
    X0=X(1:n,1);
    X0_std=std(X0);
    nvr_index=0;
    for nvr=0.02:0.02:0.1
        nvr_index=nvr_index+1;
        Result(iter_max,3)=struct('lamba',[],'p',[],'q',[],'w',[],'X_n',[],'X0F_n',[]);
        for iter_n=1:iter_max
            noise=X0_std*nvr*randn(n,1);
            x_n=X0+noise;
            SearchAgents_no=50;Max_iteration=200;dim=3;
            lb=[0,0,0];ub=[0,0,n-4];
            % Model 1 dy/dt=sum(ai*t^i)y+sum(bi*t^i)+c OLS estimate
            fobj=@main_PTGM;
            [~,param,Convergence_curve,Bestpos_curve]=WOA(SearchAgents_no,Max_iteration,lb,ub,dim,fobj,x_n,nf,time_data);
            [mape,par,X0F_n]=fobj(param,x_n,nf,time_data);
            Result(iter_n,1).lamba=par(1);Result(iter_n,1).p=par(2);Result(iter_n,1).q=par(3);
            Result(iter_n,1).w=par(4:end);Result(iter_n,1).X_n=x_n;Result(iter_n,1).X0F_n=X0F_n;
            
            % Model 2 dy/dt=sum(ai*t^i)y+sum(bi*t^i)+c RLS estimate
            fobj=@main_NPTDGM;
            lb=[0,0,0];ub=[0,0,n-4];
            [~,param,Convergence_curve,Bestpos_curve]=WOA(SearchAgents_no,Max_iteration,lb,ub,dim,fobj,x_n,nf,time_data);
            [mape,par,X0F_n]=fobj(param,x_n,nf,time_data);
            Result(iter_n,2).lamba=par(1);Result(iter_n,2).p=par(2);Result(iter_n,2).q=par(3);
            Result(iter_n,2).w=par(4:end);Result(iter_n,2).X_n=x_n;Result(iter_n,2).X0F_n=X0F_n;
            
            % Model 3 dy/dt=ay+sum(bi*t^i)+c RLS estimate
            fobj=@main_RNPTDGM;
            lb=[0,0,0];ub=[1,0,n-4];
            [~,param,Convergence_curve,Bestpos_curve]=WOA(SearchAgents_no,Max_iteration,lb,ub,dim,fobj,x_n,nf,time_data);
            [mape,par,X0F_n]=fobj(param,x_n,nf,time_data);
            Result(iter_n,3).lamba=par(1);Result(iter_n,3).p=par(2);Result(iter_n,3).q=par(3);
            Result(iter_n,3).w=par(4:end);Result(iter_n,3).X_n=x_n;Result(iter_n,3).X0F_n=X0F_n;
            
            if iter_n/100==fix(iter_n/100)
                data_length_index
                nvr
                iter_n
                toc
            end
        end
        Results{nvr_index,data_length_index}=Result;
        save Results
    end
end
