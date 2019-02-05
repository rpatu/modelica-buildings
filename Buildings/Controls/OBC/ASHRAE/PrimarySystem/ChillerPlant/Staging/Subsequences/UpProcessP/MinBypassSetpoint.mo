within Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.Staging.Subsequences.UpProcessP;
block MinBypassSetpoint
  "Sequence for generating minimum chilled water bypass flow setpoint"

  parameter Integer num = 3
    "Total number of stages, zero stage should be seem as one stage";
  parameter Modelica.SIunits.Time byPasSetTim;
  parameter Modelica.SIunits.VolumeFlowRate minFloSet[num] = {0, 0.0089, 0.0177}
    "Minimum flow rate at each chiller stage";

  Buildings.Controls.OBC.CDL.Interfaces.BooleanInput uStaUp "Indicate if there is stage up"
    annotation (Placement(transformation(extent={{-220,20},{-180,60}}),
      iconTransformation(extent={{-140,20},{-100,60}})));
  Buildings.Controls.OBC.CDL.Interfaces.BooleanInput uOnOff
    "Indicate if the stage require one chiller to be enabled while another is disabled"
    annotation (Placement(transformation(extent={{-220,-130},{-180,-90}}),
      iconTransformation(extent={{-140,-100},{-100,-60}})));
  Buildings.Controls.OBC.CDL.Interfaces.IntegerInput uSta "Current stage index"
    annotation (Placement(transformation(extent={{-220,-60},{-180,-20}}),
      iconTransformation(extent={{-140,-60},{-100,-20}})));
  Buildings.Controls.OBC.CDL.Interfaces.BooleanInput uChiDemRed
    "Operating chillers demand reduce status: true=finished reducing"
    annotation (Placement(transformation(extent={{-220,50},{-180,90}}),
      iconTransformation(extent={{-140,60},{-100,100}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealOutput yChiWatBypSet(
    final unit="m3/s")
    "Chilled water minimum flow bypass setpoint"
    annotation (Placement(transformation(extent={{180,-50},{200,-30}}),
      iconTransformation(extent={{100,-10},{120,10}})));
  Buildings.Controls.OBC.CDL.Interfaces.BooleanOutput yMinBypSet
    "Minimum chilled water flow bypass setpoint reset status"
    annotation (Placement(transformation(extent={{180,60},{200,80}}),
      iconTransformation(extent={{100,-70},{120,-50}})));

protected
  Buildings.Controls.OBC.CDL.Continuous.Sources.Constant con[num](
    final k=minFloSet)
    "Minimum bypass flow setpoint at each stage, equal to the sum of minimum chilled water flowrate of the chillers being enabled at the stage"
    annotation (Placement(transformation(extent={{-140,-30},{-120,-10}})));
  Buildings.Controls.OBC.CDL.Routing.RealExtractor curMinSet(final nin=num)
    "Targeted minimum flow setpoint at current stage"
    annotation (Placement(transformation(extent={{-80,-30},{-60,-10}})));
  Buildings.Controls.OBC.CDL.Continuous.Sources.Constant con3(
    final k=byPasSetTim)
    "Duration time to change old setpoint to new setpoint"
    annotation (Placement(transformation(extent={{-40,0},{-20,20}})));
  Buildings.Controls.OBC.CDL.Continuous.Line upSet
    "Minimum flow setpoint when there is stage up command"
    annotation (Placement(transformation(extent={{80,-50},{100,-30}})));
  Buildings.Controls.OBC.CDL.Continuous.Sources.Constant con2(final k=0)
    "Constant zero"
    annotation (Placement(transformation(extent={{20,0},{40,20}})));
  Buildings.Controls.OBC.CDL.Logical.Timer tim
    "Time after suppress chiller demand"
    annotation (Placement(transformation(extent={{20,60},{40,80}})));
  Buildings.Controls.OBC.CDL.Integers.Sources.Constant conInt1(final k=-1)
    "Constant one"
    annotation (Placement(transformation(extent={{-140,-80},{-120,-60}})));
  Buildings.Controls.OBC.CDL.Integers.Add addInt1
    "One stage lower than current one"
    annotation (Placement(transformation(extent={{-100,-100},{-80,-80}})));
  Buildings.Controls.OBC.CDL.Routing.RealExtractor lowMinSet(final nin=num)
    "Minimum flow setpoint at previous low stage"
    annotation (Placement(transformation(extent={{-80,-70},{-60,-50}})));
  Buildings.Controls.OBC.CDL.Logical.Switch swi
    annotation (Placement(transformation(extent={{40,-120},{60,-100}})));
  Buildings.Controls.OBC.CDL.Continuous.Add add2
    annotation (Placement(transformation(extent={{0,-100},{20,-80}})));
  Buildings.Controls.OBC.CDL.Logical.And and2
    annotation (Placement(transformation(extent={{-80,60},{-60,80}})));
  Buildings.Controls.OBC.CDL.Continuous.Hysteresis hys2(
    final uLow=byPasSetTim+60-5,
    final uHigh=byPasSetTim+60+5)
    "Check if it is 1 minute after new setpoint achieved"
    annotation (Placement(transformation(extent={{140,60},{160,80}})));
  Buildings.Controls.OBC.CDL.Logical.Switch swi1
    annotation (Placement(transformation(extent={{120,30},{140,50}})));
  Buildings.Controls.OBC.CDL.Logical.Not not1 "Logical not"
    annotation (Placement(transformation(extent={{-80,30},{-60,50}})));

equation
  connect(curMinSet.u, con.y)
    annotation (Line(points={{-82,-20},{-119,-20}},color={0,0,127}));
  connect(con.y, lowMinSet.u)
    annotation (Line(points={{-119,-20},{-100,-20},{-100,-60},{-82,-60}},
      color={0,0,127}));
  connect(addInt1.y, lowMinSet.index)
    annotation (Line(points={{-79,-90},{-70,-90},{-70,-72}}, color={255,127,0}));
  connect(con2.y, upSet.x1)
    annotation (Line(points={{41,10},{70,10},{70,-32},{78,-32}},
      color={0,0,127}));
  connect(lowMinSet.y, upSet.f1)
    annotation (Line(points={{-59,-60},{-40,-60},{-40,-36},{78,-36}},
      color={0,0,127}));
  connect(tim.y, upSet.u)
    annotation (Line(points={{41,70},{60,70},{60,-40},{78,-40}},
      color={0,0,127}));
  connect(con3.y, upSet.x2)
    annotation (Line(points={{-19,10},{0,10},{0,-44},{78,-44}},
      color={0,0,127}));
  connect(conInt1.y, addInt1.u1)
    annotation (Line(points={{-119,-70},{-110,-70},{-110,-84},{-102,-84}},
      color={255,127,0}));
  connect(uSta, addInt1.u2)
    annotation (Line(points={{-200,-40},{-160,-40},{-160,-96},{-102,-96}},
      color={255,127,0}));
  connect(uSta, curMinSet.index)
    annotation (Line(points={{-200,-40},{-70,-40},{-70,-32}},color={255,127,0}));
  connect(curMinSet.y, add2.u1)
    annotation (Line(points={{-59,-20},{-20,-20},{-20,-84},{-2,-84}},
      color={0,0,127}));
  connect(lowMinSet.y, add2.u2)
    annotation (Line(points={{-59,-60},{-40,-60},{-40,-96},{-2,-96}},
      color={0,0,127}));
  connect(uOnOff, swi.u2)
    annotation (Line(points={{-200,-110},{38,-110}},
      color={255,0,255}));
  connect(add2.y, swi.u1)
    annotation (Line(points={{21,-90},{28,-90},{28,-102},{38,-102}},
      color={0,0,127}));
  connect(curMinSet.y, swi.u3)
    annotation (Line(points={{-59,-20},{-20,-20},{-20,-118},{38,-118}},
      color={0,0,127}));
  connect(swi.y, upSet.f2)
    annotation (Line(points={{61,-110},{70,-110},{70,-48},{78,-48}},
      color={0,0,127}));
  connect(and2.y, tim.u)
    annotation (Line(points={{-59,70},{18,70}}, color={255,0,255}));
  connect(tim.y, hys2.u)
    annotation (Line(points={{41,70},{138,70}}, color={0,0,127}));
  connect(hys2.y, yMinBypSet)
    annotation (Line(points={{161,70},{190,70}},
      color={255,0,255}));
  connect(curMinSet.y, swi1.u1)
    annotation (Line(points={{-59,-20},{100,-20},{100,48},{118,48}},
      color={0,0,127}));
  connect(uChiDemRed, and2.u1)
    annotation (Line(points={{-200,70},{-82,70}}, color={255,0,255}));
  connect(uStaUp, and2.u2)
    annotation (Line(points={{-200,40},{-100,40},{-100,62},{-82,62}},
      color={255,0,255}));
  connect(uStaUp, not1.u)
    annotation (Line(points={{-200,40},{-82,40}}, color={255,0,255}));
  connect(not1.y, swi1.u2)
    annotation (Line(points={{-59,40},{118,40}}, color={255,0,255}));
  connect(upSet.y, swi1.u3)
    annotation (Line(points={{101,-40},{110,-40},{110,32},{118,32}},
      color={0,0,127}));
  connect(swi1.y, yChiWatBypSet)
    annotation (Line(points={{141,40},{160,40},{160,-40},{190,-40}},
      color={0,0,127}));

annotation (
  defaultComponentName="minBypSet",
  Icon(graphics={
        Rectangle(
        extent={{-100,-100},{100,100}},
        lineColor={0,0,127},
        fillColor={255,255,255},
        fillPattern=FillPattern.Solid),
        Text(
          extent={{-120,146},{100,108}},
          lineColor={0,0,255},
          textString="%name"),
        Text(
          extent={{-96,88},{-36,74}},
          lineColor={255,0,255},
          pattern=LinePattern.Dash,
          textString="uChiWatPum"),
        Text(
          extent={{-96,48},{-58,34}},
          lineColor={255,0,255},
          pattern=LinePattern.Dash,
          textString="uStaUp"),
        Text(
          extent={{-96,-32},{-64,-46}},
          lineColor={255,127,0},
          pattern=LinePattern.Dash,
          textString="uSta"),
        Text(
          extent={{-96,-72},{-58,-86}},
          lineColor={255,0,255},
          pattern=LinePattern.Dash,
          textString="uOnOff"),
        Text(
          extent={{30,10},{98,-4}},
          lineColor={0,0,127},
          pattern=LinePattern.Dash,
          textString="yChiWatBypSet"),
        Text(
          extent={{32,-52},{98,-68}},
          lineColor={255,0,255},
          pattern=LinePattern.Dash,
          textString="yMinBypSet")}),
  Diagram(coordinateSystem(preserveAspectRatio=false,
          extent={{-180,-140},{180,100}})),
  Documentation(info="<html>
<p>
Block that generates chilled water minimum bypass flow setpoint when there is 
stage-up command, for primary-only parallel chiller plants with headered chilled
water pumps and headered condenser water pumps.
The development is based to ASHRAE RP-1711 Advanced Sequences of Operation for 
HVAC Systems Phase II – Central Plants and Hydronic Systems (Draft 4 on January 7, 2019), 
section 5.2.4.18, part 2 and 3.
</p>
<p>
Whenever there is a stage-up command and after operating chillers have reduced the
demand:
</p>
<p>
1. If the stage change requires a smaller chiller being disabled and a larger 
chiller being enabled, the minimum flow setpoint shall temporarily change to 
include the minimum chilled water flowrate of both enabling chiller and 
disabled chiller prior to starting the newly enabled chiller. The change should
be slow. For example, this could be accomplished by resetting the setpoint X GPM/second, 
where X = (NewSetpoint - OldSetpoint) / <code>byPasSetTim</code>. After new 
setpoint is achieved, wait 1 minute to allow loop stabilize (<code>yMinBypSet</code>
becomes true).
</p>
<p>
2. For any other stage change, reset the minimum flow bypass setpoint 
<code>yChiWatBypSet</code> to the one for the new stage. After new 
setpoint is achieved, wait 1 minute to allow loop stabilize (<code>yMinBypSet</code>
becomes true).
</p>
<table summary=\"summary\" border=\"1\">
<tr>
<th> Chiller stage </th> 
<th> Minimum flow </th>  
</tr>
<tr>
<td align=\"center\">0</td>
<td align=\"center\">0</td>
</tr>
<tr>
<td align=\"center\">1</td>
<td align=\"center\"><code>minFloSet</code>[1]</td>
</tr>
<tr>
<td align=\"center\">2</td>
<td align=\"center\"><code>minFloSet</code>[2]</td>
</tr>
<tr>
<td align=\"center\">...</td>
<td align=\"center\">...</td>
</tr>
</table>
<br/>

</html>",
revisions="<html>
<ul>
<li>
January 31, 2019, by Jianjun Hu:<br/>
First implementation.
</li>
</ul>
</html>"));
end MinBypassSetpoint;
