function outdata=corr_loop(datafname,chansfname,varargin)

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

outdata=zeros(size(data,1),size(data,3));
for r_ind=1:size(data,1);
    for p_ind=1:size(data,3);
        tmp=corr(data(r_ind,:,p_ind),data(chan_inds(r_ind),:,p_ind));
        outdata(r_ind,p_ind)=tmp(size(tmp,1),1);
    end;
end;


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
