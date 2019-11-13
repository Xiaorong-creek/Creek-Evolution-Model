%%%%%%%%%%%%%%%%%%% Parameters
tend   = 2000;                     %Please give value - Time step of each simulation
nsim   = 100;                      %Please give value - Number of simulations
ramp   = 10;                       %Please give value 
DLand  = 0.4;                      %Please give value - Land elevation above which creek evolution will not happen

A      = 4;                        %Please give value - Tidal amplitude        
dt     = 0.01;                     %Please give value         
phase  = 0;                        %Please give value     
u0     = 0.5;                      %Please give value - Characteristic value of max current   
z0     = 0.3;                      %Please give value  
Chi    = 30;                       %Please give value - Chezy’s friction coefficient
Chv    = 20;                       %Please give value - Chezy’s friction coefficient when vegetation is present
taucri = 0.1;                      %Please give value - Critical shear stress for erosion
taucrv = 0.3;                      %Please give value - Critical shear stress for erosion when vegetation is present
temperature = 0.1;                 %Please give value - Proxy of reference potential energy of the system
nbest  = 10;                       %Please give value - Stem density of initial establishment  
gamma  = 9.81*10^3; 

%%%%%%%%%%%%%%%%%%% Parameters for the vegetation module
Mveg   = 0;       %Please give value - '1' to activate vegetation module; '0' to deactivate
Pest   = 0.01;    %Please give value - Chance of plant establishment
D      = 0.2;     %Please give value - Coefficient for plant diffusion
r_grow = 1.0;     %Please give value - Intrinsic growth rate of stem density
K_grow = 1200;    %Please give value - Maximum stem density                               
PEt    = 30;      %Please give value - Plant mortality coefficient related to flow stress
PEh    = 3000;    %Please give value - Plant mortality coefficient related to inundation
t_crp  = 0.26;    %Please give value - Critical shear stress for plant mortality
H_crp  = 1.1;     %Please give value - Critical inundation height plant mortality
