clc; clear; close all;

%% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 1. Addressing the constants
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%constants = plantConstants;     % The function where the 
                                % variables come is myConstants

hold on;
grid on;
view(3);
xlabel('X(m)') 
ylabel('Y(m)') 
zlabel('Z(m)')
[xc, yc, zc] = cylinder([0.1 0.0]);  % for a cone
[xi, yi, zi] = cylinder([0.2 0.2]);

haa(1) = surface(xc, zc, -yc, 'FaceColor', 'red');
haa(2) = surface(zi, yi, 0.5*xi,'FaceColor', 'blue');
haa(3) = surface(-zi, yi, 0.5*xi, 'FaceColor', 'yellow');
haa(4) = surface(xi, -1.5*zi, 0.5*yi, 'FaceColor', 'red');
haa(5) = surface(xc, (1.5*yc)-1.3, zi, 'FaceColor', 'red');
combined_objects = hgtransform('Parent',anx);
set(haa,'Parent',combined_objects)
set(gcf, 'Render','opengl')

drawnow
za = 0:0.01:10;
ya = 2*sin(2*pi*za);
xa = 2*cos(2*pi*za);

plot3(xa,ya,za)%,'--b','LineWidth',1)
hold on

for i = 1: length(xa)
    trans = makehgtform('translate',[xa(i) ya(i) za(i)]);
    rotz = 1; %makehgtform('zrotate',beaz(i));
	set(combined_objects, 'Matrix', trans*rotz);
	pause(0.3);
end
