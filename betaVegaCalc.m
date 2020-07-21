function [b, v] = betaVegaCalc(c, d, r, peakIndex, daysPrior)
    v = [];
    b = [];
    for t = peakIndex-daysPrior:peakIndex
        t2 = t+1;
        i1 = c(t) - d(t) - r(t);
        i2 = c(t2) - d(t2) - r(t2);
        r2 = d(t2) + r(t2);
        r1 = d(t) + r(t);
        v = [v (r2-r1)/i1];
        b = [b (i2 + v(t-49)*i1)/i1];
    end
end
