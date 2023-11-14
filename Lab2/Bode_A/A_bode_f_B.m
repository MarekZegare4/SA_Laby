function J = A_bode_f_B(X)

global DANE ZFULL Ms k

Ls = [X(1)*k(2)];
Tf = feedback(tf([Ls],[Ms]), 1);
[m, p, w] = bode(Tf, DANE(4));

zesp = m(:) .* exp(1i*deg2rad(p(:))) % zamiana amplitudy i fazy na liczby zespolone

% J = sum((P.' - p).^2 + (Y.' - m).^2); % Dopasowanie do obu charakterystyk
% J = sum((DANE(6).' - p).^2);                 % Dopasowanie do charakterystyki fazowej
% J = sum((Y_b.' - m).^2);                 % Dopasowanie do charakterystyki amplitudowej
 J = sum((imag(ZFULL(2).' - zesp)).^2 + (real(ZFULL(2).' - zesp).^2)); % Super fajna metoda na liczbach zespolonych
end