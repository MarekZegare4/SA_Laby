function J = A_bode_f_A(X)

global DANE ZFULL Ms k

Ls = [X(1)];
Tf = feedback(tf([Ls],[Ms]), 1);
[m, p, w] = bode(Tf, DANE(1));

zesp = m(:) .* exp(1i*deg2rad(p(:))) % zamiana amplitudy i fazy na liczby zespolone

% J = sum((P.' - p).^2 + (Y.' - m).^2); % Dopasowanie do obu charakterystyk
% J = sum((DANE(3).' - p(:)).^2);                 % Dopasowanie do charakterystyki fazowej
% J = sum((DANE(2).' - m(:)).^2);                 % Dopasowanie do charakterystyki amplitudowej
 J = sum((imag(ZFULL(1).' - zesp)).^2 + (real(ZFULL(1).' - zesp).^2)); % Super fajna metoda na liczbach zespolonych
end