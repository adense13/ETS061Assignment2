


%%
syms x1 x2 x3 x4 x5
z = (4*x1)+(3*x2)+(2*x3)+(2*x4)+(1*x5);
eqn1 = x1 <= 16;
eqn2 = x2 <= 2;
eqn3 = (x1+x2+x3) <= 34;
eqn4 = (x4+x5) <= 28;
eqn5 = 2*x1 <= 36;
eqn6 = (2*x2)+(2*x3)+(2*x4)+x5 <= 216;
eqn7 = (0.2*x1) + x2 + (0.5*x4) <= 18;
[A,B] = equationsToMatrix([eqn1, eqn2, eqn2, eqn4, eqn5, eqn6, eqn7], [x1, x2, x3, x4, x5])

%%

clc
clear all

c = [-4 -3 -2 -2 -1];

A = [2 0 0 0 0;
     0 2 2 2 1;
     0.2 1 0 0.5 0;
     1 0 0 0 0;
     0 0 1 0 0;
     1 1 1 0 0;
     0 0 0 1 1
     ];
 
 b = [36;
      216;
      18;
      16;
      2;
      34;
      28];
  
  b_incr = [0;
      0;
      0;
      0;
      0.6;
      0;
      0];
  
 lb = zeros(5, 1)
 %options = optimoptions('linprog', 'Algorithm', 'interior-point', 'Display', 'iter');
 %options = optimoptions('linprog', 'Algorithm', 'interior-point', 'Display', 'off');
 %options = optimoptions('linprog', 'Algorithm', 'dual-simplex', 'Display', 'iter');
 options = optimoptions('linprog', 'Algorithm', 'dual-simplex', 'Display', 'off');
 [x,fval,exitflag,output,lambda] = linprog(c', A, b, [], [], lb, [], [], options)
 
 %1d
 
 oldProfit = 0
 newProfit = -c*x
 
 profitArray = [newProfit]
 
 while true
    oldProfit = newProfit;
    
    b = b + b_incr;
    
    
    [x,fval,exitflag,output,lambda] = linprog(c', A, b, [], [], lb, [], [], options);
    newProfit = -c*x
    profitArray=[profitArray newProfit];
    %b_incr = b_incr+b_incr;
    if((newProfit-oldProfit) < 0.1), break, end
 end
plot(profitArray)
ylabel('Total Profit (1000 SEK)')
% 1e
b = [36;
      216;
      18;
      16;
      2;
      34;
      28]

  
[x,fval,exitflag,output,lambda] = linprog(c', A, b, [], [], lb, [], [], options)
startC = c;
startX = x;
oldX = x;
price_incr = -0.01;
alfa = 4;
beta = 4;
x
while true
    c = c - [price_incr 0 0 0 0];
    alfa = alfa + price_incr;
    [x,fval,exitflag,output,lambda] = linprog(c', A, b, [], [], lb, [], [], options);
    if(isequal(oldX, x) == false), break, end
    oldX = x;
end
alfa

x = startX;
c = startC;
while true
    c = c + [price_incr 0 0 0 0];
    beta = beta - price_incr;
    [x,fval,exitflag,output,lambda] = linprog(c', A, b, [], [], lb, [], [], options);
    if(isequal(oldX, x) == false), break, end
    oldX = x;
end
beta