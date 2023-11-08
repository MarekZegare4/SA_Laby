function J =rank1_to_f(X)

global T Y_i;

Ls = [X(1)];
Ms = [X(2) 1];
Tf = tf(Ls, Ms, 'InputDelay', X(3));
Ys = step(Tf, T);
J = sum((Ys - Y_i).^2);

end