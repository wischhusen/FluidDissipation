within FluidDissipation.Examples.Applications.HeatTransfer.BaseClasses.Plate;
package Overall "FluidDissipation: fluid flow around plate for overall fluid flow regime"
extends
  FluidDissipation.Examples.Applications.HeatTransfer.BaseClasses.Plate.BasePlateHT;
constant String fluidFlowRegime="overall regime";


redeclare function extends coefficientOfHeatTransfer

algorithm
  kc := FluidDissipation.HeatTransfer.Plate.kc_overall_KC(IN_con, IN_var);

end coefficientOfHeatTransfer;

annotation (Documentation(info="<html>
<p>
In this package the heat transfer function <a href=\"Modelica://FluidDissipation.HeatTransfer.Plate.kc_mean_overall_KC\"> kc_overall_KC </a> of a plate out of the <b> FluidDissipation </b> library is implemented into an usable form for replaceable calculations of convective heat transfer coefficients. All functions for <a href=\"Modelica://FluidDissipation.Examples.Applications.Plate\"> plates </a> are integrated within the <b>Modelica_Fluid </b> library as thermo-hydraulic framework.
</p>
 
<p>
This function executes the calculation of a plate at overall flow regime for an incompressible and single-phase fluid flow. Here the convective heat transfer coefficient (kc) of a fluid is calculated in dependence of its known velocity above the plate.
</p>
 
<p>
A test case for implemented heat transfer functions of plates is available as <a href=\"Modelica://FluidDissipation.Examples.TestCases.Plate\"> volume model</a> for Modelica_Fluid as thermo-hydraulic framework. 
</p>
 
</html>"));
end Overall;
