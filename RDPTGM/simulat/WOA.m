% The Whale Optimization Algorithm
function [Leader_score,Leader_pos,Convergence_curve,Bestpos_curve]=WOA(SearchAgents_no,Max_iteration,lb,ub,dim,fobj,x_n,nf,time_data)

% initialize position vector and score for the leader
Leader_pos=ones(1,dim);
Leader_score=inf; %change this to -inf for maximization problems
%Initialize the positions of search agents
Positions=initialization(SearchAgents_no,dim,ub,lb);
Convergence_curve=zeros(1,Max_iteration);
Bestpos_curve = zeros(Max_iteration,dim);%注 最优位置曲线只能适用于单维空间
M=zeros(Max_iteration,SearchAgents_no);
t=0;% Loop counter
s=0.11;%缩放因子
% Main loop
while t<Max_iteration
    for i=1:size(Positions,1)    %判断该代鲸鱼的适应度值，并更新最优得分和最优位置
        
        % Return back the search agents that go beyond the boundaries of the search space
        Flag4ub=Positions(i,:)>ub;
        Flag4lb=Positions(i,:)<lb;
        Positions(i,:)=(Positions(i,:).*(~(Flag4ub+Flag4lb)))+ub.*Flag4ub+lb.*Flag4lb;
        
        % Calculate objective function for each search agent
        fitness=fobj(Positions(i,:),x_n,nf,time_data); %注fobj([矩阵]或单个元素值）可直接调用公式，对该1行矩阵内数据代入计算
        
        % Update the leader
        if fitness<Leader_score % Change this to > for maximization problem
            Leader_score=fitness; % Update alpha
            Leader_pos=Positions(i,:);
        end
        if dim<=1
           M(t+1,i)= Positions(i,:) ;
        end
    end
    
    a=2-t*((2)/Max_iteration); % a decreases linearly fron 2 to 0 in Eq. (2.3)
    
    % a2 linearly dicreases from -1 to -2 to calculate t in Eq. (3.12)
    a2=-1+t*((-1)/Max_iteration);
    
    % Update the Position of search agents  更新鲸鱼位置
    for i=1:size(Positions,1)
        r1=rand(); % r1 is a random number in [0,1]
        r2=s*rand(); % r2 is a random number in [0,1]
        
        A=2*a*r1-a;  % Eq. (2.3) in the paper
        C=2*r2;      % Eq. (2.4) in the paper
        
        
        b=1;               %  parameters in Eq. (2.5)
        l=(a2-1)*rand+1;   %  parameters in Eq. (2.5)
        
        p = rand();        % p in Eq. (2.6)
       
       %对该只鲸鱼的每个变量数值进行优化，即问题维度D值，dim。注：每只鲸鱼的动作是不同的，总共三种动作。
        for j=1:size(Positions,2) 
            if p<0.5   
                if abs(A)>=1   %执行全局搜索
                    rand_leader_index = floor(SearchAgents_no*rand()+1); %随机定义领头鲸鱼位置
                    X_rand = Positions(rand_leader_index, :);
                    D_X_rand=abs(C*X_rand(j)-Positions(i,j)); % Eq. (2.7)
                    Positions(i,j)=X_rand(j)-A*D_X_rand;      % Eq. (2.8)
                    
                elseif abs(A)<0.5 %执行局部寻优，摇摆捕食
                    D_Leader=abs(C*Leader_pos(j)-Positions(i,j)); % Eq. (2.1)
                    Positions(i,j)=Leader_pos(j)-A*D_Leader;      % Eq. (2.2)
                end
                
            elseif p>=0.5    %执行局部寻优，气泡捕食
                distance2Leader=abs(Leader_pos(j)-Positions(i,j)); % Eq. (2.5)
                Positions(i,j)=distance2Leader*exp(b.*l).*cos(l.*2*pi)+Leader_pos(j);
            end  
        end
    end
    t=t+1;
    Convergence_curve(t)=Leader_score; %记录最优得分的寻优过程
    Bestpos_curve(t,:)=Leader_pos;
    [t Leader_score];
end
end

