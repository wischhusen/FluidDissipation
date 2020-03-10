within FluidDissipation.HeatTransfer.Plate;
function kc_overall
  "Mean heat transfer coefficient of even plate | overall regime | constant wall temperature"
  extends Modelica.Icons.Function;
  //SOURCE: VDI-Waermeatlas, Aufl. 9, Springer-Verlag, 2002, Section Gd 1
  //Notation of equations according to SOURCE

  //input records
  input FluidDissipation.HeatTransfer.Plate.kc_overall_IN_con IN_con
    "Input record for function kc_overall"
    annotation (Dialog(group="Constant inputs"));
  input FluidDissipation.HeatTransfer.Plate.kc_overall_IN_var IN_var
    "Input record for function kc_overall"
    annotation (Dialog(group="Variable inputs"));
  //output variables
  output Modelica.Units.SI.CoefficientOfHeatTransfer kc
    "Convective heat transfer coefficient" annotation (Dialog(group="Output"));
  output Modelica.Units.SI.PrandtlNumber Pr "Prandtl number"
    annotation (Dialog(group="Output"));
  output Modelica.Units.SI.ReynoldsNumber Re "Reynolds number"
    annotation (Dialog(group="Output"));
  output Modelica.Units.SI.NusseltNumber Nu "Nusselt number"
    annotation (Dialog(group="Output"));
  output Real failureStatus
    "0== boundary conditions fulfilled | 1== failure >> check if still meaningful results"
    annotation (Dialog(group="Output"));

protected
  Real MIN=Modelica.Constants.eps "Limiter";

  Real prandtlMax=2000 "Maximum Prandtl number";
  Real prandtlMin=0.6 "Minimum Prandtl number";
  Real reynoldsMax=1e7 "Maximum Reynolds number";
  Real reynoldsMin=1e1 "Minimum Reynolds number";

  //failure status
  Real fstatus[2] "Check of expected boundary conditions";

  //Documentation
algorithm
  Pr := IN_var.eta*IN_var.cp/max(MIN, IN_var.lambda);
  Re := abs(IN_var.rho*IN_var.velocity*IN_con.L/max(MIN, IN_var.eta));
  kc := FluidDissipation.HeatTransfer.Plate.kc_overall_KC(IN_con, IN_var);
  Nu := kc*IN_con.L/max(MIN, IN_var.lambda);

  //failure status
  fstatus[1] := if Re > reynoldsMax or Re < reynoldsMin then 1 else 0;
  fstatus[2] := if Pr > prandtlMax or Pr < prandtlMin then 1 else 0;

  failureStatus := 0;
  for i in 1:size(fstatus, 1) loop
    if fstatus[i] == 1 then
      failureStatus := 1;
    end if;
  end for;
  annotation (Inline=false, smoothOrder(normallyConstant=IN_con) = 2, Documentation(
        info="<html>
<p>
Calculation of the mean convective heat transfer coefficient <b> kc </b> for an overall fluid flow over an even surface.
</p>
 
<h4><font color=\"#EF9B13\">Restriction</font></h4>
<ul>
<li> constant wall temperature 
<li> overall regime (Reynolds number 1e1 &lt; Re &lt; 1e7) 
<li> Prandtl number 0.6 &le; Pr &le; 2000 
</ul>
 
<h4><font color=\"#EF9B13\">Geometry </font></h4>
<p>
<img src=\"modelica://FluidDissipation/Extras/Images/heatTransfer/plate/pic_plate.png\">
</p>  
 
<h4><font color=\"#EF9B13\">Calculation</font></h4>
The mean convective heat transfer coefficient <b> kc</b> for flat plate is calculated through the corresponding Nusselt number <b> Nu_lam</b> according to <i>[VDI 2002, p. Gd 1, eq. 1]</i> :
 
<pre>
    Nu_lam = 0.664 * Re^(0.5) * (Pr)^(1/3) 
</pre>
 
For turbulent flows the corresponding Nusselt number <b> Nu_turb</b> is calculated according to <i>[VDI 2002, p. Gd 1, eq. 2]</i> :
 
<pre>
    Nu_turb = (0.037 * Re^0.8 * Pr) / (1 + 2.443/Re^0.1 * (Pr^(2/3)-1))
</pre>
 
<p>
The overall mean convective heat transfer coefficient <b> kc </b> is calculated by:
</p>
 
<p>
<pre>
    kc =  sqrt(Nu_lam^2 + Nu_turb^2) * lambda / L
</pre>
</p>
 
<p>
with
</p>
 
<p>
<table>
<tr><td><b> cp                           </b></td><td> as specific heat capacity at constant pressure [J/(kg.K)],</td></tr>
<tr><td><b> eta                          </b></td><td> as dynamic viscosity of fluid [Pa.s],</td></tr>
<tr><td><b> kc                           </b></td><td> as mean convective heat transfer coefficient [W/(m2.K)],</td></tr>
<tr><td><b> lambda                       </b></td><td> as heat conductivity of fluid [W/(m.K)],</td></tr>
<tr><td><b> L                            </b></td><td> as length of plate [m],</td></tr>
<tr><td><b> Nu_lam                  </b></td><td> as mean Nusselt number for laminar regime [-], </td></tr>
<tr><td><b> Nu_turb                 </b></td><td> as mean Nusselt number for turbulent regime [-], </td></tr>
<tr><td><b> Nu = kc*L/lambda             </b></td><td> as mean Nusselt number for overall regime [-], </td></tr>
<tr><td><b> Pr = eta*cp/lambda           </b></td><td> as Prandtl number [-],</td></tr>
<tr><td><b> rho                          </b></td><td> as fluid density [kg/m3],</td></tr>
<tr><td><b> Re = rho*v*L/eta             </b></td><td> as Reynolds number [-].</td></tr>
</table>
</p>
 
<h4><font color=\"#EF9B13\">Verification</font></h4>
 
The mean Nusselt number <b> Nu = sqrt(Nu_lam^2 + Nu_turb^2) </b> representing the mean convective heat transfer coefficient <b> kc </b> for Prandtl numbers of different fluids is shown in the figure below.
<p>
<img src=\"modelica://FluidDissipation/Extras/Images/heatTransfer/plate/fig_plate_kc_overall.png\">
</p>
 
<h4><font color=\"#EF9B13\">References</font></h4> 
<dl> 
<dt>VDI:</dt> 
    <dd><b>VDI - W&auml;rmeatlas: Berechnungsbl&auml;tter f&uuml;r den W&auml;rme&uuml;bergang</b>. 
    Springer Verlag, 9th edition, 2002.</dd>
</dl>
 
</html>
", revisions="<html>
<pre>2016-04-12 Stefan Wischhusen: Removed singularity for Re at zero mass flow rate. </pre>
</html>"));
end kc_overall;
