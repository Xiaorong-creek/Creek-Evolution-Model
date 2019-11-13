function [Nb] = veg(deltat,deltax,deltay,tau2,dep,el,Nb,Pestv,Dv,r_growv,K_growv,PEtv,PEhv,t_crpv,H_crpv)

  H=dep+el;
 
%%%%%%%%%%%%%%%%%%% Loop

  Nf=10*rand(size(tau2,1),size(tau2,2)); %est  
  
  Nf(2:end-1,2:end-1)=Nf(2:end-1,2:end-1)+Dv*(diff(Nb(2:end-1,:),2,2)./deltax(2:end-1,1:end-1).^2 ...
      +diff(Nb(:,2:end-1),2,1)./deltay(1:end-1,2:end-1).^2); %diff
  
  Nf=Nf+r_growv*(1-Nb./K_growv).*Nb; %growth
  
  temp=(tau2-t_crpv);  temp(temp<0)=0;
  Nf=Nf-PEtv*temp; %flow
  
  temp=(H-H_crpv);  temp(temp<0)=0;
  Nf=Nf-PEhv*temp; %inund
  
  Nf(1,:)= 2;Nf(end,:)=2;Nf(:,1)=2;Nf(:,end)=2; %boundary condition
  
  Nb=Nb+deltat*Nf;
 
  Nb(isnan(Nb))=2;
  
end
