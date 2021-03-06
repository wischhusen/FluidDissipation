within FluidDissipation.Examples.Applications.PressureLoss.BaseClasses.Nozzle;
package ConicalOverall "FluidDissipation: Overall flow regime in a nozzle diffuser"
extends
  FluidDissipation.Examples.Applications.PressureLoss.BaseClasses.Nozzle.BaseNozzlePL;


redeclare function extends pressureLoss_mflow

  //input records for nozzle function
  input
    FluidDissipation.Examples.Applications.PressureLoss.BaseClasses.Nozzle.ConicalOverall.PressureLossInput_con
    IN_con annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
  input
    FluidDissipation.Examples.Applications.PressureLoss.BaseClasses.Nozzle.ConicalOverall.PressureLossInput_var
    IN_var annotation (Placement(transformation(extent={{-60,20},{-40,40}})));
  input SI.MassFlowRate m_flow "Mass flow rate" annotation (Dialog(tab="Input"));

algorithm
  DP_tot := FluidDissipation.PressureLoss.Nozzle.dp_conicalOverall_DP(
    IN_con,
    IN_var,
    m_flow);

  annotation (Documentation(info="<html>
<p>
In this package the pressure loss function <a href=\"Modelica://FluidDissipation.PressureLoss.Nozzle.dp_conicalOverall\"> dp_conicalOverall </a> of a nozzle function with surface roughness dependence  
out of the <b> FluidDissipation </b> library is  
implemented into an usable form for the replaceable pressure loss calculations of a <a  
href=\"Modelica://FluidDissipation.Examples.Applications.PressureLoss.Nozzle\"> nozzle function </a> with the <b>Modelica.Fluid </b>  
library as thermo-hydraulic framework. 
</p>
 
<p>
This function executes the calculation of a nozzle function at the overall flow regime for an incompressible and single-phase  
fluid flow considering surface roughness dependence. Here the total pressure loss (DP_tot) is calculated in dependence of a known mass flow rate (m_flow).
</p>
 
<p>
A test case ready for the simulation of a Modelica.Fluid nozzle function can be found in <a  
href=\"Modelica://FluidDissipation.Examples.TestCases.PressureLoss.Nozzle\"> Test: Nozzle functions </a>.
</p>
 
</html>
"));
end pressureLoss_mflow;
end ConicalOverall;
