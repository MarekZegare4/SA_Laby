function J =Skok_D_f_3(X)

global T3 Y3;

Ls = [X(1)];
Ms = [X(2) X(3)];
Ys = step(Ls, Ms, T3);
J = sum((Ys - Y3).^2);

end