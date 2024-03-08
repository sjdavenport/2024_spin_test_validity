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

