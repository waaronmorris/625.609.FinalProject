function dydt = odefun(~,y,p)
    s = y(1);
    i = y(2);
    r = y(3);
       
    dydt = [-p(1) * s* i/(i+s+r);
             (p(1) * s * i/(i+s+r)) - (p(2) * i);
             p(2) * i];
    
end