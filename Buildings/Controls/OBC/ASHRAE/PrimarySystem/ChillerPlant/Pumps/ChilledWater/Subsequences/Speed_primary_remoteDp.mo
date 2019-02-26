within Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.Pumps.ChilledWater.Subsequences;
block Speed_primary_remoteDp
  "Pump speed control for primary-only plants where the remote DP sensor(s) is hardwired to the plant controller"
  parameter Integer nSen = 2
    "Total number of remote differential pressure sensors";
  parameter Integer nPum = 2
    "Total number of chilled water pumps";
  parameter Real minPumSpe = 0
    "Minimum pump speed";
  parameter Real maxPumSpe = 1
    "Maximum pump speed";

  Buildings.Controls.OBC.CDL.Interfaces.BooleanInput uChiWatPum[nPum]
    "Chilled water pump status"
    annotation (Placement(transformation(extent={{-140,-70},{-100,-30}}),
      iconTransformation(extent={{-140,-20},{-100,20}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealInput dpChiWat[nSen](
    each final unit="Pa",
    each final quantity="PressureDifference")
    "Chilled water differential static pressure"
    annotation (Placement(transformation(extent={{-140,-30},{-100,10}}),
      iconTransformation(extent={{-140,60},{-100,100}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealInput dpChiWatSet(
    final unit="Pa",
    final quantity="PressureDifference")
    "Chilled water differential static pressure setpoint"
    annotation (Placement(transformation(extent={{-140,-100},{-100,-60}}),
      iconTransformation(extent={{-140,-100},{-100,-60}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealOutput yChiWatPumSpe(
    final min=0,
    final max=1,
    final unit="1") "Chilled water pump speed"
    annotation (Placement(transformation(extent={{100,40},{120,60}}),
      iconTransformation(extent={{100,-10},{120,10}})));

protected
  Buildings.Controls.OBC.CDL.Routing.RealReplicator reaRep(
    final nout=nSen) "Replicate real input"
    annotation (Placement(transformation(extent={{-40,-90},{-20,-70}})));
  Buildings.Controls.OBC.CDL.Continuous.LimPID conPID[nSen](
    each final yMax=1,
    each final yMin=0,
    each final reverseAction=true,
    each final reset=Buildings.Controls.OBC.CDL.Types.Reset.Parameter,
    each final y_reset=0) "Pump speed controller"
    annotation (Placement(transformation(extent={{20,-20},{40,0}})));
  Buildings.Controls.OBC.CDL.Logical.MultiOr mulOr(
    final nu=nPum)
    annotation (Placement(transformation(extent={{-80,-60},{-60,-40}})));
  Buildings.Controls.OBC.CDL.Logical.Not not1 "Logical not"
    annotation (Placement(transformation(extent={{-40,-60},{-20,-40}})));
  Buildings.Controls.OBC.CDL.Continuous.MultiMax maxLoo(
    final nin=nSen) "Maximum DP loop output"
    annotation (Placement(transformation(extent={{60,-20},{80,0}})));
  Buildings.Controls.OBC.CDL.Routing.BooleanReplicator booRep(
    final nout=nSen)
    "Replicate boolean input"
    annotation (Placement(transformation(extent={{-8,-60},{12,-40}})));
  Buildings.Controls.OBC.CDL.Continuous.Line pumSpe "Pump speed"
    annotation (Placement(transformation(extent={{60,40},{80,60}})));
  Buildings.Controls.OBC.CDL.Continuous.Sources.Constant pumSpe_min(
    final k=minPumSpe) "Minimum pump speed"
    annotation (Placement(transformation(extent={{-60,70},{-40,90}})));
  Buildings.Controls.OBC.CDL.Continuous.Sources.Constant pumSpe_max(
    final k=maxPumSpe) "Maximum pump speed"
    annotation (Placement(transformation(extent={{0,10},{20,30}})));
  Buildings.Controls.OBC.CDL.Continuous.Sources.Constant one(final k=1)
    "Constant one"
    annotation (Placement(transformation(extent={{-60,10},{-40,30}})));
  Buildings.Controls.OBC.CDL.Continuous.Sources.Constant zer(final k=0)
    "Constant zero"
    annotation (Placement(transformation(extent={{0,70},{20,90}})));

equation
  connect(dpChiWat, conPID.u_s)
    annotation (Line(points={{-120,-10},{18,-10}}, color={0,0,127}));
  connect(mulOr.y, not1.u)
    annotation (Line(points={{-58.3,-50},{-42,-50}}, color={255,0,255}));
  connect(uChiWatPum, mulOr.u)
    annotation (Line(points={{-120,-50},{-82,-50}}, color={255,0,255}));
  connect(conPID.y, maxLoo.u)
    annotation (Line(points={{41,-10},{58,-10}}, color={0,0,127}));
  connect(not1.y, booRep.u)
    annotation (Line(points={{-19,-50},{-10,-50}}, color={255,0,255}));
  connect(booRep.y, conPID.trigger)
    annotation (Line(points={{13,-50},{22,-50},{22,-22}}, color={255,0,255}));
  connect(dpChiWatSet, reaRep.u)
    annotation (Line(points={{-120,-80},{-42,-80}}, color={0,0,127}));
  connect(reaRep.y, conPID.u_m)
    annotation (Line(points={{-19,-80},{30,-80},{30,-22}},color={0,0,127}));
  connect(zer.y, pumSpe.x1)
    annotation (Line(points={{21,80},{40,80},{40,58},{58,58}}, color={0,0,127}));
  connect(pumSpe_min.y, pumSpe.f1)
    annotation (Line(points={{-39,80},{-20,80},{-20,54},{58,54}}, color={0,0,127}));
  connect(one.y, pumSpe.x2)
    annotation (Line(points={{-39,20},{-20,20},{-20,46},{58,46}}, color={0,0,127}));
  connect(pumSpe_max.y, pumSpe.f2)
    annotation (Line(points={{21,20},{40,20},{40,42},{58,42}}, color={0,0,127}));
  connect(maxLoo.y, pumSpe.u)
    annotation (Line(points={{81,-10},{90,-10},{90,32},{30,32},{30,50},{58,50}},
      color={0,0,127}));
  connect(pumSpe.y, yChiWatPumSpe)
    annotation (Line(points={{81,50},{110,50}}, color={0,0,127}));

annotation (
  defaultComponentName="chiPumSpe",
  Icon(graphics={
        Rectangle(
          extent={{-100,-100},{100,100}},
          lineColor={0,0,127},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-100,150},{100,110}},
          lineColor={0,0,255},
          textString="%name"),
        Text(
          extent={{-98,12},{-44,-10}},
          lineColor={255,0,255},
          pattern=LinePattern.Dash,
          textString="uChiWatPum"),
        Text(
          extent={{-98,90},{-44,68}},
          lineColor={0,0,127},
          pattern=LinePattern.Dash,
          textString="dpChiWat"),
        Text(
          extent={{22,12},{98,-10}},
          lineColor={0,0,127},
          pattern=LinePattern.Dash,
          textString="yChiWatPumSpe"),
        Text(
          extent={{-98,-68},{-34,-90}},
          lineColor={0,0,127},
          pattern=LinePattern.Dash,
          textString="dpChiWatSet")}),
  Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}})),
  Documentation(info="<html>
<p>
Block that enable and disable leading primary chilled water pump, for plants
with headered primary chilled water pumps, 
according to ASHRAE RP-1711 Advanced Sequences of Operation for HVAC Systems Phase II –
Central Plants and Hydronic Systems (Draft 4 on January 7, 2019), 
section 5.2.6 Primary chilled water pumps, part 5.2.6.5 and 5.2.6.6.
</p>
<p>
1. When any chilled water pump is proven on, <code>uChiWatPum</code> = true, 
pump speed will be controlled by a reverse acting PID loop maintaining the
differential pressure signal at a setpoint <code>dpChiWatSet</code>. All pumps
receive the same speed signal. PID loop output shall be mapped from minimum
pump speed (<code>minPumSpe</code>) at 0% to maximum pump speed
(<code>maxPumSpe</code>) at 100%.
</p>
<p>
2. Where multiple differential pressure sensors exist, a PID loop shall run for
each sensor. Chilled water pumps shall be controlled to the high signal output
of all DP sensor loops.
</p>
</html>", revisions="<html>
<ul>
<li>
January 28, 2019, by Jianjun Hu:<br/>
First implementation.
</li>
</ul>
</html>"));
end Speed_primary_remoteDp;
