function outdata=subm_par(datafname,procs,varargin)

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

try pararrayfun;
    disp('paralle packages already loaded');
catch
    disp('loading parallel package');
    pkg load parallel;
end

outdata=zeros(size(data));
mdata=mean(data,2);
meanout=pararrayfun(procs,@(i)submeanp(data,i,mdata),[1:size(data,2)], 'UniformOutput', false);
outdata=cell2mat(meanout);


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
