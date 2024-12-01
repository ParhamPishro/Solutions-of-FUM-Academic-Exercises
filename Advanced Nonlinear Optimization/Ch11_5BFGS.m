%BFGS Algorithm
%for Example 11.4 or any Two variable function
clc;
clear;
close all;

syms f(x, y)
f(x, y) = input('Enter the Function: '); % x*((5*x)/2-(3*y)/2)-y-y*((3*x)/2-y)+log(pi)

x0 = zeros(1,2);
for i=1:2
    x0(i) = input('elements = '); % [0 0]
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

    %4
    dx0 = a0*d0; %x1-x0
    g1 = Q*x1 - b;
    dg0 = g1 - g0;
    numerator1 = dg0.'*H0*dg0;
    denominator1 = dg0.'*dx0;
    fraction1 = 1 + (numerator1 / denominator1);
    numerator2 = dx0*dx0.';
    denominator2 = dx0.'*dg0;
    fraction2 = numerator2 / denominator2;
    numerator3 = (dx0*dg0.'*H0)+(H0*dg0*dx0.');
    denominator3 = dg0.'*dx0;
    fraction3 = numerator3 / denominator3;
    H1 = H0 + fraction1 * fraction2 - fraction3;
    
    if g1 == 0
        break
    end

    x0 = x1;
    H0 = H1;
end
disp('H2 = inv(Q) =')
disp(H1)