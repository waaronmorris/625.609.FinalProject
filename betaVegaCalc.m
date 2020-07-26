function [b, v] = betaVegaCalc(s, c, d, r, w, pop)
    v = [];
    b = [];
    for t = 1:w-1
        t2 = t+1;
        s1 = s(t);
        s2 = s(t2);
        i1 = c(t) - d(t) - r(t);
        %i2 = c(t2) - d(t2) - r(t2);
        r2 = d(t2) + r(t2);
        r1 = d(t) + r(t);
        v = [v (r2-r1)/i1];
        b = [b (s1-s2)/(i1.*s1)];
    end
end
