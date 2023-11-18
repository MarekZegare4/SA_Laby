data = csvread("scope_3.csv",2,0);
t = data(:,1);
ch1 = data(:, 2);
ch2 = data(:, 3);
ch3 = data(:,4)
%ch1 = ch1 + abs(ch1(1));
%ch2 = ch2 + abs(ch2(2));
% inc = 1e-4;
% t = (1*inc):inc:(inc*1200);
length(t)
plot(t(1:1500),ch1(1:1500), t(1:1500), ch2(1:1500), t(1:1500), ch3(1:1500))
hold on
%plot(t,ch2)
hold off
%xlabel('Częstotliwość [Hz]')
ylabel('Napięcie wyjściowe [V]')
legend("Skok jednostkowy","Odpowiedź skokowa")
grid on