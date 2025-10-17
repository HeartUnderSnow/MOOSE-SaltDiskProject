[Mesh]
    type = GeneratedMesh
    dim = 2
    coord_type = RZ
    xmin = 0
    xmax = 0.0065
    ymin = 0
    ymax = 0.00003
    nx = 30
    ny = 20
[]

[Variables]
    [Cr_concentration]
        initial_condition = 0.2
    []
[]

[AuxVariables]
    [defect_concentration]
    []
[]

[Kernels]
    [Cr_diffusion]
    type = MatDiffusion
    variable = Cr_concentration
    diffusivity = D_eff
    []

    [Cr_time]
        type = TimeDerivative
        variable = Cr_concentration
    []

    [Cr_source]
        type = BodyForce
        variable = Cr_concentration
        function = radiation_effect
    []
[]

[AuxKernels]
    [defect_calc]
        type = FunctionAux
        variable = defect_concentration
        function = defect_buildup
        execute_on = 'timestep_end'
    []
[]

[Functions]
    [radiation_effect]
        type = ParsedFunction
        # From SRIM:: 14 vaccancies/ion fpr 3 MeV in Ni-20Cr
        # Ion flux: 2.5465E13 ions/m^{2}/s
        # dpa rate: -1.3659E-10
        expression = 'if(x<0.0025, -1.3659e-10, 0)'
    []

    [defect_buildup]
        type = ParsedFunction
        # Defects accumulate over time in irradiated region
        expression = 'if(x<0.0025, 1e-10 + 1.3659E-10*t, 1e-10)'
    []
[]

[Materials]
    [diffusion_coef]
        type = GenericConstantMaterial
        prop_names = 'D_eff'
        prop_values = '1e-14'
    []
[]

[BCs]
    [Cr_surface]
        type = FunctionDirichletBC
        variable = Cr_concentration
        boundary = 'bottom'
        function = 'max(0.15, 0.2 - 0.00000694*t)'
    []
[]

[Executioner]
    type = Transient
    dt = 10
    end_time = 7200
    solve_type = NEWTON

    petsc_options_iname = '-pc_type -snes_linesearch_type'
    petsc_options_value = 'lu basic'

    nl_rel_tol = 1e-6
    nl_abs_tol = 1e-10
    nl_max_its = 20

    l_tol = 1e-8
    l_max_its = 100

    automatic_scaling = true
[]

[Outputs]
    exodus = true
    csv = true
[]

[Postprocessors]
    [Cr_at_surface]
        type = SideAverageValue
        variable = Cr_concentration
        boundary = 'bottom'
    []

    [Cr_at_center]
        type = PointValue
        variable = Cr_concentration
        point = '0 0.000015 0'
    []

    [defect_max]
        type = ElementExtremeValue
        variable = defect_concentration
        value_type = max
    []
[]
