%Conjugate Gradient
%for Example 10.3 or any Three variable function
clc;
clear;
close all;

syms f(x, y, z)
f(x, y, z) = input('Enter the Function: '); % 1.5*x^2+2*y^2+1.5*z^2+x*z+2*y*z-3*x-z

x0 = zeros(1,3);
for i=1:3
    x0(i) = input('elements = '); % [0 0 0]
end

%Q
q11 = diff(diff(f,x),x);
q22 = diff(diff(f,y),y);
q33 = diff(diff(f,z),z);
q12 = diff(diff(f,x),y);
q13 = diff(diff(f,x),z);
q23 = diff(diff(f,y),z);
Q = [q11,q12,q13;
    q12,q22,q23;
    q13,q23,q33];

j = 1;

gf = gradient(f);
gf0 = gf(x0(1), x0(2), x0(3));
d0 = -gf0;
a0 = -(gf0.'*d0)/(d0.'*Q*d0);
for i=1:3
    x1 = x0.' + a0*d0;
    x1 = formula(x1);
    fprintf('x(%g) = [%f, %f, %f]\t f(x%g) = %f\n',[j x1(1) x1(2) x1(3) j f(x1(1),x1(2),x1(3))])
    j = j+1;
    gf1 = gf(x1(1), x1(2), x1(3));
    if gf1 == 0
        break
    end
    beta = (gf1.'*Q*d0)/(d0.'*Q*d0);
    d = -gf1 + beta*d0;
    a = -(gf1.'*d)/(d.'*Q*d);
    a0 = formula(a);
    x0 = x1.';
    d0 = formula(d);
end
