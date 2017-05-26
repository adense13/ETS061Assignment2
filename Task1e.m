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
  
lb = zeros(5, 1);
 
options = optimoptions('linprog', 'Algorithm', 'dual-simplex', 'Display', 'off');
[x,fval,exitflag,output,lambda_1ea] = linprog(c', A, b, [], [], lb, [], [], options); %to reset our x values
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
    [x,fval,exitflag,output,lambda_1ea] = linprog(c', A, b, [], [], lb, [], [], options);
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
    [x,fval,exitflag,output,lambda_1eb] = linprog(c', A, b, [], [], lb, [], [], options);
    if(isequal(oldX, x) == false), break, end
    %if(beta > 10), break, end %can be used to break otherwise infinite loop
    oldX = x;
end
beta %upper bound