%%
clear variables;
params.size = [5 161 321];
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
tic;
PSF = MicroscPSF(params);
t = toc;

disp(['Running time = ' num2str(t) 's']);
% imagesc(squeeze(PSF(:,80,:))',[0, 0.11]), axis image
%%
p = squeeze(PSF(:,3,:))';
a = 1;
b = 0.002;
t = @(x)(log(a*x+b));
it = @(x)((exp(x)-b)/a);

% subplot(1,2,1)
hold off
imagesc(t(p))
hold on
[C,h] = contour(t(p), 8,'Color', 'black');
axis image
c = h.LevelList;
caxis([t(0) t(1)]);
colorbar('FontSize',11,'YTick',[t(0), c, t(1)],'YTickLabel',[0, round(it(c),3), 1]);

% %%
% subplot(1,2,2)
% c = [0, 0.001, 0.002, 0.005, 0.01, 0.015, 0.02, 0.03, 0.05, 0.1, 0.2, 0.3, 0.5, 0.7, 0.9];
% contourf(t(p), t(c));
% axis image
% colorbar