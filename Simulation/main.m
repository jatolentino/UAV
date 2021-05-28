clc; clear; close all;

%% Recalling the PlantConstans class with the name pCs
pCs = plantConstants;

% 1. Initial conditions
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 1.1 Initial position
xt = 0;     % initial X position
yt = -1;    % initial Y position
zt = 0;     % initial Z position
phit = 0;   % initial Euler phi angle
thetat = 0; % initial Euler theta angle
psit = 0;   % initial Euler psi angle

% 1.2 Initial velocities in the body frame
ut = 0;
vt = 0;
wt= 0;
pt = 0;
qt = 0;
rt = 0;

% 1.3 Initial propellers velocities
omega1 = 100*pi/3; % [rad/s] at t = -1s
omega2 = 100*pi/3; % [rad/s] at t = -1s
omega3 = 100*pi/3; % [rad/s] at t = -1s
omega4 = 100*pi/3; % rad/s at t = -1s

% 1.4 Initial thurst
U1 = pCs.ct*(omega1^2 + omega2^2 + omega3^2 + omega4^2);
U2 = plantConstants.ct*(omega2^2 - omega1^2);
U3 = plantConstants.ct*(omega3^2 + omega1^2);
U4 = plantConstants.ct*(-omega1^2 + omega2^2 - omega3^2 + omega4^2);

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 2. Calling psi_ref from the trajectoryGen.m 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Ts = plantConstants.Ts;     % Ts=0.1
%subIt = 4;                  % 4 iterations inside
%t = 0:Ts*subIt:100;         % t 
%f = 0.025;

% Initial and future States
states = [ut,vt,wt,pt,qt,rt,xt,yt,zt,phit,thetat,psit];

% 2.1 Choosing the trajectory and getting xyz and dot ref
[x_ref,x_dot_ref,x_dotdot_ref,y_ref,y_dot_ref,y_dotdot_ref,z_ref,z_dot_ref,z_dotdot_ref,psi_ref] = trajectoryGen(1);

% for i_total = 1:251
%     
% end

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 2. Position control
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[theta_ref, phi_ref, U1] = position_control(states,x_ref,x_dot_ref,x_dotdot_ref,y_ref,y_dot_ref,y_dotdot_ref,z_ref,z_dot_ref,z_dotdot_ref,psi_ref);



%% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% . 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%





%% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% . 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




%% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% . 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




%% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% . 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
