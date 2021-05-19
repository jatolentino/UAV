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

