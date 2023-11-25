% -- A --
% 12 od 195
% 13 od 195
% 14 od 435

% -- B --
% 15 od 420
% 16 od 430
% 17 od 190

% -- D -- 
% 18 od 195
% 19 od 195
% 20 od 195

data = csvread("CSV/csv/NewFile4.csv",2,0)
ch1 = data(1:1200, 1)
ch2 = data(1:1200, 2)
%ch1 = ch1 + abs(ch1(1))
%ch2 = ch2 + abs(ch2(2))
plot(ch1)
hold on
plot(ch2)
hold off