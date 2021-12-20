function [x] = rank2_power(v1,v2,v3)

u=v1;
v=v2;
b=v3;

if (~iscolumn(u) || ~iscolumn(v) || ~iscolumn(b))
    error('Inputs must be vectors')
end

    L= length(u);
    L1= length(v);
    L2= length(b);
    
    if L==L1 && L1==L2
        
        x= (u*u.' + v*v.')^10 *b;
   
    end
end