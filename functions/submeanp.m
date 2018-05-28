function outdata=submeanp(data,c_ind,c_mean);

%for c_ind=1:size(data,2);
    outdata=data(:,c_ind,:)-c_mean;
%end;


