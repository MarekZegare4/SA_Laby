

%uchyb
figure(4)
plot(czas(1:end/10),e(1:end/10), 'Color',clr(5))
title("Wykres wartości uchybu w czasie")
xlabel("Czas [s]")
ylabel("e(t)")
grid on

%odp skokowa


figure(1)
plot(czas(1:int:end),Y(1:int:end),'Color',clr(4),'Marker','o','LineStyle','none','MarkerSize',10) 
title("Symulacja w C++")
xlabel("Czas [s]")

hold on

opt = timeoptions("cstprefs");
opt.XLabel.String = 'Czas';
opt.YLabel.String = "y(t)";
opt.Title.String = "Uchyb położeniowy modelu referencyjnego";

% figure(2)
step(full,opt)
grid on

legend("Symulacja w C++ ", "step()")



%%porownanie przeregulowania itd

nwekt = 0.002:0.001:0.2;
przer = zeros(length(nwekt),1);
ust = zeros(length(nwekt),1);

for n = 1:length(nwekt)
sttemp = nwekt(n);
fullt = feedback(obiekt*sttemp,czujnik);
fullt = pade(fullt,30);
a = stepinfo(fullt);

przer(n) = a.Overshoot;
ust(n) = a.SettlingTime;

end

figure(3)
title("Zależność czasu ustalania oraz przeregulowania od wzmocnienia P")
yyaxis left
semilogy(nwekt,przer)
xlabel("Wzmocnienie sterownika P")
ylabel("Przeregulowanie [%]")

grid on

yyaxis right
semilogy(nwekt,ust)
ylabel("Dwuprocentowy czas ustalania [s]")
grid on



bodeSym = csvread("Bode_sym.csv",0,0);
wzm = bodeSym(:,1);
faza = (bodeSym(:,2));
freqs = bodeSym(:,3);
figure(7)
semilogx(freqs,mag2db(wzm))



figure(3)
plot(czas,R,czas,Y,czas,a)
title('Porównanie dziłania sterownika PID pod kątem ogranicznenia wewnętrznej zmiennej członu całkującego')
xlabel("Czas [s]")
ylabel("Sygnał")
grid on
legend("Pobudzenie","Z ograniczeniem", "Bez ograniczenia")



