% ABTRONIC BEZ WODY
abTzbw = [50.2 70.5 100.6 120.2 150.5 170.7 201.9 220.7 253];
abTpbw = [50.1 69 101.2 121.5 152.2 173 206.7 224.5 257.6];

%ABTRONIC Z PARA
abTzw = [50.2 70.1 100.3 120.2 150.6 170.8 202.1 221.4 252];
abTpw = [50.5 66.3 100.6 119.7 151 171.5 200.7 223 255];

figure(1)
plot(abTzbw, abTpbw, 'o--', abTzw, abTpw, 'o--')
xlabel("Tz [°C]");
ylabel("Tp [°C]")
title("Abatronic AB-8855")
legend("Bez pary wodnej", "Z parą wodną")
grid on;


% CHY BEZ WODY
chyTzbw = [50.2 70.1 100.1 120.7 150.5 171.9 201.6 223 252];
chyTpbw = [45 59.5 82 96.5 120 138 163 181 202];

%CHY Z PARA
chyTzw = [50.2 70.1 100.1 120.3 150.4 172 201.3 222.9 252];
chyTpw = [44 58 81 93.5 117.5 134.5 162.5 177.5 197];

figure(2)
plot(chyTzbw, chyTpbw, 'o--', chyTzw, chyTpw, 'o--')
xlabel("Tz [°C]");
ylabel("Tp [°C]")
title("CHY 314P")
legend("Bez pary wodnej", "Z parą wodną")
grid on;


d = [0.05 0.1 0.15 0.2 0.25 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1];
abTp = [263.2 262 260.7 258.2 257.6 255.7 252.8 253.3 248.8 247.1 242.3 235.7 224];
chyTp = [251 245 238 229 224 217 203 190 175.5 165.5 154.5 140 131.5]

figure(3)
plot(d, abTp, 'o--', d, chyTp, 'o--')
xlabel("d [m]");
ylabel("Tp [°C]")
title("Tz [°C] = 250")
legend("Abatronic AB-8855", "CHY 314P")
grid on;
