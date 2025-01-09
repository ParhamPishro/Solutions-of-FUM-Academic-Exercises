%Secant Method
%for Example 7.5 or any Single variable function
clc;
clear;
close all;

syms f(x)
f(x) = input('Enter the Function: '); %x^3-12.2*x^2+7.45*x+42

x_1 = input('Enter the Start Point (x(-1)): '); %13
x0 = input('Enter the Start Point (x(0)): '); %12
acc = input('Enter the Accuracy: '); %0.1

df = diff(f);

i = 1;
x1 = (df(x0)*x_1-df(x_1)*x0)/(df(x0)-df(x_1));
fprintf('x(1)=%f   f(x1)=%f\n',[x1 f(x1)])

while abs(x1-x0) > acc
    x0 = x1;
    x1 = (df(x0)*x_1-df(x_1)*x0)/(df(x0)-df(x_1));
    i = i+1;
    fprintf('x(%g)=%f   f(x%g)=%f\n',[i x1 i f(x1)])
end

