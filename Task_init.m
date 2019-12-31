function Task = Task_init(VehicleList, time_start, Task_veh, band, ratio, yita, SeV_index) 
setting;
alpha = 0.3;

SeV_num = size(SeV_index,2);

field1 = 'time_start';  value1 = time_start;
field2 = 'flag_task_completed';  value2 = 0;
field3 = 'flag_task';  value3 = 0;
field4 = 'band';  value4 = band;
field5 = 'ratio';  value5 = ratio;
field6 = 'SeV_index';  value6 = SeV_index;
field7 = 'Task_veh';  value7 = Task_veh;

field8 = 'flag_Offload';  value8 = zeros(1,SeV_num);
field9 = 'flag_Comput';  value9 = zeros(1,SeV_num);
field10 = 'flag_Upload';  value10 = zeros(1,SeV_num);
field11 = 'data_offload';  value11 = Data*ratio;
field12 = 'data_comput';  value12 =  Data*ratio;
field13= 'data_upload';  value13 =  Data * ratio * alpha;

field14 = 'local_delay';  value14 =  Data * yita * Cycle_bit / VehicleList(7,Task_veh);

Task = struct(field1,value1,field2,value2,field3,value3,field4,value4,field5,value5,field6,value6,field7,value7,...
field8,value8,field9,value9,field10,value10,field11,value11,field12,value12,field13,value13,field14,value14);
end