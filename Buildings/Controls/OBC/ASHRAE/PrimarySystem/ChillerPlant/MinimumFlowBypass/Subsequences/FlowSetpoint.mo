within Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.MinimumFlowBypass.Subsequences;
block FlowSetpoint "Chilled water minimum flow bypass setpoint"

  parameter Integer nSta = 3
    "Total number of stages, zero stage should be seem as one stage";
  parameter Modelica.SIunits.Time byPasSetTim = 300
    "Time to reset minimum by-pass flow";
  parameter Modelica.SIunits.VolumeFlowRate minFloSet[nSta] = {0, 0.0089, 0.0177}
    "Minimum flow rate at each chiller stage";

  Buildings.Controls.OBC.CDL.Interfaces.BooleanInput uStaUp "Indicate if there is stage up"
    annotation (Placement(transformation(extent={{-300,160},{-260,200}}),
      iconTransformation(extent={{-140,60},{-100,100}})));
  Buildings.Controls.OBC.CDL.Interfaces.BooleanInput uOnOff
    "Indicate if the stage require one chiller to be enabled while another is disabled"
    annotation (Placement(transformation(extent={{-300,-50},{-260,-10}}),
      iconTransformation(extent={{-140,-60},{-100,-20}})));
  Buildings.Controls.OBC.CDL.Interfaces.BooleanInput uUpsDevSta
    "Status of resetting status of device before reset minimum bypass flow setpoint"
    annotation (Placement(transformation(extent={{-300,120},{-260,160}}),
      iconTransformation(extent={{-140,20},{-100,60}})));
  Buildings.Controls.OBC.CDL.Interfaces.IntegerInput uSta "Current stage index"
    annotation (Placement(transformation(extent={{-300,60},{-260,100}}),
      iconTransformation(extent={{-140,-20},{-100,20}})));
  Buildings.Controls.OBC.CDL.Interfaces.BooleanInput uStaDow
    "Indicate if there is stage down"
    annotation (Placement(transformation(extent={{-300,-170},{-260,-130}}),
      iconTransformation(extent={{-140,-100},{-100,-60}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealOutput yChiWatBypSet(
    final unit="m3/s") "Chilled water minimum flow bypass setpoint"
    annotation (Placement(transformation(extent={{260,10},{280,30}}),
      iconTransformation(extent={{100,-10},{120,10}})));

protected
  Buildings.Controls.OBC.CDL.Continuous.Sources.Constant con[nSta](
    final k=minFloSet)
    "Minimum bypass flow setpoint at each stage, equal to the sum of minimum chilled water flowrate of the chillers being enabled at the stage"
    annotation (Placement(transformation(extent={{-220,90},{-200,110}})));
  Buildings.Controls.OBC.CDL.Routing.RealExtractor curMinSet(final nin=nSta)
    "Targeted minimum flow setpoint at current stage"
    annotation (Placement(transformation(extent={{-120,90},{-100,110}})));
  Buildings.Controls.OBC.CDL.Integers.Sources.Constant conInt(final k=1)
    "Constant one"
    annotation (Placement(transformation(extent={{-220,-120},{-200,-100}})));
  Buildings.Controls.OBC.CDL.Integers.Add addInt
    "One stage lower than current one"
    annotation (Placement(transformation(extent={{-180,-140},{-160,-120}})));
  Buildings.Controls.OBC.CDL.Continuous.Sources.Constant con3(
    final k=byPasSetTim)
    "Duration time to change old setpoint to new setpoint"
    annotation (Placement(transformation(extent={{-60,110},{-40,130}})));
  Buildings.Controls.OBC.CDL.Continuous.Line upSet
    "Minimum flow setpoint when there is stage up command"
    annotation (Placement(transformation(extent={{80,70},{100,90}})));
  Buildings.Controls.OBC.CDL.Continuous.Sources.Constant con2(final k=0)
    "Constant zero"
    annotation (Placement(transformation(extent={{0,110},{20,130}})));
  Buildings.Controls.OBC.CDL.Logical.Timer tim
    "Time after suppress chiller demand"
    annotation (Placement(transformation(extent={{0,170},{20,190}})));
  Buildings.Controls.OBC.CDL.Integers.Sources.Constant conInt1(final k=-1)
    "Constant one"
    annotation (Placement(transformation(extent={{-220,40},{-200,60}})));
  Buildings.Controls.OBC.CDL.Integers.Add addInt1
    "One stage lower than current one"
    annotation (Placement(transformation(extent={{-180,20},{-160,40}})));
  Buildings.Controls.OBC.CDL.Routing.RealExtractor lowMinSet(final nin=nSta)
    "Minimum flow setpoint at previous low stage"
    annotation (Placement(transformation(extent={{-120,50},{-100,70}})));
  Buildings.Controls.OBC.CDL.Routing.RealExtractor uppMinSet(final nin=nSta)
    "Minimum flow setpoint at previous upper stage"
    annotation (Placement(transformation(extent={{-120,-120},{-100,-100}})));
  Buildings.Controls.OBC.CDL.Continuous.Line dowSet
    "Minimum flow setpoint when there is stage down command"
    annotation (Placement(transformation(extent={{80,-110},{100,-90}})));
  Buildings.Controls.OBC.CDL.Logical.Timer tim1
    "Time after suppress chiller demand"
    annotation (Placement(transformation(extent={{-40,-160},{-20,-140}})));
  Buildings.Controls.OBC.CDL.Logical.Switch swi
    annotation (Placement(transformation(extent={{20,-10},{40,10}})));
  Buildings.Controls.OBC.CDL.Continuous.Add add2
    annotation (Placement(transformation(extent={{-40,40},{-20,60}})));
  Buildings.Controls.OBC.CDL.Logical.Switch swi1
    annotation (Placement(transformation(extent={{20,-80},{40,-60}})));
  Buildings.Controls.OBC.CDL.Continuous.Add add1
    annotation (Placement(transformation(extent={{-40,-60},{-20,-40}})));
  Buildings.Controls.OBC.CDL.Logical.Switch byPasSet
    "Minimum flow bypass setpoint"
    annotation (Placement(transformation(extent={{140,-10},{160,10}})));
  Buildings.Controls.OBC.CDL.Logical.And3 and4 "Logical and"
    annotation (Placement(transformation(extent={{200,150},{220,170}})));
  Buildings.Controls.OBC.CDL.Logical.Not not2 "Logical not"
    annotation (Placement(transformation(extent={{-160,-190},{-140,-170}})));
  Buildings.Controls.OBC.CDL.Logical.Not not3 "Logical not"
    annotation (Placement(transformation(extent={{140,150},{160,170}})));
  Buildings.Controls.OBC.CDL.Logical.Switch byPasSet1
    "Minimum flow bypass setpoint"
    annotation (Placement(transformation(extent={{200,10},{220,30}})));
  Buildings.Controls.OBC.CDL.Logical.And and1 "Logical not"
    annotation (Placement(transformation(extent={{-120,170},{-100,190}})));
  Buildings.Controls.OBC.CDL.Logical.And and3 "Logical not"
    annotation (Placement(transformation(extent={{-120,-160},{-100,-140}})));

equation
  connect(curMinSet.u, con.y)
    annotation (Line(points={{-122,100},{-199,100}}, color={0,0,127}));
  connect(con.y, lowMinSet.u)
    annotation (Line(points={{-199,100},{-140,100},{-140,60},{-122,60}},
      color={0,0,127}));
  connect(addInt1.y, lowMinSet.index)
    annotation (Line(points={{-159,30},{-110,30},{-110,48}}, color={255,127,0}));
  connect(con2.y, upSet.x1)
    annotation (Line(points={{21,120},{50,120},{50,88},{78,88}},
      color={0,0,127}));
  connect(lowMinSet.y, upSet.f1)
    annotation (Line(points={{-99,60},{-80,60},{-80,84},{78,84}},
      color={0,0,127}));
  connect(tim.y, upSet.u)
    annotation (Line(points={{21,180},{40,180},{40,80},{78,80}},
      color={0,0,127}));
  connect(con3.y, upSet.x2)
    annotation (Line(points={{-39,120},{-10,120},{-10,76},{78,76}},
      color={0,0,127}));
  connect(addInt.y, uppMinSet.index)
    annotation (Line(points={{-159,-130},{-110,-130},{-110,-122}},
      color={255,127,0}));
  connect(uppMinSet.y, dowSet.f1)
    annotation (Line(points={{-99,-110},{-80,-110},{-80,-96},{78,-96}},
      color={0,0,127}));
  connect(conInt1.y, addInt1.u1)
    annotation (Line(points={{-199,50},{-190,50},{-190,36},{-182,36}},
      color={255,127,0}));
  connect(uSta, addInt1.u2)
    annotation (Line(points={{-280,80},{-240,80},{-240,24},{-182,24}},
      color={255,127,0}));
  connect(uSta, curMinSet.index)
    annotation (Line(points={{-280,80},{-110,80},{-110,88}}, color={255,127,0}));
  connect(curMinSet.y, add2.u1)
    annotation (Line(points={{-99,100},{-60,100},{-60,56},{-42,56}},
      color={0,0,127}));
  connect(lowMinSet.y, add2.u2)
    annotation (Line(points={{-99,60},{-80,60},{-80,44},{-42,44}},
      color={0,0,127}));
  connect(uOnOff, swi.u2)
    annotation (Line(points={{-280,-30},{-220,-30},{-220,0},{18,0}},
      color={255,0,255}));
  connect(add2.y, swi.u1)
    annotation (Line(points={{-19,50},{0,50},{0,8},{18,8}},
      color={0,0,127}));
  connect(curMinSet.y, swi.u3)
    annotation (Line(points={{-99,100},{-60,100},{-60,-8},{18,-8}},
      color={0,0,127}));
  connect(swi.y, upSet.f2)
    annotation (Line(points={{41,0},{60,0},{60,72},{78,72}}, color={0,0,127}));
  connect(con.y, uppMinSet.u)
    annotation (Line(points={{-199,100},{-140,100},{-140,-110},{-122,-110}},
      color={0,0,127}));
  connect(uOnOff, swi1.u2)
    annotation (Line(points={{-280,-30},{-220,-30},{-220,-70},{18,-70}},
      color={255,0,255}));
  connect(curMinSet.y, add1.u1)
    annotation (Line(points={{-99,100},{-60,100},{-60,-44},{-42,-44}},
      color={0,0,127}));
  connect(uppMinSet.y, add1.u2)
    annotation (Line(points={{-99,-110},{-80,-110},{-80,-56},{-42,-56}},
      color={0,0,127}));
  connect(add1.y, swi1.u1)
    annotation (Line(points={{-19,-50},{0,-50},{0,-62},{18,-62}},
      color={0,0,127}));
  connect(curMinSet.y, swi1.u3)
    annotation (Line(points={{-99,100},{-60,100},{-60,-78},{18,-78}},
      color={0,0,127}));
  connect(con2.y, dowSet.x1)
    annotation (Line(points={{21,120},{50,120},{50,-92},{78,-92}},
      color={0,0,127}));
  connect(con3.y, dowSet.x2)
    annotation (Line(points={{-39,120},{-10,120},{-10,-104},{78,-104}},
      color={0,0,127}));
  connect(swi1.y, dowSet.f2)
    annotation (Line(points={{41,-70},{60,-70},{60,-108},{78,-108}},
      color={0,0,127}));
  connect(uSta, addInt.u2)
    annotation (Line(points={{-280,80},{-240,80},{-240,-136},{-182,-136}},
      color={255,127,0}));
  connect(conInt.y, addInt.u1)
    annotation (Line(points={{-199,-110},{-190,-110},{-190,-124},{-182,-124}},
      color={255,127,0}));
  connect(tim1.y, dowSet.u)
    annotation (Line(points={{-19,-150},{20,-150},{20,-100},{78,-100}},
      color={0,0,127}));
  connect(upSet.y, byPasSet.u1)
    annotation (Line(points={{101,80},{110,80},{110,8},{138,8}},
      color={0,0,127}));
  connect(dowSet.y, byPasSet.u3)
    annotation (Line(points={{101,-100},{120,-100},{120,-8},{138,-8}},
      color={0,0,127}));
  connect(uStaUp, byPasSet.u2)
    annotation (Line(points={{-280,180},{-220,180},{-220,160},{120,160},
      {120,0},{138,0}}, color={255,0,255}));
  connect(uStaDow, not2.u)
    annotation (Line(points={{-280,-150},{-220,-150},{-220,-180},{-162,-180}},
      color={255,0,255}));
  connect(uStaUp, not3.u)
    annotation (Line(points={{-280,180},{-220,180},{-220,160},{138,160}},
      color={255,0,255}));
  connect(not3.y,and4. u1)
    annotation (Line(points={{161,160},{170,160},{170,168},{198,168}},
      color={255,0,255}));
  connect(not2.y,and4. u2)
    annotation (Line(points={{-139,-180},{130,-180},{130,60},{170,60},
      {170,160}, {198,160}},  color={255,0,255}));
  connect(and4.y, byPasSet1.u2)
    annotation (Line(points={{221,160},{240,160},{240,60},{180,60},{180,20},
      {198,20}},  color={255,0,255}));
  connect(byPasSet1.y, yChiWatBypSet)
    annotation (Line(points={{221,20},{270,20}}, color={0,0,127}));
  connect(byPasSet.y, byPasSet1.u3)
    annotation (Line(points={{161,0},{180,0},{180,12},{198,12}}, color={0,0,127}));
  connect(curMinSet.y, byPasSet1.u1)
    annotation (Line(points={{-99,100},{-60,100},{-60,28},{198,28}},
      color={0,0,127}));
  connect(uStaUp, and1.u1)
    annotation (Line(points={{-280,180},{-122,180}}, color={255,0,255}));
  connect(and1.y, tim.u)
    annotation (Line(points={{-99,180},{-2,180}}, color={255,0,255}));
  connect(uUpsDevSta, and1.u2)
    annotation (Line(points={{-280,140},{-230,140},{-230,172},{-122,172}},
      color={255,0,255}));
  connect(uUpsDevSta, and3.u2)
    annotation (Line(points={{-280,140},{-230,140},{-230,-158},{-122,-158}},
      color={255,0,255}));
  connect(uStaDow, and3.u1)
    annotation (Line(points={{-280,-150},{-122,-150}}, color={255,0,255}));
  connect(and3.y, tim1.u)
    annotation (Line(points={{-99,-150},{-42,-150}}, color={255,0,255}));
  connect(uUpsDevSta, and4.u3)
    annotation (Line(points={{-280,140},{190,140},{190,152},{198,152}},
      color={255,0,255}));

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
          extent={{-98,88},{-60,74}},
          lineColor={255,0,255},
          pattern=LinePattern.Dash,
          textString="uStaUp"),
        Text(
          extent={{-100,8},{-70,-4}},
          lineColor={255,127,0},
          pattern=LinePattern.Dash,
          textString="uSta"),
        Text(
          extent={{-98,-32},{-60,-46}},
          lineColor={255,0,255},
          pattern=LinePattern.Dash,
          textString="uOnOff"),
        Text(
          extent={{-98,-72},{-52,-86}},
          lineColor={255,0,255},
          pattern=LinePattern.Dash,
          textString="uStaDow"),
        Text(
          extent={{34,10},{98,-6}},
          lineColor={0,0,127},
          pattern=LinePattern.Dash,
          textString="yChiWatBypSet"),
        Text(
          extent={{-98,48},{-36,30}},
          lineColor={255,0,255},
          pattern=LinePattern.Dash,
          textString="uUpsDevSta")}),
  Diagram(coordinateSystem(preserveAspectRatio=false,
          extent={{-260,-200},{260,200}})),
  Documentation(info="<html>
<p>
Block that controls chilled water minimum flow bypass valve for primary-only
plants with a minimum flow bypass valve, 
according to ASHRAE RP-1711 Advanced Sequences of Operation for HVAC Systems Phase II –
Central Plants and Hydronic Systems (Draft 4 on January 7, 2019), 
section 5.2.8 Chilled water minimum flow bypass valve.
</p>
<p>
1. Bypass valve shall modulate to maintain minimum flow <code>VBypas_flow</code>
at a setpoint equal to the sum of the minimum chilled water flowrate of the chillers
commanded on run in each stage.
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

<p>
2. If there is any stage change requiring a chiller on and another chiller off,
the minimum flow setpoint shall temporarily change to include the minimum 
chilled water flowrate of both enabling chiller and disabled chiller prior
to starting the newly enabled chiller.
</p>
<p>
3. When any chilled water pump is proven on (<code>uChiWatPum</code> = true), 
the bypass valve PID loop shall be enabled. The valve shall be opened otherwise.
When enabled, the bypass valve loop shall be biased to start with the valve
100% open.
</p>
<p>
Note that when there is stage change thus requires changes of 
minimum bypass flow setpoint, the change should be slowly.
For example, this could be accomplished by resetting the setpoint X GPM/second, 
where X = (NewSetpoint - OldSetpoint) / <code>byPasSetTim</code>.
</p>
</html>",
revisions="<html>
<ul>
<li>
January 31, 2019, by Jianjun Hu:<br/>
First implementation.
</li>
</ul>
</html>"));
end FlowSetpoint;
