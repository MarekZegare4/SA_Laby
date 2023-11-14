function J =Skok_D_f_1(X)

global T1 Y1;

Ls = [X(1)];
Ms = [X(2) X(3)];
Ys = step(Ls, Ms, T1);
J = sum((Ys - Y1).^2);

end