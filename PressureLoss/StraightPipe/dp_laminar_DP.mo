within FluidDissipation.PressureLoss.StraightPipe;
function dp_laminar_DP
  "Pressure loss of straight pipe | calculate pressure loss| laminar flow regime (Hagen-Poiseuille)"
  extends Modelica.Icons.Function;
  //SOURCE_1: Idelchik, I.E.: HANDBOOK OF HYDRAULIC RESISTANCE, 3rd edition, 2006.

  import FD = FluidDissipation.PressureLoss.StraightPipe;

  //input records
  input FluidDissipation.PressureLoss.StraightPipe.dp_laminar_IN_con IN_con
    "Input record for function dp_laminar_DP"
    annotation (Dialog(group="Constant inputs"));
  input FluidDissipation.PressureLoss.StraightPipe.dp_laminar_IN_var IN_var
    "Input record for function dp_laminar_DP"
    annotation (Dialog(group="Variable inputs"));
  input Modelica.Units.SI.MassFlowRate m_flow "Mass flow rate"
    annotation (Dialog(group="Input"));

  //output variables
  output Modelica.Units.SI.Pressure DP "Output for function dp_laminar_DP";

protected
  Real MIN=Modelica.Constants.eps;

  Modelica.Units.SI.Diameter d_hyd=IN_con.d_hyd "Hydraulic diameter";
  Modelica.Units.SI.Area A_cross=PI*IN_con.d_hyd^2/4
    "Circular cross sectional area";

  Modelica.Units.SI.Velocity velocity=m_flow/max(MIN, IN_var.rho*A_cross)
    "Mean velocity";

  //Documentation

algorithm
  DP := 32*IN_var.eta*velocity*IN_con.L/d_hyd^2;
  annotation (Inline=true,
    smoothOrder(normallyConstant=IN_con) = 2,
    inverse(m_flow=FluidDissipation.PressureLoss.StraightPipe.dp_laminar_MFLOW(
          IN_con,
          IN_var,
          DP)),
    Documentation(info="<html>
<p>
Calculation of pressure loss in a straight pipe for <b> laminar </b> flow regime of an incompressible and single-phase fluid flow only.
</p>
 
<p>
This function can be used to calculate both the pressure loss at known mass flow rate <b> or </b> mass flow rate at known pressure loss within one function in dependence of the known 
variable (dp or m_flow).
</p>
 
<p>
Generally this  function is numerically best used for the <b> incompressible case </b>, where the mass flow rate (m_flow) is known (as state variable) in the used model and the corresponding pressure loss (DP) has to be calculated. On the other hand the  function <a href=\"Modelica://FluidDissipation.PressureLoss.StraightPipe.dp_laminar_MFLOW\">dp_laminar_MFLOW</a> is numerically best used for the <b> compressible case </b> if the pressure loss (dp) is known (out of pressures as state variable) and the mass flow rate (M_FLOW) has to be calculated.
</p>
 
<h4><font color=\"#EF9B13\">Restriction</font></h4>
This function shall be used inside of the restricted limits according to the referenced literature.
<ul>
 <li>
      <b> circular cross sectional area </b>
 <li>
      <b> laminar flow regime (Reynolds number Re &le; 2000) <i>[VDI-W&auml;rmeatlas 2002, p. Lab, eq. 3] </i> </b>
</ul>
 
<h4><font color=\"#EF9B13\">Geometry </font></h4>
<p>
<img src=\"modelica://FluidDissipation/Extras/Images/pressureLoss/straightPipe/pic_straightPipe.png\">
</p>
 
<h4><font color=\"#EF9B13\">Calculation</font></h4>
The pressure loss <b> dp </b> for straight pipes is determined by:
<p>
<pre>
dp = lambda_FRI * (L/d_hyd) * (rho/2) * velocity^2
</pre>
</p>
 
<p>
with
</p>
 
<p>
<table>
<tr><td><b> lambda_FRI     </b></td><td> as Darcy friction factor [-].</td></tr>
<tr><td><b> L              </b></td><td> as length of straight pipe [m],</td></tr>
<tr><td><b> d_hyd          </b></td><td> as hydraulic diameter of straight pipe [m],</td></tr>
<tr><td><b> rho            </b></td><td> as density of fluid [kg/m3],</td></tr>
<tr><td><b> velocity       </b></td><td> as mean velocity [m/s].</td></tr>
</table>
</p>
 
The Darcy friction factor <b> lambda_FRI </b> of straight pipes for the laminar flow regime is calculated by <b> Hagen-Poiseuilles </b> law according to <i>[Idelchik 2006, p. 77, eq. 2-3]</i> as follows:
<ul>
 <li> 
     <b> Laminar flow regime </b> is restricted to a Reynolds number <b> Re </b> &le; 2000</li> and calculated through:
     <pre>
 
     lambda_FRI = 64/Re
     </pre>
 
     <p>
     with
     </p>
 
     <p>
     <table>
     <tr><td><b> lambda_FRI     </b></td><td> as Darcy friction factor [-],</td></tr>
     <tr><td><b> Re             </b></td><td> as Reynolds number [-].</td></tr>
     </table>
     </p>
 
 </li> 
</ul>
 
<p>      
The Darcy friction factor <b> lambda_FRI </b> in the laminar regime is independent 
of the surface roughness <b> K </b> as long as the relative roughness <b> k = surface rouhgness/hydraulic diameter </b> is smaller than 0.007.
A higher relative roughness <b> k </b> than 0.007 leads to an earlier leaving of the laminar regime to the transition regime at some value of Reynolds number <b> Re_lam_leave </b>. This earlier leaving is not modelled here because only laminar fluid flow is considered.
</p>
 
<h4><font color=\"#EF9B13\">Verification</font></h4> 
<p> 
The Darcy friction factor <b> lambda_FRI </b> in dependence of Reynolds number is shown in the figure below.
</p>
<p> 
<img src=\"modelica://FluidDissipation/Extras/Images/pressureLoss/straightPipe/fig_straightPipe_laminar_lambdavsRe_ver.png\">
</p>
 
<p>
The pressure loss <b> dp </b> for the laminar regime in dependence of the mass flow rate of water is shown in the figure below.
</p>
<p> 
<img src=\"modelica://FluidDissipation/Extras/Images/pressureLoss/straightPipe/fig_straightPipe_dp_laminar_DPvsMFLOW.png\">
</p>
 
<p> 
Note that this pressure loss function shall not be used for the modelling outside of the laminar flow regime at <b> Re </b> &gt; 2000</li> even though it could be used for that. 
</p>
 
<p>
If the whole flow 
regime shall be modelled, the pressure loss function <a href=\"Modelica://FluidDissipation.PressureLoss.StraightPipe.dp_overall\">dp_overall</a> can be used.
</p>
 
<h4><font color=\"#EF9B13\">References</font></h4> 
<dl>
 <dt>Elmqvist,H., M.Otter and S.E. Cellier:</dt>
    <dd><b>Inline integration: A new mixed
    symbolic / numeric approach for solving differential-algebraic equation systems.</b>.
    In Proceedings of European Simulation MultiConference, Praque, 1995.</dd> 
<dt>Idelchik,I.E.:</dt>
    <dd><b>Handbook of hydraulic resistance</b>.
    Jaico Publishing House,Mumbai,3rd edition, 2006.</dd>
 <dt>VDI:</dt> 
    <dd><b>VDI - W&auml;rmeatlas: Berechnungsbl&auml;tter f&uuml;r den W&auml;rme&uuml;bergang</b>. 
    Springer Verlag, 9th edition, 2002.</dd>
</dl>
</html>
"));
end dp_laminar_DP;
