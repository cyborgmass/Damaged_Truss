function force = white_noise(Intensity,delta_t,Duration,Order,cutoff)

Seed = 1;         
rng(Seed,"twister")
t = (delta_t:delta_t:Duration)';
Nt = length(t);  % Number of Time Increments

% Design a Low-Pass Digital Butterworth Filter
[filt_num,filt_den] = butter(Order, cutoff*2*delta_t);
Nt2 = Nt + 2*Order;

ff = Intensity*randn(Nt2,1)./delta_t^0.5;
ff= filter(filt_num,filt_den,ff);
ff= ff(Nt2-Nt+1:end,:);

force(:,1)=t;
force(:,2)=ff;
end