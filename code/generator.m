%generator  Makes generator objective function and constraints
%
%  SYNOPSIS: [f,Aeq,beq,Aeinq,beinq,lb,ub,x]=generator(noload,startupcost,shutdowncost,price,quantity, NT)
%
%  Determines type of price function (non-convex or convex)
%  Depending on type, makes objective function, equality constraints,
%  inequality constraints, lower bounds, upper bounds, and x
%  (integer/continous) array for 1 generator given a 1XN array for the
%  price, a 1XN array for the quantity, and a 1X1 array with the noload
%  cost, startup cost, and shut down cost. Everything else is dynamically created.
%  NT is the number of hours under study, other variables are defined.


function [f,Aeq,beq,Aeinq,beinq,lb,ub,x]=generator(noload,startupcost,shutdowncost,price,quantity,NT,PMIN,PMAX,QSC,MSR,RU,RD,D,SR,OR)

%
% Determine Function Type
%

% Dummy Variables
temp = price(1);
flag1 = 0;

for i=2:length(price)
if price(i) < temp
    flag1 = 1;
else
    temp = price(i);
end;
end;

%
% If flag1 = 1, this is a non-convex function (the price decreases)
% If flag1 = 2, this is a convex function, the price is non-decreasing
%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Non-Convex Function
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if flag1 == 1
    % Form non-convex functions    
    c = zeros(1,length(price));
    for i=1:length(c)
        c(i) = price(i);        
    end;    
    
    % generate p variables
    p = zeros(1,length(price));
    p(1) = 1;
    for i=1:length(p)
        p(i) = 1;
    end;
    
    % generate delta variables
    d = zeros(1,length(price));
    d(1) = 1;
    for i=1:length(d)
        d(i) = 1;
    end;   
    
    u = zeros(1,1+length(d));
    f = zeros(1,length(u));
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Objective function
    f1 = [noload 0 c f startupcost shutdowncost 0 0];
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    f = [];
    for i=1:NT
        f = [f f1];
    end;
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Equality constraints
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    e = zeros(1,length(d));
    e = [0 -1 p 0 e 0 0 0 0];
    Aeq = [];
    for i=1:NT
     Aeq = [Aeq e];
    end;
    
    beq = [0];
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Inequality contraints
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
     % this generates the constraint array
    %make temp array
    temp = zeros(1,length(price));
    t = [-1;1];
    s = [0;0];
    temp2 = [];
    for i=1:length(price)
      for j=1:length(price) 
         if i == 1
           if j ==1   
             temp2 = [t]; 
           else
             temp2 = [temp2 s];
           end;
         else
          
          if j == i 
            temp2 =  [temp2 t];
          else
            temp2  = [temp2 s]; 
          end;        
         end;   
      end;      
    end;  
temp2;
j=1;
k = length(price);
temp3 = [];
for i=1:length(price)
 temp3 = [temp3; temp2(1:2,j:k)];
 j = j + length(price);
 k = k + length(price);
end;
temp3;

mastermatrix = temp3;
deltamatrix = mastermatrix;

pcolumn = [zeros(1,length(mastermatrix))]';
scolumn = [zeros(1,length(mastermatrix))]';
ocolumn = [zeros(1,length(mastermatrix))]';
ycolumn = [zeros(1,length(mastermatrix))]';
zcolumn = [zeros(1,length(mastermatrix))]';
dcolumn = [zeros(1,length(mastermatrix))]';
ccolumn = [zeros(1,length(mastermatrix))]';
ucolumn = [0 -quantity(1) zeros(1,length(mastermatrix)-2)]';

% temp2(1:2,i:j)     
% temp2(1:2,1:3) i                  j = length(p)    
% temp2(1:2,4:6) i = i + length(p)  j = j + length(p)
% temp2(1:2,7:9) i = i + length(p)  j = j + length(p)

% add the zero column

mastermatrix = [ucolumn pcolumn mastermatrix dcolumn];

% add the delta values

for i=1:length(deltamatrix)
    for j =1:length(deltamatrix)/2
        deltamatrix(i,j) = 0;    
    end;
end;


% add delta values

for i=1:length(deltamatrix)
    for j =1:length(deltamatrix)/2
        if i == 1 && j == 1
            deltamatrix(i,j) = quantity(1);  
        else
           if i == length(deltamatrix) &&  j == length(deltamatrix)/2
             deltamatrix(i,j) = -quantity(length(quantity)); 
           else             
            if (j > 1 && j < length(deltamatrix)/2) && (i > 2 && i < length(deltamatrix)-1) 

                if (j*2 == i) || (j*2-1 == i)
                        if j*2 == i
                           deltamatrix(i,j) = -quantity (j);
                        else
                           deltamatrix(i,j) = quantity(j); 
                        end;
                else
                deltamatrix(i,j) = 0;                    
                end;
                    
                
            else                      
               
               deltamatrix(i,j) = 0;
           end;   
               
           end;   
            
        end;   
    end;
end;

    

mastermatrix = [mastermatrix deltamatrix ycolumn zcolumn scolumn ocolumn];    


Aeinq = [];

for i=1:NT   
    Aeinq = [Aeinq mastermatrix];
end;

beinq = zeros(1,2*length(quantity))';


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Start-up and Shut-down Indicators
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
n = 6*length(price);
m = length(Aeinq);

%Initialize first array to zero
Aeq2 = zeros(n,m);

for j=1:m
        for i=1:n
       if i == 1 && j == 1
           Aeq2(i,j) = -1;
           Aeq2(i+1,j) = 1;
       else
           if ((j == 2*length(price) +4) && i == 1)
           Aeq2(i,j) = 1;
           Aeq2(i,j+1) = -1;             
           else
           if (i >1 && (j > 2*length(price)+7))    
           Aeq2(i,j) = Aeq2(i-1,j-(2*length(price)+7));         
           else
           end;
           end;
           
       end;
        
        
    end;
end;

beq2 = zeros(1,6*length(price))';

% Add to master equality arrays
Aeq = [Aeq; Aeq2];
beq = [beq; beq2];


% Make Inequality arrays
n = 6*length(price);
m = length(Aeinq);

%Initialize first array to zero
Aeinq2 = zeros(n,m);

for j=1:m
     for i=1:n
           if ((j == 2*length(price)+4) && i == 1)
                Aeinq2(i,j) = 1;
                Aeinq2(i,j+1) = 1;             
           else
            if (i >1 && j > (2*length(price)+7))    
                Aeinq2(i,j) = Aeinq2(i-1,j-(2*length(price)+7));         
            else
            end;
           end;
     end;
end;

beinq2 = ones(1,6*length(price))';

% Add to master equality arrays
Aeinq = [Aeinq; Aeinq2];
beinq = [beinq; beinq2];


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Capacity constraints
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

n = 2*NT;
m = length(Aeq);

%Initialize first array to zero
Aeq2 = zeros(n,m);

for j=1:m
        for i=1:n
       if i == 1 && j == 2
           Aeq2(i,j) = PMIN;
           Aeq2(i+1,j) = -PMAX;
           Aeq2(i,j+1) = 1;
           Aeq2(i+1,j+1) = -1;
       else
           if (i >2 && j > (2*length(price)+7))    
           Aeq2(i,j) = Aeq2(i-2,j-(2*length(price)+7));         
           else
           end;
           
       end;
        
        
    end;
end;

beq2 = zeros(1,2*NT)';

% Add to master equality arrays
Aeq = [Aeq; Aeq2];
beq = [beq; beq2];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Reserves
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

n = NT;
m = length(Aeq);

%Initialize first array to zero
Aeq2 = zeros(n,m);

for j=1:m
        for i=1:n
       if i == 1 && j == 1
           Aeq2(i,j) = QSC;
           Aeq2(i,j+2*length(price)+5) = -1;
           Aeq2(i,j+2*length(price)+6) = 1;
       else
           if (i >1 && j > (2*length(price)+7))    
           Aeq2(i,j) = Aeq2(i-1,j-(2*length(price)+7));         
           else
           end;
           
       end;
        
        
    end;
end;

beq2 = 15*ones(1,NT)';

% Add to master equality arrays
Aeq = [Aeq; Aeq2];
beq = [beq; beq2];


n = 3*NT;
m = length(Aeinq);

%Initialize first array to zero
Aeinq2 = zeros(n,m);

for j=1:m
      for i=1:n
       if i == 2 && j == 1
           Aeinq2(i,j) = -10*MSR;
           Aeinq2(i-1,j+1) = 1;
           Aeinq2(i-1,j+2*length(price)+5) =  1;
           Aeinq2(i,j+2*length(price)+5) =  1;
           Aeinq2(i+1,j+2*length(price)+5) =  -1;
       else
           if (i >3 && j > (2*length(price)+7))    
           Aeinq2(i,j) = Aeinq2(i-3,j-(2*length(price)+7));         
           else
           end;
           
       end;
        
        
    end;
end;
beinq3 = [PMAX 0 0];
beinq2 = [];
for i=1:NT
   beinq2 = [beinq2 beinq3];
end;
beinq2 = beinq2';

% Add to master equality arrays
Aeinq = [Aeinq; Aeinq2];
beinq = [beinq; beinq2];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Ramping constraints
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

n = 2*NT;
m = length(Aeq);

%Initialize first array to zero
Aeq2 = zeros(n,m);

for j=1:m
        for i=1:n
       if i == 1 && j == 2
           Aeq2(i,j) = 1;
           Aeq2(i+1,j) = -1;
           Aeq2(i+2,j) = -1;
           Aeq2(i+3,j) = 1;
           Aeq2(i,j+2*length(price) + 2) = -(PMIN-RU);
           Aeq2(i+1,j+2*length(price) + 3) = -(PMIN-RD);
           
       else
           if (i >2 && j > (2*length(price)+7))    
           Aeq2(i,j) = Aeq2(i-2,j-(2*length(price)+7));         
           else
           end;
           
       end;
        
        
    end;
end;

beq3 = [RU RD];
beq2 = [];
for i=1:NT
    beq2 = [beq2 beq3];
end;

beq2 = beq2';



% Add to master equality arrays
Aeq = [Aeq; Aeq2];
beq = [beq; beq2];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% System Load Balance and Reserve Requirements
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%
% Load Balance
%%%%%%%%%%%%%%%%%%%%%%%

n = NT;
m = length(Aeq);

%Initialize first array to zero
Aeq2 = zeros(n,m);

for j=1:m
        for i=1:n
       if i == 1 && j == 2
           Aeq2(i,j) = 1;
       else
           if (i >1 && j > (2*length(price)+7))    
           Aeq2(i,j) = Aeq2(i-1,j-(2*length(price)+7));         
           else
           end;
           
       end;
        
        
    end;
end;

beq2 = -[D]';

% Add to master equality arrays
Aeq = [Aeq; Aeq2];
beq = [beq; beq2];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Spinning Reserve Balance
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

n = NT;
m = length(Aeinq);

%Initialize first array to zero
Aeinq2 = zeros(n,m);

for j=1:m
        for i=1:n
       if i == 1 && j == 14
           Aeinq2(i,j) = -1;
       else
           if (i >1 && j > (2*length(price)+7))    
           Aeinq2(i,j) = Aeinq2(i-1,j-(2*length(price)+7));         
           else
           end;
           
       end;
        
        
    end;
end;

beinq2 = -[SR]';

% Add to master equality arrays
Aeinq = [Aeinq; Aeinq2];
beinq = [beinq; beinq2];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Operating Reserve Balance
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


n = NT;
m = length(Aeinq);

%Initialize first array to zero
Aeinq2 = zeros(n,m);

for j=1:m
        for i=1:n
       if i == 1 && j == 15
           Aeinq2(i,j) = -1;
       else
           if (i >1 && j > (2*length(price)+7))    
           Aeinq2(i,j) = Aeinq2(i-1,j-(2*length(price)+7));         
           else
           end;
           
       end;
        
        
    end;
end;

beinq2 = -[OR]';

% Add to master equality arrays
Aeinq = [Aeinq; Aeinq2];
beinq = [beinq; beinq2];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Upper Bounds
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

ub = [];
for i=1:length(price)
 ub = [ub inf];   
end;

ub1 = [inf ub];

ub2 = ones(1,length(price));
ub2 = [1 ub2];

ub1 = [1 ub1 ub2 1 1 1 1];
ub = [];
for i=1:NT
    ub = [ub ub1];
end;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Lower bounds
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

lb = zeros(1,length(Aeinq));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% xint array
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

x = [];
for i=1:length(price)
  x(i) = 1;    
end;

x2 = [];
for i = 1:length(price)
  x2(i) = 0;  
end;

x1 = [1 0 x2 1 x 1 1 1 1];

x = [];
for i=1:NT
    x = [x x1];
end;
  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Convex Function
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

else    
    % Form convex function
    c = zeros(1,length(price));
    c(1) = 0;
    for i=1:length(c)
        c(i) = price(i);        
    end;    
    
    % generate p variables
    p = zeros(1,length(price));
    p(1) = 1;
    for i=1:length(p)
        p(i) = 1;
    end;
    
    % generate delta variables 
    %  none needed in convex, but used for consistentcy
    d = zeros(1,length(price));
    
    
    u = zeros(1,1+length(d));
    f = zeros(1,length(u));
    %objective function
    f1 = [noload 0 c f startupcost shutdowncost 0 0];
    f = [];
    for i=1:NT
        f = [f f1];
    end;
    
    %equality constraints
    e = zeros(1,length(d));
    e = [0 -1 p 0 e 0 0 0 0];
    Aeq = []
    
    for i=1:NT
      Aeq = [Aeq e];
    end;
    
    
    
    beq = [0];

    %inequality constraints
    
    %make temp array
    temp = zeros(length(p));
    for i=1:length(p)
        for j=1:length(p)
        if i == j
            temp(i,j) = -1;
        else
            temp(i,j) = 0;
        end;    
        end;        
    end;
    
    temp = [temp];
    
    temp2 = zeros(length(p));
    for i=1:length(p)
        for j=1:length(p)
        if i == j
            temp2(i,j) = 1;
        else
            temp2(i,j) = 0;
        end;    
        end;        
    end;   
    
    temp2 = [temp2];   
    % This is the inequality matrix
    Aeinq = [temp; temp2];
    [m,n] = size(Aeinq);
    
    mcolumn= zeros(1,m)';
    e = [mcolumn mcolumn Aeinq mcolumn zeros(m,n) mcolumn mcolumn mcolumn mcolumn];
    Aeinq = [];
    for i=1:NT
     Aeinq = [Aeinq e];   
    end;
    
    
    % make the b equations
    temp = zeros(1,length(quantity));
    beinq = [temp'; quantity']; 
          
    
% create upper bound

ub = [];
for i = 1:length(price)+1
  ub(i) = inf;  
end;

ub = [inf 1 ub];

% create lower bound
lb = zeros(1,length(Aeinq));

% create x array

x = [];
for i=1:length(price)+1
  x(i) = 0;    
end;

x = [0 1 x];


end;

output=[];
