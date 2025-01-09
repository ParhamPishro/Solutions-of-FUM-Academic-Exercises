%Gradient Descent
%for Example 8.1 or any Three variable function
clc;
clear;
close all;

syms f(x, y, z)
f(x, y, z) = input('Enter the Function: '); % (x-4)^4+(y-3)^2+4*(z+5)^4

x0 = zeros(1,3);
for i=1:3
    x0(i) = input('elements = '); % [4 2 -1]
end

gf = gradient(f);
%%%%%%%%%%%%%%%%%%%%%%%%%%
j = 1;
while true
    gf0 = gf(x0(1), x0(2), x0(3));
    fprintf('gradient f(x%g) = [%f, %f, %f]\n',[j-1 gf0(1) gf0(2) gf0(3)])
    syms f_alpha(a)
    var = x0.'-a*gf0;
    f_alpha(a) = f(var(1), var(2), var(3));
    
    %Bisection Method
    a0_bi = -100;
    b0_bi = 100;
    uncert = 0.0001;
    N = ceil(log(uncert/(b0_bi-a0_bi))/log(0.5));
    x0_bi = (a0_bi+b0_bi)/2;
    df = diff(f_alpha);
    for i=1:N
        if df(x0_bi)>0
            b0_bi = x0_bi;
        else
            a0_bi = x0_bi;
        end
        x0_bi = (a0_bi+b0_bi)/2;
    end
    a = x0_bi;

    x1 = x0 - (a*gf0).';
    fprintf('x(%g) = [%f, %f, %f]\n',[j x1(1) x1(2) x1(3)])
    if norm(gf0) < 0.001
        break
    else
        x0 = x1;
    end
    j = j+1;
end