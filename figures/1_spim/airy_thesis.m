%%
x = -10:0.3:10;
y = x;
[X, Y] = meshgrid(x, y);
R = sqrt(X.^2+Y.^2);
n = 1;
lambda = 500e-9;
%V = 2*pi*n*
H = (2*besselj(1,R)./R).^2;
m = ceil(length(x) / 2);
H(m,m) = 1;
%%
figureSize = 500;
borderWidth = 1.5;
lineWidth = 1.5;
scheme = 'RdYlBu';
%%
f4 = figure(4);
%cla reset;
pos = get(f4, 'Position');
set(f4, 'Position', [pos(1),pos(2),1.5*figureSize,figureSize])
%hold on
axis square
set(gcf, 'Color', 'w')
set(gca, 'LineWidth', 1)
h = gca;
h.YRuler.LineWidth = borderWidth;
h.XRuler.LineWidth = borderWidth;
mesh(X,Y,H)
set(h, 'Box', 'on', 'Color', g(1), 'FontSize', 20)
h.GridColor = g(0.5);
grid on
grid minor
xlabel('x');
ylabel('y');
zlabel('$H(0,v)$','Interpreter','latex');
xticklabels([]);
yticklabels([]);
zticklabels([]);
title({'Airy pattern';''})


