%% Fs5
fwhm_vals = [5:15, 20,25,30,35,40,45];
plot(fwhm_vals, [1,2,2,3,4,4,5,6,8,9,10, 18,28,40,54,71,90])
hold on

srf = loadsrf('fs5', 'sphere');
fwhmconverts = zeros(1,length(fwhm_vals));
for I = 1:length(fwhm_vals)
    fwhm = fwhm_vals(I);
    fwhmconverts(I) = srf_fwhm2niters(fwhm, srf.lh, 1.478);
end
plot(fwhm_vals, fwhmconverts)

%% Fs6
fwhm_vals = 5:5:45;
plot(fwhm_vals, [4,18,40,71,111,160,218,285,360])
hold on

srf = loadsrf('fs6', 'sphere');
fwhmconverts = zeros(1,length(fwhm_vals));
for I = 1:length(fwhm_vals)
    fwhm = fwhm_vals(I);
    fwhmconverts(I) = srf_fwhm2niters(fwhm, srf.lh, 1.478);
end
plot(fwhm_vals, fwhmconverts)

%%
a = load('bert_thickness_vars.mat');
unsmoothed_data = bert_ic6_fwhm_0_thickness.data;
smoothed_data = bert_ic6_fwhm_40_thickness.data;
srf6sphere = loadsrf('fs6', 'sphere');
mysmoothed_data = smooth_surface(srf6sphere.lh, unsmoothed_data, 40);

%%
srf6sphere = loadsrf('fs6', 'sphere');
a = load('fssmoothnoise.mat');
subplot(1,2,1)
srfplot(srf6sphere.lh, a.data.fwhm10)
subplot(1,2,2)
srfplot(srf6sphere.lh, a.data.fwhm15)

%%
subplot(1,2,1)
mysmooth = smooth_surface(srf6sphere.lh, a.data.fwhm0, 15,'ones', 64);
srfplot(srf6sphere.lh, mysmooth)
title('Mysmooth', 'color', 'white')
subplot(1,2,2)
srfplot(srf6sphere.lh, a.data.fwhm15)
title('FSsmooth', 'color', 'white')
% saveim('smooth15_40.pdf')

%%
niter_vals = 58:80;
store_mse = zeros(1,length(niter_vals));
for I = 1:length(store_mse)
    mysmooth = smooth_surface(srf6sphere.lh, a.data.fwhm0, 15,'ones', niter_vals(I));
    store_mse(I) = sum((a.data.fwhm15 - mysmooth).^2);
end
plot(niter_vals, store_mse)

%%
subplot(1,2,1)
mysmooth = smooth_surface(srf6sphere.lh, a.data.fwhm0, 15);
srfplot(srf6sphere.lh, mysmooth)
title('Mysmooth', 'color', 'white')
subplot(1,2,2)
srfplot(srf6sphere.lh, a.data.fwhm15)
title('FSsmooth', 'color', 'white')

%%
niter_vals = 20:45;
store_mse = zeros(1,length(niter_vals));
for I = 1:length(store_mse)
    I
    mysmooth = smooth_surface(srf6sphere.lh, a.data.fwhm0, 10,'ones', niter_vals(I));
    store_mse(I) = sum((a.data.fwhm10 - mysmooth).^2);
end
plot(niter_vals, store_mse)

%%
subplot(1,2,1)
mysmooth = smooth_surface(srf6sphere.lh, a.data.fwhm0, 10);
srfplot(srf6sphere.lh, mysmooth)
title('Mysmooth', 'color', 'white')
subplot(1,2,2)
srfplot(srf6sphere.lh, a.data.fwhm10)
title('FSsmooth', 'color', 'white')
saveim('smooth10_18.pdf')

subplot(1,2,1)
mysmooth = smooth_surface(srf6sphere.lh, a.data.fwhm0, 10, 'ones', 30);
srfplot(srf6sphere.lh, mysmooth)
title('Mysmooth', 'color', 'white')
subplot(1,2,2)
srfplot(srf6sphere.lh, a.data.fwhm10)
title('FSsmooth', 'color', 'white')
saveim('smooth10_30.pdf')


%%
b = load('unsmoothed_data.mat');
bertsphere = loadsrf('bert', 'sphere.reg');
bertsmooth10 = smooth_surface(bertsphere.lh, b.data.lh, 10);
subplot(1,2,1)
srfplot(bertsphere.lh, bertsmooth10)
subplot(1,2,2)
srfplot(srf6sphere.lh, a.data.fwhm10)

%%
niters = srf_fwhm2niters(10, srf6sphere.lh)

%%
bertsrf = loadsrf('bert', 'sphere.reg');
subplot(1,2,1)
srfplot(srf6sphere.lh, smoothed_data)
subplot(1,2,2)
srfplot(bertsrf.lh, a.bert_orig_thickness.data)
