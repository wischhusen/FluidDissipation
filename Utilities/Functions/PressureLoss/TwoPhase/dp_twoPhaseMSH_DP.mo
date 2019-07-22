within FluidDissipation.Utilities.Functions.PressureLoss.TwoPhase;
function dp_twoPhaseMSH_DP
  "Two phase flow frictional pressure loss according to Mueller-Steinhagen and Heck (1986)| calculate pressure loss| overall flow regime"
  input FluidDissipation.Utilities.Records.General.TwoPhaseFlow_con
    IN_con "Input record for constant values";
  input FluidDissipation.Utilities.Records.General.TwoPhaseFlow_var
    IN_var "Input record for variable values";
  input Modelica.SIunits.MassFlowRate m_flow "Mass flow rate";

  output Modelica.SIunits.PressureDifference DP "Pressure difference";

  import SMOOTH = FluidDissipation.Utilities.Functions.General.Stepsmoother;

protected
  Real Re_lam "Reynolds number for determination of flow regime";
  Real Re_trans "Reynolds number for flow regime transition";
  Modelica.SIunits.Length d_hyd = 4*IN_con.A_cross/IN_con.perimeter
    "Hydraulic diameter";

algorithm
  Re_trans := 1187;
  Re_lam := 4*m_flow/(d_hyd*IN_var.eta_l*Modelica.Constants.pi);

  DP:= SMOOTH(
    Re_trans,
    Re_trans + 100,
    Re_lam)*
    SMOOTH(
    -Re_trans,
    -Re_trans - 100,
    Re_lam)*FluidDissipation.Utilities.Functions.PressureLoss.TwoPhase.dp_twoPhaseLaminarMSH_DP(
    IN_con,
    IN_var,
    m_flow) + SMOOTH(
    Re_trans + 100,
    Re_trans,
    Re_lam)*FluidDissipation.Utilities.Functions.PressureLoss.TwoPhase.dp_twoPhaseTurbulentMSH_DP(
    IN_con,
    IN_var,
    m_flow) + SMOOTH(
    -Re_trans - 100,
    -Re_trans,
    Re_lam)*FluidDissipation.Utilities.Functions.PressureLoss.TwoPhase.dp_twoPhaseTurbulentMSH_DP(
    IN_con,
    IN_var,
    m_flow);
  annotation (Documentation(info="<HTML><HEAD><meta http-equiv=\"Content-Type\" content=\"text/html;charset=utf-8\"><html><body>
<style type='text/css'>
                        a          { text-decoration: none      }
                        a:hover    { text-decoration: underline }
                        a:active   { text-decoration: underline }
                        strike     { color: grey                }
                        u          { text-decoration: none;
                                     background-color: yellow   }
                        tt         { color: #000000;            }
                        pre        { color: #000000;
                                     margin-left: 20px          }
                        h1         { text-align: center;
                                     color: #ef9b13             }
                        h2         { color: #ef9b13             }
                        h3         { color: #000000             }
                        h4         { color: #EF9B13             }
                        h5         { color: #EF9B13             }
                        span.insen { color: grey                }
                        .page { max-width: 1000px;}
                        .menu{
                                float:left; width: 300px;
                        }

                        .content { padding-left: 320px;}
                        .notebook{font-variant: small-caps;
                                        color:#4e9a06;
                                        padding: 0px 20px;}
                        hr{clear:both;}
                </style>
</HEAD><BODY>

<h4>Restrictions</h4>
<p>
<ul>
<li>no supercritical flow conditions are supported</li>
<li><img src=\"modelica://FluidDissipation/Extras/Images/pressureLoss/StraightPipe/Equations/equation.png\" alt=\"\"></li>
<li>frictional pressure drop of gas flow is lower than the frictional pressure drop of the liquid flow (e.g. certain oil-gas flows)</li>
<li>surface roughness is not considered, equation of Blasius used for turbulent flow regime</li>
</ul>
</p>
<h4><font color=\"#EF9B13\">Geometry </font></h4>
<p>
<img src=\"modelica://FluidDissipation/Extras/Images/pressureLoss/straightPipe/pic_straightPipe.png\">
</p>
 
<h4>Laminar flow regime</h4>
<p>
i.e. <img src=\"modelica://FluidDissipation/Extras/Images/pressureLoss/StraightPipe/Equations/equation007.png\" alt=\"\"><br>
<img src=\"modelica://FluidDissipation/Extras/Images/pressureLoss/StraightPipe/Equations/equation008.png\" alt=\"\"><br>
<img src=\"modelica://FluidDissipation/Extras/Images/pressureLoss/StraightPipe/Equations/equation013.png\" alt=\"\"><br>
</p>


<h4>Turbulent flow regime</h4>
<p>
i.e. <img src=\"modelica://FluidDissipation/Extras/Images/pressureLoss/StraightPipe/Equations/equation006.png\" alt=\"\"><br>
<img src=\"modelica://FluidDissipation/Extras/Images/pressureLoss/StraightPipe/Equations/equation001.png\" alt=\"\"><br>
<img src=\"modelica://FluidDissipation/Extras/Images/pressureLoss/StraightPipe/Equations/equation012.png\" alt=\"\"></p>
<h4>Validation</h4>
<p>
<img src=\"modelica://FluidDissipation/Extras/Images/pressureLoss/StraightPipe/fig_validPL_straigthPipeTwoPhaseMSH.png\" alt=\"\" width=\"600\">
</p>
<p>
Fluid is Nitrogen, pipe diameter is 0.014 m. Measurement data is taken from [2].
</p>
<h4>References</h4>
<p>
[1]   H. Mueller-Steinhagen and K. Heck: \"A Simple Friction Pressure Drop Correlation for Two-Phase Flow in Pipes\", Chem. Eng. Process, 1986, 20, 297-308
</p>
<p>
[2]   H. Mueller-Steinhagen: \"Waermeuebergang und Fouling beim Stroemungssieden von Argon und Stickstoff im horizontalen Rohr\", Fortschrittsberichte der VDI Zeitschriften, Reihe 6 Nr. 143, 1984  
</p>

</BODY></HTML>"));
end dp_twoPhaseMSH_DP;
