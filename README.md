

## Overview 

In this repository, the depletion and diffusion of chroumium in half-inch wide disk of Ni-20Cr was modeled in MOOSE as it is irradiated by the proton beam current (2.5mm radius) and corroded by facing molten FLiNaK salt at 650\U+00B0 C. This is an attempt to verify the phenoma in which [Zhou et al.(2019)](https://doi.org/10.1016/j.nimb.2018.11.024) concluded proton irradiation de-accelerated corrosion of the Ni-20Cr foil in molten FLiNaK salt. 

![MIT Facility](ZhouDiagramExperimentalMiT.png)

**Features** 
- 2-D axial geometry of 30-micron Ni-20Cr foil 
- SRIM-derived displacment damage rates 
- Coupled Cr diffusion with radiative-enchanced transport 

## Geometry 
- Cr
- **Disk/Foil:** Ni-20Cr disk, 12.7 mm diameter, 30 micron thick 
- **Coordinate system:** 2D cylinderical (RZ) 
- **Mesh:** 30 x 20 elements 

### Physics 
1. **Chromium diffusion:** D = 1x10^{-14} \frac{m^{2}}{s} at 650\U+00B0 C 
2. **Radiation damage:** 3 MeV proton beam, 80 nA, 2.4 mm spot 
3. **Surface corrosion:** Dirichlet BC representing Cr depletion to 17%

**MOOSE Visualization of Cr Depletion**
![Cr depletion](MOOSE_visualization/Cr_depletion.png)
**MOOSE Visualization of Defect Concentraion** 
![Radiation damage](MOOSE_visualization/defect_concentration.png)

# SRIM/TRIM Calculation Results [2]:

## Parameters
- Ion: H (protons)
- Energy: 3 MeV
- Target: Ni-20Cr
- Density: 8.3 g/cm^{3}
- Thickness: 30 microns 
- Ions calculated: 9999

Displacement damage calculated via SRIM-2013
```
Ion flux: 2.5465x10^{13} \frac{ions}{m^{2}s}
Displacements: 14 vaccancies/ion 
dpa rate: 1.3659x10^{-10} dpa/s
```
![TargetVacancies](SRIM_data/TargetVacancies.png)

## Summary 

- **Peak defect concentration:** - 1.3659x10^{-10} dpa/s in irradiated region 
- Failed to repeat de-accelerated corrosion observed in [Zhou et al. (2019)](https://doi.org/10.1016/j.nimb.2018.11.024)
- Further refinement is needed to model the self-healing behavior of the alloy once exposed to proton irradiation 

## References
[1] Zhou, W., Woller, K. B., Zheng, G. (Tony), Stahle, P. W., & Short, M. P. (2019). A simultaneous corrosion/irradiation facility for testing molten salt-facing materials. Nuclear Instruments & Methods in Physics Research. Section B, Beam Interactions with Materials and Atoms, 440, 54–59. https://doi.org/10.1016/j.nimb.2018.11.024

[2] Ziegler, J. F., Ziegler, M. D., & Biersack, J. P. (2010). SRIM – The stopping and range of ions in matter (2010). Nuclear Instruments & Methods in Physics Research. Section B, Beam Interactions with Materials and Atoms, 268(11), 1818–1823. https://doi.org/10.1016/j.nimb.2010.02.091

