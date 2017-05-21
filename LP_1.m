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

%--------------------------------
%1b------------------------------
%--------------------------------

%options = optimoptions('linprog', 'Algorithm', 'interior-point', 'Display', 'iter');
%options = optimoptions('linprog', 'Algorithm', 'interior-point', 'Display', 'off');
%options = optimoptions('linprog', 'Algorithm', 'dual-simplex', 'Display', 'iter');
options = optimoptions('linprog', 'Algorithm', 'dual-simplex', 'Display', 'off');
[x,fval,exitflag,output,lambda] = linprog(c', A, b, [], [], lb, [], [], options);
x

%--------------------------------
%1d------------------------------
%--------------------------------

oldProfit = 0;
profit = -c*x

profitArray = [profit]
 
 while true
    oldProfit = profit;
    
    b = b + b_incr;
    
    [x,fval,exitflag,output,lambda] = linprog(c', A, b, [], [], lb, [], [], options);
    profit = -c*x
    profitArray=[profitArray profit];
    if((profit-oldProfit) < 0.1), break, end
 end
plot(profitArray)
ylabel('Total Profit (1000 SEK)')

%--------------------------------
%1e------------------------------
%--------------------------------
%First let's start by resetting all values to their initial state
b = [36;
     216;
     18;
     16;
     2;
     34;
     28]; %reset our b matrix, since we messed with that in 1d
  
[x,fval,exitflag,output,lambda] = linprog(c', A, b, [], [], lb, [], [], options); %to reset our x values
startC = c; %values to reset to for the beta loop
startX = x; %values to reset to for the beta loop

%Now let's start with the actual task 1e
oldX = x;
price_incr = -0.01;
alfa = 4;
beta = 4;

%let's find the lower interval bound
while true
    c = c - [price_incr 0 0 0 0];
    alfa = alfa + price_incr;
    [x,fval,exitflag,output,lambda] = linprog(c', A, b, [], [], lb, [], [], options);
    if(isequal(oldX, x) == false), break, end
    oldX = x;
end
alfa %lower bound

%let's find the upper interval bound
x = startX;
c = startC;
while true
    c = c + [price_incr 0 0 0 0];
    beta = beta - price_incr;
    [x,fval,exitflag,output,lambda] = linprog(c', A, b, [], [], lb, [], [], options);
    if(isequal(oldX, x) == false), break, end
    %if(beta > 10), break, end %can be used to break loop when beta gets way too big
    oldX = x;
end
beta %upper bound