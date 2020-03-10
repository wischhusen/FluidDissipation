within FluidDissipation.Examples.TestCases.HeatTransfer;
model General "Test case for heat transfer of generic geometries"

  Applications.HeatTransfer.GeneralHeatTransferModel general(m_flow=
        massFlowRate.y, redeclare package Medium =
        Modelica.Media.Air.DryAirNasa)
    annotation (Placement(transformation(extent={{-34,-34},{34,34}})));

  Modelica.Blocks.Sources.Constant pressure(k=1e5)
    annotation (Placement(transformation(extent={{-100,60},{-80,80}})));
  Modelica.Blocks.Sources.Sine temperature(
    amplitude=2,
    f=1,
    offset=20) "[degC]"
    annotation (Placement(transformation(extent={{-100,20},{-80,40}})));
  Modelica.Blocks.Sources.Sine massFlowRate(
    f=1,
    offset=0,
    amplitude=0.1) "[kg/s]"
    annotation (Placement(transformation(extent={{-100,-20},{-80,0}})));

  inner StateForHeatTransfer stateForHeatTransfer(
    p_state=pressure.y,
    t_state=temperature.y,
    redeclare package Medium = Modelica.Media.Air.DryAirNasa)
    annotation (Placement(transformation(extent={{80,-100},{100,-80}})));
equation

  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}}), graphics={Text(
          extent={{-70,110},{74,68}},
          lineColor={0,0,255},
          textString="Test of implementation for generic functions")}));
end General;
