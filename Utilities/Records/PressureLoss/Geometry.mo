within FluidDissipation.Utilities.Records.PressureLoss;
record Geometry "Input for several geometries of internal flow"
  extends Modelica.Icons.Record;

  FluidDissipation.Utilities.Types.GeometryOfInternalFlow geometry=
      FluidDissipation.Utilities.Types.GeometryOfInternalFlow.Circular
    "Choice of geometry for internal flow" annotation (Dialog(group="Channel"));

  Modelica.Units.SI.Length K=0
    "Roughness (average height of surface asperities)"
    annotation (Dialog(group="Channel"));
  Modelica.Units.SI.Length L=1 "Length" annotation (Dialog(group="Channel"));

  //geometry variables
  //annular(1)
  Modelica.Units.SI.Diameter d_ann=d_cir "Small diameter" annotation (Dialog(
        group="Annular cross sectional area", enable=geometry ==
          FluidDissipation.Utilities.Types.GeometryOfInternalFlow.Annular));
  Modelica.Units.SI.Diameter D_ann=2*d_ann "Large diameter" annotation (Dialog(
        group="Annular cross sectional area", enable=geometry ==
          FluidDissipation.Utilities.Types.GeometryOfInternalFlow.Annular));
  //circular(2)
  Modelica.Units.SI.Diameter d_cir=0.1 "Internal diameter" annotation (Dialog(
        group="Circular cross sectional area", enable=geometry ==
          FluidDissipation.Utilities.Types.GeometryOfInternalFlow.Circular));
  //elliptical(3)
  Modelica.Units.SI.Length a_ell=(3/4)*d_cir "Half length of long base line"
    annotation (Dialog(group="Elliptical cross sectional area", enable=geometry
           == FluidDissipation.Utilities.Types.GeometryOfInternalFlow.Elliptical));
  Modelica.Units.SI.Length b_ell=0.5*a_ell "Half length of short base line"
    annotation (Dialog(group="Elliptical cross sectional area", enable=geometry
           == FluidDissipation.Utilities.Types.GeometryOfInternalFlow.Elliptical));
  //rectangular(4)
  Modelica.Units.SI.Length a_rec=d_cir "Horizontal length" annotation (Dialog(
        group="Rectangular cross sectional area", enable=geometry ==
          FluidDissipation.Utilities.Types.GeometryOfInternalFlow.Rectangular));
  Modelica.Units.SI.Length b_rec=a_rec "Vertical length" annotation (Dialog(
        group="Rectangular cross sectional area", enable=geometry ==
          FluidDissipation.Utilities.Types.GeometryOfInternalFlow.Rectangular));
  //triangular(5)
  Modelica.Units.SI.Length a_tri=d_cir*(1 + 2^0.5) "Length of base line"
    annotation (Dialog(group="Triangle cross sectional area", enable=geometry
           == FluidDissipation.Utilities.Types.GeometryOfInternalFlow.Isosceles));
  Modelica.Units.SI.Length h_tri=0.5*a_tri
    "Height to top angle perpendicular to base line" annotation (Dialog(group=
          "Triangle cross sectional area", enable=geometry == FluidDissipation.Utilities.Types.GeometryOfInternalFlow.Isosceles));
  Modelica.Units.SI.Angle beta=90*PI/180 "Top angle" annotation (Dialog(group=
          "Triangle cross sectional area", enable=geometry == FluidDissipation.Utilities.Types.GeometryOfInternalFlow.Isosceles));
end Geometry;
