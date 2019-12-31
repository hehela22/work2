function [VehicleList] = VehicleMovement(VehicleList,TimeToGo)% get vehicles new position;% new speed
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
%11.Price  
%12.Time left in cell 1or2
setting;

VehicleList(1,:)=VehicleList(1,:) + VehicleList(5,:)./3.6 ./10^6.*TimeToGo; %更新车辆位置

VehicleList(6,:)=VehicleList(6,:)-TimeToGo;
if sum(VehicleList(6,:)<=0)>0
    index=find(VehicleList(6,:)<=0);% find vehicles who are going to change speed;
    [~,Number]=size(index);
    VehicleList(5,index) = normrnd(VehicleList(4,index),VehicleList(3,index),1,Number);
end

end
