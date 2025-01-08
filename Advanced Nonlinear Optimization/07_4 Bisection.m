%Bisection Method
%for Example 7.3 or any Single variable function
clc;
clear;
close all;

syms f(x)
f(x) = input('Enter the Function: '); %x^4-14*x^3+60*x^2-70*x

a0 = input('Start of Interval: '); %0
b0 = input('End of Interval: '); %2
uncert = input('Enter the Uncentaintry: '); %0.3

x = a0:0.01:b0;
y = f(x);
plot(x,y)
xlabel('x');
ylabel('f(x)');

N = ceil(log(uncert/(b0-a0))/log(0.5));

x0 = (a0+b0)/2;
df = diff(f);

for i=1:N
    if df(x0)>0
        b0 = x0;
    else
        a0 = x0;
    end
    x0 = (a0+b0)/2;
    fprintf('Interval(%g) = [%f,%f]\tf(a,b)=[%f,%f]\n',[i a0 b0 f(a0) f(b0)])
end
