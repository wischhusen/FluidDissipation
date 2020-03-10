within FluidDissipation.Utilities.Records.General;
record IdealGas_var
  "Base record for generic pressure loss function | ideal gas | mean density"
  extends Modelica.Icons.Record;

  Modelica.Units.SI.Density rho_m=1.189 "Mean density of ideal gas"
    annotation (Dialog(group="Fluid properties", enable=useMeanDensity));
  Modelica.Units.SI.Temperature T_m=(293 + 293)/2
    "Mean temperature of ideal gas"
    annotation (Dialog(group="Fluid properties", enable=not (useMeanDensity)));
  Modelica.Units.SI.Pressure p_m=(1e5 + 1e5)/2 "Mean pressure of ideal gas"
    annotation (Dialog(group="Fluid properties", enable=not (useMeanDensity)));

end IdealGas_var;
