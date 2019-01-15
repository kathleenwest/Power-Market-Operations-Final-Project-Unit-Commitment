% MATLAB Code – Main Program to formulate unit commitment for a non-convex function
% Generator # 1 Information
noload = [200];
startupcost=[100];
shutdowncost=[50];
price = [20 25 24 23];
quantity = [40 60 80 40];
NT = [24];
PMIN= [100];
PMAX= [220];
QSC = [15];
MSR = [2];
RU = [40];
RD = [50];
D =  [175.19 165.15 158.67 154.73 155.06 160.48 173.39 177.6 186.81 206.96 228.61 236.1 242.18 243.6 248.86 255.79 256 246.74 245.97 237.35 237.31 232.67 195.93 195.6];
SR = [2.63 2.48	2.38 2.32 2.33 2.4 2.6 2.85 3.09 3.26 3.43 3.54	3.63 3.66 3.73 3.84	3.84 3.7 3.69 3.56 3.56	3.41 3.02 2.95];
OR = [12.26	11.56 11.1 10.83 10.85 11.23 12.14 13.33 14.39 15.2	16 16.52 16.95 17.05 17.42 17.91 17.92 17.27 17.22 16.62 16.62 15.9	14.07 13.78];

% Create objective function, constraints, bounds, based on generator values
% listed above

[f,Aeq,beq,Aeinq,beinq,lb,ub,x]=generator(noload,startupcost,shutdowncost,price,quantity,NT,PMIN,PMAX,QSC,MSR,RU,RD,D,SR,OR);

A = Aeinq;
b = beinq;
xint = x;
clear Aeinq, clear beinq, clear x;

% Call MIP solver
[x,fval,exitflag,output,lambda]=mipprog(f,A,b,Aeq,beq,lb,ub,xint);

% output results
x

% objective function value
fval
