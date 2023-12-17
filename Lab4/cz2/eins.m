
%% przebieg __--__  wzm uchybu 0,33  k gały 0,4  R9 = 50 

dane = csvread("scope_1.csv",3,0);
t1 = dane(:,1)';
ch1 = dane(:,2)';
tacho1 = dane(:,3)';
Zas1 = dane(:,4)';
%ch4 = dane(:,5);
plot(t1,ch1, t1,tacho1,t1,Zas1)

            