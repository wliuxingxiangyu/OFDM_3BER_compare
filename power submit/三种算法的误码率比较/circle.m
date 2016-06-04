function []=circle( )
centerXY2D=[ 200, 200;
    800, 800;
    600, 400;
    300, 700; ];
circleNum=size(centerXY2D,1);
comRad=50;%ͨ�Ű뾶communication Radius=50��
for i=1:circleNum
    alpha=[0:(pi/50):2*pi];
    circleX=centerXY2D(i,1)+comRad*cos(alpha);
    circleY=centerXY2D(i,2)+comRad*sin(alpha);
    plot(circleX,circleY,'-k','LineWidth',1);
    text(centerXY2D(i,1),centerXY2D(i,2),num2str(i) );%ǰ�������꣬�����������label 
    hold on;
end
axis([0 1000 0 1000 ]);
grid;
end
