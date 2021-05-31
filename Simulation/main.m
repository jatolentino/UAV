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
%%[theta_ref, phi_ref, U1] = position_control(states,x_ref,x_dot_ref,x_dotdot_ref,y_ref,y_dot_ref,y_dotdot_ref,z_ref,z_dot_ref,z_dotdot_ref,psi_ref);


%% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
counter = 0;
%Hdbstore = [];
Hdbstore = {};
Cdbstore = {};
AdciStore = {};
FdbTstore = {};
statesssau = {};
References = {};
duss = {};
U2s = {};
U3s = {};
U4s = {};
dus3 = {};
for itotal = 1:outterLoops-1      % 251
    [theta_ref, phi_ref, U1] = positionControl(states,x_ref(itotal+1),x_dot_ref(itotal+1),x_dotdot_ref(itotal+1),y_ref(itotal+1),...
        y_dot_ref(itotal+1),y_dotdot_ref(itotal+1),z_ref(itotal+1),z_dot_ref(itotal+1),z_dotdot_ref(itotal+1),psi_ref(itotal+1));
    
    Phi_ref = phi_ref*ones(1,innerLoops+1)';
    Theta_ref = theta_ref*ones(1,innerLoops+1)';
    
    % 3.1.1 Making psi increase continuosly in the horizon
    Psi_ref = zeros(1,innerLoops+1)'

    for itpsi = 1:innerLoops+1   % 4
            Psi_ref(itpsi,1) = psi_ref(itotal) + (itpsi-1)*(psi_ref(itotal+1) - psi_ref(itotal))/innerLoops;
    end
    refNestedAngles = [];
    temporaryAngles = [Phi_ref,Theta_ref,Psi_ref];
    refNestedAngles = [refNestedAngles ; temporaryAngles];
    refSignals = zeros(1,length(Phi_ref)*statesToControl);
    kSig = 1;
    for i = 1:statesToControl:length(Phi_ref)*statesToControl       % 1,2,3  4,5,6  [phiref0 thetaref0 psiref0   phiref1 thetaref1 psiref1...
       refSignals(i) = Phi_ref(kSig);
       refSignals(i+1) = Theta_ref(kSig);
       refSignals(i+2) = Psi_ref(kSig);
       kSig = kSig+1;
    end
    count = 1;
    hz = pCs.hz;
    for i = 1:innerLoops
        [Ad,Bd,Cd,Dd,xdot,ydot,zdot,phi,theta,psi,phidot,thetadot,psidot] = discretePlant(states);%,sumOmegas);
        % for graph
        tempInertialVel = [xdot ydot zdot];
        nestedInertialVel = [];
        nestedInertialVel = [nestedInertialVel;tempInertialVel];
        % ----
        statesAugmented = [phi;phidot;theta;thetadot;psi;psidot;U2;U3;U4];
        count = count + statesToControl;
        if count + statesToControl*hz - 1 <= length(refSignals)
            reference = refSignals(count:count+statesToControl*hz-1)';
        else
            reference = refSignals(count:length(refSignals))';
            hz = hz - 1;
        end
        [Hdb,FdbT,Cdb,Adci] = attitudeControl(Ad,Bd,Cd,Dd,hz);
        counter = counter + 1;
        statesssau{counter}  = statesAugmented;
        Hdbstore{counter} = Hdb;
        FdbTstore{counter} = FdbT;
        Cdbstore{counter} = Cdb;
        Adcistore{counter} = Adci;
        References{counter} = reference;
        
        
        
    end
end
