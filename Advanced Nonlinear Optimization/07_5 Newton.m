%Newton's Method
%for Example 7.4 or any Single variable function
clc;
clear;
close all;

syms f(x)
f(x) = input('Enter the Function: '); %0.5*x^2-sin(x)

x0 = input('Enter the Start Point: '); %0.5
acc = input('Enter the Accuracy: '); %10^(-5)

df = diff(f);
ddf = diff(f,2);

x1 = x0 - (df(x0)/ddf(x0));
i=1;

fprintf('x(1)=%f\tf(x1)=%f\n',[x1 f(x1)])
while abs(x1-x0)>acc
    x0 = x1;
    x1 = x0 - (df(x0)/ddf(x0));
    i = i+1;
    fprintf('x(%g)=%f\tf(x%g)=%f\n',[i x1 i f(x1)])
end
