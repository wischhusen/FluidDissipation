within FluidDissipation.Utilities.Records.PressureLoss;
record StraightPipe "Input for straight pipe"

  extends Modelica.Icons.Record;

  Modelica.Units.SI.Diameter d_hyd=0.1 "Hydraulic diameter"
    annotation (Dialog(group="Straight pipe"));
  Modelica.Units.SI.Length K=0
    "Roughness (average height of surface asperities)"
    annotation (Dialog(group="Straight pipe"));
  Modelica.Units.SI.Length L=1 "Length"
    annotation (Dialog(group="Straight pipe"));
end StraightPipe;
