function J =Skok_B_f_3(X)

global T3 Y3;

Ls = [X(1) X(2)];
Ms = [X(3) X(4) X(5)];
Ys = step(Ls, Ms, T3);
J = sum((Ys - Y3).^2);

end