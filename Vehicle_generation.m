function [VehicleList] = Vehicle_generation()
% 1.location
% 2.cell
% 3.speed
% 4.QoS require
% 5.left bits
% 6.network belongings (0.none 1.BS 2.AP)
% 7.backoffvalue
% 8.backoffstage
% 9.Period
%10.Time left to change speed
%11.price
%12.Time left in cell 1or2,vary with vehicle moving
%13.
%14.The data vehicles in BS need to trans corresponds to expected time in intinial cell ,constant 
setting;

%     kjam=250;%veh/km
%     vf=100;%veh/km

    VehNumber = 50;
    AvrDistance = 60; %m
    Interdistance = exprnd(AvrDistance,1,VehNumber+10);
    origin=0;
    num = 1;
    location=[];
    while(num <= VehNumber)
        location(num) = origin + Interdistance(num);
        origin = origin+Interdistance(num);
        num = num + 1;
    end

    VehicleList=zeros(7,VehNumber);
    VehicleList(1,:) = location;%位置 (单位：m)
    VehicleList(2,:) = 0;%时间
    VehicleList(3,:) = randi([21,39],1,VehNumber); %车辆速度标准差 km/h
    VehicleList(4,:) = randi([70,130],1,VehNumber); %车辆平均速度  km/h
    VehicleList(5,:) = normrnd(VehicleList(4,:),VehicleList(3,:),1,VehNumber); %车辆速度 km/h
    VehicleList(6,:) = rand(1,VehNumber) * Period; %车辆改变车速时间间隔
    VehicleList(7,:) = (0.5 + (1.5).*rand(1,VehNumber))*10^9; %车辆计算能力 单位：cycles/s

%     VehicleList(8,:) = 0; % 车辆收到任务时刻
%     VehicleList(9,:) = 0; % 车辆收到结果时刻

end
