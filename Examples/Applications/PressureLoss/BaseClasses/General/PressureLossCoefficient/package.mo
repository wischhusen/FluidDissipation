within FluidDissipation.Examples.Applications.PressureLoss.BaseClasses.General;
package PressureLossCoefficient "FluidDissipation: Generic function with pressure loss coefficient dependence"
extends
  FluidDissipation.Examples.Applications.PressureLoss.BaseClasses.General.BaseGeneralPL;


redeclare function extends massFlowRate_dp

  //input records for generic pressure loss coefficient (zeta_TOT) function
  input
    FluidDissipation.Examples.Applications.PressureLoss.BaseClasses.General.PressureLossCoefficient.PressureLossInput_con
    IN_con annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
  input
    FluidDissipation.Examples.Applications.PressureLoss.BaseClasses.General.PressureLossCoefficient.PressureLossInput_var
    IN_var annotation (Placement(transformation(extent={{-60,20},{-40,40}})));
  input SI.Pressure dp "Pressure loss" annotation (Dialog(tab="Input"));

algorithm
  M_FLOW :=
    FluidDissipation.PressureLoss.General.dp_pressureLossCoefficient_MFLOW(
    IN_con,
    IN_var,
    dp);

  annotation (Documentation(info="<html>
<p>
In this package the pressure loss function <a  
href=\"Modelica://FluidDissipation.PressureLoss.General.dp_genericPressureLossCoefficient_MFLOW\">  
dp_genericPressureLossCoefficient_MFLOW </a> of a generic function with pressure loss coefficient dependence out of the <b>  
FluidDissipation </b> library is implemented into an usable form for the replaceable pressure loss calculations of a <a  
href=\"Modelica://FluidDissipation.Examples.Applications.General\"> generic function </a> with the <b>Modelica.Fluid </b>  
library as thermo-hydraulic framework. 
</p>
 
<p>
This function executes the calculation of a generic function at the overall flow regime for an incompressible and single-phase  
fluid flow considering pressure loss coefficient (zeta) dependency. Here the mass flow rate (M_FLOW) is calculated in dependence  
of a known pressure loss (dp).
</p>
 
<p>
A test case ready for the simulation of a Modelica.Fluid generic function can be found in <a  
href=\"Modelica://FluidDissipation.Examples.TestCases.PressureLoss.General\"> Test: Generic functions </a>.
</p>
 
</html>
"));
end massFlowRate_dp;
end PressureLossCoefficient;
