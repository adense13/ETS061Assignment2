clc
clear all

c = [-1;
     -5];
A = [2 -1;
     -1 1;
     1 4];
 b = [double(intmax);
      double(intmax);
      double(intmax)];
 lb = [0;
       0];
 %options = optimoptions('intlinprog', 'Display', 'iter');
 options = optimoptions('intlinprog', 'Display', 'off');
 intcon = [1;
           2];
[x, fval, exitflag, output] = intlinprog(c', intcon, A, b, [], [], lb, [], options)

z=(-c).*x;

%2.b
options_l = optimoptions('linprog', 'Algorithm', 'dual-simplex', 'Display', 'off');
[x_l,fval_l,exitflag_l,output_l,lambda_l] = linprog(c', A, b, [], [], lb, [], [], options_l);
z_l=(-c).*x_l;
