%Rank One Correction Formula
%for Example 11.1 or any Two variable function
clc;
clear;
close all;

syms f(x, y)
f(x, y) = input('Enter the Function: '); % x^2+0.5*y^2+3

x0 = zeros(1,2);
for i=1:2
    x0(i) = input('elements = '); % [1 2]
end
x0 = x0.';

%1
Q = hessian(f);
Q = Q(x0(1), x0(2));
H0 = eye(2);
bx = diff(f,x);
bx = bx(0,0);
by = diff(f,y);
by = by(0,0);
b = -[bx; by];

for i=1:2

    %2
    g0 = Q*x0 - b;
    d0 = -H0*g0;

    %3
    a0 = -(g0.'*d0)/(d0.'*Q*d0);
    x1 = x0 + a0*d0;
    x_show = formula(x1);
    fprintf('x(%g) = [%f, %f]\t f(x%g) = %f\n',[i x_show(1) x_show(2) i f(x1(1), x1(2))])
    %

    %4
    dx0 = a0*d0;
    g1 = Q*x1 - b;
    dg0 = g1 - g0;
    numerator = (dx0-H0*dg0)*(dx0-H0*dg0).';
    denominator = dg0.'*(dx0 - H0*dg0);
    H1 = H0 + (numerator)/(denominator);
    
    if g1 == 0
        break
    end

    x0 = x1;
    H0 = H1;
end