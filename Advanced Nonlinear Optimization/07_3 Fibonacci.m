%ّFibonacci Method
%for Example 7.2 or any Single variable function
clc;
clear;
close all;

syms f(x)
f(x) = input('Enter the Function: '); %x^4-14*x^3+60*x^2-70*x

a0 = input('Start of Interval: '); %0
b0 = input('End of Interval: '); %2
uncert = input('Enter the Uncentaintry: '); %0.3
epsilon = input('Enter the Epsilon: '); %0.05

x = a0:0.01:b0;
y = f(x);
plot(x,y)
xlabel('x');
ylabel('f(x)');


F(1)=1;
F(2)=1;

%rho = (3-sqrt(5))/2;
N = 0;
while F(N+2) < (1+2*epsilon)*(b0-a0)/uncert
    F(N+3) = F(N+2)+F(N+1);
    N = N+1;
end

l=a0;
r=b0;
a = l + (F(N+1)/F(N+2))*(r-l);
lower = 'a';
f_a = f(a);

for i=1:N
    if i~=N
        rho = 1-F(N+2-i)/F(N+3-i);
    else
        rho=0.5-epsilon;
    end

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
