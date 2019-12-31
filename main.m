clc;clear;
warning('off')
setting;
K = 1;
Delay_ana = cell(1,K);
Delay_sim = cell(1,K);
Success_task_num = zeros(1,K);
Total_task_num = zeros(1,K);
SeV_num_ana = [];
yita_ana = [];
Task = [];

for k = 1:K

    [VehicleList] = Vehicle_generation();% vehicle generation,record file setup
    time = 0;
    time_count = 0;
    
    while time < (SimulationTime + 10*10^6)
        TimeToGo = 100;%us
        if time_count <= 0
            Total_task_num(1,k) = Total_task_num(1,k) + 1;
            time_start = time;
            time_count = Task_arrival_period;
            
            Task_veh = randi([10,40],1,1);
            [band,ratio,yita,SeV_index,Delay] = optimize(VehicleList , Task_veh, Total_task_num(1,k));
            Delay_ana{1,k} = [Delay_ana{1,k},Delay];
            SeV_num = size(SeV_index,2);
            yita_ana = [yita_ana,yita]; %每次任务的本地计算比例
            SeV_num_ana = [SeV_num_ana,SeV_num]; %每次任务可供卸载的SeV数目
            
            task = Task_init(VehicleList, time_start, Task_veh, band, ratio, yita, SeV_index); %初始化任务，注意任务是结构体
            Task = [Task,task]; % 将新任务加入任务结构体数组
        end
        
        for i = 1:Total_task_num(1,k)
            if Task(i).flag_task == 0 && Task(i).flag_task_completed == 0
                Task(i) = Task_exec(Task(i), TimeToGo, VehicleList);
                if Task(i).flag_task_completed == 1
                    Delay_sim{1,k} = [Delay_sim{1,k} , max((time + TimeToGo - Task(i).time_start)/10^6 , Task(i).local_delay)];
                    Success_task_num(1,k) = Success_task_num(1,k) + 1;
                end
            else
                continue;
            end
        end
        
        time
        dbstop if error
        time = time + TimeToGo;
        time_count = time_count - TimeToGo;
        [VehicleList] = VehicleMovement(VehicleList,TimeToGo);
    end
end   