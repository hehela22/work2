function [data ,flag_SeV_i, flag_task] = SeV_Trans(data, band, SeV_veh, Task_veh, TimeToGo ,VehicleList)

setting;
d = abs(VehicleList(1,SeV_veh) - VehicleList(1,Task_veh)); %返回特定车辆与Task_veh之间的距离
if d > Radius
    flag_task = 1;
else
    Rate = band * Bandwidth * log(P_t * d^(-P_loss) / P_n); %传输速率 单位：bit/s
    data = data -  Rate * TimeToGo / 10^6; 
    flag_task = 0;
end

if data<=0
    flag_SeV_i = 1;
else
    flag_SeV_i = 0;
end

end
    