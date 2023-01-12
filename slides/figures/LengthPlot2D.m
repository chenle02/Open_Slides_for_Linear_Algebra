figure(1), clf
LW = 2;
FS = 18;
x = [3;1];
quiver(-1,0,5,0,0,'k', 'LineWidth', LW)
hold on
quiver(0,-1,0,5,0,'k', 'LineWidth', LW)
quiver(0,0,x(1),x(2),0,'b','LineWidth',LW+1)
text(2.8,1.5,'$\displaystyle{\bf v}=\left[\begin{array}{c} v_1 \\ v_2 \end{array}\right]$','Interpreter','latex', 'FontSize', FS)
axis off, axis equal