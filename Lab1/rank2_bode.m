function J =rank2_bode(X)

global F Y P Z;

Ls = [X(1)];
Ms = [X(2) X(3) 1];
[m, p, w] = bode(Ls, Ms, F);

zesp = m .* exp(1i*deg2rad(p)); % zamiana amplitudy i fazy na liczby zespolone

% J = sum((P.' - p).^2 + (Y.' - m).^2); % Dopasowanie do obu charakterystyk
% J = sum((P.' - p).^2);                 % Dopasowanie do charakterystyki fazowej
% J = sum((Y.' - m).^2);                 % Dopasowanie do charakterystyki amplitudowej
J = sum((imag(Z.' - zesp)).^2 + (real(Z.' - zesp).^2)) % Super fajna metoda na liczbach zespolonych

end