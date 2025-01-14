%The Simulated Annealing Algorithm
%for any Single variable function
clc;
clear;
close all;

syms f(x)
f(x) = input('Enter the Function: '); % 3*sin(x)+(0.1*x-3).^2
a = input('Start of Interval: '); % 0
b = input('End of Interval: '); % 60

s0 = a + rand*(b-a);
r = 10; % epsilon=r
s=s0;
e = f(s);
sbest = s; ebest = e;
T = 10;

for i=1:1000
    snew = s + (rand-0.5)*2*r;
    enew = f(snew);
    deltaE = enew - e;
    if deltaE < 0 || rand < exp(-deltaE/T)
        s = snew; e = enew;
        if enew < ebest
            sbest = snew; ebest = enew;
        end
    end
    T = 0.99*T;
end
fprintf('min=%f , f_min=%f\n',[sbest ebest])