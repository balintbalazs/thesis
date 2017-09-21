%%
clear variables;
s = [773 773];
hs = ceil(s/2);
params.size = [s 773];
params.NA = 1.1;
params.lambda = 510e-9;
params.resLateral = 2e-9;
params.resAxial = 2e-9;
params.M = 50;
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
p = squeeze(PSF(:,hs(2),:))';
% p = p(1:end-offset,:);
pIllu = squeeze(mean(PSFillu,2));
% pIllu = pIllu(1+round(offset/2):end-round(offset/2),:);
% pIllu = squeeze(PSFillu(:,161,:));
pIllu = pIllu ./ max(pIllu(:));
p = p .* pIllu;
rots = [0,30,60,90];
% p2 = imrotate(p, rot, 'crop');
% p3 = imrotate(p, -1*rot, 'crop');
% p = p .* pIllu;
% p = imrotate(p, (180-rot)/2, 'crop');
% p = pIllu;

a = 1;
b = 0.002;
t = @(x)(log(a*x+b));
it = @(x)((exp(x)-b)/a);

f = figure(2);
% set(f, 'Position', [ 586        1697        1334         499]);
scaleBar = 1000e-9; % meters
pixelSize = params.resLateral;
margin = 0.03; % relative to image width (w)
thickness = 0.02;
w = s(1);
offset = (params.size(1) - w) / 2;

%%
for i = 1:4
    subplot(2,2,i)
    hold off
    p2 = imrotate(p, rots(i)/2, 'crop');
    p3 = imrotate(p, -rots(i)/2, 'crop');
    imagesc(t(p2 .* p3))
    hold on
    [C, h] = contour(t(p2 .* p3), 8,'Color', 'black');
    c = h.LevelList;
%     title('Detection')    
    axis image
    xlim([(s(2)-w)/2, (s(2)-w)/2+w+1]);
    ylim([(s(1)-w)/2, (s(1)-w)/2+w+1]);
    caxis([t(0) t(1)]);
    colorbar('FontSize',11,'YTick',[t(0), c, t(1)],'YTickLabel',[0, round(it(c),3), 1]);
    rectangle('Position', [offset+w-scaleBar/pixelSize-w*margin, offset+(1-margin)*w-thickness*w, scaleBar/pixelSize, thickness*w], 'FaceColor', 'white', 'EdgeColor', 'none');
    xticklabels('')
    yticklabels('')
end
%%
export_fig rotated_psfs.pdf
%%
rots = 0:1:90;
clear axial lateral;
for i = 1:length(rots);
    p2 = imrotate(p, rots(i)/2, 'crop');
    p3 = imrotate(p, -rots(i)/2, 'crop');
    P = p2 .* p3;
    lateral(i) = fwhm(1:s(1), P(hs(1),:));
    axial(i) = fwhm(1:s(1), P(:,hs(2)));
end
figure(3)
hold off
plot(rots, axial*pixelSize*1e6)
hold on
plot(rots, lateral*pixelSize*1e6)