function [data ,flag_SeV_i, flag_task] = SeV_Trans(data, band, SeV_veh, Task_veh, TimeToGo ,VehicleList)

setting;
d = abs(VehicleList(1,SeV_veh) - VehicleList(1,Task_veh)); %�����ض�������Task_veh֮��ľ���
if d > Radius
    flag_task = 1;
else
    Rate = band * Bandwidth * log(P_t * d^(-P_loss) / P_n); %�������� ��λ��bit/s
    data = data -  Rate * TimeToGo / 10^6; 
    flag_task = 0;
end

if data<=0
    flag_SeV_i = 1;
else
    flag_SeV_i = 0;
end

end
    