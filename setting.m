%public setting

SimulationTime=100*10^6; %simulation duration 

Task_arrival_period = 10*10^6; %任务到达时间间隔

Period = 10^6;%us 车辆改变车速时间间隔

Radius = 300; % v2v通信距离 单位：m

Bandwidth = 20*10^6; % Hz

Data = 100*10^6; % 任务量 单位：bit

Cycle_bit = 1000; % 比特任务量所需要CPU cycle数目 单位：cycles/s 

alpha = 0.3;  % 计算任务结果相对于输入量的比例

epsilon = 0.4; % 可靠性门限

Noise = -100; % 噪声功率 单位：dbm

P_n = 10^(Noise/10); %噪声功率 单位：mW

P_t = 500; % v2v传输功率 单位：mW

P_loss = 3; % 大尺度衰落系数 

MAX_TIME = 200; %车辆之间最大可连接时间





