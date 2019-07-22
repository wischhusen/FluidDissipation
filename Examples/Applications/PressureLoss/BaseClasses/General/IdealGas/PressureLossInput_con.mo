within FluidDissipation.Examples.Applications.PressureLoss.BaseClasses.General.IdealGas;
record PressureLossInput_con "Input record for dp_idealGas"

  extends FluidDissipation.PressureLoss.General.dp_idealGas_IN_con;

  annotation (Documentation(info="<html>
This record is used as <b> input record </b> for the pressure loss of the <a  
href=\"Modelica://FluidDissipation.PressureLoss.General\"> generic ideal gas function </a> implemented in Modelica.Fluid  
as thermo-hydraulic framework.
</html>"));

end PressureLossInput_con;
