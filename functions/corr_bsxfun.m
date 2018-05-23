function outdata=corr_bsxfun(datafname,chansfname,varargin)

%HANDLE INPUTS
outfname='';
ofi=(find(strcmp('outfname',varargin)));
if ~isempty(ofi);outfname=varargin{ofi+1};end

proffname='';
pfi=(find(strcmp('proffname',varargin)));
if ~isempty(pfi);proffname=varargin{pfi+1};end

tictoc='on';
tti=(find(strcmp('tictoc',varargin)));
if ~isempty(tti);tictoc=varargin{tti+1};end

%START PROFILING
if ~isempty(proffname);
  profile off;
  profile on;
end

if strcmp(tictoc,'on');
  tic;
end


%PERFORM CALCULATIONS
load(datafname);
load(chansfname);

az = bsxfun(@minus, data, mean(data,2));
bz = bsxfun(@minus,data(chan_inds,:,:), mean(data(chan_inds,:,:),2));
a2 = az .^ 2;
b2 = bz .^ 2;
ab = az .* bz;
outdata=squeeze(sum(ab,2)./sqrt(sum(a2,2).*sum(b2,2)));


%END PROFILING
if strcmp(tictoc,'on');
  toc
end

if ~isempty(proffname);
  p_info=profile('info');
  profile off;
  save(proffname,'p_info');
end

%WRITE OUTPUT FILE
if ~isempty(outfname);
  save(outfname,'outdata');
end
