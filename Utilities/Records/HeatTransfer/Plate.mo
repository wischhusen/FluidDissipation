within FluidDissipation.Utilities.Records.HeatTransfer;
record Plate "Input for plate"
  extends Modelica.Icons.Record;

  Modelica.Units.SI.Length L=1 "Length of plate"
    annotation (Dialog(group="Plate"));

end Plate;
