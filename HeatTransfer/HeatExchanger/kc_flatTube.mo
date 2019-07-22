within FluidDissipation.HeatTransfer.HeatExchanger;
function kc_flatTube

  extends Modelica.Icons.Function;
  //SOURCE: A.M. Jacobi, Y. Park, D. Tafti, X. Zhang. AN ASSESSMENT OF THE STATE OF THE ART, AND POTENTIAL DESIGN IMPROVEMENTS, FOR FLAT-TUBE HEAT EXCHANGERS IN AIR CONDITIONING AND REFRIGERATION APPLICATIONS - PHASE I

  //input records
  input FluidDissipation.HeatTransfer.HeatExchanger.kc_flatTube_IN_con IN_con
    "Input record for function kc_flatTube_KC";
  input FluidDissipation.HeatTransfer.HeatExchanger.kc_flatTube_IN_var IN_var
    "Input record for function kc_flatTube_KC";

  //output variables
  output SI.CoefficientOfHeatTransfer kc "Convective heat transfer coefficient"
    annotation (Dialog(group="Output"));
  output SI.PrandtlNumber Pr "Prandtl number" annotation (Dialog(group="Output"));
  output SI.ReynoldsNumber Re "Reynolds number"
    annotation (Dialog(group="Output"));
  output SI.NusseltNumber Nu "Nusselt number"
    annotation (Dialog(group="Output"));
  output Real failureStatus
    "0== boundary conditions fulfilled | 1== failure >> check if still meaningful results"
    annotation (Dialog(group="Output"));

  import TYP = FluidDissipation.Utilities.Types.HTXGeometry_flatTubes;

protected
  SI.Area A_c=if IN_con.geometry == TYP.LouverFin then IN_con.A_fr*((IN_con.F_l
       - IN_con.delta_f)*(IN_con.F_p - IN_con.delta_f)/((IN_con.F_l + IN_con.D_m)
      *IN_con.F_p)) else if IN_con.geometry == TYP.RectangularFin then IN_con.A_fr
      *(h*s/((h + t + IN_con.D_m)*(s + t))) else 0
    "Minimum flow cross-sectional area";
  SI.Length h=if IN_con.geometry == TYP.RectangularFin then IN_con.D_h*(1 +
      IN_con.alpha)/(2*IN_con.alpha) else 0 "Free flow height";
  SI.Length l=if IN_con.geometry == TYP.RectangularFin then t/IN_con.delta else
            0 "Fin length";
  SI.Length s=if IN_con.geometry == TYP.RectangularFin then h*IN_con.alpha else
            0 "Lateral fin spacing (free flow width)";
  SI.Length t=if IN_con.geometry == TYP.RectangularFin then s*IN_con.gamma else
            0 "Fin thickness";
algorithm
  kc := FluidDissipation.HeatTransfer.HeatExchanger.kc_flatTube_KC(IN_con,
    IN_var);
  Pr := abs(IN_var.eta*IN_var.cp/IN_var.lambda);

  if IN_con.geometry == TYP.LouverFin then
    Re := abs(IN_var.m_flow)*IN_con.L_p/(IN_var.eta*A_c);
    Nu := max(1e-3, kc*IN_con.L_p/IN_var.lambda);
  elseif IN_con.geometry == TYP.RectangularFin then
    Re := abs(IN_var.m_flow)*IN_con.D_h/(IN_var.eta*A_c);
    Nu := max(1e-3, kc*IN_con.D_h/IN_var.lambda);
  end if;

  failureStatus := if IN_con.geometry == TYP.LouverFin then if Re < 100 or Re
     > 3000 then 1 else 0 else if IN_con.geometry == TYP.RectangularFin then
    if Re < 300 or Re > 5000 then 1 else 0 else 0;

  annotation (Inline=false, smoothOrder(normallyConstant=IN_con) = 2, Documentation(info="<html>
<p>
Calculation of the mean convective heat transfer coefficient <b> kc </b> for the air-side heat transfer of heat exchangers with flat tubes and several fin geometries.
</p>

<h4><font color=\"#EF9B13\">Restriction</font></h4>
<ul>
<li> According to the kind of fin geometry the calculation is valid in a range of <b> Re</b> from 100 to 5000. </li>

<p>
<table>
<tr><td><b> Louver fin     </b></td><td> 100 &lt; Re_Lp &lt; 3000,</td></tr>
<tr><td><b> Rectangular offset strip fin       </b></td><td> 300 &lt; Re_Dh &lt; 5000.</td></tr>
</table>
</p>

<br>

<li> medium = air </li>
</ul>

<h4><font color=\"#EF9B13\">Geometry </font></h4>
<p>
<img src=\"modelica://FluidDissipation/Extras/Images/heatTransfer/heatExchanger/pic_flatTube.png\", width=850>
</p> 

<h4><font color=\"#EF9B13\">Calculation</font></h4>
<p>
The mean convective heat transfer coefficient <b> kc </b> for heat exchanger is calculated through the corresponding Coulburn factor <b> j </b>:
</p>

<ul>
  <li> <b>Louver fin</b>:
     <p>
     <pre>
      kc =  j * Re_Lp * Pr^(1/3) * lambda / L_p
     </pre>
     </p>
     <p>
     <pre>
      j = f(Re_Lp, delta_f, F_l, F_p, L_l, L_p, Phi, T_d, T_p) 
     </pre>
     </p>
  <li> <b>Rectangular offset strip fin</b>:
     <p>
     <pre>
      kc =  j * Re_Dh * Pr^(1/3) * lambda / D_h
     </pre>
     </p>
     <p>
     <pre>
      j = f(Re_Dh, alpha, delta, gamma) 
     </pre>
     </p>
</ul>
 
<p>
with
</p>
 
<p>
<table>
<tr><td><b> alpha                         </b></td><td> as fraction of lateral fin spacing <b> s </b> and free flow height <b> h </b> [-],</td></tr>
<tr><td><b> D_h                           </b></td><td> as hydraulic diameter [m],</td></tr>
<tr><td><b> delta                         </b></td><td> as fraction of fin thickness <b> t </b> and fin length <b> l </b> [-],</td></tr>
<tr><td><b> delta_f                       </b></td><td> as fin thickness [m],</td></tr>
<tr><td><b> F_l                           </b></td><td> as fin length [m],</td></tr>
<tr><td><b> F_p                           </b></td><td> as fin pitch [m],</td></tr>
<tr><td><b> gamma                         </b></td><td> as fraction of fin thickness <b> t </b> and lateral fin spacing <b> s </b> [-],</td></tr>
<tr><td><b> kc                            </b></td><td> as mean convective heat transfer coefficient [W/(m2K)],</td></tr>
<tr><td><b> L_l                           </b></td><td> as louver length [m],</td></tr>
<tr><td><b> L_p                           </b></td><td> as louver pitch [m],</td></tr>
<tr><td><b> lambda                        </b></td><td> as heat conductivity of fluid [W/(mK)],</td></tr>
<tr><td><b> Phi                           </b></td><td> as louver angle [grad],</td></tr>
<tr><td><b> Pr = eta*cp/lambda            </b></td><td> as Prandtl number [-],</td></tr>
<tr><td><b> Re_Dh = rho*velocity_c*D_h/eta</b></td><td> as Reynolds number based on hydraulic diameter <b> D_h </b> and average velocity <b> velocity_c </b> at minimum cross-sectional area <b> A_c </b> [-],</td></tr>
<tr><td><b> Re_Lp = rho*velocity_c*L_p/eta</b></td><td> as Reynolds number based on louver pitch <b> L_p </b> and average velocity <b> velocity_c </b> at minimum cross-sectional area <b> A_c </b> [-],</td></tr>
<tr><td><b> T_d                           </b></td><td> as tube depth [m],</td></tr>
<tr><td><b> T_p                           </b></td><td> as tube pitch [m].</td></tr>
</table>
</p>

<p>
The minimum flow cross-sectional area <b> A_c </b> for heat exchangers is determined by:
</p>
<ul>
  <li> <b>Louver fin</b>:
     <p>
     <pre>
      A_c = A_fr * (F_l - delta_f ) * (F_p - delta_f) / ((F_l + D_m) * F_p)
     </pre>
     </p>
  <li> <b>Rectangular offset strip fin</b>:
     <p>
     <pre>
      A_c = A_fr * h * s / ((h + t + D_m) * (s +t ))
     </pre>
     </p>
</ul>

<p>
with
</p>

<p>
<table>
<tr><td><b> A_fr          </b></td><td> as frontal area [m^2],</td></tr>
<tr><td><b> D_m           </b></td><td> as major tube diameter of flat tube [m],</td></tr>
<tr><td><b> delta_f       </b></td><td> as fin thickness [m],</td></tr>
<tr><td><b> F_l           </b></td><td> as fin length [m],</td></tr>
<tr><td><b> F_p           </b></td><td> as fin pitch [m],</td></tr>
<tr><td><b> l             </b></td><td> as fin length of rectangular offset strip fin [m],</td></tr>
<tr><td><b> s             </b></td><td> as lateral fin spacing of rectangular offset strip fin [m],</td></tr>
<tr><td><b> t             </b></td><td> as fin thickness of rectangular offset strip fin [m].</td></tr>
</table>
</p>

<h4><font color=\"#EF9B13\">Verification</font></h4>
<p>
The mean Nusselt number <b> Nu </b> representing the mean convective heat transfer coefficient <b> kc </b> is shown below for different fin geometries at similar dimensions. 
</p>

<p>
<img src=\"modelica://FluidDissipation/Extras/Images/heatTransfer/heatExchanger/fig_flatTube_kc.png\">
</p>

<h4><font color=\"#EF9B13\">References</font></h4> 
<dl>
 <dt>Y.-J. CHANG and C.-C. WANG:</dt> 
    <dd><b>A generalized heat transfer correlation for louver fin geometry</b>. 
    In International Journal of Heat and Mass Transfer, volume 40, No. 3,  pages 533-544, 1997.</dd>
 <dt>Y.-J. CHANG and C.-C. WANG:</dt> 
    <dd><b>Air Side Performance of Brazed Aluminium Heat Exchangers</b>. 
    In Journal of Enhanced Heat Transfer, volume 3, No. 1,  pages 15-28, 1996.</dd>
 <dt>R.-M. Manglik, A.-E. Bergles:</dt> 
    <dd><b>Heat Transfer and Pressure Drop Correlations for the Rectangular Offset Strip Fin Compact Heat Exchanger</b>. 
    In Experimental Thermal and Fluid Science, volume 10, pages 171-180, 1995.</dd>
</dl>

</html>
", revisions="<html>
<pre>2016-04-12 Stefan Wischhusen: Removed singularity for Re at zero mass flow rate. </pre>
</html>"));
end kc_flatTube;
