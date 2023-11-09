function J =Skok_B_f_1(X)

global T1 Y1;

Ls = [X(1) X(2)];
Ms = [X(3) X(4) X(5)];
Ys = step(Ls, Ms, T1);
J = sum((Ys - Y1).^2);

end