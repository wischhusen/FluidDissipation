within FluidDissipation.Examples.Applications.PressureLoss.BaseClasses.StraightPipe;
partial package BaseStraightPipePL "Base package for all pressure loss functions of a straight pipe"
extends FluidDissipation.Utilities.Icons.BaseLibrary;


replaceable partial function massFlowRate_dp
  extends Modelica.Icons.Function;

  //mass flow rate as output
  output SI.MassFlowRate M_FLOW;

end massFlowRate_dp;
end BaseStraightPipePL;
