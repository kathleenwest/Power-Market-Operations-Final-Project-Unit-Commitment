%mipprog  Solves mixed integer linear programming problems.
%
%  SYNOPSIS: [x,fval,exitflag,output,lambda]=mipprog(f,A,b,Aeq,beq,lb,ub,xint)
%
%     solves the following MILP problem
%
%             min v = f'*x
%                 A*x <= b
%                 Aeq*x = beq
%                 lb <= x <= ub
%                 xint are integer
%

function [x,fval,exitflag,output,lambda]=mipprog(f,A,b,Aeq,beq,lb,ub,xint)

if sum(xint)==0 
    [x,fval,exitflag,output,lambda]=linprog(f,A,b,Aeq,beq,lb,ub);
    return
end

mip_a=[A;Aeq];
mip_b=[my2col(b);my2col(beq)];
mip_e=[-1*ones(length(b),1);zeros(length(beq),1)];
mip_xint=find(xint==1);
[fval,x,milp_lambda,exitflag,rhs_sen,var_reducedcost]=lp_solve(-f,mip_a,mip_b,mip_e,lb,ub,mip_xint);
fval=-fval;
if exitflag==0 | exitflag==1 | exitflag==11 | exitflag==12
    lambda.lower=var_reducedcost;
    lambda.upper=var_reducedcost;
    lambda.ineqlin=rhs_sen(1:length(b));
    lambda.eqlin=rhs_sen(length(b)+1:length(mip_b));
else
    lambda.lower=[];
    lambda.upper=[];
    lambda.ineqlin=[];
    lambda.eqlin=[];
end
output=[];
