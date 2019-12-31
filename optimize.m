function [band,ratio,yita,veh_index_offload,t_max_ana] = optimize(VehicleList , Task_veh, task_index)

    setting;
    [~,total_num] = size(VehicleList);
    veh_index = [];
    for i=1:total_num
        if abs(VehicleList(1,i) - VehicleList(1,Task_veh))<= Radius && i~=Task_veh
            veh_index = [veh_index ,i];
        end
    end
    [~,veh_num] = size(veh_index); 

    time_pre = zeros(1,veh_num);
    d = zeros(1,veh_num);
    for i = 1 : veh_num
        time_pre(i) = prediction(VehicleList, Task_veh , veh_index(i)); %返回特定车辆与Task_veh之间的最大卸载时延
        d(i) = abs(VehicleList(1,veh_index(i)) - VehicleList(1,Task_veh)); %返回特定车辆与Task_veh之间的距离
    end
    
    filename = ['task',num2str(task_index),'.mat'];
    save(filename,'VehicleList','Task_veh','veh_index','time_pre','d');
    save('test.mat','VehicleList','Task_veh','veh_index','time_pre','d');
    
    index = find(time_pre>=1);
    veh_index_offload = veh_index(index);
    n = size(veh_index_offload,2);
    [x,fval] = objfunx(VehicleList,Task_veh,veh_index_offload,time_pre(index),d(index));
%         n = veh_num;
%         cvx_begin quiet
%             variables b(1,n) r(1,n) c t;
%             expression t_n(1,n);
%             t_n_1 = Data.* r./(b.*Bandwidth.*log(P_t .* d.^(-P_loss)./P_n)) + Data.* r .* Cycle_bit./VehicleList(7,veh_index); %候选SeV的卸载时延
%             t_n_2 = Data.* r./(b.*Bandwidth.*log(P_t .* (d + (VehicleList(5,veh_index)-VehicleList(5,Task_veh))./3.6.*t_n_1).^(-P_loss)./P_n));
%             t_n = t_n_1 + t_n_2;
%             minimize t;
%             subject to
%                 t_n <= t; %每个SeV的卸载时延都要不大于t
%                 t_n <= time_pre; %每个SeV的卸载时延都要不大于估计得到的最大卸载时延time_pre
%                 Data * c * Cycle_bit /VehicleList(7,Task_veh) <= t; %Task_veh本地计算时延不大于t
%                 sum(r) == 1 - c;%所有SeV的任务比例之和等于1减去本地计算比例c
%                 sum(b) == 1;%SeV的频谱比例之和为1
%                 0<=b<=1;
%                 0<=r<=1;
%                 0<=c<=1;
%        cvx_end

    
    band = x(n+1:2*n);
    ratio = x(1:n);
    yita = x(2*n+1);   
    t_max_ana = fval;                    
end
    