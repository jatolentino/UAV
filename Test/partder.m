function [m] = partder(fun) %,a,b)%partder(fun,a,b)%, Y , Z) 
    syms t xdotdot x(t) y(t) xdd yd xd ydot xdot y1

    xdd = diff(x(t),t,t);
    yd = diff(y(t),t);
    xd = diff(x(t),t);
    
    derf = diff(fun,t);
    m = subs(derf, [xdd,yd,xd], [xdotdot,ydot,xdot]);
    
end
