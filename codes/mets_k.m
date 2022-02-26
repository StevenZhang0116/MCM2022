load tokyo

%% Parameters Settings
METS_max = 27.82; % unitless
mod = normrnd(64.85,5.46); % ml/kg
d_max = (mod/(60*2.8)); % M-h
t_r = 10; % h
S_fast = unifrnd(0.6,3.7); % M/h
avg_v = 50000; % m/h

M = METs ./ METS_max;
% x = wgn(1,54,2)/10;
% M = M + x;

trat_ss = ss;
trat_ss(1) = [];
delta_ss = zeros(size(ss)-1);
for i = 1: size(delta_ss)
    delta_ss(i) = ss(i+1)-ss(i);
end

M_norm = normalize(M,'range');
p = 0.1; % probablity of the athlete to speed up
A = (rand(size(M_norm,2))<p); % bernoulli matrix

a = 5.20 - (1.52/t_r) + (3.92/t_r^2);
b = 3.93 - (3.57/t_r) + (3.66/t_r^2);
F = zeros(1,size(M_norm,2));


%% Main Loop
for x = 1: size(M_norm,2)
    counter = 1; % whether M minimum is reached

    alpha = normrnd(0,0.3); % speed up factor, unitless
    t_fraction = max(normrnd(0.1,0.1),0); % time fraction of speeding up compring to each time of exercise
    beta = normrnd(0.05,0.05); % epoc decay factor

    if x == 1
        delta_M = M_norm(x);
    else
        delta_M = (M_norm(x)-M_norm(x-1));
    end
    
    if x > 1 && M_norm(x) < 0.39 && M_norm(x-1) < 0.39 % 0.39M = infinite time of exhaustion
        counter = -1;
    end
    
    t_e = delta_ss(x)/avg_v;
    
    if counter == -1 && delta_M > 0
        counter = -1;
    elseif counter == 1 && delta_M > 0
        counter = 1;
    elseif counter == -1 && delta_M < 0
        counter = -1;
    elseif counter == 1 && delta_M < 0
        counter = -1;
    end
    
    if A(1,x) == 1 % will run fast        
        f_fast = counter * abs(delta_M)^2/(2*exp(1-t_fraction)*alpha*S_fast*d_max);
        f_slow = abs((a*delta_M^b-1/(exp(1-t_fraction)*alpha*t_r))*t_e);
    else
        f_fast = counter * abs(delta_M)^2/(2*S_fast*d_max);
        f_slow = abs((a*delta_M^b-1/t_r)*t_e);
    end
    
    f_sum = f_fast+f_slow;
    
    if x == 1
        F(x) = f_sum;
    else
        F(x) = F(x-1)+f_sum;
    end
        
    if F(x) > 1
        M_norm(x) = M_norm(x)-0.01;
    end
    
    if F(x) < 0
        F(x) = 0;
    end

    %% Calculate EPOC
    if t_e >= abs(delta_M)/S_fast
        epoc_fast = 0.5*(delta_M)^2/(S_fast*t_e);
    else
        epoc_fast = 0.5-S_fast*t_e;
    end
    
    epoc_slow = d_max/t_r;
    
    if f_sum < 0
        M_norm(x) = M_norm(x)+beta*(epoc_fast+epoc_slow);
    end    
end

F_norm = normalize(F,'range');

figure(1)
plot(trat_ss, M_norm);
xlabel("Distance")
ylabel("M")
figure(2)
plot(trat_ss, F_norm)
xlabel("Distance")
ylabel("F")