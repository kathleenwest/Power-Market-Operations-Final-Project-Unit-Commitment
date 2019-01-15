% convert to column vector
function [v_c]=my2col(v_rc)

[row,col]=size(v_rc);
if row==1
    v_c=v_rc';
elseif col==1
    v_c=v_rc;
else
    v_c=[];
end

    