function [err] = odefit(exp_t,exp_y,p)
    [~,y] = ode45(@(t,y)odefun(t,y,p),exp_t,[5072000-1 1 0]); %initial conditions w/ 1 infected (i) 
    %err = sum((y(:) - exp_y).^2);   % This gives a lousy fit!
    t = transpose(exp_y);
    err = norm(transpose(exp_y)) - norm(y); 
    %err = norm((y - exp_y)); 
end