function Fiber=Generate_Fiber(x,y,z,L,N)

%input

%x=[x1 x2]: x boundaries of the box
%y=[y1 y2]: y boundaries of the box
%z=[z1 z2]: z boundaries of the box
%L: Length of fibers
%N: Number of fibers

%output

%Fiber: (N,6) matrix of fiber coordinates with (:,1), (:,2) and (:,3) are x,y, and z coordinates of one end 
%and (:,4),(:,5) and (:,6) are x,y, and z coordinates of the other end.  

for i=1:1:N

while 1

x1=min(x)+(max(x)-min(x))*rand(1);
y1=min(y)+(max(y)-min(y))*rand(1);
z1=min(z)+(max(z)-min(z))*rand(1);

theta=2*pi*rand(1);
gamma=2*pi*rand(1); 
phi=2*pi*rand(1);

Dr=[cos(gamma)*cos(phi)-cos(theta)*sin(gamma)*sin(phi)  sin(gamma)*cos(phi)+cos(theta)*cos(gamma)*sin(phi) sin(theta)*sin(phi)  ...
 ; -cos(gamma)*sin(phi)-cos(theta)*sin(gamma)*cos(phi) -sin(gamma)*sin(phi)+cos(theta)*cos(gamma)*cos(phi) sin(theta)*cos(phi)  ...
 ;                  sin(theta)*sin(gamma)                         -sin(theta)*cos(gamma)                         cos(theta)     ];


c2=[x1 y1 z1]'+Dr*[L 0 0]';

x2=c2(1);
y2=c2(2);
z2=c2(3);

if x2<=x(2) && x2>=x(1) && y2<=y(2) && y2>=y(1) && z2<=z(2) && z2>=z(1)  
break;
end    
    
end

Fiber(i,1)=x1;
Fiber(i,2)=y1;
Fiber(i,3)=z1;
Fiber(i,4)=x2;
Fiber(i,5)=y2;
Fiber(i,6)=z2;

end


      