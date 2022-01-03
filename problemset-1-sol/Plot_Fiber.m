function Plot_Fiber(x,y,z,Fiber)

%input

%x=[x1 x2]: x boundaries of the box
%y=[y1 y2]: y boundaries of the box
%z=[z1 z2]: z boundaries of the box
%Fiber: (N,6) matrix of fiber coordinates with (:,1), (:,2) and (:,3) are x,y, and z coordinates of one end 
%and (:,4),(:,5) and (:,6) are x,y, and z coordinates of the other end.

%output

%Fibers are plotted inside a box 

figure

%Plot cube
vcube = [ x(1) y(1) z(1); x(2) y(1) z(1); x(2) y(2) z(1); x(1) y(2) z(1);...
          x(1) y(1) z(2); x(2) y(1) z(2); x(2) y(2) z(2); x(1) y(2) z(2)]';
      

idx = [1 2 3 4 1 5 6 7 8 5 6 2 3 7 8 4];
vert(1,:) = vcube(1,:);
vert(2,:) = vcube(2,:);
vert(3,:) = vcube(3,:);

vx = vert(1,idx);
vy = vert(2,idx);
vz = vert(3,idx);

plot3(vx,vz,vy,'k');
hold on

%Plot Fiber

for i=1:1:size(Fiber,1)

x1=Fiber(i,1);
y1=Fiber(i,2);
z1=Fiber(i,3);
x2=Fiber(i,4);
y2=Fiber(i,5);
z2=Fiber(i,6);
  
plot3([x1 x2],[z1 z2],[y1 y2],'b');

end

view(60,30);
daspect([1 1 1]);

end