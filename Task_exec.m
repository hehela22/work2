function  task = Task_exec(task, TimeToGo, VehicleList)
    setting;
    SeV_num = size(task.SeV_index,2);
    for i=1:SeV_num
            if task.flag_task == 0
                if task.flag_Offload(i) == 0 
                    [task.data_offload(i) , task.flag_Offload(i) ,task.flag_task] = TaV_Trans(task.data_offload(i), task.band(i), task.SeV_index(i), task.Task_veh, TimeToGo, VehicleList);
                end
                if task.flag_Offload(i) && task.flag_Comput(i) == 0
                    task.data_comput(i) = task.data_comput(i) - VehicleList(7,task.SeV_index(i)) * (TimeToGo/10^6) / Cycle_bit;
                    if task.data_comput(i)<=0
                        task.flag_Comput(i) = 1;
                    end
                end
                if task.flag_Comput(i) && task.flag_Upload(i) == 0
                    [task.data_upload(i) , task.flag_Upload(i) , task.flag_task] = SeV_Trans(task.data_upload(i), task.band(i), task.SeV_index(i), task.Task_veh, TimeToGo, VehicleList);
                end
            else
                break;
            end
    end
    if sum(task.flag_Upload==1)== SeV_num && task.flag_task == 0
        task.flag_task_completed = 1; %任务完成
    end
end
