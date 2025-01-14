%The Nelder-Mead Simplex Algorithm
%for any Two variable function
clc;
clear;
close all;

syms f(x, y)
f(x, y) = input('Enter the Function: '); % x-y+2*x^2+2*x*y+y^2

alpha = input('Enter alpha(Suggested 1): ');
beta = input('Enter beta(Suggested 0.5): ');
gamma = input('Enter gamma(Suggested 2): ');
delta = input('Enter delta(Suggested 1): ');
epsilon = input('Enter epsilon: '); % 0.2

x1 = zeros(1,2);
for i=1:2
    x1(i) = input('elements = '); % [4 4]
end
x2 = x1 + [delta 0];
x3 = x1 + [0 delta];

x = [x1; x2; x3];

f_list = [f(x(1,1),x(1,2)), f(x(2,1),x(2,2)), f(x(3,1),x(3,2))];
fprintf('\nx1=%f,%f\tx2=%f,%f\tx3=%f,%f\tf(x1)=%f\tf(x2)=%f\tf(x3)=%f\n\n', ...
    [x1(1) x1(2) x2(1) x2(2) x3(1) x3(2) f_list(1) f_list(2) f_list(3)])

Q = std(f_list);

i=1;

while Q > epsilon
    fprintf('Iteration %g)\n',i)
    % Reflection
    [fx_l, x_l] = min(f_list);
    [fx_h, x_h] = max(f_list);
    x_o = 0.5*(x(1,:) + x(2,:) + x(3,:) - x(x_h,:));
    f(x_o(1), x_o(2));
    x_r = (1+alpha)*x_o - alpha*x(x_h,:);
    f(x_r(1), x_r(2));
    fprintf('xl=%g\txh=%g\txo=%f,%f f(xo)=%f\txr=%f,%f f(xr)=%f\n', ...
        [x_l x_h x_o(1) x_o(2) f(x_o(1), x_o(2)) x_r(1) x_r(2) f(x_r(1), x_r(2))])

    if f(x_r(1), x_r(2)) < fx_h
        % Expansion
        x_e = gamma*x_r + (1-gamma)*x_o;
        f(x_e(1), x_e(2));

        if f(x_e(1), x_e(2)) < fx_l
            x(x_h,:) = x_e;
        else
            x(x_h,:) = x_r;
        end
    end

    if (f(x_r(1), x_r(2)) > fx_l) && (f(x_r(1), x_r(2)) > fx_h)
        %Contraction
        x_e = beta*x(x_h,:) + (1-beta)*x_o;
        f(x_e(1), x_e(2));

        if f(x_e(1), x_e(2)) < fx_h
            x(x_h,:) = x_e;
        end
    end

    fprintf('xe=%f,%f\tf(xe)=%f\n',[x_e(1) x_e(2) f(x_e(1), x_e(2))])
    fprintf('x1=%f,%f\tx2=%f,%f\tx3=%f,%f\tf(x1)=%f\tf(x2)=%f\tf(x3)=%f\n', ...
        [x(1,1) x(1,2) x(2,1) x(2,2) x(3,1) x(3,2) f_list(1) f_list(2) f_list(3)])


    f_list = [f(x(1,1),x(1,2)), f(x(2,1),x(2,2)), f(x(3,1),x(3,2))];
    Q = std(f_list);
    fprintf('Q=%f \n\n', Q)

    i=i+1;

end