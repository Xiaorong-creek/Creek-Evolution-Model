close all
LD  = inpolygon(X,Y,pol(:,1),pol(:,2));
LD1 = depth>DLand;

% Initialize
creek_need=zeros(nrow,ncol,nsim);   

tic;
for s=1:nsim
    s
% Initialize                                                                                                                                                                                                                                                                                                                                                                                                                                                                       
p=zeros(nrow,ncol);pd=zeros(nrow,ncol);
b=zeros(nrow,ncol);
taucr=taucri*ones(nrow,ncol);
Ch=Chi*ones(nrow,ncol);
plt=nbest*rand(nrow,ncol);
Z=depth;

% Initial creek 
creek=zeros(nrow,ncol);creek=logical(creek);
for i=1:size(inicreekN,1)
creek(inicreekN(i,1),inicreekN(i,2))=1;
end

%%% Main loop
cnt=0;
for t=1:tend
    t
%%%% eq1 - Calculate water surface elevation
%%% Source
  ele     =  A*cos(t*dt+phase); 
  dele_dt =  (-1)*A*dt*sin(t*dt+phase);
  down    = (ele-z0)^2;  
  up     = (8/3/pi)*(u0./Ch.^2);    
  coeff   =  up/down;
  b(:,:)  =  coeff*dele_dt;

%%% Water elevation for headward erosion
  for n = 1:1000    
      pd=p;
      for i=2:nrow-1
        for j=2:ncol-1
          p(i,j) = ((pd(i+1,j)+pd(i-1,j))*dy(i-1,j-1)^2 + (pd(i,j-1)+pd(i,j+1))*dx(i-1,j-1)^2 - b(i,j)*dx(i-1,j-1)^2*dy(i-1,j-1)^2 )/(dx(i-1,j-1)^2+dy(i-1,j-1)^2)/2;
        end
      end
      
      % boundaries 
      p(1:nrow-1,ncol)=p(1:nrow-1,ncol-1);  % sea obc - East
      p(1:nrow-1,1)=p(1:nrow-1,2);     % land
      p(1,1:ncol-1)=p(2,1:ncol-1);      % land
      p(nrow,1:ncol-1)=0; % sea obc - North
      p(creek)=0;     
  end

%%%% eq2 - Calculate bed stress
% gradient of surface water elevation
  dpx=diff(p,1,2); dpy=diff(p,1,1);
  px=dpx./dx;      py=dpy./dy; 
  px=[zeros(nrow,1) px];
  py=[zeros(1,ncol) 
      py];

% shear stress
  taux=gamma*(ele+p-Z).*px;
  tauy=gamma*(ele+p-Z).*py;
  tau=sqrt(taux.^2+tauy.^2); 
  tau1=tau; 
  tau(LD)=nan; tau(LD1)=nan; 

%%%% The creek evolution module
if t>ramp
  newcrkidx=morpho(p,creek,tau,taucr,temperature,pol,X,Y); 
  cnt=cnt+1;
  
  if cnt>1
     if newcrkidx<=nrow*ncol
       creek(newcrkidx)=1;
       Z(newcrkidx)=-1;
     else
        disp 'No more bed stress exceedance is found. Calculation complete.'
        break
     end
  end
  
end  

%%%%   The vegetation module 
if logical(Mveg)
   plt(creek)=2;
   plt = veg(dt,dx,dy,tau1,Z,ele,plt,Pest,D,r_grow,K_grow,PEt,PEh,t_crp,H_crp);  
   plt(plt<=0)=2;
   
   taucr(plt>=230)=taucrv;
   Ch(plt>0)=Chv;
end

end

creek_need(:,:,s)=creek; 

end
toc

prob=sum(creek_need(:,:,:),3)/nsim;
figure
contourf(X,Y,prob,100,'linestyle','none')