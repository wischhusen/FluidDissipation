within FluidDissipation.HeatTransfer.StraightPipe;
function kc_overall
  "Mean heat transfer coefficient of straight pipe | uniform wall temperature or uniform heat flux | hydrodynamically developed or undeveloped overall flow regime| pressure loss dependence"
  extends Modelica.Icons.Function;
  //input records
  input FluidDissipation.HeatTransfer.StraightPipe.kc_overall_IN_con IN_con
    "Input record for function kc_overall"
    annotation (Dialog(group="Constant inputs"));
  input FluidDissipation.HeatTransfer.StraightPipe.kc_overall_IN_var IN_var
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
  type TYP = Modelica.Fluid.Dissipation.Utilities.Types.Roughness;

  Real MIN=Modelica.Constants.eps "Limiter";

  Modelica.Units.SI.Area A_cross=PI*IN_con.d_hyd^2/4 "Cross sectional area";

  Modelica.Units.SI.Velocity velocity=abs(IN_var.m_flow)/max(MIN, IN_var.rho*
      A_cross) "Mean velocity";

  //failure status
  Real fstatus[3] "Check of expected boundary conditions";

  //Documentation
algorithm
  Pr := abs(IN_var.eta*IN_var.cp/max(MIN, IN_var.lambda));
  Re := (IN_var.rho*velocity*IN_con.d_hyd/max(MIN, IN_var.eta));
  kc := FluidDissipation.HeatTransfer.StraightPipe.kc_overall_KC(IN_con, IN_var);
  Nu := kc*IN_con.d_hyd/max(MIN, IN_var.lambda);

  //failure status
  if IN_con.roughness == TYP.Neglected then
    if Re > 1e6 then
      fstatus[1] := 1;
    else
      fstatus[1] := 0;
    end if;
  elseif IN_con.roughness == TYP.Considered then
    if Re > 1e6 then
      fstatus[1] := 1;
    else
      fstatus[1] := 0;
    end if;
  else
    assert(true, "No choice of roughness is selected");
  end if;
  fstatus[2] := if Pr < 0.6 or Pr > 1e3 then 1 else 0;
  fstatus[3] := if IN_con.d_hyd/max(MIN, IN_con.L) > 1 then 1 else 0;

  failureStatus := 0;
  for i in 1:size(fstatus, 1) loop
    if fstatus[i] == 1 then
      failureStatus := 1;
    end if;
  end for;
  annotation (Inline=false, smoothOrder(normallyConstant=IN_con) = 2, Documentation(
        info="<html>
<p>
Calculation of mean convective heat transfer coefficient <b> kc </b> of a straight pipe at an uniform wall temperature <b> or </b> uniform heat flux <b> and </b> for a hydrodynamically developed <b>or</b> undeveloped overall fluid flow with neglect <b> or </b> consideration of pressure loss influence.
</p>
 
<h4><font color=\"#EF9B13\">Restriction</font></h4>
<ul>
<li> circular cross sectional area </li>
<li> uniform wall temperature (UWT) <b> or </b> uniform heat flux (UHF) </li>
<li> hydrodynamically developed fluid flow </li>
<li> hydraulic diameter / length &le; 1 </li>
<li> 0.6 &le; Prandtl number &le; 1000 </li>
</ul>
 
<h4><font color=\"#EF9B13\">Geometry </font></h4> 
<p>
<img src=\"modelica://FluidDissipation/Extras/Images/pressureLoss/straightPipe/pic_straightPipe.png\">
</p>    
 
<h4><font color=\"#EF9B13\">Calculation</font></h4> 
<p>
<b> Laminar regime:</b>
The mean convective heat transfer coefficient <b> kc </b> of a straight pipe in the laminar regime can be calculated for the following four heat transfer boundary conditions through its corresponding Nusselt number <b> Nu </b>:
 
<p>
<b> Uniform wall temperature in developed fluid flow (heatTransferBoundary == UWTuDFF)</b> according to <i>[VDI 2002, p. Ga 2, eq. 6]</i> :
</p> 
 
<pre>
    Nu_TD = [3.66^3 + 0.7^3 + {1.615*(Re*Pr*d_hyd/L)^1/3 - 0.7}^3]^1/3 
</pre>
 
<p>
<b> Uniform heat flux in developed fluid flow (heatTransferBoundary == UHFuDFF)</b> according to <i>[VDI 2002, p. Ga 4, eq. 19]</i> :
</p> 
 
<pre>
    Nu_qD = [4.364^3 + 0.6^3 + {1.953*(Re*Pr*d_hyd/L)^1/3 - 0.6}^3]^1/3 
</pre>
 
<p>
<b> Uniform wall temperature in undeveloped fluid flow (heatTransferBoundary == UWTuUFF)</b> according to <i>[VDI 2002, p. Ga 2, eq. 12]</i> :
</p> 
 
<pre>
    Nu_TU = [3.66^3 + 0.7^3 + {1.615*(Re*Pr*d_hyd/L)^1/3 - 0.7}^3 + {(2/[1+22*Pr])^1/6*(Re*Pr*d_hyd/L)^0.5}^3]^1/3 
</pre>
 
<p>
<b> Uniform heat flux in undeveloped fluid flow (heatTransferBoundary == UHFuUFF)</b> according to <i>[VDI 2002, p. Ga 5, eq. 25]</i> :
</p> 
 
<pre>
    Nu_qU = [4.364^3 + 0.6^3 + {1.953*(Re*Pr*d_hyd/L)^1/3 - 0.6}^3 + {0.924*Pr^1/3*[Re*d_hyd/L]^0.5}^3]^1/3.  
</pre>
 
<p>
The <b> transition regime </b> (2e3 &le; Reynolds number &le; 1e4) is calculated via a smoothing interpolation function.
</p>
 
<p>  
<b> Turbulent regime: </b>
<b>Neglect pressure loss influence (roughness == Neglected):</b>
</p>
 
The mean convective heat transfer coefficient <b> kc </b> for smooth straight pipes is calculated through its corresponding Nusselt number <b> Nu </b> according to <i> [Dittus and Boelter in Bejan 2003, p. 424, eq. 5.76]</i>
 
<pre>
    Nu = 0.023 * Re^(4/5) * Pr^(1/3).
</pre>
 
<p>
<b>Consider pressure loss influence (roughness == Considered):</b>
</p>
 
<p>
The mean convective heat transfer coefficient <b> kc </b> for rough straight pipes is calculated through its corresponding Nusselt number <b> Nu </b> according to <i>[Gnielinski in VDI 2002, p. Ga 5, eq. 26]</i>
</p>
 
<pre>
    Nu = (zeta/8)*Re*Pr/(1 + 12.7*(zeta/8)^0.5*(Pr^(2/3)-1))*(1+(d_hyd/L)^(2/3)),
</pre>
 
<p>
where the influence of the pressure loss on the heat transfer calculation is considered through
</p>
 
<p>
<pre>
    zeta =  (1.8*log10(Re)-1.5)^-2.
</pre>
</p>
 
<p>
The corresponding mean convective heat transfer coefficient <b> kc </b> results to
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
<tr><td><b> d_hyd                      </b></td><td> as hydraulic diameter of straight pipe [m],</td></tr>
<tr><td><b> kc                         </b></td><td> as mean convective heat transfer coefficient [W/(m2K)],</td></tr>
<tr><td><b> lambda                     </b></td><td> as heat conductivity of fluid [W/(mK)],</td></tr>
<tr><td><b> L                          </b></td><td> as length of straight pipe [m],</td></tr>
<tr><td><b> Nu = kc*d_hyd/lambda       </b></td><td> as mean Nusselt number [-], </td></tr>
<tr><td><b> Pr = eta*cp/lambda         </b></td><td> as Prandtl number [-],</td></tr>
<tr><td><b> Re = rho*v*d_hyd/eta       </b></td><td> as Reynolds number [-],</td></tr>
<tr><td><b> v                          </b></td><td> as mean velocity [m/s],</td></tr>
<tr><td><b> zeta                       </b></td><td> as pressure loss coefficient [-]. </td></tr>
</table>
</p>
 
<p>
Note that there is no significant difference for the calculation of the mean Nusselt number <b> Nu </b> at a uniform wall temperature (UWT) or a uniform heat flux (UHF) as heat transfer boundary in the turbulent regime (Bejan 2003, p.303).
</p>
 
<h4><font color=\"#EF9B13\">Verification</font></h4>
<p>
The mean Nusselt number <b> Nu </b> representing the mean convective heat transfer coefficient <b> kc </b> is shown for the fluid properties of Water (Prandtl number Pr = 7) and a diameter to pipe length fraction of 0.1 in the figure below. 
</p>
 
<p>
The following verification considers pressure loss influence (roughness == Considered).
</p>
 
<p>
<img src=\"modelica://FluidDissipation/Extras/Images/heatTransfer/straightPipe/fig_straightPipe_kc_overall.png\">
</p>
 
<h4><font color=\"#EF9B13\">References</font></h4> 
<dl>
 <dt>Bejan,A.:</dt> 
    <dd><b>Heat transfer handbook</b>. 
    Wiley, 2003.</dd>
 <dt>VDI:</dt> 
    <dd><b>VDI - W&auml;rmeatlas: Berechnungsbl&auml;tter f&uuml;r den W&auml;rme&uuml;bergang</b>. 
    Springer Verlag, 9th edition, 2002.</dd>
</dl>
 
</html>
", revisions="<html>
<pre>2016-04-12 Stefan Wischhusen: Removed singularity for Re at zero mass flow rate.<br> 
2016-06-03 Stefan Wischhusen: Failure status corrected. Function is also valid for laminar and transitional flow. </pre>
</html>"));
end kc_overall;
