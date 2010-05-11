within Buildings.Fluid.Actuators.Dampers;
model MixingBox "Outside air mixing box with interlocked air dampers"
  extends Buildings.BaseClasses.BaseIconLow;
  outer Modelica.Fluid.System system "System wide properties";
  replaceable package Medium =
      Modelica.Media.Interfaces.PartialMedium "Medium in the component"
    annotation (choicesAllMatching = true);
  import Modelica.Constants;

  parameter Boolean allowFlowReversal = system.allowFlowReversal
    "= true to allow flow reversal, false restricts to design direction (port_a -> port_b)"
    annotation(Dialog(tab="Assumptions"), Evaluate=true);

  VAVBoxExponential damOA(A=AOut,
    redeclare package Medium = Medium,
    dp_nominal=dpOut_nominal,
    dp_nominalIncludesDamper=dp_nominalIncludesDamper,
    from_dp=from_dp,
    linearized=linearized,
    use_deltaM=use_deltaM,
    deltaM=deltaM,
    use_v_nominal=use_v_nominal,
    v_nominal=v_nominal,
    roundDuct=roundDuct,
    ReC=ReC,
    m_flow_small=m_flow_small,
    a=a,
    b=b,
    yL=yL,
    yU=yU,
    k0=k0,
    k1=k1,
    use_constant_density=use_constant_density,
    allowFlowReversal=allowFlowReversal,
    m_flow_nominal=mOut_flow_nominal)
    annotation (Placement(transformation(extent={{-40,50},{-20,70}},   rotation=
           0)));
  parameter Boolean use_deltaM = true
    "Set to true to use deltaM for turbulent transition, else ReC is used";
  parameter Real deltaM = 0.3
    "Fraction of nominal mass flow rate where transition to turbulent occurs"
    annotation(Dialog(enable=use_deltaM));
  parameter Boolean use_v_nominal = true
    "Set to true to use face velocity to compute area";
  parameter Modelica.SIunits.Velocity v_nominal=1 "Nominal face velocity"
    annotation(Dialog(enable=use_v_nominal));

  parameter Boolean roundDuct = false
    "Set to true for round duct, false for square cross section"
    annotation(Dialog(enable=not use_deltaM));
  parameter Real ReC=4000
    "Reynolds number where transition to turbulent starts"
    annotation(Dialog(enable=not use_deltaM));

  parameter Modelica.SIunits.Area AOut=mOut_flow_nominal/rho_nominal/v_nominal
    "Face area outside air damper"
    annotation(Dialog(enable=not use_v_nominal));
  VAVBoxExponential damExh(                            A=AExh,
    redeclare package Medium = Medium,
    m_flow_nominal=mExh_flow_nominal,
    dp_nominal=dpExh_nominal,
    dp_nominalIncludesDamper=dp_nominalIncludesDamper,
    from_dp=from_dp,
    linearized=linearized,
    use_deltaM=use_deltaM,
    deltaM=deltaM,
    use_v_nominal=use_v_nominal,
    v_nominal=v_nominal,
    roundDuct=roundDuct,
    ReC=ReC,
    m_flow_small=m_flow_small,
    a=a,
    b=b,
    yL=yL,
    yU=yU,
    k0=k0,
    k1=k1,
    use_constant_density=use_constant_density,
    allowFlowReversal=allowFlowReversal) "Exhaust air damper"
    annotation (Placement(transformation(extent={{-20,-70},{-40,-50}}, rotation=
           0)));
  parameter Modelica.SIunits.Area AExh=mExh_flow_nominal/rho_nominal/v_nominal
    "Face area exhaust air damper"
    annotation(Dialog(enable=not use_v_nominal));
  VAVBoxExponential damRec(                            A=ARec,
    redeclare package Medium = Medium,
    m_flow_nominal=mRec_flow_nominal,
    dp_nominal=dpRec_nominal,
    dp_nominalIncludesDamper=dp_nominalIncludesDamper,
    from_dp=from_dp,
    linearized=linearized,
    use_deltaM=use_deltaM,
    deltaM=deltaM,
    use_v_nominal=use_v_nominal,
    v_nominal=v_nominal,
    roundDuct=roundDuct,
    ReC=ReC,
    m_flow_small=m_flow_small,
    a=a,
    b=b,
    yL=yL,
    yU=yU,
    k0=k0,
    k1=k1,
    use_constant_density=use_constant_density,
    allowFlowReversal=allowFlowReversal) "Recirculation air damper"
                               annotation (Placement(transformation(
        origin={30,0},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  parameter Modelica.SIunits.Area ARec=mRec_flow_nominal/rho_nominal/v_nominal
    "Face area recirculation air damper"
    annotation(Dialog(enable=not use_v_nominal));

  parameter Boolean dp_nominalIncludesDamper=false
    "set to true if dp_nominal includes the pressure loss of the open damper"
    annotation (Dialog(group="Nominal condition"));

  parameter Modelica.SIunits.MassFlowRate mOut_flow_nominal
    "Mass flow rate outside air damper"
    annotation (Dialog(group="Nominal condition"));
  parameter Modelica.SIunits.Pressure dpOut_nominal(min=0, displayUnit="Pa")
    "Pressure drop outside air leg"
     annotation (Dialog(group="Nominal condition"));

  parameter Modelica.SIunits.MassFlowRate mRec_flow_nominal
    "Mass flow rate recirculation air damper"
    annotation (Dialog(group="Nominal condition"));
  parameter Modelica.SIunits.Pressure dpRec_nominal(min=0, displayUnit="Pa")
    "Pressure drop recirculation air leg"
     annotation (Dialog(group="Nominal condition"));

  parameter Modelica.SIunits.MassFlowRate mExh_flow_nominal
    "Mass flow rate exhaust air damper"
    annotation (Dialog(group="Nominal condition"));
  parameter Modelica.SIunits.Pressure dpExh_nominal(min=0, displayUnit="Pa")
    "Pressure drop exhaust air leg"
     annotation (Dialog(group="Nominal condition"));

  parameter Modelica.Media.Interfaces.PartialMedium.MassFlowRate m_flow_small=1E-4
      *mOut_flow_nominal "Small mass flow rate for regularization of zero flow"
    annotation (Dialog(tab="Advanced"));
  parameter Boolean from_dp=true
    "= true, use m_flow = f(dp) else dp = f(m_flow)"
    annotation (Dialog(tab="Advanced"));
  parameter Boolean linearized=false
    "= true, use linear relation between m_flow and dp for any flow rate"
    annotation (Dialog(tab="Advanced"));
  parameter Boolean use_constant_density=true
    "Set to true to use constant density for flow friction"
    annotation (Dialog(tab="Advanced"));
  parameter Real a=-1.51 "Coefficient a for damper characteristics"
    annotation (Dialog(tab="Damper coefficients"));
  parameter Real b=0.105*90 "Coefficient b for damper characteristics"
    annotation (Dialog(tab="Damper coefficients"));
  parameter Real yL=15/90 "Lower value for damper curve"
    annotation (Dialog(tab="Damper coefficients"));
  parameter Real yU=55/90 "Upper value for damper curve"
    annotation (Dialog(tab="Damper coefficients"));
  parameter Real k0=1E6
    "Flow coefficient for y=0, k0 = pressure drop divided by dynamic pressure"
    annotation (Dialog(tab="Damper coefficients"));
  parameter Real k1=0.45
    "Flow coefficient for y=1, k1 = pressure drop divided by dynamic pressure"
    annotation (Dialog(tab="Damper coefficients"));

  Modelica.Fluid.Interfaces.FluidPort_a port_Out(redeclare package Medium =
        Medium, m_flow(start=0, min=if allowFlowReversal then -Constants.inf else
                0))
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-110,50},{-90,70}},
          rotation=0)));
  Modelica.Fluid.Interfaces.FluidPort_b port_Exh(redeclare package Medium =
        Medium, m_flow(start=0, max=if allowFlowReversal then +Constants.inf else
                0))
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-90,-70},{-110,-50}},
          rotation=0)));
  Modelica.Fluid.Interfaces.FluidPort_a port_Ret(redeclare package Medium =
        Medium, m_flow(start=0, min=if allowFlowReversal then -Constants.inf else
                0))
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{110,-70},{90,-50}}, rotation=
            0)));
  Modelica.Fluid.Interfaces.FluidPort_b port_Sup(redeclare package Medium =
        Medium, m_flow(start=0, max=if allowFlowReversal then +Constants.inf else
                0))
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{110,50},{90,70}}, rotation=0)));
  Modelica.Blocks.Interfaces.RealInput y "Damper position (0: closed, 1: open)"
    annotation (Placement(transformation(extent={{-20,-20},{20,20}},   rotation=270,
        origin={0,120})));
  Modelica.Blocks.Sources.Constant uni(k=1) "Unity signal"
    annotation (Placement(transformation(extent={{-90,-4},{-70,16}},rotation=0)));

  Modelica.Blocks.Math.Add add(k2=-1)
                             annotation (Placement(transformation(extent={{-40,-10},
            {-20,10}},    rotation=0)));

protected
  parameter Medium.Density rho_nominal=Medium.density(sta_nominal)
    "Density, used to compute fluid volume";
  parameter Medium.ThermodynamicState sta_nominal=
     Medium.setState_pTX(T=Medium.T_default, p=Medium.p_default, X=Medium.X_default);
equation
  connect(y, damOA.y) annotation (Line(points={{1.11022e-15,120},{0,120},{0,80},
          {-30,80},{-30,68}},
                     color={0,0,127}));
  connect(y, damExh.y) annotation (Line(points={{1.11022e-15,120},{0,120},{0,
          -40},{-30,-40},{-30,-52}},   color={0,0,127}));
  connect(uni.y, add.u1) annotation (Line(points={{-69,6},{-42,6},{-42,6}},
        color={0,0,127}));
  connect(y, add.u2) annotation (Line(points={{1.11022e-15,120},{0,120},{0,-20},
          {-52,-20},{-52,-6},{-42,-6}},
                color={0,0,127}));
  connect(add.y, damRec.y) annotation (Line(points={{-19,6.10623e-16},{-19,0},{
          22,0},{22,1.15598e-15}},
                             color={0,0,127}));
  connect(damOA.port_a, port_Out) annotation (Line(
      points={{-40,60},{-100,60}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(damExh.port_b, port_Exh) annotation (Line(
      points={{-40,-60},{-100,-60}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(port_Sup, damOA.port_b) annotation (Line(
      points={{100,60},{-20,60}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(damRec.port_b, port_Sup) annotation (Line(
      points={{30,10},{30,60},{100,60}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(port_Ret, damExh.port_a) annotation (Line(
      points={{100,-60},{-20,-60}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(port_Ret, damRec.port_a) annotation (Line(
      points={{100,-60},{30,-60},{30,-10}},
      color={0,127,255},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=true,  extent={{-100,
            -100},{100,100}}),
                      graphics),
                       Icon(coordinateSystem(preserveAspectRatio=true,  extent={{-100,
            -100},{100,100}}), graphics={
        Rectangle(
          extent={{-98,66},{94,54}},
          lineColor={0,0,255},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-94,-54},{96,-66}},
          lineColor={0,0,255},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-6,66},{6,-56}},
          lineColor={0,0,255},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-70,42},{-48,78},{-30,78},{-54,42},{-70,42}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{68,66},{90,60},{68,54},{68,66}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{72,-58},{92,-62}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{72,-54},{48,-60},{72,-66},{72,-54}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{2,104},{28,82}},
          lineColor={0,0,127},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          textString="y"),
        Rectangle(
          extent={{48,62},{68,58}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-74,-76},{-52,-40},{-34,-40},{-58,-76},{-74,-76}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-20,-18},{2,18},{20,18},{-4,-18},{-20,-18}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid)}),
    Documentation(revisions="<html>
<ul>
<li>
February 23, 2010 by Michael Wetter:<br>
First implementation.
</li>
</ul>
</html>", info="<html>
<p>
Model of an outside air mixing box with air dampers.
Set <code>y=0</code> to close the outside air and exhast air dampers.
</p>
<p>
If <code>dp_nominalIncludesDamper=true</code>, then the parameter <code>dp_nominal</code>
is equal to the pressure drop of the damper plus the fixed flow resistance at the nominal
flow rate.
If <code>dp_nominalIncludesDamper=false</code>, then <code>dp_nominal</code>
does not include the flow resistance of the air damper.
</p>
</html>"));
end MixingBox;
