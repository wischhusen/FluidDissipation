within FluidDissipation.Utilities.Functions.General;
function PrandtlNumber "calculation of Prandtl number"
  extends Modelica.Icons.Function;
  import      Modelica.Units.SI;
  import MIN = Modelica.Constants.eps;

  //fluid properties
  input Modelica.Units.SI.SpecificHeatCapacityAtConstantPressure cp
    "specific heat capacity of fluid at constant pressure";
  input Modelica.Units.SI.DynamicViscosity eta "dynamic viscosity of fluid";
  input Modelica.Units.SI.ThermalConductivity lambda
    "thermal conductivity of fluid";

  output Modelica.Units.SI.PrandtlNumber Pr "Prandtl number";

algorithm
  Pr := eta*cp/max(MIN, lambda);
  annotation (Inline=true, smoothOrder=1);
end PrandtlNumber;
