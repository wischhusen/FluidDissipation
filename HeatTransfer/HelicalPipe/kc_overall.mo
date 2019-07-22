within FluidDissipation.HeatTransfer.HelicalPipe;
function kc_overall
  "Mean heat transfer coefficient of helical pipe | overall flow regime"
  extends Modelica.Icons.Function;
  //SOURCE: VDI-Waermeatlas, 9th edition, Springer-Verlag, 2002, section Gc1 - Gc2
  //Notation of equations according to SOURCE

  //input records
  input FluidDissipation.HeatTransfer.HelicalPipe.kc_overall_IN_con IN_con
    "Input record for function kc_overall"
    annotation (Dialog(group="Constant inputs"));
  input FluidDissipation.HeatTransfer.HelicalPipe.kc_overall_IN_var IN_var
    "Input record for function kc_overall"
    annotation (Dialog(group="Variable inputs"));

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

protected
  Real MIN=Modelica.Constants.eps "Limiter";

  SI.Area A_cross=PI*IN_con.d_hyd^2/4 "Cross sectional area";

  SI.Velocity velocity=abs(IN_var.m_flow)/max(MIN, IN_var.rho*A_cross)
    "Mean velocity";

  //Documentation
algorithm
  Pr := abs(IN_var.eta*IN_var.cp/max(MIN, IN_var.lambda));
  Re := (IN_var.rho*velocity*IN_con.d_hyd/max(MIN, IN_var.eta));
  kc := FluidDissipation.HeatTransfer.HelicalPipe.kc_overall_KC(IN_con, IN_var);
  Nu := kc*IN_con.d_hyd/max(MIN, IN_var.lambda);

  failureStatus := 0;

  annotation (Inline=false, smoothOrder(normallyConstant=IN_con) = 2, Documentation(
        info="<html>
<p>
Calculation of the mean convective heat transfer coefficient <b> kc </b> of a helical pipe in a hydrodynamically developed overall flow regime.
</p>
 
<h4><font color=\"#EF9B13\">Restriction</font></h4>
<ul>
<li> hydrodynamically developed fluid flow </li>
<li> neglect influence of heat transfer direction (heating/cooling) according to <i> Sieder and Tate </i> </li>
</ul>
 
The critical Reynolds number <b> Re_crit </b> in a helical pipe depends on its mean curvature diameter. The smaller the mean curvature diameter of the helical pipe <b> d_coil</b>, the earlier the turbulent regime will start due to vortexes out of higher centrifugal forces.
 
<h4><font color=\"#EF9B13\">Geometry </font></h4>
<p>
<img src=\"modelica://FluidDissipation/Extras/Images/heatTransfer/helicalPipe/pic_helicalPipe.png\">
</p>  
 
<h4><font color=\"#EF9B13\">Calculation</font></h4>
<b> Laminar regime:</b>
The mean convective heat transfer coefficient <b> kc </b> for helical pipes in the laminar regime is calculated through the corresponding Nusselt number <b> Nu </b> according to <i>[VDI 2002, p. Gc 2, eq. 5]</i> :
 
<pre>
    Nu = 3.66 + 0.08*[1 + 0.8*(d_hyd/d_coil)^0.9]*Re^m*Pr^(1/3) 
</pre>
 
<p>
with the exponent <b> m </b> for the Reynolds number
</p>
 
<p>
<pre>
    m = 0.5 + 0.2903*(d_hyd/d_coil)^0.194.
</pre>
</p>
 
<p>
The <b> transition regime </b> (2e3 &le; Reynolds number &le; 1e4) is calculated via a smoothing interpolation function.
<p>
 
<p>  
<b> Turbulent regime: </b>
The mean convective heat transfer coefficient <b> kc </b> for helical pipes in the turbulent regime is calculated through the corresponding Nusselt number <b> Nu </b> according to <i>[VDI 2002, p. Ga 2, eq. 6]</i> :
 
<pre>
    Nu = (zeta_TOT/8)*Re*Pr/{1 + 12.7*(zeta_TOT/8)^0.5*[Pr^(2/3)-1]},
</pre>
 
<p>
where the influence of the pressure loss on the heat transfer calculation is considered through
</p>
 
<p>
<pre>
    zeta_TOT = 0.3164*Re^(-0.25) + 0.03*(d_hyd/d_coil)^(0.5).
</pre>
</p> 
<p>
The resulting mean convective heat transfer coefficient <b> kc </b> is calculated through:
</p>
 
<p>
<pre>
    kc =  Nu * lambda / d_hyd
</pre>
</p>
 
<p>
with
</p>
 
<p>
<table>
<tr><td><b> d_mean                     </b></td><td> as mean diameter of helical pipe [m],</td></tr>
<tr><td><b> d_coil = f(geometry)       </b></td><td> as mean curvature diameter of helical pipe [m],</td></tr>
<tr><td><b> d_hyd                      </b></td><td> as hydraulic diameter of the helical pipe [m],</td></tr>
<tr><td><b> h                          </b></td><td> as slope of helical pipe [m],</td></tr>
<tr><td><b> kc                         </b></td><td> as mean convective heat transfer coefficient [W/(m2K)],</td></tr>
<tr><td><b> lambda                     </b></td><td> as heat conductivity of fluid [W/(mK)],</td></tr>
<tr><td><b> L                          </b></td><td> as total length of helical pipe [m],</td></tr>
<tr><td><b> Nu = kc*d_hyd/lambda       </b></td><td> as mean Nusselt number [-], </td></tr>
<tr><td><b> Pr = eta*cp/lambda         </b></td><td> as Prandtl number [-],</td></tr>
<tr><td><b> Re = rho*v*d_hyd/eta       </b></td><td> as Reynolds number [-],</td></tr>
<tr><td><b> Re_crit = f(geometry)      </b></td><td> as critical Reynolds number [-].</td></tr>
</table>
</p>
 
<h4><font color=\"#EF9B13\">Verification</font></h4>  
<p>
The mean Nusselt number <b> Nu </b> representing the mean convective heat transfer coefficient <b> kc </b> is shown below for different numbers of turns <b> n_nt </b> at constant total length of the helical pipe. 
</p>
 
<p>
<img src=\"modelica://FluidDissipation/Extras/Images/heatTransfer/helicalPipe/fig_helicalPipe_kc_overall.png\">
</p>
 
<p> 
The convective heat transfer of a helical pipe is enhanced compared to a straight pipe due to occurring turbulences resulting out of centrifugal forces. The higher the number of turns, the better is the convective heat transfer for the same length of a pipe.
</p>

<p> 
Note that the ratio of hydraulic diameter to total length of helical pipe <b> d_hyd/L </b> has no remarkable influence on the coefficient of heat transfer <b> kc </b>.
</p>

<h4><font color=\"#EF9B13\">References</font></h4> 
<dl>
 <dt>GNIELINSKI, V.:</dt> 
    <dd><b>Heat transfer and pressure drop in helically coiled tubes.</b>. 
    In 8th International Heat Transfer Conference, volume 6, pages 2847?2854, Washington,1986. Hemisphere.</dd>
</dl>
</html>
 
 
 
", revisions="<html>
<pre>2016-04-12 Stefan Wischhusen: Removed singularity for Re at zero mass flow rate. </pre>
</html>"));
end kc_overall;
