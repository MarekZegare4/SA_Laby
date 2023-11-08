function J = B_bode_f_C(X)

global F3 Z3;

Ls = [X(1) X(2)];
Ms = [X(3) X(4) X(5)];
Tf = tf([Ls],[Ms]);
[m, p, w] = bode(Tf, F3);

zesp = m(:) .* exp(1i*deg2rad(p(:))); % zamiana amplitudy i fazy na liczby zespolone

% J = sum((P.' - p).^2 + (Y.' - m).^2); % Dopasowanie do obu charakterystyk
% J = sum((P.' - p).^2);                 % Dopasowanie do charakterystyki fazowej
% J = sum((Y_b.' - m).^2);                 % Dopasowanie do charakterystyki amplitudowej
J = sum((imag(Z3.' - zesp)).^2 + (real(Z3.' - zesp).^2)); % Super fajna metoda na liczbach zespolonych
end