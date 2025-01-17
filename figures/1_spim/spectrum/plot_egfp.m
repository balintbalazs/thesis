
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

hold off
plot(ex.x, ex.y, 'LineWidth', lineWidth)
hold on
plot(em.x, em.y, 'LineWidth', lineWidth)

xlim([350, 650])
ylim([0,1.2])
set(h, 'Box', 'on', 'Color', g(1), 'FontSize', 16)
h.GridColor = g(0.5);
grid on
grid minor
xlabel('Wavelength (nm)');
ylabel('%T');