x = 0:0.01:pi/2;
n = 1.33;
NA = n*sin(x);
eff = (1-cos(x))/2;
a = x * 180 / pi;
%%
figureSize = 500;
lineWidth = 1.5;
%%
f7 = figure(7)
cla reset;
pos = get(f7, 'Position');
set(f7, 'Position', [pos(1), pos(2), figureSize, figureSize])
hold on
axis square
set(gcf, 'Color', 'w')

plot(NA, eff, 'LineWidth', 2*lineWidth)
h = gca;
h.GridColor = [1,1,1];
h.GridAlpha = 1;
grid on
set(h, 'LineWidth', lineWidth)
set(h, 'Box', 'on', 'Color', repmat(0.9,[1,3]), 'FontSize', 12)

%%
export_fig 'light_eff.pdf'