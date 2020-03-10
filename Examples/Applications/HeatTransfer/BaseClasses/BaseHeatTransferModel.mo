within FluidDissipation.Examples.Applications.HeatTransfer.BaseClasses;
partial model BaseHeatTransferModel

  //interfaces
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermalPort
    "Thermal port" annotation (Placement(transformation(extent={{-20,60},{20,80}},
          rotation=0), iconTransformation(extent={{-20,100},{20,120}})));

  //input
  input Modelica.Units.SI.MassFlowRate m_flow "Mass flow rate"
    annotation (Dialog(group="Input"));

  //fluid properties
  input Modelica.Units.SI.SpecificHeatCapacityAtConstantPressure cp
    "Specific heat capacity of fluid at constant pressure";
  input Modelica.Units.SI.DynamicViscosity eta "Dynamic viscosity of fluid";
  input Modelica.Units.SI.ThermalConductivity lambda
    "Thermal conductivity of fluid";
  input Modelica.Units.SI.Density rho "Density of fluid";
  input Modelica.Units.SI.Temperature T "Temperature of fluid";

  //target
  Real kc "Mean convective heat transfer coefficient for channel";
  Modelica.Units.SI.HeatFlowRate Q_flow=thermalPort.Q_flow
    "Heat flow rate over boundary";

  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}}), graphics));
end BaseHeatTransferModel;
