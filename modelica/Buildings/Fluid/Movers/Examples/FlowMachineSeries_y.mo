within Buildings.Fluid.Movers.Examples;
model FlowMachineSeries_y "Test model for two flow machines in series"
  import Buildings;
  extends Modelica.Icons.Example;
  package Medium = Buildings.Media.ConstantPropertyLiquidWater;

  parameter Modelica.SIunits.MassFlowRate m_flow_nominal=
     1 "Nominal mass flow rate";

  Buildings.Fluid.Movers.FlowMachine_y floMac1(
    redeclare package Medium = Medium,
    m_flow_nominal=1,
    redeclare function flowCharacteristic =
        Buildings.Fluid.Movers.BaseClasses.Characteristics.linearFlow (
          V_flow_nominal={m_flow_nominal/1000,0}, dp_nominal={0,2*4*1000}),
    dynamicBalance=false) "Model of a flow machine"
    annotation (Placement(transformation(extent={{-20,50},{0,70}})));

  Buildings.Fluid.Sources.Boundary_pT sou(
    redeclare package Medium = Medium,
    use_p_in=false,
    p(displayUnit="Pa") = 300000,
    T=293.15,
    nPorts=1) annotation (Placement(transformation(extent={{-92,50},{-72,70}},
          rotation=0)));

  Modelica.Blocks.Sources.Constant const2(k=1)
    annotation (Placement(transformation(extent={{40,80},{60,100}})));

  parameter Medium.ThermodynamicState state_start = Medium.setState_pTX(
      T=Medium.T_default,
      p=Medium.p_default,
      X=Medium.X_default) "Start state";
  parameter Modelica.SIunits.Density rho_nominal=Medium.density(
     state_start) "Density, used to compute fluid mass"
                                           annotation (Evaluate=true);
  inner Modelica.Fluid.System system
    annotation (Placement(transformation(extent={{120,-80},{140,-60}})));
  Buildings.Fluid.Movers.FlowMachine_y floMac2(
    redeclare package Medium = Medium,
    m_flow_nominal=1,
    redeclare function flowCharacteristic =
        Buildings.Fluid.Movers.BaseClasses.Characteristics.linearFlow (
          V_flow_nominal={m_flow_nominal/1000,0}, dp_nominal={0,2*4*1000}),
    dynamicBalance=false) "Model of a flow machine"
    annotation (Placement(transformation(extent={{60,50},{80,70}})));
  Modelica.Blocks.Sources.Ramp     const1(
    height=-1,
    offset=1,
    duration=8,
    startTime=1)
    annotation (Placement(transformation(extent={{-40,80},{-20,100}})));
  Buildings.Fluid.Sources.Boundary_pT sou1(
    redeclare package Medium = Medium,
    use_p_in=false,
    nPorts=1,
    p(displayUnit="Pa") = 300000 + 4000,
    T=293.15) annotation (Placement(transformation(extent={{156,50},{136,70}},
          rotation=0)));
equation
  connect(const2.y, floMac2.y)
                              annotation (Line(
      points={{61,90},{70,90},{70,70}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(const1.y, floMac1.y) annotation (Line(
      points={{-19,90},{-10,90},{-10,70}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(floMac1.port_b, floMac2.port_a) annotation (Line(
      points={{5.55112e-16,60},{60,60}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(sou.ports[1], floMac1.port_a) annotation (Line(
      points={{-72,60},{-20,60}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(floMac2.port_b, sou1.ports[1]) annotation (Line(
      points={{80,60},{136,60}},
      color={0,127,255},
      smooth=Smooth.None));
  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{160,
            160}}), graphics),
    __Dymola_Commands(file="modelica://Buildings/Resources/Scripts/Dymola/Fluid/Movers/Examples/FlowMachineSeries_y.mos"
        "Simulate and plot"),
    Documentation(info="<html>
This example tests the configuration of two flow machines that are installed in series.
Both flow machines start with full speed. 
Between <i>t=1</i> second and <i>t=9</i> seconds, the speed of the flow machine on the left is reduced to zero.
As its speed is reduced, the mass flow rate is reduced. Note that even at zero input, the mass flow rate is non-zero,
but the pressure rise of the pump is zero.
</html>", revisions="<html>
<ul>
<li>March 24 2010, by Michael Wetter:<br>
First implementation.
</li>
</ul>
</html>"),    Diagram,
    experiment(
      StopTime=10,
      Tolerance=1e-05,
      Algorithm="Radau"),
    __Dymola_experimentSetupOutput);
end FlowMachineSeries_y;
