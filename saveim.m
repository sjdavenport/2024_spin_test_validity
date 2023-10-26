function saveim( figname, do_trans )
% NEWFUN
%--------------------------------------------------------------------------
% ARGUMENTS
% Mandatory
% Optional
%--------------------------------------------------------------------------
% OUTPUT
% 
%--------------------------------------------------------------------------
% EXAMPLES
% 
%--------------------------------------------------------------------------
% AUTHOR: Samuel Davenport
%--------------------------------------------------------------------------

%%  Check mandatory input and get important constants
%--------------------------------------------------------------------------

%%  Add/check optional values
%--------------------------------------------------------------------------
if ~exist( 'figname', 'var' )
   % Default value
   figname = 'screenfig';
end

if ~exist( 'do_trans', 'var' )
   % Default value
   do_trans = 0;
end

%%  Main Function Loop
%--------------------------------------------------------------------------
if do_trans == 1
    export_fig(['C:/Users/12SDa/global/TomsMiniProject/Matlab/Figures/', figname], '-transparent')
else
    export_fig(['C:/Users/12SDa/global/TomsMiniProject/Matlab/Figures/', figname])
end
end

