clear all
confirmed = loadData('confirmed');
deaths = loadData('deaths');
recovered = loadData('recovered');

region = 171; % Queensland
t = 60:width(confirmed); 
N = 4880000; 
S = N - confirmed{region,t} - deaths{region,t} - recovered{168,t};
I = confirmed{region,t} - deaths{region,t} - recovered{168,t};
R = deaths{region,t} + recovered{168,t};

s = S/N;
i = I/N;
r = R/N;


exp_y = [s(:); i(:); r(:)];
exp_t = 1:length(i);
p0 = [0.2 0.2 60]; %initial guess for beta, gamma and the delay
p_estimate = fminsearch(@(p)odefit(exp_t,exp_y,p),p0);
[~,Y] = ode45(@(t,y)odefun(t,y,p_estimate),exp_t,[1 1/5072000 0]);
S = Y(:,1); I = Y(:,2); R = Y(:,3);
plot(exp_t,i,'o',exp_t,r,'*',exp_t,I,exp_t,R)
legend('i','r','I','R')
figure
plot(exp_t,s,'o',exp_t,S,exp_t,)
legend('S')
function err = odefit(exp_t,exp_y,p)
    [~,y] = ode45(@(t,y)odefun(t,y,p),exp_t,[1 1/4880000 0]); %initial conditions w/ 1 infected (i)
    err = sum((y(:) - exp_y).^2);   
end
function dydt = odefun(t,y,p)
         
        s = y(1);
        i = y(2);
       % r = y(3);
       beta = p(1); gamma = p(2); deltat = p(3);
       if t<deltat
          gamma = 0;
       end
       
       
    dydt = [-beta * s * i;
             beta * s * i - gamma * i;
             gamma * i];
    
end