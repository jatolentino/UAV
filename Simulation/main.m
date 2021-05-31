clc; clear; close all;

% Recalling the constants with the name pCs
pCs = plantConstants;

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 1. Initial conditions
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 1.1 Initial position and Euler angles
xt = 0;
yt = -1;
zt = 0;
phit = 0;
thetat = 0;
psit = 0;


% 1.2 Initial velocities
ut = 0;
vt = 0;
wt= 0;
pt = 0;
qt = 0;
rt = 0;


% 1.3 Initial propellers velocities
omega1=110*pi/3; % rad/s at t = -1s
omega2=110*pi/3; % rad/s at t = -1s
omega3=110*pi/3; % rad/s at t = -1s
omega4=110*pi/3; % rad/s at t = -1s


% 1.4 Initial thurst
U1 = pCs.ct*(omega1^2 + omega2^2 + omega3^2 + omega4^2);
U2 = pCs.ct*pCs.l*(omega2^2 - omega4^2);
U3 = pCs.ct*pCs.l*(omega3^2 + omega1^2);
U4 = pCs.cq*(-omega1^2 + omega2^2 - omega3^2 + omega4^2);


%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 2. Calling psi_ref from the trajectoryGen.m 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 2.1 Time constans and loops
Ts = 0.1;                       % Ts=0.1
innerLoops = pCs.innerLoops;    % 4 iterations inside, for the MPC
t = 0:Ts*innerLoops:100;        % duration of the simulation
outterLoops = length(t);        % 251 for the Feedback

% 2.2 Initial and future States
states = [ut,vt,wt,pt,qt,rt,xt,yt,zt,phit,thetat,psit];


% 2.3 Choosing the trajectory and getting xyz and dot ref
[x_ref,x_dot_ref,x_dotdot_ref,y_ref,y_dot_ref,y_dotdot_ref,z_ref,z_dot_ref,z_dotdot_ref,psi_ref] = trajectoryGen(1,t); % 1 refers to the path1

%plot3(x_ref,y_ref,z_ref)

%%
[theta_ref, phi_ref, U1] = position_control(states,x_ref,x_dot_ref,x_dotdot_ref,y_ref,y_dot_ref,y_dotdot_ref,z_ref,z_dot_ref,z_dotdot_ref,psi_ref);


%% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% . 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
