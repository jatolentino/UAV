function [theta_ref, phi_ref, U1] = position_control(states,x_ref,x_dot_ref,x_dotdot_ref,y_ref,y_dot_ref,y_dotdot_ref,z_ref,z_dot_ref,z_dotdot_ref,psi_ref)
pCs = plantConstants;
           %1  2  3  4  5  6  7  8  9  10    11     12  
% states = [ut,vt,wt,pt,qt,rt,xt,yt,zt,phit,thetat,psit];
% x_ref,x_dot_ref,x_dotdot_ref,y_ref,y_dot_ref,y_dotdot_ref,z_ref,z_dot_ref,z_dotdot_ref
g = pCs.g;
px = pCs.px;
py = pCs.py;
pz = pCs.pz;
m = pCs.m;
u = states(1);
v = states(2);
w = states(3);

x = states(7);
y = states(8);
z = states(9);

phi = states(10);
theta = states(11);
psi = states(12);

end
