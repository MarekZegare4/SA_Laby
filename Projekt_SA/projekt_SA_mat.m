tab = csvread("Wyjscie_symulacji.csv",1,0);

h =tab(1,1);
czasKoniec = tab(1,2);
Tp = tab(1,3);
Ti = tab(2,1);
Kp = tab(2,2);
a1 = tab(2,3);
a2 = tab(3,1);
To = tab(3,2);

clr = ["#D95319" "#EDB120" "#7E2F8E" "#77AC30" "#4DBEEE" "#A2142F"];

Y = tab(4:end,1);
e = tab(4:end,2);
czas = tab(4:end,3);
R = tab(4:end,4);

figure(1)
hold on
plot(czas,e)
axis([0 0.1 0 10])
title("Odpowiedź skokowa układu ze sterownikiem LEAD")
xlabel("Czas [s]")
ylabel("Sygnał")
grid on
legend("k =2", "k = 0.7", "k = 0.8", "k = 0.85" , "k = 0.9")


L1 = [0.152951155860919    -252566.219002589    168352968265.966];
M1 = [1    3012.29640106007    4851594.98215333    1649854568.84972    0]; %0.131341301319037

M2 = M1*1.25;
M2(1) = 1;

[A,B,C,D] = tf2ss(L1,M1);

global t Yt apr;

%apr = 0.002;

int = 100;

t = czas(1:int:end);
Yt =Y(1:int:end);

Xp = [ 1 1 1 1 1 1 ];
Xf = fminsearch("min_proj",Xp)

agf = tf([Xf(1) Xf(2) Xf(3)],[Xf(4) Xf(5)  Xf(6) 0]);

agh = tf([-15.26 2.881e4],[1 282 0]);



figure(3)
step(tf(L1,M1),0.1)
axis([0 0.1 0 10])
hold on
plot(czas(1:int:end),Y(1:int:end), 'Color', clr(4), 'LineStyle','none','Marker','hexagram')


obiekt = tf(Kp/Ti,[a2*Tp (a2 +a1*Tp) (a1 +Tp)  1 0],'inputdelay',5*To);
czujnik = tf(1,[0.05*Tp 1],'inputdelay',To);
ster = 0.03 ;

    
full = feedback(obiekt*ster,czujnik);

% fullpade = pade(full,15);
% stepinfo(fullpade)
% figure(2)
% step(fullpade)


lead = tf([1 282],[ 1 1032]);
UklKor = agh*lead;


syms l1 l2 l3 l4 s

L = [l1;l2;l3;l4];

eq2 = s^4 + 3764.9*s^3 + 7579883.1*s^2 + 3221996400.0*s;

solve(eq1 == eq2, l1, l2, l3, l4)


r1 = det(s*eye(4) - A +L*C)


solve(r1==eq2, l1, l2, l3, l4, s)
eqs = [fgh(1) ==1, fgh(2) == 3764.9, fgh(3) == 7579883.1, fgh(4) == 221996400.0];
awe = solve(eqs, l1, l2, l3, l4);


vpa(awe.l1,3)
vpa(awe.l2,3)
vpa(awe.l3,3)
vpa(awe.l4,3)



r2 = 








