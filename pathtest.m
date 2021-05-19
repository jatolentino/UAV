close all;
clc; clear;
% SEt the limmtis and select a view
ax = axes('XLim',[-20 10],'YLim',[-20 20],'ZLim',[-20 20]);
% ax = axes(
% xlim([-2 2]);
% ylim([-2 10]);
% zlim([-1.5 1.5]);
%view(3);
%axis equal;
hold on;
grid on;
view(3);
daspect([1 1 1]);
xlabel('X') 
ylabel('Y') 
zlabel('Z') 
[xc, yc, zc] = cylinder([0.1 0.0]);  % for a cone
[x, y, z] = cylinder([0.2 0.2]);
 
h(1) = surface(xc, zc, -yc, 'FaceColor', 'red');
h(2) = surface(z, y, 0.5*x,'FaceColor', 'blue');
h(3) = surface(-z, y, 0.5*x, 'FaceColor', 'yellow');
h(4) = surface(x, -1.5*z, 0.5*y, 'FaceColor', 'red');
h(5) = surface(xc, (1.5*yc)-1.3, z, 'FaceColor', 'red');

%Create group object and parent surfaces
combined_objects = hgtransform('Parent',ax);
set(h,'Parent',combined_objects)
% Set the renderer to OpenGL and update the display
set(gcf, 'Render','opengl')

% Concatenate the transforms and
% set the transform matrix property
% set(t, 'Matrix',Rz)
drawnow

% lon = [ 0 0.1 2 4 4  5 6 7  8 9 10];
% lat = [0 1 1 1 0 0 0 -1 -1 -1 -1];
% bea = [0 -1 0 0 0.5 0 0 0.5 0 0 0];

z = 0:0.05:10;
y = 6*sin(2*z);
x = 6*cos(2*z);
plot3(x,y,z);
beaz = 0:3*0.031416:3*2*3.1416;
set(gcf,'Units','normalized','OuterPosition',[0 0 1 1]);
for i = 1: length(z)
    %lon = [0 0.1 2 4 4  5 6 7 9 10];    % Y
    %lon = y(i);
    %lat = x(i);
    %lat = [0 1 1 1 0 0 0 -1 -1 -5]; % X
    %bea = [0 3.1416 0 0 0.5 0 0 0.5 0 0 0]; % yaw or PSI angles
    %bea = beaz(i);
    %alt = [0 1 1.5 2 2.5 3 3.5 4 4.5 5]; % Zc
    %alt = z(i);
	   trans = makehgtform('translate',[x(i) y(i) z(i)]);
    %trans = makehgtform('translate',[lat(i) y(i) alt(i)]);
	   %rotz = 1;
    rotz = makehgtform('zrotate',beaz(i));
	  set(combined_objects, 'Matrix', trans*rotz);
	  pause(0.3);
    %pause;
end
