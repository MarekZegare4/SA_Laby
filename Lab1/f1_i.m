function [model, uklad] = f1_i(csv_data, skok_czasu, dlugosc_czasu, gestosc_probek)

    data = csvread(csv_data , 2, 0);
    Ts = (0:skok_czasu:dlugosc_czasu)
    T = (0:1:dlugosc_czasu);
    Y = data(100:gestosc_probek:1200, 2)
    Y = data(100:gestosc_probek:1200, 2) + abs(Y(1))

    Xo = [1.1 1];
    X = fminsearch('rank1', Xo);
    Ls = [X(1)];
    Ms = [X(2) 1];
    Ys = step(Ls, Ms, Ts);
    
    model = [Ts; Ys];
    uklad = [T; Y];
end