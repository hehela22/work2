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
        time_pre(i) = prediction(VehicleList, Task_veh , veh_index(i)); %�����ض�������Task_veh֮������ж��ʱ��
        d(i) = abs(VehicleList(1,veh_index(i)) - VehicleList(1,Task_veh)); %�����ض�������Task_veh֮��ľ���
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
%             t_n_1 = Data.* r./(b.*Bandwidth.*log(P_t .* d.^(-P_loss)./P_n)) + Data.* r .* Cycle_bit./VehicleList(7,veh_index); %��ѡSeV��ж��ʱ��
%             t_n_2 = Data.* r./(b.*Bandwidth.*log(P_t .* (d + (VehicleList(5,veh_index)-VehicleList(5,Task_veh))./3.6.*t_n_1).^(-P_loss)./P_n));
%             t_n = t_n_1 + t_n_2;
%             minimize t;
%             subject to
%                 t_n <= t; %ÿ��SeV��ж��ʱ�Ӷ�Ҫ������t
%                 t_n <= time_pre; %ÿ��SeV��ж��ʱ�Ӷ�Ҫ�����ڹ��Ƶõ������ж��ʱ��time_pre
%                 Data * c * Cycle_bit /VehicleList(7,Task_veh) <= t; %Task_veh���ؼ���ʱ�Ӳ�����t
%                 sum(r) == 1 - c;%����SeV���������֮�͵���1��ȥ���ؼ������c
%                 sum(b) == 1;%SeV��Ƶ�ױ���֮��Ϊ1
%                 0<=b<=1;
%                 0<=r<=1;
%                 0<=c<=1;
%        cvx_end

    
    band = x(n+1:2*n);
    ratio = x(1:n);
    yita = x(2*n+1);   
    t_max_ana = fval;                    
end
    