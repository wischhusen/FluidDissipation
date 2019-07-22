within FluidDissipation.PressureLoss.General;
function dp_nominalPressureLossLawDensity "Generic pressure loss | nominal operation point | pressure loss law (coefficient and exponent) | density dependence"
  extends Modelica.Icons.Function;
  //input records
  input FluidDissipation.PressureLoss.General.dp_nominalPressureLossLawDensity_IN_con IN_con "Input record for function dp_nominalPressureLossLawDensity" annotation (
    Dialog(group = "Constant inputs"));
  input FluidDissipation.PressureLoss.General.dp_nominalPressureLossLawDensity_IN_var IN_var "Input record for function dp_nominalPressureLossLawDensity" annotation (
    Dialog(group = "Variable inputs"));
  input FluidDissipation.Utilities.Records.PressureLoss.PressureLossInput chosenTarget "Target variable of calculation" annotation (
    Dialog(group = "Input"));
  //output variables
  output SI.Pressure DP "pressure loss" annotation (
    Dialog(group = "Output"));
  output SI.MassFlowRate M_FLOW "mass flow rate" annotation (
    Dialog(group = "Output"));
  output Utilities.Types.PressureLossCoefficient zeta_TOT "Pressure loss coefficient" annotation (
    Dialog(group = "Output"));
  // Re has no meaning for this function
  final output SI.ReynoldsNumber Re = 0 "Reynolds number" annotation (
    Dialog(group = "Output"));
  final output SI.PrandtlNumber Pr = 0 "Prandtl number" annotation (
    Dialog(group = "Output"));
  // function has no restrictions
  final output Real failureStatus = 0 "0== boundary conditions fulfilled | 1== failure >> check if still meaningful results" annotation (
    Dialog(group = "Output"));

protected
  Real MIN=Modelica.Constants.eps;
  Modelica.SIunits.Velocity velocity "Mean velocity of flow";

algorithm

  if chosenTarget.target == FluidDissipation.Utilities.Types.PressureLossTarget.MassFlowRate then
    DP := chosenTarget.dp;
    M_FLOW := FluidDissipation.PressureLoss.General.dp_nominalPressureLossLawDensity_MFLOW(IN_con, IN_var, chosenTarget.dp);
  else
    M_FLOW := chosenTarget.m_flow;
    DP := FluidDissipation.PressureLoss.General.dp_nominalPressureLossLawDensity_DP(IN_con, IN_var, chosenTarget.m_flow);
  end if;

  velocity := abs(M_FLOW)/max(MIN, IN_var.rho*IN_con.A_cross);
  // Resulting zeta_TOT can be different from input due to
  // regularization function (at low pressure loss)
  zeta_TOT := DP/(0.5*IN_var.rho*max(MIN, velocity^IN_con.exp));
  annotation (
    Inline = false,
    smoothOrder(normallyConstant = IN_con) = 2,
    Documentation(info = "<html>
<p>
Calculation of a generic pressure loss in dependence of nominal fluid variables (e.g. nominal density) via interpolation from an operation point.
This generic function considers the pressure loss law via a nominal pressure loss (dp_nom), a pressure loss coefficient (zeta_TOT) and a pressure loss law exponent (exp) as well as the influence of density on pressure loss.
The function can be used to calculate pressure loss at known mass flow rate <b> or </b>  mass flow rate at known pressure loss.
</p>
 
<h4><font color=\"#EF9B13\">Calculation</font></h4>
The pressure loss calculation for this generic function is further documented for the incompressible case <a href=\"Modelica://FluidDissipation.PressureLoss.General.dp_nominalPressureLossLawDensity_DP\">dp_nominalPressureLossLawDensity_DP</a> and the compressible case <a href=\"Modelica://FluidDissipation.PressureLoss.General.dp_nominalPressureLossLawDensity_MFLOW\">dp_nominalPressureLossLawDensity_MFLOW</a>.
</html>", revisions = "<html>
2017-03-24 Stefan Wischhusen: Provided reasonable outputs for all outputs of the function.
</html>"));
end dp_nominalPressureLossLawDensity;
