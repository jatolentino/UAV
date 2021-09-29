function [UAV] = myDrone()
  
% Plot_UAVe(x1(1),y1(1),z1(1),0,0,pi,1.2)
az = pi;
scale = 1
scale=0.3*scale;   
dx=0;dy=0;dz=0; 
ax=0;
ay=0;
az=0;

%M1=Plot_UAVe(x1(1),y1(1),z1(1),0,0,phi(1),1.2); % Plot UAV initial position x1,y1 and phi orientation


Rx=[ 1, 0, 0; 0, cos(ax), -sin(ax); 0, sin(ax), cos(ax)];
Ry=[ cos(ay), 0, sin(ay); 0, 1, 0; -sin(ay), 0, cos(ay)];
Rz=[ cos(az), -sin(az), 0; sin(az), cos(az), 0; 0, 0,1];

R=Rx*Ry*Rz;
body=[
-8.524 -3.178 0;
-8.524 -1.575 0;
-23.622 -1.575 0;
-23.622 1.575 0;
-8.524 1.575 0;
-8.524 3.178 0;
-6.884 5.868 0;
-1.575 8.933 0;
-1.575 23.622 0;
1.575 23.622 0;
1.575 8.933 0;
6.884 5.868 0;
8.524 3.178 0;
8.524 1.575 0;
23.622 1.575 0;
23.622 -1.575 0;
8.524 -1.575 0;
8.524 -3.178 0;
7.014 -5.793 0;
1.575 -8.933 0;
1.575 -23.622 0;
-1.575 -23.622 0;
-1.575 -8.933 0;
-7.014 -5.793 0;]*1/(3.937*3);
zb = 0.2;

body1=[body(:,1) body(:,2) body(:,3)+zb];
bodysize=1;

for k=1:length(body(:,1))-1
    sp1=[body(k,1) body(k,2) body(k,3);body(k+1,1) body(k+1,2) body(k,3); body(k+1,1) body(k+1,2) body1(k,3); body(k,1)  body(k,2) body1(k,3)]*scale*R;
  UAV(k)=patch(sp1(:,1)+dx,sp1(:,2)+dy,sp1(:,3)+dz,[0.1 0.1 0.1]);
if k==length(body(:,1))-1
    sp1=[body(length(body),1) body(length(body),2) body(k,3); body(1,1) body(1,2) body(k,3); body(1,1) body(1,2) body1(k,3);body(length(body),1) body(length(body),2) body1(k,3)]*scale*R;
   UAV(k+1)= patch(sp1(:,1)+dx,sp1(:,2)+dy,sp1(:,3)+dz,[0.1 0.1 0.1]);
end
end

bodysize=bodysize+k;
body=body*scale*R;
body1=body1*scale*R;
UAV(bodysize+1)=patch(body(:,1)+dx,body(:,2)+dy,body(:,3)+dz,[0 0.6 0.8]);
UAV(bodysize+2)=patch(body1(:,1)+dx,body1(:,2)+dy,body1(:,3)+dz,[0 0.6 0.8]);

% cubre elices
a=pi/10;
th=pi/4:a:2*pi+pi/4;

x=1.4142*cos(th)*0.5;
y=1.4142*sin(th)*0.5;
z=0.21*ones(1,length(th));

hp1=[x'-1.7 y' z']*scale*R;    % arriba
hp2=[x'+1.7 y' z']*scale*R;    % arriba

hp3=[x'-1.7 y' z']*scale*R;
hp4=[x'+1.7 y' z']*scale*R;

hp5=[x' y'-2 z']*scale*R;
hp6=[x' y'+2 z']*scale*R;

UAV(bodysize+3)=patch(hp1(:,1)+dx,hp1(:,2)+dy,hp1(:,3)+dz,[0.1 0.1 0.1],'FaceAlpha',0.25);
UAV(bodysize+4)=patch(hp2(:,1)+dx,hp2(:,2)+dy,hp2(:,3)+dz,[0.1 0.1 0.1],'FaceAlpha',0.25);
UAV(bodysize+5)=patch(hp3(:,1)+dx,hp3(:,2)+dy,hp3(:,3)+dz,[0.1 0.1 0.1],'FaceAlpha',0.25);
UAV(bodysize+6)=patch(hp4(:,1)+dx,hp4(:,2)+dy,hp4(:,3)+dz,[0.1 0.1 0.1],'FaceAlpha',0.25);
UAV(bodysize+7)=patch(hp5(:,1)+dx,hp5(:,2)+dy,hp5(:,3)+dz,[0.1 0.1 0.1],'FaceAlpha',0.25);
UAV(bodysize+8)=patch(hp6(:,1)+dx,hp6(:,2)+dy,hp6(:,3)+dz,[0.1 0.1 0.1],'FaceAlpha',0.25);

% Propellers

x=1.4142*cos(th)*0.06;
y=1.4142*sin(th)*0.5;
z=0.22*ones(1,length(th));

h1=[x'+1.7 y' z']*scale*R;
h2=[x'+1.7 y' z']*scale*R;
h3=[x'-1.7 y' z']*scale*R;
h4=[x'-1.7 y' z']*scale*R;

h5=[x'+1.7 y' z']*scale*R;
h6=[x'+1.7 y' z']*scale*R;
h7=[x'-1.7 y' z']*scale*R;
h8=[x'-1.7 y' z']*scale*R;

h9=[x' y'-2 z']*scale*R;
h10=[x' y'-2 z']*scale*R;
h11=[x' y'+2 z']*scale*R;
h12=[x' y'+2 z']*scale*R;


UAV(bodysize+9)=patch(h1(:,1)+dx,h1(:,2)+dy,h1(:,3)+dz,[0.1 0.1 0.1]);
UAV(bodysize+10)=patch(h2(:,1)+dx,h2(:,2)+dy,h2(:,3)+dz,[0.1 0.1 0.1]);
UAV(bodysize+11)=patch(h3(:,1)+dx,h3(:,2)+dy,h3(:,3)+dz,[0.1 0.1 0.1]);
UAV(bodysize+12)=patch(h4(:,1)+dx,h4(:,2)+dy,h4(:,3)+dz,[0.1 0.1 0.1]);
UAV(bodysize+13)=patch(h5(:,1)+dx,h5(:,2)+dy,h5(:,3)+dz,[0.1 0.1 0.1]);
UAV(bodysize+14)=patch(h6(:,1)+dx,h6(:,2)+dy,h6(:,3)+dz,[0.1 0.1 0.1]);
UAV(bodysize+15)=patch(h7(:,1)+dx,h7(:,2)+dy,h7(:,3)+dz,[0.1 0.1 0.1]);
UAV(bodysize+16)=patch(h8(:,1)+dx,h8(:,2)+dy,h8(:,3)+dz,[0.1 0.1 0.1]);
UAV(bodysize+17)=patch(h9(:,1)+dx,h9(:,2)+dy,h9(:,3)+dz,[0.1 0.1 0.1]);
UAV(bodysize+18)=patch(h10(:,1)+dx,h10(:,2)+dy,h10(:,3)+dz,[0.1 0.1 0.1]);
UAV(bodysize+19)=patch(h11(:,1)+dx,h11(:,2)+dy,h11(:,3)+dz,[0.1 0.1 0.1]);
UAV(bodysize+20)=patch(h12(:,1)+dx,h12(:,2)+dy,h12(:,3)+dz,[0.1 0.1 0.1]);

%% MOTORS

bodysize=bodysize+20;

a=pi/10;
th=pi/4:a:2*pi+pi/4;

x=1.4142*cos(th)*0.15;
y=1.4142*sin(th)*0.15;
z=0*ones(1,length(th));

hp1=[x'+1.7 y' z'];
hp2=[x'-1.7 y' z'];
hp3=[x'-1.7 y' z'];
hp4=[x'+1.7 y' z'];
hp5=[x' y'-2 z'];
hp6=[x' y'+2 z'];

zb=0.21;


for k=1:length(hp1)-1
    sp1=[hp1(k,1) hp1(k,2) 0;hp1(k+1,1) hp1(k+1,2) 0; hp1(k+1,1) hp1(k+1,2) zb; hp1(k,1)  hp1(k,2) zb]*scale*R;
  UAV(bodysize+k)=patch(sp1(:,1)+dx,sp1(:,2)+dy,sp1(:,3)+dz,'r');
if k==length(hp1)-1
    sp1=[hp1(length(hp1),1) hp1(length(hp1),2) 0; hp1(1,1) hp1(1,2) 0; hp1(1,1) hp1(1,2) zb;hp1(length(hp1),1) hp1(length(hp1),2) zb]*scale*R;
  UAV(bodysize+k+1)=patch(sp1(:,1)+dx,sp1(:,2)+dy,sp1(:,3)+dz,'r');
end
end
bodysize=bodysize+k+1;
for k=1:length(hp2)-1
    sp1=[hp2(k,1) hp2(k,2) 0;hp2(k+1,1) hp2(k+1,2) 0; hp2(k+1,1) hp2(k+1,2) zb; hp2(k,1)  hp2(k,2) zb]*scale*R;
  UAV(bodysize+k)=patch(sp1(:,1)+dx,sp1(:,2)+dy,sp1(:,3)+dz,'r');
if k==length(hp2)-1
    sp1=[hp2(length(hp2)) hp2(length(hp2),2) 0; hp2(1,1) hp2(1,2) 0; hp2(1,1) hp2(1,2) zb;hp2(length(hp2),1) hp2(length(hp2),2) zb]*scale*R;
  UAV(bodysize+k+1)=patch(sp1(:,1)+dx,sp1(:,2)+dy,sp1(:,3)+dz,'r');
end
end

bodysize=bodysize+k+1;
for k=1:length(hp3)-1
    sp1=[hp3(k,1) hp3(k,2) 0;hp3(k+1,1) hp3(k+1,2) 0; hp3(k+1,1) hp3(k+1,2) zb; hp3(k,1)  hp3(k,2) zb]*scale*R;
  UAV(bodysize+k)=patch(sp1(:,1)+dx,sp1(:,2)+dy,sp1(:,3)+dz,'r');
if k==length(hp3)-1
    sp1=[hp3(length(hp3)) hp3(length(hp3),2) 0; hp3(1,1) hp3(1,2) 0; hp3(1,1) hp3(1,2) zb;hp3(length(hp3),1) hp3(length(hp3),2) zb]*scale*R;
    UAV(bodysize+k+1)=patch(sp1(:,1)+dx,sp1(:,2)+dy,sp1(:,3)+dz,'r');
end
end
bodysize=bodysize+k+1;
for k=1:length(hp4)-1
    sp1=[hp4(k,1) hp4(k,2) 0;hp4(k+1,1) hp4(k+1,2) 0; hp4(k+1,1) hp4(k+1,2) zb; hp4(k,1)  hp4(k,2) zb]*scale*R;
  UAV(bodysize+k)=patch(sp1(:,1)+dx,sp1(:,2)+dy,sp1(:,3)+dz,'r');
if k==length(hp4)-1
    sp1=[hp4(length(hp4)) hp4(length(hp4),2) 0; hp4(1,1) hp4(1,2) 0; hp4(1,1) hp4(1,2) zb;hp4(length(hp4),1) hp4(length(hp4),2) zb]*scale*R;
   UAV(bodysize+k+1)= patch(sp1(:,1)+dx,sp1(:,2)+dy,sp1(:,3)+dz,'r');
end
end
bodysize=bodysize+k+1;
for k=1:length(hp5)-1
    sp1=[hp5(k,1) hp5(k,2) 0;hp5(k+1,1) hp5(k+1,2) 0; hp5(k+1,1) hp5(k+1,2) zb; hp5(k,1)  hp5(k,2) zb]*scale*R;
  UAV(bodysize+k)=patch(sp1(:,1)+dx,sp1(:,2)+dy,sp1(:,3)+dz,'r');
if k==length(hp5)-1
    sp1=[hp5(length(hp5)) hp5(length(hp5),2) 0; hp5(1,1) hp5(1,2) 0; hp5(1,1) hp5(1,2) zb;hp5(length(hp5),1) hp5(length(hp5),2) zb]*scale*R;
   UAV(bodysize+k+1)= patch(sp1(:,1)+dx,sp1(:,2)+dy,sp1(:,3)+dz,'r');
end
end
bodysize=bodysize+k+1;
for k=1:length(hp6)-1
    sp1=[hp6(k,1) hp6(k,2) 0;hp6(k+1,1) hp6(k+1,2) 0; hp6(k+1,1) hp6(k+1,2) zb; hp6(k,1)  hp6(k,2) zb]*scale*R;
  UAV(bodysize+k)=patch(sp1(:,1)+dx,sp1(:,2)+dy,sp1(:,3)+dz,'r');
if k==length(hp6)-1
    sp1=[hp6(length(hp6)) hp6(length(hp6),2) 0; hp6(1,1) hp6(1,2) 0; hp6(1,1) hp6(1,2) zb;hp6(length(hp6),1) hp6(length(hp6),2) zb]*scale*R;
   UAV(bodysize+k+1)= patch(sp1(:,1)+dx,sp1(:,2)+dy,sp1(:,3)+dz,'r');
end
end
bodysize=bodysize+k+1;

hp1=hp1*scale*R;
hp2=hp2*scale*R;
hp3=hp3*scale*R;
hp4=hp4*scale*R;
hp5=hp5*scale*R;
hp6=hp6*scale*R;

zb = 0.21*scale;

UAV(bodysize+1)=patch(hp1(:,1)+dx,hp1(:,2)+dy,hp1(:,3)+dz,'r');
UAV(bodysize+2)=patch(hp2(:,1)+dx,hp2(:,2)+dy,hp2(:,3)+dz,'r');
UAV(bodysize+3)=patch(hp3(:,1)+dx,hp3(:,2)+dy,hp3(:,3)+dz,'r');
UAV(bodysize+4)=patch(hp4(:,1)+dx,hp4(:,2)+dy,hp4(:,3)+dz,'r');
UAV(bodysize+5)=patch(hp5(:,1)+dx,hp5(:,2)+dy,hp5(:,3)+dz,'r');
UAV(bodysize+6)=patch(hp6(:,1)+dx,hp6(:,2)+dy,hp6(:,3)+dz,'r');

UAV(bodysize+7)=patch(hp1(:,1)+dx,hp1(:,2)+dy,hp1(:,3)+zb+dz,'r');
UAV(bodysize+8)=patch(hp2(:,1)+dx,hp2(:,2)+dy,hp2(:,3)+zb+dz,'r');
UAV(bodysize+9)=patch(hp3(:,1)+dx,hp3(:,2)+dy,hp3(:,3)+zb+dz,'r');
UAV(bodysize+10)=patch(hp4(:,1)+dx,hp4(:,2)+dy,hp4(:,3)+zb+dz,'r');
UAV(bodysize+11)=patch(hp5(:,1)+dx,hp5(:,2)+dy,hp5(:,3)+zb+dz,'r');
UAV(bodysize+12)=patch(hp6(:,1)+dx,hp6(:,2)+dy,hp6(:,3)+zb+dz,'r');
