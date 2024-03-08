fwhm_vals = 5:15;
plot(fwhm_vals, [1,2,2,3,4,4,5,6,8,9,10])
hold on

srf = loadsrf('fs5', 'sphere');
fwhmconverts = zeros(1,length(fwhm_vals));
for I = 1:length(fwhm_vals)
    fwhm = fwhm_vals(I);
    fwhmconverts(I) = srf_fwhm2niters(fwhm, srf, 1.48);
end
plot(fwhm_vals, fwhmconverts)