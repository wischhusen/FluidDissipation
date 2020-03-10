within FluidDissipation.Examples.Verifications.HeatTransfer.Plate;
model kc_overall_KC "Verification of function kc_overall_KC"

  parameter Integer n=size(cp, 1);

  //plate variable
  parameter Modelica.Units.SI.Length L=1 "Length of plate";

  //fluid property variables
  parameter Modelica.Units.SI.SpecificHeatCapacityAtConstantPressure cp[:]={
      1007,4189,3384.550}
    "Specific heat capacity at constant pressure of fluid";
  parameter Modelica.Units.SI.DynamicViscosity eta[:]={18.24e-6,1001.6e-6,0.114}
    "Dynamic viscosity of fluid";
  parameter Modelica.Units.SI.ThermalConductivity lambda[:]={25.69e-3,598.5e-3,
      0.387} "Thermal conductivity of fluid";
  parameter Modelica.Units.SI.Density rho[:]={1.188,998.21,1037.799}
    "Density of fluid";

  //here: Nusselt number as input for reverse calculation
  Modelica.Units.SI.NusseltNumber Nu[n]=ones(n)*input_Nu.y;
  Modelica.Units.SI.Velocity velocity[n](start=ones(n)*1e-6);
  Modelica.Units.SI.CoefficientOfHeatTransfer kc[n]={Nu[i]*lambda[i]/L for i
       in 1:n};

  //input record
  FluidDissipation.HeatTransfer.Plate.kc_overall_IN_con IN_con[n](each L=L)
    annotation (Placement(transformation(extent={{-20,20},{0,40}})));

  FluidDissipation.HeatTransfer.Plate.kc_overall_IN_var IN_var[n](
    cp=cp,
    eta=eta,
    lambda=lambda,
    rho=rho,
    velocity=abs(velocity))
    annotation (Placement(transformation(extent={{0,20},{20,40}})));

  Modelica.Units.SI.PrandtlNumber Pr[n]={eta[i]*cp[i]/lambda[i] for i in 1:n}
    "Prandtl number";
  Modelica.Units.SI.ReynoldsNumber Re[n]={rho[i]*abs(velocity[i])*L/eta[i] for
      i in 1:n} "Reynolds number";

public
  Modelica.Blocks.Sources.Ramp input_Nu(
    startTime=0,
    duration=1,
    height=1e6,
    offset=1e0) annotation (Placement(
        transformation(extent={{50,-80},{70,-60}})));
equation
  //heat transfer calculation
  kc = {FluidDissipation.HeatTransfer.Plate.kc_overall_KC(IN_con[i], IN_var[i])
    for i in 1:n};

  annotation (__Dymola_Commands(file=
          "modelica://FluidDissipation/Extras/Scripts/heatTransfer/plate/kc_overall_KC.mos"
        "Verification of kc_overall_KC"), Diagram(coordinateSystem(
          preserveAspectRatio=true, extent={{-100,-100},{100,100}}), graphics={
          Text(
          extent={{-100,50},{100,75}},
          lineColor={0,0,255},
          textString=
            "Heat transfer of plate for OVERALL flow regime (inlining)"),Text(
          extent={{-100,11},{100,6}},
          lineColor={0,0,255},
          textString="Target: m_flow == f(kc)"),Text(
          extent={{-98,-50},{102,-25}},
          lineColor={0,0,255},
          textString=
            "Here: unintended input variables for creation of nonlinear equations (proof analytical Jacobians)")}));
end kc_overall_KC;
