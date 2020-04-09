within Buildings.Applications.DHC.Networks.BaseClasses;
partial model PartialDistribution1Pipe
  "Partial model for one-pipe distribution network"
  extends PartialDistribution;
  replaceable model Model_pipDis = Fluid.Interfaces.PartialTwoPortInterface (
    redeclare final package Medium = Medium,
    final allowFlowReversal=allowFlowReversal)
    "Model for distribution pipe";
  parameter Boolean have_heaFloOut = false
    "Set to true to output the heat flow rate transferred to each connected load"
    annotation(Evaluate=true);
  parameter Modelica.SIunits.MassFlowRate mDis_flow_nominal
    "Nominal mass flow rate in the distribution line"
    annotation(Dialog(tab="General", group="Nominal condition"));
  parameter Modelica.SIunits.MassFlowRate mCon_flow_nominal[nCon]
    "Nominal mass flow rate in each connection line"
    annotation(Dialog(tab="General", group="Nominal condition"));
  parameter Modelica.Fluid.Types.Dynamics energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial
    "Type of energy balance: dynamic (3 initialization options) or steady state"
    annotation(Evaluate=true, Dialog(tab = "Dynamics", group="Equations"));
  parameter Modelica.SIunits.Time tau=10
    "Time constant at nominal flow for dynamic energy and momentum balance"
    annotation (
      Dialog(tab="Dynamics", group="Nominal condition",
      enable=not energyDynamics==Modelica.Fluid.Types.Dynamics.SteadyState));
  // IO CONNECTORS
  Modelica.Blocks.Interfaces.RealOutput Q_flow[nCon](
    each final quantity="HeatFlowRate",each final unit="W") if have_heaFloOut
    "Heat flow rate transferred to the connected load (>=0 for heating)"
    annotation (Placement(transformation(extent={{100,60},{140,100}}),
      iconTransformation(extent={{200,60},{220,80}})));
  Modelica.Blocks.Interfaces.RealOutput mCon_flow[nCon](
    each final quantity="MassFlowRate", each final unit="kg/s")
    "Connection supply mass flow rate (measured)"
    annotation (Placement(transformation(
      extent={{100,40},{140,80}}),
      iconTransformation(extent={{200,40},{220,60}})));
  Modelica.Blocks.Interfaces.RealOutput mByp_flow[nCon](
    each final quantity="MassFlowRate", each final unit="kg/s")
    "Bypass mass flow rate"
    annotation (Placement(transformation(extent={{100,20},{140,60}}),
        iconTransformation(extent={{200,20},{220,40}})));
  // COMPONENTS
  replaceable PartialConnection1Pipe con[nCon](
    redeclare each final package Medium = Medium,
    each final have_heaFloOut=have_heaFloOut,
    each final mDis_flow_nominal=mDis_flow_nominal,
    final mCon_flow_nominal=mCon_flow_nominal,
    each final allowFlowReversal=allowFlowReversal,
    each final energyDynamics=energyDynamics,
    each final tau=tau)
    "Connection to agent"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Model_pipDis pipEnd(
    final m_flow_nominal=mDis_flow_nominal)
    "Pipe representing the end of the distribution line (after last connection)"
    annotation (Placement(transformation(extent={{40,-10},{60,10}})));
equation
  // Connecting outlets to inlets for all instances of connection component.
  if nCon >= 2 then
    for i in 2:nCon loop
      connect(con[i - 1].port_bDis, con[i].port_aDis);
    end for;
  end if;
  connect(con.port_bCon, ports_bCon)
    annotation (Line(points={{0,10},{0,40},{-80, 40},{-80,100}}, color={0,127,255}));
  connect(ports_aCon, con.port_aCon)
    annotation (Line(points={{80,100},{80,40}, {6,40},{6,10}}, color={0,127,255}));
  connect(port_aDisSup, con[1].port_aDis)
    annotation (Line(points={{-100,0},{-10,0}}, color={0,127,255}));
  connect(con[nCon].port_bDis, pipEnd.port_a)
    annotation (Line(points={{10,0},{40,0}}, color={0,127,255}));
  connect(pipEnd.port_b, port_bDisSup)
    annotation (Line(points={{60,0},{100,0}}, color={0,127,255}));
  connect(con.Q_flow, Q_flow)
    annotation (Line(points={{11,8},{16,8},{16,24},{88,24},{88,80},{120,80}},  color={0,0,127}));
  connect(con.mByp_flow, mByp_flow)
    annotation (Line(points={{11,4},{20,4},{20, 20},{92,20},{92,40},{120,40}}, color={0,0,127}));
  connect(con.mCon_flow, mCon_flow)
    annotation (Line(points={{11,6},{18,6},{18, 22},{90,22},{90,60},{120,60}}, color={0,0,127}));
  annotation (
      Documentation(info="
<html>
<p>
Partial model of a one-pipe distribution network.
</p>
<p>
An array of replaceable partial models is used to represent the
connections along the network, including the pipe segment immediately
upstream of each connection.
</p>
<p>
A replaceable partial model is used to represent the pipe segment of
the return line after the last connection.
</p>
<p>
Optionally the heat flow rate transferred to each connected load can be output.
</p>
</html>",
revisions=
"<html>
<ul>
<li>
February 21, 2020, by Antoine Gautier:<br/>
First implementation.
</li>
</ul>
</html>"),
    Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{-6,-200},{6,200}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          origin={0,0},
          rotation=90),
        Rectangle(
          extent={{-53,4},{53,-4}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          origin={-120,47},
          rotation=90),
        Rectangle(
          extent={{-53,4},{53,-4}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          origin={120,47},
          rotation=90)}),
    Diagram( coordinateSystem(preserveAspectRatio=false)));
end PartialDistribution1Pipe;
