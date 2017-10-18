%%
clear variables;
params.size = [387 387 387];
params.NA = 1.1;
params.lambda = 510e-9;
params.resLateral = 25e-9;
params.resAxial = 25e-9;
params.M = 5;
params.ns  = 1.33;  % refractive index of sample
params.ng0 = 1.33;  % coverslip RI, design
params.ng  = 1.33;  % coverslip RI, experimental
params.ni0 = 1.33;  % immersion RI, design
params.ni  = 1.33;  % immersion RI, experimental
params.ti0 = 1900e-6;  % working distance (um) i.e. distance to coverslip
params.tg0 = 100e-6;     % coverslip thickness, design
params.tg  = 50e-6;     % coverslip thickness, exerimental
params.pZ = 50e-6;  % sample distance from coverslip

params.numBasis = 1000;
params.numSamp = 2000;
params.fastcom = 0;
params.overSampling = 3;
%%
paramsIllu = params;
paramsIllu.NA = 0.1;
paramsIllu.lambda = 488e-9;
%%
tic;
PSF = MicroscPSF(params);
PSFillu = MicroscPSF(paramsIllu);
t = toc;

disp(['Running time = ' num2str(t) 's']);
% imagesc(squeeze(PSF(:,80,:))',[0, 0.11]), axis image
%%
offset = 0;
p = squeeze(PSF(:,194,:))';
p = p(1:end-offset,:);
pIllu = squeeze(mean(PSFillu,2));
pIllu = pIllu(1+round(offset/2):end-round(offset/2),:);
% pIllu = squeeze(PSFillu(:,161,:));
pIllu = pIllu ./ max(pIllu(:));
% p = p .* pIllu;
rot = 90;
p2 = imrotate(p, rot, 'crop');
% p3 = imrotate(p, -1*rot, 'crop');
% p = p .* pIllu;
% p = imrotate(p, (180-rot)/2, 'crop');
% p = pIllu;

a = 1;
b = 0.002;
t = @(x)(log(a*x+b));
it = @(x)((exp(x)-b)/a);

f = figure(1)
% set(f, 'Position', [ 586        1697        1334         499]);

w = 321;
%%
subplot(1,3,2)
hold off
imagesc(t(p))
hold on
[C,h] = contour(t(p), 8,'Color', 'black');
c = h.LevelList;
title('Detection')
%
subplot(1,3,1)
hold off
imagesc(t(pIllu))
hold on
[C,h] = contour(t(pIllu), c,'Color', 'black');
title('Illumination')
%
subplot(1,3,3)
hold off
imagesc(t(p.*pIllu))
hold on
[C,h] = contour(t(p.*pIllu), c,'Color', 'black');
title('Combined')

for i = 1:3
    subplot(1,3,i)    
    axis image
    s=size(pIllu);
    xlim([(s(2)-w)/2, (s(2)-w)/2+w+1]);
    ylim([(s(1)-w)/2, (s(1)-w)/2+w+1]);
    caxis([t(0) t(1)]);
    colorbar('FontSize',11,'YTick',[t(0), c, t(1)],'YTickLabel',[0, round(it(c),3), 1]);
    rectangle('Position', [290, 330, 1/0.025, 5], 'FaceColor', 'white', 'EdgeColor', 'white')
    xticklabels('')
    yticklabels('')
end
%%
export_fig psf_spim.pdf
%%
%
set(gcf, 'Color', 'w');
subplot(1,2,2)
otf = psf2otf(p);
otf(1:1);
% otf(1:1) = 1;
otf = fftshift(otf);
% otf = fftshift(psf2otf(p));
mtf = abs(otf);
mtf = mtf / max(mtf(:));
% mtf = mtf(120:202,120:202);
t = @(x)(x);
it = @(x)(x);
hold off
imagesc(t(mtf))
hold on
[C,h] = contour(t(mtf), 4,'Color', 'black');
% [C,h] = contour(t(p1), 8,'Color', 'black');
% [C,h] = contour(t(p2), 8,'Color', 'black');
axis image
w = 66;
% xlim([(s(2)-w)/2, (s(2)-w)/2+w+1]);
% ylim([(s(1)-w)/2, (s(1)-w)/2+w+1]);
c = h.LevelList;
% caxis([t(0) t(1)]);
colorbar('FontSize',11,'YTick',[t(0), c, t(1)],'YTickLabel',[0, round(it(c),3), 1]);
