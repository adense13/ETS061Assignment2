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
  
 lb = zeros(5, 1);
 
options = optimoptions('linprog', 'Algorithm', 'dual-simplex', 'Display', 'off');
[x,fval,exitflag,output,lambda_1b] = linprog(c', A, b, [], [], lb, [], [], options);
 
oldProfit = 0;
profit = -c*x

profitArray = [profit];
demandArray = [b(5)];
shadowPriceArray = [20000];
 
 while true
    oldProfit = profit;
    
    b = b + b_incr;
    
    [x,fval,exitflag,output,lambda_1d] = linprog(c', A, b, [], [], lb, [], [], options);
    profit = -c*x
    profitArray=[profitArray profit];
    demandArray=[demandArray b(5)];
    shadowPriceArray=[shadowPriceArray lambda_1d.ineqlin(5)];
    if((profit-oldProfit) < 0.1), break, end
 end
plot(demandArray, profitArray*1000*10000)
ylabel('Total Profit (SEK)')
xlabel('Demand')