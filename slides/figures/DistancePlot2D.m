figure(1), clf
LW = 2;
FS = 18;

quiver(-1,0,7,0,0,'k', 'LineWidth', LW)
hold on
quiver(0,-1,0,7,0,'k', 'LineWidth', LW)
quiver(0,0,3,1,0,'b','LineWidth',LW)
quiver(0,0,1,4,0,'b','LineWidth',LW)
quiver(3,1,-2,3,0,'m','LineWidth',LW+1)
%plot([1,4,3],[4,5,1],'b--','LineWidth',LW)
grid on
text(2.8,0.75,'$\displaystyle{\bf v}=\left[\begin{array}{c} v_1 \\ v_2 \end{array}\right]$','Interpreter','latex', 'FontSize', FS)
text(0.1,4.75,'$\displaystyle{\bf u}=\left[\begin{array}{c} u_1 \\ u_2 \end{array}\right]$','Interpreter','latex', 'FontSize', FS)
%text(3.25,5.25,'$\displaystyle{\bf x}+{\bf y}=\left[\begin{array}{c} 4 \\ 5 \end{array}\right]$','Interpreter','latex', 'FontSize', FS)
%title('Graphical representation of adding vectors', 'FontSize', FS)
axis off, axis equal

figure(2), clf

quiver(-1,0,7,0,0,'k', 'LineWidth', LW)
hold on
quiver(0,-1,0,7,0,'k', 'LineWidth', LW)
quiver(0,0,3,1,0,'b','LineWidth',LW)
quiver(0,0,1,4,0,'b','LineWidth',LW)
quiver(1,4,2,-3,0,'m','LineWidth',LW+1)
%plot([1,4,3],[4,5,1],'b--','LineWidth',LW)
grid on
text(2.8,0.75,'$\displaystyle{\bf v}=\left[\begin{array}{c} v_1 \\ v_2 \end{array}\right]$','Interpreter','latex', 'FontSize', FS)
text(0.1,4.75,'$\displaystyle{\bf u}=\left[\begin{array}{c} u_1 \\ u_2 \end{array}\right]$','Interpreter','latex', 'FontSize', FS)
%text(3.25,5.25,'$\displaystyle{\bf x}+{\bf y}=\left[\begin{array}{c} 4 \\ 5 \end{array}\right]$','Interpreter','latex', 'FontSize', FS)
%title('Graphical representation of adding vectors', 'FontSize', FS)
axis off, axis equal