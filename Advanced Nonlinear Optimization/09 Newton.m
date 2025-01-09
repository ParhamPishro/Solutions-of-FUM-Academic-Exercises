%Newtos's Method
%for Example 9.1 or any Four variable function
clc;
clear;
close all;

syms f(x1, x2, x3, x4)
f(x1, x2, x3, x4) = input('Enter the Function: '); % (x1+10*x2)^2+5*(x3-x4)^2+(x2-2*x3)^4+10*(x1-x4)^4

x0 = zeros(1,4);
for i=1:4
    x0(i) = input('elements = '); % [3 -1 0 1]
end

gf = gradient(f);
hf = hessian(f);
%%%%%%%%%%%%%%%%%%%%%%%%%%
j = 1;
while true
    gf0 = gf(x0(1), x0(2), x0(3), x0(4));
    fprintf('gradient f(x%g) = [%f, %f, %f, %f]\n',[j-1 gf0(1) gf0(2) gf0(3) gf0(4)])
    
    hf0 = hf(x0(1), x0(2), x0(3), x0(4));
    fprintf('hessian f(x%g) =\n',j-1)
    disp(hf0)
    
    hf0_1 = inv(hf0);
    fprintf('inverse of hessian f(x%g) =\n',j-1)
    disp(hf0_1)

    hfg0 = hf0_1 * gf0;
    fprintf('inverse of hessian f(x%g) * gradient f(x%g) =\n',[j-1 j-1])
    disp(hfg0)
    
    x1 = x0 - hfg0.';
    fprintf('x(%g) = [%f, %f, %f, %f]\t f(x%g) = %f\n\n',[j x1(1) x1(2) x1(3) x1(4) j f(x1(1),x1(2),x1(3),x1(4))])
    if norm(gf0) < 0.001
        break
    else
        x0 = x1;
    end
    j = j+1;

end