within FluidDissipation.Utilities.Functions.General;
function ReynoldsNumber "calculation of Reynolds number"
  extends Modelica.Icons.Function;
  import      Modelica.Units.SI;
  import MIN = Modelica.Constants.eps;

  //geometry
  input Modelica.Units.SI.Area A_cross "Cross sectional area";
  input Modelica.Units.SI.Length perimeter "Wetted perimeter";

  //fluid properties
  input Modelica.Units.SI.Density rho "Density of fluid";
  input Modelica.Units.SI.DynamicViscosity eta "Dynamic viscosity of fluid";

  input Modelica.Units.SI.MassFlowRate m_flow "Mass flow rate";

  output Modelica.Units.SI.ReynoldsNumber Re "Reynolds number";
  output Modelica.Units.SI.Velocity velocity "Mean velocity";

// protected
//   SI.Diameter d_hyd=4*A_cross/max(MIN, perimeter) "Hydraulic diameter";

algorithm
  Re := 4*abs(m_flow)/max(MIN, (perimeter*eta));
  velocity := m_flow/max(MIN, (rho*A_cross));
  annotation (Inline=true, smoothOrder=1,
    Documentation(revisions="<html>
<pre>2016-04-12 Stefan Wischhusen: Removed obsolete d_hyd from function ReynoldsNumber.</pre>
</html>"));
end ReynoldsNumber;
