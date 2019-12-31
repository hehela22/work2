function [time] = prediction(VehicleList, Task_veh , Sev_veh)
    
    setting;
    
    beta = (VehicleList(5,Sev_veh) - VehicleList(5,Task_veh)) / 3.6;
    sigma = (VehicleList(3,Sev_veh)/3.6)^2 + (VehicleList(3,Task_veh)/3.6)^2;
    R = Radius; 
    d = VehicleList(1,Sev_veh) - VehicleList(1,Task_veh);

    syms x n t ;
    x1 = 4*n*R;
    x2 = 2*R - 4*n*R;
    z = 1/(sqrt(sigma)*sqrt(2*pi*t)) * ( exp(beta*x1/sigma - (x - d - x1 - beta*t)^2 /(2*sigma*t)) - exp(beta*x2/sigma - (x - d - x2 - beta*t)^2 /(2*sigma*t)) ); 
    pdf =  symsum(z , n ,-inf ,inf);
    cdf(t) =  int(pdf , x , -R , R);


    t_l = 0;
    t_r = MAX_TIME;
    if double(eval(cdf(t_r))) >= epsilon
        time = t_r;
    else
        while t_l < t_r
            t_mid = (t_l + t_r) / 2;
            tmp = double(eval(cdf(t_mid)));
%             tmp
            if abs(tmp - epsilon)<=1e-02
                time = t_mid;
                break;
            else
                if t_r - t_l <= 5e-01
                    time = t_l;
                    break;
                end
                if tmp - epsilon < -1e-02
                    t_r = t_mid;
                elseif tmp - epsilon > 1e-02
                    t_l = t_mid;
                end
            end
        end
    end
    
    time
end       
    
    

