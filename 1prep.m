clear all;close all;clc

% Extract longgrdenc latgrdenc 
grdfile = 'Hesketh.grd';
[longgrdenc,latgrdenc]=opengrd(grdfile);
longgrdenc=longgrdenc(1:end-1,1:end-1);
latgrdenc=latgrdenc(1:end-1,1:end-1);

% Calculate dx and dy
X=longgrdenc; Y=latgrdenc; nrow=size(X,1); ncol=size(X,2);
dx=zeros(nrow,ncol-1);dy=zeros(nrow-1,ncol);
for i=1:nrow
    for j=1:ncol-1
        latlon1=[X(i,j) Y(i,j)];latlon2=[X(i,j+1) Y(i,j+1)];
        [dxtmp1 dxtmp2]=lldistkm(latlon1,latlon2);
        dx(i,j)=dxtmp1*1000;
    end
end
for j=1:ncol
    for i=1:nrow-1
        latlon1=[X(i,j) Y(i,j)];latlon2=[X(i+1,j) Y(i+1,j)];
        [dytmp1 dytmp2]=lldistkm(latlon1,latlon2);
        dy(i,j)=dytmp1*1000;
    end
end

% Extract depth 
depfile = 'Kesketh.dep';
depth=opendep(depfile);  %% call function opengrd to extract coordinates of mesh
depth=depth(1:end-1,1:end-1);
depth=(-1)*depth;

% Extract drypoint(initial creek) location
inicreekN=load('Hesketh_inicreek.dry');
inicreekN=inicreekN(:,2:3)-1;

% Load polygon for the open sea
pol=load('Hesketh_offshore.pol');

clearvars -except X Y dx dy nrow ncol depth inicreekN pol 

