function out=corrp(data,chan_inds,p_ind);

for r_ind=1:size(data,1);
%    for p_ind=1:size(data,3);
        tmp=corr(data(r_ind,:,p_ind),data(chan_inds(r_ind),:,p_ind));
        out(r_ind)=tmp(size(tmp,1),1);
%    end;
end;

