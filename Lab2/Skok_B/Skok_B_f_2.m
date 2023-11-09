function J =Skok_B_f_2(X)

global T2 Y2;

Ls = [X(1) X(2)];
Ms = [X(3) X(4) X(5)];
Ys = step(Ls, Ms, T2);
J = sum((Ys - Y2).^2);

end