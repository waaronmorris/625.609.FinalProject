confirmed = loadData('confirmed');
deaths = loadData('deaths');
recovered = loadData('recovered');

region = 12; %Queensland
t = 12:180;
N = 7.5*10^9;
syms beta vega

R = deaths{region,t} + recovered{region,t};
I = confirmed{region,t} - R;
S = N - I - R;

beta = p(1);
vega = p(2);
dS(t) = -beta*(S(t-1)./N);
dI(t) = beta*(S(t-1).*I(t-1)./N) - vega*I(t-1);
dR(t) = vega*I(t-1);

fun = @(p,I)p(1)*(S.*I./N) - p(2)*I;

p0 = [1.5, 0.5];
p = lsqcurvefit(fun,p0,t,I);

%[bfit, vfit] = lsqcurvefit(infected(bfit,vfit),I(1),t,I)


figure
hold on
scatter(t,confirmed{region,12:180}-(deaths{region,12:180}+recovered{region,12:180}))
plot(t,dI)
hold off
