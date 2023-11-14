function J =Skok_D_f_2(X)

global T2 Y2;

Ls = [X(1)];
Ms = [X(2) X(3)];
Ys = step(Ls, Ms, T2);
J = sum((Ys - Y2).^2);

end