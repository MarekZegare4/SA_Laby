function wynik = min1rzad(X)

global tm tachom


L = [X(1)]; %kp
M = [X(2) 1]; %X(2) = Ts

sys = tf(L,M);

opt = stepDataOptions("StepAmplitude",4.08);

Ys = step(sys,tm, opt);
wynik = sum((tachom-Ys).^2);

end