within Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.MinimumFlowBypass;
block Controller
  "Controller for chilled water minimum flow bypass valve"

  parameter Integer num = 3
    "Total number of stages, zero stage should be seem as one stage";
  parameter Modelica.SIunits.Time byPasSetTim;
  parameter Modelica.SIunits.VolumeFlowRate minFloSet[num] = {0, 0.0089, 0.0177}
    "Minimum flow rate at each chiller stage";


  Buildings.Controls.OBC.CDL.Interfaces.BooleanInput uStaUp "Indicate if there is stage up"
    annotation (Placement(transformation(extent={{-300,120},{-260,160}}),
      iconTransformation(extent={{-120,20},{-100,40}})));
  Buildings.Controls.OBC.CDL.Interfaces.BooleanInput uOnOff
    "Indicate if the stage require one chiller to be enabled while another is disabled"
    annotation (Placement(transformation(extent={{-300,-90},{-260,-50}}),
      iconTransformation(extent={{-120,-70},{-100,-50}})));
  Buildings.Controls.OBC.CDL.Interfaces.IntegerInput uSta "Current stage index"
    annotation (Placement(transformation(extent={{-300,20},{-260,60}}),
      iconTransformation(extent={{-120,-40},{-100,-20}})));
  Buildings.Controls.OBC.CDL.Interfaces.BooleanInput uStaDow
    "Indicate if there is stage down"
    annotation (Placement(transformation(extent={{-300,-240},{-260,-200}}),
      iconTransformation(extent={{-120,-100},{-100,-80}})));
  Buildings.Controls.OBC.CDL.Interfaces.BooleanInput uChiWatPum
    "Indicate if there is any chilled water pump is proven on: true=ON, false=OFF"
    annotation (Placement(transformation(extent={{-300,180},{-260,220}}),
      iconTransformation(extent={{-120,80},{-100,100}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealInput VBypas_flow(
    final min=0,
    final unit="m3/s",
    quantity="VolumeFlowRate") "Measured bypass flow rate"
    annotation (Placement(transformation(extent={{-300,150},{-260,190}}),
      iconTransformation(extent={{-120,50},{-100,70}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealOutput yValPos
    "Chilled water minimum flow bypass valve position"
    annotation (Placement(transformation(extent={{260,210},{280,230}}),
      iconTransformation(extent={{100,-10},{120,10}})));

  CDL.Logical.Sources.Constant con1(k=true) "Constant true"
    annotation (Placement(transformation(extent={{162,-194},{182,-174}})));
  CDL.Logical.Sources.Constant con4(k=true) "Constant false"
    annotation (Placement(transformation(extent={{162,-250},{182,-230}})));
protected
  Buildings.Controls.OBC.CDL.Continuous.Sources.Constant con[num](
    final k=minFloSet)
    "Minimum bypass flow setpoint at each stage, equal to the sum of minimum chilled water flowrate of the chillers being enabled at the stage"
    annotation (Placement(transformation(extent={{-220,50},{-200,70}})));
  Buildings.Controls.OBC.CDL.Routing.RealExtractor curMinSet(final nin=num)
    "Targeted minimum flow setpoint at current stage"
    annotation (Placement(transformation(extent={{-120,50},{-100,70}})));
  Buildings.Controls.OBC.CDL.Integers.Sources.Constant conInt(final k=1)
    "Constant one"
    annotation (Placement(transformation(extent={{-220,-180},{-200,-160}})));
  Buildings.Controls.OBC.CDL.Integers.Add addInt
    "One stage lower than current one"
    annotation (Placement(transformation(extent={{-180,-200},{-160,-180}})));
  Buildings.Controls.OBC.CDL.Continuous.Sources.Constant con3(
    final k=byPasSetTim)
    "Duration time to change old setpoint to new setpoint"
    annotation (Placement(transformation(extent={{-60,90},{-40,110}})));
  Buildings.Controls.OBC.CDL.Continuous.Line upSet
    "Minimum flow setpoint when there is stage up command"
    annotation (Placement(transformation(extent={{80,30},{100,50}})));
  Buildings.Controls.OBC.CDL.Continuous.Sources.Constant con2(final k=0)
    "Constant zero"
    annotation (Placement(transformation(extent={{0,90},{20,110}})));
  Buildings.Controls.OBC.CDL.Logical.Timer tim
    "Time after suppress chiller demand"
    annotation (Placement(transformation(extent={{0,130},{20,150}})));
  Buildings.Controls.OBC.CDL.Integers.Sources.Constant conInt1(final k=-1)
    "Constant one"
    annotation (Placement(transformation(extent={{-220,0},{-200,20}})));
  Buildings.Controls.OBC.CDL.Integers.Add addInt1
    "One stage lower than current one"
    annotation (Placement(transformation(extent={{-180,-20},{-160,0}})));
  Buildings.Controls.OBC.CDL.Routing.RealExtractor lowMinSet(final nin=num)
    "Minimum flow setpoint at previous low stage"
    annotation (Placement(transformation(extent={{-120,10},{-100,30}})));
  Buildings.Controls.OBC.CDL.Routing.RealExtractor uppMinSet(final nin=num)
    "Minimum flow setpoint at previous upper stage"
    annotation (Placement(transformation(extent={{-120,-170},{-100,-150}})));
  Buildings.Controls.OBC.CDL.Continuous.Line dowSet
    "Minimum flow setpoint when there is stage down command"
    annotation (Placement(transformation(extent={{80,-150},{100,-130}})));
  Buildings.Controls.OBC.CDL.Logical.Timer tim1
    "Time after suppress chiller demand"
    annotation (Placement(transformation(extent={{0,-230},{20,-210}})));
  Buildings.Controls.OBC.CDL.Logical.Switch swi
    annotation (Placement(transformation(extent={{20,-40},{40,-20}})));
  Buildings.Controls.OBC.CDL.Continuous.Add add2
    annotation (Placement(transformation(extent={{-40,-20},{-20,0}})));
  Buildings.Controls.OBC.CDL.Logical.Switch swi1
    annotation (Placement(transformation(extent={{20,-120},{40,-100}})));
  Buildings.Controls.OBC.CDL.Continuous.Add add1
    annotation (Placement(transformation(extent={{-40,-100},{-20,-80}})));
  Buildings.Controls.OBC.CDL.Logical.Switch byPasSet
    "Minimum flow bypass setpoint"
    annotation (Placement(transformation(extent={{160,-70},{180,-50}})));
  Buildings.Controls.OBC.CDL.Continuous.LimPID valPos(
    final yMax=1,
    final yMin=0,
    final reset=Buildings.Controls.OBC.CDL.Types.Reset.Parameter,
    final y_reset=1) "By pass valve position"
    annotation (Placement(transformation(extent={{220,210},{240,230}})));
  Buildings.Controls.OBC.CDL.Logical.Not not1
    annotation (Placement(transformation(extent={{-220,190},{-200,210}})));

equation
  connect(curMinSet.u, con.y)
    annotation (Line(points={{-122,60},{-199,60}}, color={0,0,127}));
  connect(con.y, lowMinSet.u)
    annotation (Line(points={{-199,60},{-140,60},{-140,20},{-122,20}},
      color={0,0,127}));
  connect(addInt1.y, lowMinSet.index)
    annotation (Line(points={{-159,-10},{-110,-10},{-110,8}}, color={255,127,0}));
  connect(con2.y, upSet.x1)
    annotation (Line(points={{21,100},{50,100},{50,48},{78,48}},
      color={0,0,127}));
  connect(lowMinSet.y, upSet.f1)
    annotation (Line(points={{-99,20},{-80,20},{-80,44},{78,44}},
      color={0,0,127}));
  connect(tim.y, upSet.u)
    annotation (Line(points={{21,140},{40,140},{40,40},{78,40}},
      color={0,0,127}));
  connect(con3.y, upSet.x2)
    annotation (Line(points={{-39,100},{-10,100},{-10,36},{78,36}},
      color={0,0,127}));
  connect(addInt.y, uppMinSet.index)
    annotation (Line(points={{-159,-190},{-110,-190},{-110,-172}},
      color={255,127,0}));
  connect(uppMinSet.y, dowSet.f1)
    annotation (Line(points={{-99,-160},{-80,-160},{-80,-136},{78,-136}},
      color={0,0,127}));
  connect(uStaDow, tim1.u)
    annotation (Line(points={{-280,-220},{-2,-220}}, color={255,0,255}));
  connect(conInt1.y, addInt1.u1)
    annotation (Line(points={{-199,10},{-190,10},{-190,-4},{-182,-4}},
      color={255,127,0}));
  connect(uSta, addInt1.u2)
    annotation (Line(points={{-280,40},{-240,40},{-240,-16},{-182,-16}},
      color={255,127,0}));
  connect(uSta, curMinSet.index)
    annotation (Line(points={{-280,40},{-110,40},{-110,48}}, color={255,127,0}));
  connect(uStaUp, tim.u)
    annotation (Line(points={{-280,140},{-2,140}}, color={255,0,255}));
  connect(curMinSet.y, add2.u1)
    annotation (Line(points={{-99,60},{-60,60},{-60,-4},{-42,-4}},
      color={0,0,127}));
  connect(lowMinSet.y, add2.u2)
    annotation (Line(points={{-99,20},{-80,20},{-80,-16},{-42,-16}},
      color={0,0,127}));
  connect(uOnOff, swi.u2)
    annotation (Line(points={{-280,-70},{-220,-70},{-220,-30},{18,-30}},
      color={255,0,255}));
  connect(add2.y, swi.u1)
    annotation (Line(points={{-19,-10},{0,-10},{0,-22},{18,-22}},
      color={0,0,127}));
  connect(curMinSet.y, swi.u3)
    annotation (Line(points={{-99,60},{-60,60},{-60,-38},{18,-38}},
      color={0,0,127}));
  connect(swi.y, upSet.f2)
    annotation (Line(points={{41,-30},{60,-30},{60,32},{78,32}}, color={0,0,127}));
  connect(con.y, uppMinSet.u)
    annotation (Line(points={{-199,60},{-140,60},{-140,-160},{-122,-160}},
      color={0,0,127}));
  connect(uOnOff, swi1.u2)
    annotation (Line(points={{-280,-70},{-220,-70},{-220,-110},{18,-110}},
      color={255,0,255}));
  connect(curMinSet.y, add1.u1)
    annotation (Line(points={{-99,60},{-60,60},{-60,-84},{-42,-84}},
      color={0,0,127}));
  connect(uppMinSet.y, add1.u2)
    annotation (Line(points={{-99,-160},{-80,-160},{-80,-96},{-42,-96}},
      color={0,0,127}));
  connect(add1.y, swi1.u1)
    annotation (Line(points={{-19,-90},{0,-90},{0,-102},{18,-102}},
      color={0,0,127}));
  connect(curMinSet.y, swi1.u3)
    annotation (Line(points={{-99,60},{-60,60},{-60,-118},{18,-118}},
      color={0,0,127}));
  connect(con2.y, dowSet.x1)
    annotation (Line(points={{21,100},{50,100},{50,-132},{78,-132}},
      color={0,0,127}));
  connect(con3.y, dowSet.x2)
    annotation (Line(points={{-39,100},{-10,100},{-10,-144},{78,-144}},
      color={0,0,127}));
  connect(swi1.y, dowSet.f2)
    annotation (Line(points={{41,-110},{60,-110},{60,-148},{78,-148}},
      color={0,0,127}));
  connect(uSta, addInt.u2)
    annotation (Line(points={{-280,40},{-240,40},{-240,-196},{-182,-196}},
      color={255,127,0}));
  connect(conInt.y, addInt.u1)
    annotation (Line(points={{-199,-170},{-190,-170},{-190,-184},{-182,-184}},
      color={255,127,0}));
  connect(tim1.y, dowSet.u)
    annotation (Line(points={{21,-220},{40,-220},{40,-140},{78,-140}},
      color={0,0,127}));
  connect(upSet.y, byPasSet.u1)
    annotation (Line(points={{101,40},{140,40},{140,-52},{158,-52}},
      color={0,0,127}));
  connect(dowSet.y, byPasSet.u3)
    annotation (Line(points={{101,-140},{140,-140},{140,-68},{158,-68}},
      color={0,0,127}));
  connect(uStaUp, byPasSet.u2)
    annotation (Line(points={{-280,140},{-20,140},{-20,120},{120,120},{120,-60},
      {158,-60}}, color={255,0,255}));
  connect(uChiWatPum, not1.u)
    annotation (Line(points={{-280,200},{-222,200}}, color={255,0,255}));
  connect(not1.y, valPos.trigger)
    annotation (Line(points={{-199,200},{222,200},{222,208}}, color={255,0,255}));
  connect(byPasSet.y, valPos.u_s)
    annotation (Line(points={{181,-60},{200,-60},{200,220},{218,220}},
      color={0,0,127}));
  connect(VBypas_flow, valPos.u_m)
    annotation (Line(points={{-280,170},{230,170},{230,208}}, color={0,0,127}));
  connect(valPos.y, yValPos)
    annotation (Line(points={{241,220},{250,220},{250,220},{270,220}},
      color={0,0,127}));

annotation (
  defaultComponentName="minBypValCon",
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
          extent={{-96,98},{-36,84}},
          lineColor={255,0,255},
          pattern=LinePattern.Dash,
          textString="uChiWatPum"),
        Text(
          extent={{-98,68},{-38,54}},
          lineColor={0,0,127},
          pattern=LinePattern.Dash,
          textString="VBypas_flow"),
        Text(
          extent={{-96,38},{-58,24}},
          lineColor={255,0,255},
          pattern=LinePattern.Dash,
          textString="uStaUp"),
        Text(
          extent={{-96,-22},{-58,-36}},
          lineColor={255,127,0},
          pattern=LinePattern.Dash,
          textString="uStaUp"),
        Text(
          extent={{-96,-52},{-58,-66}},
          lineColor={255,0,255},
          pattern=LinePattern.Dash,
          textString="uOnOff"),
        Text(
          extent={{-98,-82},{-60,-96}},
          lineColor={255,0,255},
          pattern=LinePattern.Dash,
          textString="uStaDow"),
        Text(
          extent={{56,10},{100,-4}},
          lineColor={0,0,127},
          pattern=LinePattern.Dash,
          textString="yValPos")}),
  Diagram(coordinateSystem(preserveAspectRatio=false,
          extent={{-260,-240},{260,240}})),
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
end Controller;
