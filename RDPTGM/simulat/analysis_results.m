clear;clc
load Results
% 不分析a b , 分析p q  和预测MAPE
Anlysis1.p=cell(4,1);
Anlysis1.q=cell(4,1);

for data_length_num=1:size(Results,2)-1
for i=1:size(Results,1)
    for j=1:iter_max
        n=length(Results{i,data_length_num}(j,1).X_n);
    Anlysis1.MAPE{i,data_length_num}{1}(j,:)=[mean(abs(X(n+1:n+1,:)-Results{i,data_length_num}(j,1).X0F_n(n+1:n+1,:))./X(n+1:n+1,:)),mean(abs(X(n+1:n+1,:)-Results{i,data_length_num}(j,2).X0F_n(n+1:n+1,:))./X(n+1:n+1,:)),mean(abs(X(n+1:n+1,:)-Results{i,data_length_num}(j,3).X0F_n(n+1:n+1,:))./X(n+1:n+1,:))];
    Anlysis1.MAPE{i,data_length_num}{2}(j,:)=[mean(abs(X(n+1:n+2,:)-Results{i,data_length_num}(j,1).X0F_n(n+1:n+2,:))./X(n+1:n+2,:)),mean(abs(X(n+1:n+2,:)-Results{i,data_length_num}(j,2).X0F_n(n+1:n+2,:))./X(n+1:n+2,:)),mean(abs(X(n+1:n+2,:)-Results{i,data_length_num}(j,3).X0F_n(n+1:n+2,:))./X(n+1:n+2,:))];
    Anlysis1.MAPE{i,data_length_num}{3}(j,:)=[mean(abs(X(n+1:n+3,:)-Results{i,data_length_num}(j,1).X0F_n(n+1:n+3,:))./X(n+1:n+3,:)),mean(abs(X(n+1:n+3,:)-Results{i,data_length_num}(j,2).X0F_n(n+1:n+3,:))./X(n+1:n+3,:)),mean(abs(X(n+1:n+3,:)-Results{i,data_length_num}(j,3).X0F_n(n+1:n+3,:))./X(n+1:n+3,:))];
    Anlysis1.MAPE{i,data_length_num}{4}(j,:)=[mean(abs(X(n+1:n+4,:)-Results{i,data_length_num}(j,1).X0F_n(n+1:n+4,:))./X(n+1:n+4,:)),mean(abs(X(n+1:n+4,:)-Results{i,data_length_num}(j,2).X0F_n(n+1:n+4,:))./X(n+1:n+4,:)),mean(abs(X(n+1:n+4,:)-Results{i,data_length_num}(j,3).X0F_n(n+1:n+4,:))./X(n+1:n+4,:))];
    Anlysis1.MAPE{i,data_length_num}{5}(j,:)=[mean(abs(X(n+1:n+5,:)-Results{i,data_length_num}(j,1).X0F_n(n+1:n+5,:))./X(n+1:n+5,:)),mean(abs(X(n+1:n+5,:)-Results{i,data_length_num}(j,2).X0F_n(n+1:n+5,:))./X(n+1:n+5,:)),mean(abs(X(n+1:n+5,:)-Results{i,data_length_num}(j,3).X0F_n(n+1:n+5,:))./X(n+1:n+5,:))];
    Anlysis1.RMSE{i,data_length_num}{1}(j,:)=[sqrt(mean((X(n+1:n+1,:)-Results{i,data_length_num}(j,1).X0F_n(n+1:n+1,:)).^2)),sqrt(mean((X(n+1:n+1,:)-Results{i,data_length_num}(j,2).X0F_n(n+1:n+1,:)).^2)),sqrt(mean((X(n+1:n+1,:)-Results{i,data_length_num}(j,3).X0F_n(n+1:n+1,:)).^2))];
    Anlysis1.RMSE{i,data_length_num}{2}(j,:)=[sqrt(mean((X(n+1:n+2,:)-Results{i,data_length_num}(j,1).X0F_n(n+1:n+2,:)).^2)),sqrt(mean((X(n+1:n+2,:)-Results{i,data_length_num}(j,2).X0F_n(n+1:n+2,:)).^2)),sqrt(mean((X(n+1:n+2,:)-Results{i,data_length_num}(j,3).X0F_n(n+1:n+2,:)).^2))];
    Anlysis1.RMSE{i,data_length_num}{3}(j,:)=[sqrt(mean((X(n+1:n+3,:)-Results{i,data_length_num}(j,1).X0F_n(n+1:n+3,:)).^2)),sqrt(mean((X(n+1:n+3,:)-Results{i,data_length_num}(j,2).X0F_n(n+1:n+3,:)).^2)),sqrt(mean((X(n+1:n+3,:)-Results{i,data_length_num}(j,3).X0F_n(n+1:n+3,:)).^2))];
    Anlysis1.RMSE{i,data_length_num}{4}(j,:)=[sqrt(mean((X(n+1:n+4,:)-Results{i,data_length_num}(j,1).X0F_n(n+1:n+4,:)).^2)),sqrt(mean((X(n+1:n+4,:)-Results{i,data_length_num}(j,2).X0F_n(n+1:n+4,:)).^2)),sqrt(mean((X(n+1:n+4,:)-Results{i,data_length_num}(j,3).X0F_n(n+1:n+4,:)).^2))];
    Anlysis1.RMSE{i,data_length_num}{5}(j,:)=[sqrt(mean((X(n+1:n+5,:)-Results{i,data_length_num}(j,1).X0F_n(n+1:n+5,:)).^2)),sqrt(mean((X(n+1:n+5,:)-Results{i,data_length_num}(j,2).X0F_n(n+1:n+5,:)).^2)),sqrt(mean((X(n+1:n+5,:)-Results{i,data_length_num}(j,3).X0F_n(n+1:n+5,:)).^2))];    
    end
end
end
mean_mape_results=[];std_mape_results=[];
for i=1:size(Anlysis1.MAPE,1)
    tmp1=[];tmp2=[];
    for j=1:size(Anlysis1.MAPE,2)
        tmp1=[tmp1,mean(Anlysis1.MAPE{i,j}{1,1})'];
        tmp2=[tmp2,std(Anlysis1.MAPE{i,j}{1,1})'];
    end
        mean_mape_results=[mean_mape_results;tmp1];
        std_mape_results=[std_mape_results;tmp2];
end
mean_rmse_results=[];std_rmse_results=[];
for i=1:size(Anlysis1.RMSE,1)
    tmp1=[];tmp2=[];
    for j=1:size(Anlysis1.RMSE,2)
        tmp1=[tmp1,mean(Anlysis1.RMSE{i,j}{1,1})'];
        tmp2=[tmp2,std(Anlysis1.RMSE{i,j}{1,1})'];
    end
        mean_rmse_results=[mean_rmse_results;tmp1];
        std_rmse_results=[std_rmse_results;tmp2];
end

