data = csvread("NewFile9.csv",2,0);
ch1 = data(96:1200, 1);
ch2 = data(96:1200, 2);
ch1 = ch1 + abs(ch1(1));
ch2 = ch2 + abs(ch2(2));
inc = 1e-4;
t = (96*inc):inc:(inc*1200);
length(t)
plot(t,ch1)
hold on
plot(t,ch2)
hold off
%xlabel('Częstotliwość [Hz]')
ylabel('Napięcie wyjściowe [V]')
legend("Skok jednostkowy", "Odpowiedź skokowa")
save("test.mat", "ch1")