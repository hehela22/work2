%public setting

SimulationTime=100*10^6; %simulation duration 

Task_arrival_period = 10*10^6; %���񵽴�ʱ����

Period = 10^6;%us �����ı䳵��ʱ����

Radius = 300; % v2vͨ�ž��� ��λ��m

Bandwidth = 20*10^6; % Hz

Data = 100*10^6; % ������ ��λ��bit

Cycle_bit = 1000; % ��������������ҪCPU cycle��Ŀ ��λ��cycles/s 

alpha = 0.3;  % ����������������������ı���

epsilon = 0.4; % �ɿ�������

Noise = -100; % �������� ��λ��dbm

P_n = 10^(Noise/10); %�������� ��λ��mW

P_t = 500; % v2v���书�� ��λ��mW

P_loss = 3; % ��߶�˥��ϵ�� 

MAX_TIME = 200; %����֮����������ʱ��





