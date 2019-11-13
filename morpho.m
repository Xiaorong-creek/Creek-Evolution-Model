function [creekupdate] = morpho(eta1,creek1,tau1,tauc,T,polsea,LOGI,LAT)

% eq(4) --> P(S)=exp(-E(S)/T)
a=size(eta1);
eta1(creek1)=0;
expect=(-1)*sum(sum(eta1))/(a(1)*a(2)-sum(sum(creek1)));
ord=floor( log10(expect));
expect=expect/(10^(ord+2));
if expect>0
    expect=(-1)*expect;
end
prob=exp(expect/T);

% find all bordering cells and their bed stress
idx_inq=[];tau_inq=[];
[row,col]=find(creek1==1);

neighcheck =  zeros(size(creek1)); % Opitimize - mask cells that's been searched out

for m=1:length(row)
    r=row(m);c=col(m);
    neigh(1:8,1:2) = [r+[-1;0;1;-1;1;-1;0;1] c+[-1;-1;-1;0;0;1;1;1] ]; %8neighbors of one of the creek cells
    
    idx=sub2ind(size(creek1),[neigh(:,1)],[neigh(:,2)]); %convert index to linear index
    L=creek1(idx);tauL=tau1(idx);
    idx1=idx(~L);tauL1=tauL(~L);
    
    Duplicates = neighcheck(idx1); % Opitimize - mask cells that's been searched out
    idx1 = idx1(~Duplicates); tauL1 = tauL1(~Duplicates);% Opitimize - mask cells that's been searched out

    idx_inq=[idx_inq
             idx1];
    tau_inq=[tau_inq
             tauL1];
    neighcheck(idx1)=1; % Opitimize - mask cells that's been searched out
end
Uniidxtau=[idx_inq tau_inq];

%remove neighboring cells that are in the sea
M=LOGI(Uniidxtau(:,1));N=LAT(Uniidxtau(:,1));
LS=inpolygon(M,N,polsea(:,1),polsea(:,2));
Uniidxtau1=Uniidxtau(~LS,:);

% calculate bed stress exceedances and remove negative ones
tc  = tauc(Uniidxtau1(:,1));
tauex = [Uniidxtau1(:,1) Uniidxtau1(:,2)-tc];
Lex = tauex(:,2)>=0;
Uniidxtau2=tauex(Lex,:);

% check if there is still stress exceedances
tauexn=size(Uniidxtau2,1);
   if tauexn>0 %there is still stress exceedance
    
      % sort positive bed stress exceedances in descending order
      Unitauidx=sortrows(Uniidxtau2,2,'descend');

      % connect a new pixel to creek
      lp=0;
      for n=1:size(Unitauidx,1)
          R=rand;
          if R>prob
              creekupdate=Unitauidx(n);
              %disp 'Signal: R>P is found'
             break
          end
          lp=lp+1;
      end
    
          if lp==size(Unitauidx,1)
              creekupdate=Unitauidx( 1+floor ( rand*size(Unitauidx,1) ) );
              %disp 'Signal: no R>P is found'
          end
       
   else %there is no more stress exceedance
    creekupdate=size(LOGI,1)*size(LOGI,2)+1;
   end
   
end % end of function





