clc; clear; close all;

syms t xdotdot x(t) y(t) xdd yd xd ydot xdot y1 sx cx sy cy

% NOTE: diff(x(t),t) = x'  diff(x(t),t,t) = x''

%partder(diff(x(t),t,t)*y)

partder(x*sin(x)*y + y*cos(x))

subs(partder(x*sin(x)*y + y*cos(x)), [x(t),y(t),sin(x(t)),cos(x(t))],['x','y',sx,cx])
%eqn = subs(partder(x*sin(x)*y + y^2*cos(x)), [x(t),y(t),sin(x(t)),cos(x(t))],['x','y',sx,cx]);

eqn = partder(x*sin(x)*y + y*cos(x));
fso = isolate(eqn == 0,y);
subs(fso, [x(t),y(t),sin(x(t)),cos(x(t))],['x','y',sx,cx])
%^(partder(sin(x)*x),x(t),)
