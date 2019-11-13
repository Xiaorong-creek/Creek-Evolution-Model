This model is written by Xiaorong Li (xiaorong.li@liverpool.ac.uk; xiaorongli.912@gmail.com) to produce results published in:
Li, X., Leonardi, N., Plater, A. (2019). A stochastic approach to modeling tidal creek evolution: Exploring environmental influences on creek topologies through ensemble predictions. Geophysical Research Letters.

The model is based on methods documented in:
[1] D'Alpaos, A., Lanzoni, S., Marani, M., Fagherazzi, S., & Rinaldo, A. (2005). Tidal network ontogeny: Channel initiation and early development. Journal of Geophysical Research: Earth Surface, 110(F2).
[2] Temmerman, S., Bouma, T. J., Van de Koppel, J., Van der Wal, D., De Vries, M. B., & Herman, P. M. J. (2007). Vegetation causes channel erosion in a tidal landscape. Geology, 35(7), 631-634.
******************************************************************************************************************************

To run the model, four input files are required:
1. A grid file defining the model domain. The example (Hesketh.grd) was created using the Delft3D GUI;
2. A bathymetry file.  The example (Hesketh.dep) was created using the Delft3D GUI;
3. A file indicating locations of the existing creek. The example (Hesketh_inicreek.dry) was created using the Delft3D GUI;
4. A polygon file enclosing the offshore area. The example (Hesketh_offshore.pol) was created using the Delft3D GUI.

The above four input files are loaded in '1prep.m', which means 1prep.m needs to be run first.
******************************************************************************************************************************

Parameters of the model are defined in 2parameters.m. They need to be assigned values according to the users' cases. 
******************************************************************************************************************************

The main calculation is in '3main.m'.
******************************************************************************************************************************

The other matlab scripts (locinicreek.m, morpho.m, veg.m, opendep.m and opengrd.m) are functions that will be called by 1prep.m and/or 3main.m. These ones don't need to be run actively.
******************************************************************************************************************************

In summary, the work flow should be:
1.   Prepare input files
2.   Set parameters in 2parameters.m (Please refer to the above-mentioned publications for detailed description of the parameters)
3.   run 1prep.m
4.   run 2parameters.m
5.   run 3main.m
******************************************************************************************************************************

Please contact Xiaorong Li (xiaorong.li@liverpool.ac.uk; xiaorongli.912@gmail.com) if you have questions/comments/suggestions.

------------------------------------------------------------------------------------------------------------------------------

