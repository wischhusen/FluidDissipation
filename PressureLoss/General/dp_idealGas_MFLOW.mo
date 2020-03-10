within FluidDissipation.PressureLoss.General;
function dp_idealGas_MFLOW
  "Generic pressure loss | calculate mass flow rate | ideal gas | mean density"
  extends Modelica.Icons.Function;

  import FD = FluidDissipation.PressureLoss.General;

  //input records
  input FluidDissipation.PressureLoss.General.dp_idealGas_IN_con IN_con
    "Input record for function dp_idealGas_MFLOW"
    annotation (Dialog(group="Constant inputs"));
  input FluidDissipation.PressureLoss.General.dp_idealGas_IN_var IN_var
    "Input record for function dp_idealGas_MFLOW"
    annotation (Dialog(group="Variable inputs"));
  input Modelica.Units.SI.Pressure dp "Pressure loss"
    annotation (Dialog(group="Input"));

  //output variables
  output Modelica.Units.SI.MassFlowRate M_FLOW
    "Output for function dp_idealGas_MFLOW";

protected
  Real Km_internal=IN_con.Km "Coefficient for pressure loss";

  Modelica.Units.SI.Density rho_internal=IN_var.p_m/(IN_con.R_s*IN_var.T_m)
    "Mean density";

  //Documentation

algorithm
  M_FLOW := (IN_con.R_s/Km_internal)^(1/IN_con.exp)*(rho_internal)^(1/IN_con.exp)
    *FluidDissipation.Utilities.Functions.General.SmoothPower(
    dp,
    IN_con.dp_smooth,
    1/IN_con.exp);
  annotation (Inline=true,
    smoothOrder(normallyConstant=IN_con) = 2,
    inverse(dp=FluidDissipation.PressureLoss.General.dp_idealGas_DP(
          IN_con,
          IN_var,
          M_FLOW)),
    Documentation(info="<html>
<p>
Calculation of a generic pressure loss for an <b> ideal gas </b> using mean density.
</p>
 
<p>
This function can be used to calculate both the pressure loss at known mass flow rate <b> or </b> mass flow rate at known pressure loss within one function in dependence of the known 
variable (dp or m_flow).
</p>
 
<p>
Generally this  function is numerically best used for the <b> compressible case </b> if the pressure loss (dp) is known (out of pressures as state variable) and the mass flow rate (M_FLOW) has to be calculated. On the other hand the  function <a href=\"Modelica://FluidDissipation.PressureLoss.General.dp_idealGas_DP\">dp_idealGas_DP</a> is numerically best used for the <b> incompressible case </b>, where the mass flow rate (m_flow) is known (as state variable) in the used model and the corresponding pressure loss (DP) has to be calculated. 
</p> 
 
<h4><font color=\"#EF9B13\">Restriction</font></h4>
This function shall be used inside of the restricted limits according to the referenced literature.
<ul>
 <li>
    <b> ideal gas </b> 
 </li>
 <li>
    mean density of ideal gas
 </li>
</ul>
 
<h4><font color=\"#EF9B13\">Calculation</font></h4>
<p>
The geometry parameters of energy devices necessary for the pressure loss calculations are often not exactly known. 
Therefore the modelling of the detailed pressure loss calculation has to be simplified. 
</p>
 
The pressure loss <b> dp </b> for the compressible case [Mass flow rate = f(dp)] is determined by (Eq.1):
<pre>
    m_flow := (R_s/Km)^(1/exp)*(rho_m)^(1/exp)*dp^(1/exp)
</pre>
 
<p>
for the underlying base equation using ideal gas law as follows:
</p>
<pre>
    dp^2 = p_2^2 - p_1^2 = Km*m_flow^exp*(T_2 + T_1)
    dp   = p_2 - p_1     = Km*m_flow^exp*T_m/p_m, Eq.2 with [dp] = Pa, [m_flow] = kg/s
</pre>
 
<p>
so that the coefficient <b> Km </b> is calculated out of Eq.2:
</p>
 
</p>
<pre>
    Km = dp*R_s*rho_m / m_flow^exp , [Km] = [Pa^2/{(kg/s)^exp*K}]
</pre>
 
where the mean density <b> rho_m </b> is calculated according to the ideal gas law out of an arithmetic mean pressure and temperature:
</p>
<pre>
   rho_m = p_m / (R_s*T_m) , p_m = (p_1 + p_2)/2 and T_m = (T_1 + T_2)/2.
</pre>
 
<p>
with
</p>
 
<p>
<table>
<tr><td><b> exp                    </b></td><td> as exponent of pressure loss law [-],</td></tr>
<tr><td><b> dp                     </b></td><td> as pressure loss [Pa],</td></tr>
<tr><td><b> Km                     </b></td><td> as coefficient w.r.t. mass flow rate! [Km] = [Pa^2/{(kg/s)^exp*K}],</td></tr>
<tr><td><b> m_flow                 </b></td><td> as mass flow rate [kg/s],</td></tr>
<tr><td><b> p_m = (p_2 + p_1)/2    </b></td><td> as mean pressure of ideal gas [Pa],</td></tr>
<tr><td><b> T_m = (T_2 + T_1)/2    </b></td><td> as mean temperature of ideal gas [K],</td></tr>
<tr><td><b> rho_m = p_m/(R_s*T_m)  </b></td><td> as mean density of ideal gas [kg/m3],</td></tr>
<tr><td><b> R_s                    </b></td><td> as specific gas constant of ideal gas [J/(kgK)],</td></tr>
<tr><td><b> V_flow                 </b></td><td> as volume flow rate of ideal gas [m^3/s].</td></tr>
</table>
</p>
 
<p> 
Furthermore the coefficient <b> Km </b> can be defined more detailed w.r.t. the definition of pressure loss if <b> Km </b> is not given as (e.g. measured) value. Generally pressure loss can be calculated due to local losses <b> Km,LOC </b> or frictional losses <b> Km,FRI </b>.
</p> 
<p> 
Pressure loss due to local losses gives the following definition of <b> Km </b>: 
</p>
<pre>
    dp        = zeta_LOC * (rho_m/2)*velocity^2 is leading to
      Km,LOC  = (8/&Pi^2)*R_s*zeta_LOC/(d_hyd)^4, considering the cross sectional area of pipes.
</pre>
 
<p>
and pressure loss due to friction is leading to
</p>
<pre>
    dp        = lambda_FRI*L/d_hyd * (rho_m/2)*velocity^2
      Km,FRI  = (8/&Pi^2)*R_s*lambda_FRI*L/(d_hyd)^5, considering the cross sectional area of pipes.
</pre>
 
<p>
with
</p>
 
<p>
<table>
<tr><td><b> dp                    </b></td><td> as pressure loss [Pa],</td></tr>
<tr><td><b> d_hyd                 </b></td><td> as hydraulic diameter of pipe [m],</td></tr>
<tr><td><b> Km,i                  </b></td><td> as coefficients w.r.t. mass flow rate! [Km] = [Pa^2/{(kg/s)^exp*K}],</td></tr>
<tr><td><b> lambda_FRI            </b></td><td> as Darcy friction factor [-],</td></tr>
<tr><td><b> L                     </b></td><td> as length of pipe [m],</td></tr>
<tr><td><b> rho_m = p_m/(R_s*T_m) </b></td><td> as mean density of ideal gas [kg/m3],</td></tr>
<tr><td><b> velocity              </b></td><td> as mean velocity [m/s],</td></tr>
<tr><td><b> zeta_LOC              </b></td><td> as local resistance coefficient [-].</td></tr>
</table>
</p>
 
Note that the variables of this function are delivered in SI units so that the coefficient Km shall be given in SI units too.
 
<h4><font color=\"#EF9B13\">Verification</font></h4> 
<p>
<b> Compressible case </b> [Mass flow rate = f(dp)]: 
</p>
<p>
The mass flow rate <b> m_flow </b> for different coefficients <b> Km </b> as parameter is shown in dependence of its pressure loss <b> dp </b> in the figure below.
</p>
<p>
<img src=\"modelica://FluidDissipation/Extras/Images/pressureLoss/general/fig_general_dp_idealGas_MFLOWvsDP.png\">
</p>
 
Note that the verification for <a href=\"Modelica://FluidDissipation.PressureLoss.General.dp_idealGas_DP\">dp_idealGas_DP</a> is also valid for this inverse calculation due to using the same functions.
 
<h4><font color=\"#EF9B13\">References</font></h4> 
<dl>
<dt>Elmqvist, H., M.Otter and S.E. Cellier:</dt>
    <dd><b>Inline integration: A new mixed
    symbolic / numeric approach for solving differential-algebraic equation systems.</b>.
    In Proceedings of European Simulation MultiConference, Praque, 1995.</dd>
</dl>
</html>"));
end dp_idealGas_MFLOW;
