tab = readtable("Wyjscie_symulacji.csv");
tab = table2array(tab);

Y = tab(2:end,1);
U = tab(2:end,2);
czas = tab(2:end,3);

h = 0.01;

figure(1)
plot(czas,Y/(2*h),'Marker','x','LineStyle','none','Color','Red')
title("Symulacja")
hold on

% figure(2)
impulse(1,[1 2 2 1 0])
legend("Symulacja w c++ (podzielona przez 2h z jakiegoś powodu)", "impulse()")