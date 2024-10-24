%Golden Section Search
%for Example 7.1 or any Single variable function
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

rho = (3-sqrt(5))/2;
N = ceil(log(uncert/(b0-a0))/log(1-rho));

l=a0;
r=b0;
a = l + (1-rho)*(r-l);
lower = 'a';
f_a = f(a);

for i=1:N
    if lower =='a'
        b = a;
        f_b = f_a;
        a = l + (rho)*(r-l);
        f_a = f(a);
    else
        a = b;
        f_a = f_b;
        b = l + (1-rho)*(r-l);
        f_b = f(b);
    end

    if f_a<f_b
        r=b;
        lower = 'a';
    else
        l=a;
        lower = 'b';
    end
    fprintf('Interval(%g) = [%f,%f]\tf(a,b)=[%f,%f]\n',[i l r f(l) f(r)])
end
