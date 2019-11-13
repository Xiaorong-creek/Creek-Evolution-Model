
function [depth]=opendep (filename) 

fileid=fopen(filename);
nrow=1;
ncol=1;

while (~feof(fileid))

  linetxt=fgetl(fileid);
  checker=size(linetxt,2);

    if checker== 128 
        rest=1;
        while ~isempty(rest)
        [token,rest]=strtok(linetxt,' ');
        linetxt=rest;
        depth(nrow,ncol)=str2double(token);
        ncol=ncol+1;
        end
        nrow=nrow+1;
        ncol=1;       
    else
        rest=1;
        while ~isempty(rest)
        [token,rest]=strtok(linetxt,' ');
        linetxt=rest;
        depth(nrow,ncol)=str2double(token);
        ncol=ncol+1;
        end
    end
end   

end