within FluidDissipation.PressureLoss.General;
function dp_nominalPressureLossLawDensity_MFLOW
  "Generic pressure loss | calculate mass flow rate | nominal operation point | pressure loss law (coefficient and exponent) | density dependence"
  extends Modelica.Icons.Function;

  import FD = FluidDissipation.PressureLoss.General;

  //input records
  input
    FluidDissipation.PressureLoss.General.dp_nominalPressureLossLawDensity_IN_con
    IN_con "Input record for function dp_nominalPressureLossLawDensity_MFLOW"
    annotation (Dialog(group="Constant inputs"));
  input
    FluidDissipation.PressureLoss.General.dp_nominalPressureLossLawDensity_IN_var
    IN_var "Input record for function dp_nominalPressureLossLawDensity_MFLOW"
    annotation (Dialog(group="Variable inputs"));
  input SI.Pressure dp "Pressure loss" annotation (Dialog(group="Input"));

  //output variables
  output SI.MassFlowRate M_FLOW
    "Output for function dp_nominalPressurelosslawDensity_MFLOW";

protected
  Real exp_density=if IN_con.target ==FluidDissipation.Utilities.Types.MassOrVolumeFlowRate.MassFlowRate
                                                                                               then
            1 - IN_con.exp else 1 "Exponent of density fraction (rho/rho_nom)";
  SI.MassFlowRate m_flow_nom=if IN_con.target ==FluidDissipation.Utilities.Types.MassOrVolumeFlowRate.MassFlowRate
                                                                                               then
            IN_con.m_flow_nom else IN_var.rho*IN_con.V_flow_nom
    "Nominal mean flow velocity at operation point";

  //Documentation

algorithm
  M_FLOW := if IN_con.exp > 1.0 or IN_con.exp < 1.0 then
    FluidDissipation.Utilities.Functions.General.SmoothPower(
    dp,
    0.01*IN_con.dp_nom,
    1/IN_con.exp)*IN_con.m_flow_nom*(IN_con.A_cross/IN_con.A_cross_nom)*(IN_con.rho_nom
    /IN_var.rho)^(exp_density/IN_con.exp)*((1/IN_con.dp_nom)*(IN_con.zeta_TOT_nom
    /IN_var.zeta_TOT))^(1/IN_con.exp) else IN_con.m_flow_nom*(IN_con.A_cross/
    IN_con.A_cross_nom)*(IN_con.rho_nom/IN_var.rho)^(exp_density/1)*((dp/IN_con.dp_nom)
    *(IN_con.zeta_TOT_nom/IN_var.zeta_TOT))^(1/1);
  annotation (Inline=false,
    smoothOrder(normallyConstant=IN_con) = 2,
    inverse(dp=FluidDissipation.PressureLoss.General.dp_nominalPressureLossLawDensity_DP(
          IN_con,
          IN_var,
          M_FLOW)),
    Documentation(info="<html>
<p>
Calculation of a generic pressure loss in dependence of nominal fluid variables (e.g. nominal density) via interpolation from an operation point.
This generic function considers the pressure loss law via a nominal pressure loss (dp_nom), a pressure loss coefficient (zeta_TOT) and a pressure loss law exponent (exp) as well as the influence of density on pressure loss.
The function can be used to calculate pressure loss at known mass flow rate <b> or </b>  mass flow rate at known pressure loss.
</p>
 
<p>
This function can be used to calculate both the pressure loss at known mass flow rate <b> or </b> mass flow rate at known pressure loss within one function in dependence of the known 
variable (dp or m_flow).
</p>
 
<p>
Generally this  function is numerically best used for the <b> compressible case </b> if the pressure loss (dp) is known (out of pressures as state variable) and the mass flow rate (M_FLOW) has to be calculated. On the other hand the  function <a href=\"Modelica://FluidDissipation.PressureLoss.General.dp_nominalPressureLossLawDensity_DP\">dp_nominalPressurelosslawDensity_DP</a> is numerically best used for the <b> incompressible case </b>, where the mass flow rate (m_flow) is known (as state variable) in the used model and the corresponding pressure loss (DP) has to be calculated. 
</p>
 
<h4><font color=\"#EF9B13\">Calculation</font></h4>
<p>
The geometry parameters of energy devices necessary for the pressure loss calculations are often not exactly known. 
Therefore the modelling of the detailed pressure loss calculation have to be simplified.
This function uses nominal variables (e.g. nominal pressure loss) at a known operation point of the energy device to interpolate the actual pressure loss according to a pressure loss law (exponent).
</p>
 
In the following the pressure loss <b> dp </b> is generally determined from a known operation point via a law of similarity:
<pre>
   dp/dp_nom = (zeta_TOT/zeta_TOT_nom)*(rho/rho_nom)*(v/v_nom)^exp
</pre> 
 
<p>
with
</p>
 
<p>
<table>
<tr><td><b> dp             </b></td><td> as pressure loss [Pa],</td></tr>
<tr><td><b> dp_nom         </b></td><td> as nominal pressure loss [Pa],</td></tr>
<tr><td><b> m_flow         </b></td><td> as mass flow rate [kg/s],</td></tr>
<tr><td><b> m_flow_nom     </b></td><td> as nominal mass flow rate [kg/s],</td></tr>
<tr><td><b> exp            </b></td><td> as exponent of pressure loss calculation [-],</td></tr>
<tr><td><b> rho            </b></td><td> as fluid density [kg/m3],</td></tr>
<tr><td><b> rho_nom        </b></td><td> as nominal fluid density [kg/m3],</td></tr>
<tr><td><b> v              </b></td><td> as mean flow velocity [m/s],</td></tr>
<tr><td><b> v_nom          </b></td><td> as nominal mean flow velocity [m/s],</td></tr>
<tr><td><b> zeta_TOT       </b></td><td> as pressure loss coefficient [-],</td></tr>
<tr><td><b> zeta_TOT_nom   </b></td><td> as nominal pressure loss coefficient [-].</td></tr>
</table>
</p>
 
The fraction of mean flow velocities (v/v_nom) can be calculated through its corresponding <b> mass flow rates </b>, densities and cross sectional areas:
<pre>
   v/v_nom = (m_flow/m_flow_nom)*(A_cross_nom/A_cross)*(rho_nom/rho)
</pre>
 
<p>
<b> or </b> through its corresponding <b> volume flow rates </b>, densities and cross sectional areas:
</p>
 
<pre>
    v/v_nom = (V_flow/V_flow_nom)*(A_cross_nom/A_cross).
</pre>
 
 
<p>
with
</p>
 
<p>
<table>
<tr><td><b> A_cross        </b></td><td> as cross sectional area [m2],</td></tr>
<tr><td><b> A_cross_nom    </b></td><td> as nominal cross sectional area [m2],</td></tr>
<tr><td><b> rho            </b></td><td> as fluid density [kg/m3],</td></tr>
<tr><td><b> rho_nom        </b></td><td> as nominal fluid density [kg/m3],</td></tr>
<tr><td><b> v              </b></td><td> as mean flow velocity [m/s],</td></tr>
<tr><td><b> v_nom          </b></td><td> as nominal mean flow velocity [m/s],</td></tr>
<tr><td><b> V_flow         </b></td><td> as volume flow rate [m3/s],</td></tr>
<tr><td><b> V_flow_nom     </b></td><td> as nominal volume flow rate [m3/s].</td></tr>
</table>
</p> 
 
Here the <b> compressible case </b> [Mass flow rate = f(dp)] determines the unknown mass flow rate out of a given pressure loss:
<p>
<pre>
   m_flow = m_flow_nom*(A_cross/A_cross_nom)*(rho_nom/rho)^(exp_density/exp)*[(dp/dp_nom)*(zeta_TOT_nom/zeta_TOT)]^(1/exp);
</pre>    
</p> 
 
<p>
where the exponent for the fraction of densities is determined w.r.t. the chosen nominal mass flow rate or nominal volume flow rate to:
</p>
 
<p>
<pre>
  exp_density = if NominalMassFlowRate == 1 then 1-exp else 1
</pre>    
</p> 
 
<p>
with
</p>
 
<p>
<table>
<tr><td><b> NominalMassFlowRate    </b></td><td> as reference for pressure loss law (mass flow rate of volume flow rate),</td></tr>
<tr><td><b> exp                    </b></td><td> as exponent of pressure loss calculation [-],</td></tr>
<tr><td><b> exp_density            </b></td><td> as exponent for density [-].</td></tr>
</table>
</p> 
 
To avoid numerical difficulties this pressure loss function is linear smoothed for small pressure losses, with
<p>
<pre> 
   dp &le; 0.01*dp_nom
</pre>  
</p>
 
<p> 
Note that the input and output arguments for functions throughout this library always use mass flow rates. Here you can choose <b> NominalMassFlowRate == 1 </b> for using a nominal mass flow rate or <b> NominalMassFlowRate == 2 </b> for using a nominal volume flow rate. The output argument will always be a mass flow rate for further use as flow model in a thermo-hydraulic framework. 
</p>
 
<p>
Note that the pressure loss coefficients (zeta_TOT,zeta_TOT_nom) refer to its mean flow velocities (v,v_nom) in the pressure loss law to obtain its corresponding pressure loss.
</p>
 
<h4><font color=\"#EF9B13\">Verification</font></h4>
<p>
<b> Compressible case </b> [Mass flow rate = f(dp)]: 
</p>
 
The generic mass flow rate <b> M_FLOW </b> in dependence of the pressure loss <b> dp </b> is shown for a turbulent pressure loss regime (exp == 2) in the figure below.
<p>
<img src=\"modelica://FluidDissipation/Extras/Images/pressureLoss/general/fig_general_dp_nominalPressureLossLawDensity_MFLOWvsDP.png\">
</p> 
 
Note that the verification for <a href=\"Modelica://FluidDissipation.PressureLoss.General.dp_nominalPressureLossLawDensity_DP\">dp_nominalPressureLossLawDensity_DP</a> is also valid for this inverse calculation due to using the same functions.
 
 
<h4><font color=\"#EF9B13\">References</font></h4> 
<dl>
<dt>Elmquist, H., M.Otter and S.E. Cellier:</dt>
    <dd><b>Inline integration: A new mixed
    symbolic / numeric approach for solving differential-algebraic equation systems.</b>.
    In Proceedings of European Simulation MultiConference, Praque, 1995.</dd>
<dt>Wischhusen, S.:</dt>
    <dd><b>Dynamische Simulation zur wirtschaftlichen Bewertung von komplexen Energiesystemen.</b>.
    PhD thesis, Technische Universit&auml;t Hamburg-Harburg, 2005.</dd>
</dl>
 
</html>"));
end dp_nominalPressureLossLawDensity_MFLOW;
