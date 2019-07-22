within FluidDissipation.Examples.TestCases.PressureLoss;
model StraightTwoPhasePipe
  "Test cases of pressure loss functions for straight pipes with two phase flow"

  inner Modelica.Fluid.System system(p_ambient(displayUnit="Pa") = 100000,
      m_flow_small=0.01) annotation (Placement(transformation(extent={{80, -100}, {100, -80}})));

public
  Modelica.Blocks.Sources.Sine input_mflow(
    freqHz=1,
    offset=0,
    amplitude=1)
    annotation (Placement(transformation(extent={{-100,-50},{-80,-30}})));

public
  Modelica.Blocks.Sources.RealExpression input_p(y=from_mflow.port_a.p)
    annotation (Placement(transformation(extent={{-100,
            10},{-80,30}})));
  Modelica.Fluid.Sources.Boundary_pT IN_p(
    nPorts=1,
    p(displayUnit="Pa") = system.p_ambient,
    use_p_in=true,
    redeclare package Medium = Modelica.Media.Water.WaterIF97_ph,
    T(displayUnit="degC") = 373.15)
    annotation (Placement(transformation(extent={{-60,10},{-40,30}})));

  Modelica.Fluid.Sources.FixedBoundary OUT_dp(
    p=system.p_ambient,
    T=system.T_ambient,
    nPorts=1,
    redeclare package Medium = Modelica.Media.Water.WaterIF97_ph)
                                                              annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={90,20})));

  Modelica.Fluid.Sources.FixedBoundary OUT_mflow(
    p=system.p_ambient,
    nPorts=1,
    redeclare package Medium = Modelica.Media.Water.WaterIF97_ph,
    T=system.T_ambient)                                       annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={90,-40})));

  Modelica.Fluid.Sources.MassFlowSource_T IN_mflow(
    nPorts=1,
    use_m_flow_in=true,
    redeclare package Medium = Modelica.Media.Water.WaterIF97_ph,
    T=373.15)                                                 annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-50,-40})));

  FluidDissipation.Examples.Applications.PressureLoss.StraightPipeFlowModel from_dp(
      redeclare package Medium = Modelica.Media.Water.WaterIF97_ph, redeclare
      model FlowModel =
        FluidDissipation.Examples.Applications.PressureLoss.BaseClasses.StraightPipe.OverallTwoPhase.OverallTwoPhaseFlowModel)
    annotation (Placement(transformation(extent={{-24,-4},{24,44}})));

  FluidDissipation.Examples.Applications.PressureLoss.StraightPipeFlowModel from_mflow(
      redeclare model FlowModel =
        FluidDissipation.Examples.Applications.PressureLoss.BaseClasses.StraightPipe.OverallTwoPhase.OverallTwoPhaseFlowModel,
      redeclare package Medium = Modelica.Media.Water.WaterIF97_ph)
    "Calculate pressure loss from mass flow rate"
    annotation (Placement(transformation(extent={{-24,-64},{24,-16}})));
equation
  connect(IN_p.ports[1], from_dp.port_a) annotation (Line(
      points={{-40,20},{-24,20}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(from_dp.port_b, OUT_dp.ports[1]) annotation (Line(
      points={{24,20},{80,20}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(from_mflow.port_b, OUT_mflow.ports[1]) annotation (Line(
      points={{24,-40},{80,-40}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(from_mflow.port_a, IN_mflow.ports[1]) annotation (Line(
      points={{-24,-40},{-40,-40}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(input_mflow.y, IN_mflow.m_flow_in) annotation (Line(
      points={{-79,-40},{-70,-40},{-70,-32},{-60,-32}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(input_p.y, IN_p.p_in) annotation (Line(
      points={{-79,20},{-72,20},{-72,28},{-62,28}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (
    Documentation(info="<html>
<p>
Switch to the diagram or equation layer to see the model of a <b> Modelica.Fluid straight pipe </b> using <b> FluidDissipation pressure loss calculations </b>.
</p>
</html>
"), experiment(Interval=0.0002),
    Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
            100}}), graphics={Text(
          extent={{-96,122},{86,60}},
          lineColor={0,0,255},
          textString="Test: Straight pipe functions"),Text(
          extent={{-56,-2},{60,-18}},
          lineColor={255,0,0},
          textString=
              "set record parameters for chosen pressure loss function (inside flow model)")}));
end StraightTwoPhasePipe;
