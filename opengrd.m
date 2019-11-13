
function [longgrdenc,latgrdenc]=opengrd (filename) % first you have longitude and then latitude
% this is the encription grid, or this grid will also include the
% additional array from the grid at half cell distance from the last cell
% read and parse encriptio grid data negative
fileid=fopen(filename);
% auxiliary variables
% gotres = 0.5; read from file
nlhead = 8; %%%%%%%%%%%%%************************************NL cambiato qst to 8 % this is the number of lines before the coordiante system starts
%maxcol=361; %read from file
% maxrow=720; %read from file
ncolfile = 5; % number of column of grd

if fileid<0 % if fileid=-1 it was not able to open the file
    disp ('Error reading file...')
end

ln=1; %line counter; updated every loop

narm=1;
npas=1;
nrow=0;
flaglat=0;
ncol=1;
sumnrow=0;

while (~feof(fileid)) %as long as file is not over
    
    linetxt=fgetl(fileid);

    if ln==7 % this is the line afetr the header where there is M, N number
        [token,rest]=strtok(linetxt,' ');
        maxcol=str2double(token); % number of column
        maxrow=str2double(rest); %number of row
    end
    
    if ln>8 % now the coordiante system starts. 
        [token,rest]=strtok(linetxt,' ');
        
        %%%%----If it starts with ETA means new ROW
        if strcmp(token,'ETA=') % compare two strings if start with ETA (strcmp==1)means new row. 
            [token,rest]=strtok(rest,' ');
            nrow=str2double(token); % number of row is take after ETA 
            sumnrow=sumnrow+1; % sum the number of rows
            ncol=1;
            %and push the rest to the line adding the column
            
            if sumnrow>maxrow 
            % if has finished the rows it means that it has finished presenting the longitute and start presenting the latitudes. 
                flaglat=1;
            end
            
            while ~isempty(rest) % continue adding numbers unil the numbers in the row are over. 
                [token,rest]=strtok(rest,' ');
                if flaglat
                    latgrd(nrow,ncol)=str2double(token); % latituted for one row
                    ncol=ncol+1;
                else
                    longgrd(nrow,ncol)=str2double(token); %longitude for one row
                    ncol=ncol+1;
                end
                
            end
            
        %%%%----If it does NOT start with ETA means need to continue previous row  
        else
            %this is because it reads at least once the first token
            if flaglat
                latgrd(nrow,ncol)=str2double(token);
                ncol=ncol+1;
            else
                longgrd(nrow,ncol)=str2double(token);
                ncol=ncol+1;
            end
            while ~isempty(rest)
                [token,rest]=strtok(rest,' ');
                if flaglat
                    latgrd(nrow,ncol)=str2double(token);
                    ncol=ncol+1;
                else
                    longgrd(nrow,ncol)=str2double(token);
                    ncol=ncol+1;
                end
                
            end
        end
        %if nrow==maxrow
        
    end
    
    ln=ln+1;
    
end

longgrdenc(1:maxrow+1,1:maxcol+1)=-999;
latgrdenc(1:maxrow+1,1:maxcol+1)=-999;

longgrdenc(1:maxrow,1:maxcol)=longgrd;
latgrdenc(1:maxrow,1:maxcol)=latgrd;

longgrdenc(end,1:end)= 2*longgrdenc(end-1,1:end)-longgrdenc(end-2,1:end);
longgrdenc(1:end,end)= 2*longgrdenc(1:end,end-1)-longgrdenc(1:end,end-2);

latgrdenc(end,1:end)= 2*latgrdenc(end-1,1:end)-latgrdenc(end-2,1:end);
latgrdenc(1:end,end)= 2*latgrdenc(1:end,end-1)-latgrdenc(1:end,end-2);

fclose(fileid);

end