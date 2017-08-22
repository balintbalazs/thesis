folder = 'D:\Documents\data\DualMouse\Beam 2x\2017-08-10_08.41.21\';
fnRight = 'channel_2_right_AVG.tif';
fnLeft = 'channel_3_left_AVG.tif';

lineWidth = 1.5;
%%
right = imread([folder, fnRight]);
left = imread([folder, fnLeft]);

right = right(:,1:2048);
left = left(:,1:2048);
%% axial intensity check
figure(1)
subplot(2,2,1);
rowLeft = 1022;
plot(left(rowLeft,:), 'LineWidth', lineWidth);
ylim([0,2600]);
xlim([0,2048]);
title({'Left view, axial intensity profile', sprintf('Row %d', rowLeft)})

subplot(2,2,2);
rowRight = 1023;
plot(right(rowRight,:), 'LineWidth', lineWidth);
ylim([0,2600]);
xlim([0,2048]);
title({'Right view, axial intensity profile', sprintf('Row %d', rowRight)})

% lateral intensity check
subplot(2,2,3)
colLeft = 1020;
plot(left(:,colLeft), 'LineWidth', lineWidth);
ylim([0,2600]);
xlim([924,1124]);
title({'Left view, lateral intensity profile', sprintf('Column %d', colLeft)})

subplot(2,2,4)
colRight = 1020;
plot(right(:,colRight), 'LineWidth', lineWidth);
ylim([0,2600]);
xlim([924,1124]);
title({'Right view, lateral intensity profile', sprintf('Column %d', colRight)})

%
figure(1)
set(gcf, 'Color', 'white')
axialTicks = [0,512,1024,1536,2048];
axialTicks2 = [0,66,133,200,266];
lateralTicks = [974,1024,1074];
lateralTicks2 = [126,133,140];
pixelSize = 0.13;
for i = 1:4
    subplot(2,2,i)
    h = gca;
    h.GridColor = [1,1,1];
    h.GridAlpha = 1;
    grid on
    set(h, 'LineWidth', lineWidth)
    set(h, 'Box', 'on', 'Color', repmat(0.9,[1,3]), 'FontSize', 12)
    set(h, 'XTick', axialTicks2/pixelSize)
    set(h, 'XTickLabels', axialTicks2)
    if i>=3 
        set(h, 'XTick', lateralTicks2/pixelSize);
    set(h, 'XTickLabels', lateralTicks2)
    end
    xlabel('Position (\mum)')
    ylabel('Intenisty (DN)')
end
%%
scaleBarLenght = 50;
figure(2)
imagesc(left,[0,2600])
title('Left view')

figure(3)
imagesc(right,[0,2600])
title('Right view')

for i=2:3
    figure(i);    
    axis image
    colorbar
    rectangle('Position', [1800-scaleBarLenght/pixelSize/2, 1950, scaleBarLenght/pixelSize, 20], 'EdgeColor', 'none', 'FaceColor', 'white')
    text(1800, 1900, sprintf('%d \\mum', scaleBarLenght), 'Color', 'white', 'HorizontalAlignment', 'center')
end


%%

rotateticklabel(gca, 45)