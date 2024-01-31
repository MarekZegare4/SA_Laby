

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
%%semilogx(freqs,mag2db(wzm))


% for n = 1:length(freqs)
%     if faza(n) >10
%         faza(n) = faza(n)-180;
%     end
% end
wzm =mag2db(wzm);

semilogx(freqs,faza)


figure(3)
plot(czas,R,czas,Y,czas,a)
title('Porównanie dziłania sterownika PID pod kątem ogranicznenia wewnętrznej zmiennej członu całkującego')
xlabel("Czas [s]")
ylabel("Sygnał")
grid on
legend("Pobudzenie","Z ograniczeniem", "Bez ograniczenia")



figure(2)
plot(czas,e, 'Color', clr(2))
title("Wykres uchybu od czasu, symulacja w C++")
xlabel("Czas [s]")
ylabel("e(t)")
legend("Pobudzenie r(t) =t")
grid on



s = -460;

bieg = 1032;

%s = - 400;

Nuk = -15.26*s + 2.881e4;
Duk = s^2 + 282*s;

Nlead = s +282;
Dlead = s + bieg; % bieg


Nn = Nuk*Nlead;
Dn = Duk*Dlead;

Nnp = -763*s/25 + 827833/25;
Dnp = 3*s^2 + 2*s*282 + bieg*s*2 + 282*bieg;


eq = (Nn*Dnp == Nnp* Dn);
solve(eq,s)


bieg1 = 626;
bieg2 = 2.9693e+03;

c = roots(1 - (153622527682281473)/52432960749568 -  (49643196284691022137)/26216480374784 -  254294346000/763)
d =polyval(c, 1:0.001:10);

% d - bieg dolny


syms s;

a =   -15.2600;
b = 2.881e4;
c = 282;
%s = -460;
%d = 1100;
d = 6.811154576804347e+02;


ND1 = [3*a (2*a*(c+d) + 3*(b +a*c)) (d*c+c*b+(b+a*c)*2*(c+d)) ((b+a*c)*d*c + c*b*2*(c+d)) +c*c*b*d];
N1D = [2*a (2*a*(c+d)+b+a*c) (2*a*d*c +b +a*c) (d*c*(b+a*c)) 0];



nd2 = 3*a*s^4 + (2*a*(c+d) + 3*(b +a*c))*s^3 + (d*c+c*b+(b+a*c)*2*(c+d))*s^2 + ((b+a*c)*d*c + c*b*2*(c+d))*s +c*c*b*d;
dn2 = 2*a*s^4 + (2*a*(c+d)+b+a*c)*s^3 + (2*a*d*c +b +a*c)*s^2 + (d*c*(b+a*c))*s;

eq = (nd2 - dn2 ==0);
solve(eq,d)


dsol = 4.135418089007480e+02 ; 

b2 = 674;

dobry_bieg =1032;

coddd = 4.114459039579253e+03;



syms s d z
%s = -460;


Ns = (a*s +b)*(s+z);
Ds = (s^2 + c*s)*(s+d);

Ns1 = (2*a*s +b +a*c);
Ds1 = (3*s^2 + 2*s*(c+d) + d*c);


eq1 = (Ns*Ds1 - Ds*Ns1 ==0);
solve(eq,d)



roots([1 -(3311332)/763 (1477263218885439)/1600126976 (265632285219887)/6250496   -22827803635800325/223232 ])

roots()


klop =feedback(agh,1);
klop2 =feedback(7.34*agh*lead,1);
step(klop,klop2)


figure(8)

opt = timeoptions("cstprefs");
opt.Title.String = "Porównanie odpowiedzi skokowej układów";
step(klop, klop2,opt)
grid on
legend("Układ referncyjny", "Układ z korektorem LEAD")


syms p

0.001 = 141p/(14450*(p/50));

14450*(p/50)*0.001 = 141p;

solve(14450*(p/50)*0.001 == 141*p,p)







