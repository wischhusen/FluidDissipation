within FluidDissipation.Examples.Applications.HeatTransfer.BaseClasses;
partial model BaseHeatTransferModel_TwoPhase

  //interfaces
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermalPort
    "Thermal port" annotation (Placement(transformation(extent={{-20,60},{20,80}},
          rotation=0), iconTransformation(extent={{-20,100},{20,120}})));

  //input
  input Modelica.Units.SI.MassFlowRate m_flow "Mass flow rate"
    annotation (Dialog(group="Input"));
  input Modelica.Units.SI.Temperature T_w "Wall temperature"
    annotation (Dialog(group="Input"));

  //fluid properties
  input Modelica.Units.SI.SpecificHeatCapacityAtConstantPressure cp_g
    "Specific heat capacity of gas at constant pressure";
  input Modelica.Units.SI.SpecificHeatCapacityAtConstantPressure cp_l
    "Specific heat capacity of liquid at constant pressure";
  input Modelica.Units.SI.DynamicViscosity eta_g "Dynamic viscosity of gas";
  input Modelica.Units.SI.DynamicViscosity eta_l "Dynamic viscosity of liquid";
  input Modelica.Units.SI.ThermalConductivity lambda_g
    "Thermal conductivity of gas";
  input Modelica.Units.SI.ThermalConductivity lambda_l
    "Thermal conductivity of liquid";
  input Modelica.Units.SI.Density rho_g "Density of gas";
  input Modelica.Units.SI.Density rho_l "Density of liquid";
  input Modelica.Units.SI.Pressure pressure "Mean pressure of fluid";
  input Modelica.Units.SI.Temperature T_s=0 "Saturation temperature";
  input Modelica.Units.SI.SpecificEnthalpy dh_lg
    "Evaporation enthalpy of fluid";
  input Real x_flow "Mass flow rate quality";

  //target
  Real kc "Mean convective heat transfer coefficient for channel";
  Modelica.Units.SI.HeatFlowRate Q_flow=thermalPort.Q_flow
    "Heat flow rate over boundary";

  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}}), graphics));
end BaseHeatTransferModel_TwoPhase;
