%The Naive Random Search Algorithm
%for any Single variable function
clc;
clear;
close all;

syms f(x)
f(x) = input('Enter the Function: ');
a = input('Start of Interval: ');
b = input('End of Interval: ');

format long
x0 = a + (b-a)*rand(1);
for i=1:1000
    x1 = a + (b-a)*rand(1);
    if f(x1) < f(x0)
        x0 = x1;
        fprintf('Iteration %g: min=%f\n',[i x0])
    end
end