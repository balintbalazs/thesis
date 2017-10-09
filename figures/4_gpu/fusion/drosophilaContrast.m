folder = 'D:\Documents\data\GPU_fusion\';

fnLeft = 'D2re_left.tif';
fnRight = 'D2re_right.tif';
fnFused = 'D2re_fused.tif';

%%
left = readTiff3D([folder, fnLeft]);
right = readTiff3D([folder, fnRight]);
fused = readTiff3D([folder, fnFused]);

%%
pPSFSupportDiameter = 3;
[height, width, depth] = size(left);
lOTFSupportX = width / pPSFSupportDiameter;
lOTFSupportY = height / pPSFSupportDiameter;
%%
DCTSLeft = DCTS_perSlice(left, lOTFSupportX, lOTFSupportY);

%%
DCTSRight = DCTS_perSlice(right, lOTFSupportX, lOTFSupportY);

%%
DCTSFused = DCTS_perSlice(fused, lOTFSupportX, lOTFSupportY);

%%
DCTSMean = DCTS_perSlice(wMean, lOTFSupportX, lOTFSupportY);


%%
figure(pPSFSupportDiameter)
hold off
plot(DCTSFused, 'LineWidth', 2)
hold on
plot(DCTSLeft)
plot(DCTSRight)
xlabel('z position in stack (\mum)')
legend({'Fused', 'Left', 'Right'}, 'Location', 'northeastoutside')
ylabel('DCTS')
xlim([1,depth])
% ylim([0.002, 0.02])
title({'Image contrast', 'depending on z position'})
set(gcf, 'Color', 'white')
%%
weightsRight = DCTSRight ./ (DCTSRight + DCTSLeft);
wMean = zeros(size(left));
leftM = fliplr(left);
for i = 1:depth
   wMean(:,:,i) = right(:,:,i) .* weightsRight(i) + ...
                + leftM(:,:,i) .* (1-weightsRight(i));
end
%%

%%
% %%
% params.size = [91 91 21];
% params.NA = 0.8;
% params.lambda = 600e-9;
% params.resLateral = 406.25e-9;
% params.resAxial = 406.25e-9;
% params.M = 5;
% params.ns  = 1.33;  % refractive index of sample
% params.ng0 = 1.33;  % coverslip RI, design
% params.ng  = 1.33;  % coverslip RI, experimental
% params.ni0 = 1.33;  % immersion RI, design
% params.ni  = 1.33;  % immersion RI, experimental
% params.ti0 = 1900e-6;  % working distance (um) i.e. distance to coverslip
% params.tg0 = 100e-6;     % coverslip thickness, design
% params.tg  = 50e-6;     % coverslip thickness, exerimental
% params.pZ = 50e-6;  % sample distance from coverslip
% 
% params.numBasis = 1000;
% params.numSamp = 2000;
% params.fastcom = 0;
% params.overSampling = 3;
% 
% %%
% tic;
% PSF = MicroscPSF(params);
% t = toc;