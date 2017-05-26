clc
clear all

c = [-1;
     -5];
A = [2 -1;
     -1 1;
     1 4];
 b = [4;
      1;
      12];
 lb = [0;
       0];
 %options = optimoptions('intlinprog', 'Display', 'iter');
 options = optimoptions('intlinprog', 'Display', 'off');
 intcon = [1;
           2];
[x, fval, exitflag, output] = intlinprog(c', intcon, A, b, [], [], lb, [], options)

z=(-c)'*x;

%2.b
options_l = optimoptions('linprog', 'Algorithm', 'dual-simplex', 'Display', 'off');
[x_l,fval_l,exitflag_l,output_l,lambda_l] = linprog(c', A, b, [], [], lb, [], [], options_l);
x_l_rounded = round(x_l);
z_l=(-c).*x_l;

x_l_collection = [];
z_l_collection = [];
for i = 1:4
    if(i == 1)
        x_l_rounded = [floor(x_l(1)), floor(x_l(2))];
    elseif (i==2)
        x_l_rounded = [ceil(x_l(1)), ceil(x_l(2))];
    elseif (i==3)
        x_l_rounded = [ceil(x_l(1)), floor(x_l(2))];
    else
        x_l_rounded = [floor(x_l(1)), ceil(x_l(2))];
    end
    xMulA = x_l_rounded .* A
    xMulASummed = sum(xMulA, 2)
    
    satisfiesEquation = true;
    for j = 1:3
        if(xMulASummed(j) > b(j))
            satisfiesEquation = false;
        end
    end
    if(satisfiesEquation == true)
        x_l_collection=[x_l_collection x_l_rounded];
        z_l_collection=[z_l_collection ((-c(1))*x_l_rounded(1) + (-c(2))*x_l_rounded(2))];
    end
end
%See x_l_collection and z_l_collection for seeing which answer we got
