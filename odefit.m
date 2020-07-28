function [err] = odefit(exp_t,exp_y,p)
    [~,y] = ode45(@(t,y)odefun(t,y,p),exp_t,exp_y(:,1)); %initial conditions w/ 1 infected (i) 
    %err = sum((y(:) - exp_y).^2);   % This gives a lousy fit!
    
    err = .5*norm((diff(y) - diff(transpose(exp_y)))) + .5*norm((y - transpose(exp_y))); 
    %err = norm((y - exp_y)); 
end