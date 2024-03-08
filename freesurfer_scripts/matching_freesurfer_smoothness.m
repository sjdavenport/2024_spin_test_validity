%% Fs5
fwhm_vals = [5:15, 20,25,30,35,40,45];
plot(fwhm_vals, [1,2,2,3,4,4,5,6,8,9,10, 18,28,40,54,71,90])
hold on

srf = loadsrf('fs5', 'sphere');
fwhmconverts = zeros(1,length(fwhm_vals));
for I = 1:length(fwhm_vals)
    fwhm = fwhm_vals(I);
    fwhmconverts(I) = srf_fwhm2niters(fwhm, srf, 1.475);
end
plot(fwhm_vals, fwhmconverts)

%%
