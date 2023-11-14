data = csvread("NewFile7.csv",2,0)
ch1 = data(550:1200, 1)
ch2 = data(550:1200, 2)
ch1 = ch1 + abs(ch1(1))
ch2 = ch2 + abs(ch2(2))
plot(ch1)
hold on
plot(ch2)
hold off
%xlabel('Częstotliwość [Hz]')
ylabel('Napięcie wyjściowe [V]')
legend("Skok jednostkowy", "Odpowiedź skokowa")
save("test.mat", "ch1")