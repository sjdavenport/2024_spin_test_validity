FWHM_vec = [0,5,10,15,20,25];
fpr_vec = zeros(1, length(FWHM_vec));
for I = 1:length(FWHM_vec)
    I
    fpr_vec(I) = spin_fpr_singlesubject(FWHM_vec(I), 1000, 1000, 0);
    save('./fpr_vec', 'fpr_vec')
end

FWHM_vec = [0,5,10,15,20,25];
fpr_vec_mask = zeros(1, length(FWHM_vec));
for I = 1:length(FWHM_vec)
    I
    fpr_vec_mask(I) = spin_fpr_singlesubject(FWHM_vec(I), 1000, 1000, 1)
    save('./fpr_vec', 'fpr_vec', 'fpr_vec_mask')
end

%%
% [ interval, std_error ] = bernstd( 0.05, 1000, 0.95 )
FWHM_vec = [0,5,10,15,20,25];
plot(FWHM_vec, fpr_vec_mask, 'LineWidth', 4)
hold on
% plot(FWHM_vec, fpr_vec, 'LineWidth', 4)
plot(FWHM_vec, 0.05*ones(1, length(FWHM_vec)), '--', 'Color', 'black')
ylim([0,0.07])
matniceplot
BigFont(22)
xlabel('FWHM')
ylabel('FPR')
title('Spin test FPR')

%%
FWHM_vec = 0:1:10;
% fpr_vec = zeros(1, length(FWHM_vec));
for I = 1:length(FWHM_vec)
    if I > 9
        I
        fpr_vec(I) = oasis_fpr_singlesubject(FWHM_vec(I), 1000, 1000)
        save('./fpr_vec_oasis', 'fpr_vec')
    end
end

%%
FWHM_vec = 0:1:9;
fpr_vec = [0.0470    0.0460    0.0450    0.0500  0.058    0.0660         0.0695    0.0730    0.0700    0.0750 ];
plot(FWHM_vec, fpr_vec, 'LineWidth', 6)
hold on
% plot(FWHM_vec, fpr_vec, 'LineWidth', 4)
plot(FWHM_vec, 0.05*ones(1, length(FWHM_vec)), '-', 'Color', 'black')
stdlims = bernstd(0.05, 1000, 0.95);
plot(FWHM_vec, stdlims(1)*ones(1, length(FWHM_vec)), '--', 'Color', [0.5,0.5,0.5])
plot(FWHM_vec, stdlims(2)*ones(1, length(FWHM_vec)), '--', 'Color', [0.5,0.5,0.5])

% ylim([0,0.07])
xlim([0,9])
ylim([0,0.08])
matniceplot
BigFont(22)
xlabel('FWHM')
ylabel('FPR')
title('Spin test FPR')

%%
FWHM_vec = 10:5:30;
% fpr_vec_hs = zeros(1, length(FWHM_vec));
for I = 4:length(FWHM_vec)
    I
    fpr_vec_hs(I) = oasis_fpr_singlesubject(FWHM_vec(I), 1000, 1000)
    save('./fpr_vec_oasis_hs', 'fpr_vec_hs')
end

%%
FWHM_vec = 0:5:30;
fpr_vec_hs_6 = zeros(1, length(FWHM_vec));
for I = 1:length(FWHM_vec)
    I
    fpr_vec_hs_6(I) = oasis_fpr_singlesubject(FWHM_vec(I), 1000, 50, 'fs6')
    save('./fpr_vec_oasis_hs_6', 'fpr_vec_hs_6')
end

%% TODO for spin test fpr sims
% Run for higher smoothnesses, say FWHM = 0, 5, 10, 15, 20, 25, 30
% Run without the medial wall
% Run on a higher fs average shape

% All in all things would go a lot faster if you could run them on the
% servers!! So try and hook yourself up to that. Probably that has to wait
% until after the ICLR submission though!

%
FWHM_vec = 0:5:30;
fpr_vec_hs = [0.047 0.0660 0.0720    0.0730    0.0720    0.0580    0.0560];

plot(FWHM_vec, fpr_vec_hs, 'LineWidth', 6)
hold on
% plot(FWHM_vec, fpr_vec, 'LineWidth', 4)
plot(FWHM_vec, 0.05*ones(1, length(FWHM_vec)), '-', 'Color', 'black')
stdlims = bernstd(0.05, 1000, 0.95);
plot(FWHM_vec, stdlims(1)*ones(1, length(FWHM_vec)), '--', 'Color', [0.5,0.5,0.5])
plot(FWHM_vec, stdlims(2)*ones(1, length(FWHM_vec)), '--', 'Color', [0.5,0.5,0.5])

% % ylim([0,0.07])
% xlim([0,9])
ylim([0,0.08])
matniceplot
BigFont(22)
xlabel('FWHM')
ylabel('FPR')
title('Spin test FPR')

%%
for I = 2:43
    system(['mv nnindices_subject_', num2str(I), '.mat fs6_nnnnindices_subject_', num2str(I), '.mat'])
end
