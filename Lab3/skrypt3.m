dane = csvread("scope_2.csv",2,0);

t = dane(405:end,1);
t = t -abs(t(1));
ch1 = dane(405:end,2);
ch2 = dane(405:end,3);
ch2 = ch2+abs(ch2(1)) -0.2;

figure(1)
plot(t,ch1,t,ch2)

Kp = 1.0323/2;

% model = tf([1.0323/2],[2.5770e-07 2.3088e-04 1/2]);
% 
% Tw = 2.30884e-04;
% Tz = 2.5770e-07/Tw;
% kpetl = 0.9687;


% obiekt1 = feedback(tf(1,[Tw 1]),4)*tf(1,[Tz 0])*2*Kp;
% obiekt1 = feedback(obiekt1,kpetl);
% 
% figure(3)
% opt = stepDataOptions("StepAmplitude",0.205*2,'InputOffset',-0.205)
% step(obiekt1,opt)



figure(2)

int = 60;
plot(out.zas_sym)
hold on
plot(out.wyj_sym)
grid on
plot(t(1:int:end),ch2(1:int:end),'LineStyle','none','Marker','square','MarkerSize',9,'Color',"#7E2F8E" )

title("Wykres dla Kw = 4")
xlabel("Czas [s]")
ylabel("Napięcie na wyjściu [V]")
legend("Zasilanie","Wyjście symulacyjne","Dane pomiarowe")

