load("1.mat");
load("1_b.mat")
Ts = (0:1e-6:11*100*2e-5)
T = (0:2e-5*100:11*100*2e-5);
%a = tf([aL],[aM])
%b = tf([bL],[bM])
step(tf([1068],[1 476.9]))
hold on;
step(b)
