within FluidDissipation.Examples.Applications.HeatTransfer.BaseClasses.HeatExchanger.BaseHeatExchangerHT;
partial model BaseHeatExchangerModelWallState
  "Base heat transfer model with wall state for heat exchanger functions in Modelica.Fluid"

  //icon
  extends FluidDissipation.Utilities.Icons.HeatTransfer.HeatExchanger_i;

  extends BaseClasses.BaseHeatTransferModel;

    //fluid properties at wall
  input Modelica.Units.SI.SpecificHeatCapacityAtConstantPressure cp_w
    "Specific heat capacity of fluid at constant pressure at wall surface";
  input Modelica.Units.SI.DynamicViscosity eta_w
    "Dynamic viscosity of fluid at wall surface";
  input Modelica.Units.SI.ThermalConductivity lambda_w
    "Thermal conductivity of fluid at wall surface";
  Modelica.Units.SI.Temperature T_w "Temperature of fluid at wall surface";

end BaseHeatExchangerModelWallState;
