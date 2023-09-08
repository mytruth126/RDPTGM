function [ ERROR ] = calculate_error( Y1,Y2 )
global error_style;
switch error_style
    case 'MAPE'
        ERROR=mape(Y1,Y2);
    case 'RMSE'
        ERROR=rmse(Y1,Y2);
    case 'MAE'
        ERROR=mae(Y1,Y2);
    case 'R2'
        ERROR=R_square(Y1,Y2);
end
end

function ERROR=mape(Y1,Y2)
m=numel(Y1);
ERROR=mean(abs(Y1(1:m,:)-Y2(1:m,:))./Y1(1:m,:));
end

function ERROR=rmse(Y1,Y2)
m=numel(Y1);
ERROR=sqrt(mean((Y1(1:m,:)-Y2(1:m,:)).^2));
end

function ERROR=mae(Y1,Y2)
m=numel(Y1);
ERROR=mean(abs(Y1(1:m,:)-Y2(1:m,:)));
end

function ERROR=R_square(Y1,Y2)
m=numel(Y1);
ERROR= 1 - (sum((Y2(1:m,:) - Y1(1:m,:)).^2) / sum((Y1(1:m,:) - mean(Y1(1:m,:))).^2));
end
