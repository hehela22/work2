function [x,f] = objfunx(VehicleList,Task_veh,veh_index,time_pre,d)

%solve optimization problem, use 'fmincon', only get local minimum value

setting;
% index = find(time_pre>=1);
% veh_index_init = veh_index(index);
% veh_index_init

n = size(veh_index,2);
X0 = zeros(2*n+1,1);
X0(1:n)= 1/(n+1)*ones(1,n);
X0(n+1:2*n) = 1/(n)*ones(1,n);
X0(2*n+1) = 1/(n+1);

t_n_1 = @(x) Data.* x(1:n)'./(x(n+1:2*n)'.*Bandwidth.*log(1 + P_t .* d.^(-P_loss)./P_n)) + Data.* x(1:n)' .* Cycle_bit./VehicleList(7,veh_index); % TaV offload task delay and computing delay
t_n_2 = @(x) abs(Data.* x(1:n)'.*alpha./(x(n+1:2*n)'.*Bandwidth.*log(1 + P_t .* (d + (VehicleList(5,veh_index)-VehicleList(5,Task_veh))./3.6.*t_n_1(x)).^(-P_loss)./P_n))); % SeV upload answer delay
t_n = @(x) t_n_1(x) + t_n_2(x); % total task delay
t_loc = @(x) Data * x(2*n+1) * Cycle_bit/VehicleList(7,Task_veh); % local computing delay

fun = @(x) max([max(t_n(x)) , t_loc(x)]);
nonlcon = @(x) deal(t_n(x) - time_pre , []);

% fun = @(x) max([ max( Data.*x(1:n)./(x(n+1:2*n).*Bandwidth.*log(P_t .* d(index).^(-P_loss)./P_n)) + Data.*x(1:n).* Cycle_bit./VehicleList(7,veh_index_init) ) , Data*x(2*n+1)*Cycle_bit/VehicleList(7,Task_veh)]);
% nonlcon = @(x) deal(Data.*x(1:n)./(x(n+1:2*n).*Bandwidth.*log(P_t .* d(index).^(-P_loss)./P_n)) + Data.*x(1:n).* Cycle_bit./VehicleList(7,veh_index_init) - time_pre(index) , []);

Aeq = zeros(2,2*n+1);
Aeq(1,1:n) = ones(1,n);
Aeq(1,n+1:2*n) = zeros(1,n);
Aeq(1,2*n+1) = 1;
Aeq(2,1:n) = zeros(1,n);
Aeq(2,n+1:2*n) = ones(1,n);
Aeq(2,2*n+1) = 0;

beq = [1,1]';
Vlb = zeros(2*n+1,1);
Vub = ones(2*n+1,1);
[x,f] = fmincon(fun,X0,[],[],Aeq,beq,Vlb,Vub,nonlcon);

% problem = createOptimProblem('fmincon',...
%  'objective',fun,...
%  'nonlcon',nonlcon,...
%  'x0',X0,...
%  'Aeq',Aeq,...
%  'beq',beq,...
%  'lb',Vlb,...
%  'ub',Vub);
% 
% problem.solver = 'simulannealbnd';
% % problem.objective = fun;
% problem.options = saoptimset('Display','iter',...
%  'InitialTemperature',10,...
%  'MaxIter',1000000);
% [x,f] = simulannealbnd(problem);

x
f
end