% MIP Problem Example
% min  x1 + x2
% s.t. 2 x1 + x2 >= 4
%      x1 + 3 x2 >= 6
%      0 <= x1 <= 10, integer
%      0 <= x2 <= 20, integer

% set input data
f=[1 1]';
A=[-2 -1;
   -1 -3];
b=[-4 -6]';
Aeq=[];
beq=[];
lb=[0 0]';
ub=[10 20]';
xint=[1 1]'; %specifying whether a variable is integer: 1->integer, 0->continuous

% call MIP solver
[x,fval,exitflag,output,lambda]=mipprog(f,A,b,Aeq,beq,lb,ub,xint);

% output results
x

% objective function value
fval