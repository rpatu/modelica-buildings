within Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.Pump;
block CondenserWater "Condenser water pump control"

  parameter Integer staNum = 3 "Total number of chiller stages";
  parameter Integer pumNum = 2 "Total number of pumps";
  parameter Real conWatPumSpeSet[2*staNum] = {0, 0.5, 0.75, 0.6, 0.75, 0.9}
    "Condenser water pump speed setpoint, according to current chiller stage and WSE status"
    annotation (Dialog(group="Setpoint according to stage"));
  parameter Real conWatPumOnSet[2*staNum] = {0,1,1,2,2,2}
    "Number of condenser water pumps that should be ON, according to current chiller stage and WSE status"
    annotation (Dialog(group="Setpoint according to stage"));
  parameter Real stagingRuntime=240*60*60 "Staging runtime"
    annotation (Dialog(group="Equipment roration"));
  parameter Boolean initRoles[pumNum]={true,false}
    "Initial roles: true = lead, false = lag/standby"
    annotation (Dialog(group="Equipment roration"));

  Buildings.Controls.OBC.CDL.Interfaces.IntegerInput uChiSta "Current chiller stage"
    annotation (Placement(transformation(extent={{-260,50},{-220,90}}),
      iconTransformation(extent={{-140,20},{-100,60}})));
  Buildings.Controls.OBC.CDL.Interfaces.BooleanInput uWSE
    "Water side economizer status: true = ON, false = OFF"
    annotation (Placement(transformation(extent={{-262,-50},{-222,-10}}),
      iconTransformation(extent={{-140,-60},{-100,-20}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealOutput yConWatPum[pumNum](
    each final min=0,
    each final max=1,
    each final unit="1") "Condenser water pump speed"
    annotation (Placement(transformation(extent={{220,-10},{240,10}}),
      iconTransformation(extent={{100,-10},{120,10}})));

  Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.Generic.EquipmentRotationMult equRot(
    final num=pumNum,
    final stagingRuntime=stagingRuntime,
    final initRoles=initRoles) "Rotate lead and lag pump assignment"
    annotation (Placement(transformation(extent={{140,50},{160,70}})));
  Buildings.Controls.OBC.CDL.Routing.RealExtractor conWatPumOn(
    final nin=2*staNum) "Number of condenser water pump should be on"
    annotation (Placement(transformation(extent={{-80,60},{-60,80}})));
 Buildings.Controls.OBC.CDL.Routing.RealExtractor conWatPumSpe(
    final nin=2*staNum)
    "Condenser water pump speed"
    annotation (Placement(transformation(extent={{-80,-70},{-60,-50}})));
  Buildings.Controls.OBC.CDL.Continuous.GreaterEqualThreshold mulPum(
    final threshold=1.5) "Check if more than one pump should turn on"
    annotation (Placement(transformation(extent={{-20,30},{0,50}})));
  Buildings.Controls.OBC.CDL.Continuous.GreaterEqualThreshold zerPum(
    final threshold=0.5) "Check if any pump should turn on"
    annotation (Placement(transformation(extent={{-20,60},{0,80}})));
  Buildings.Controls.OBC.CDL.Logical.LogicalSwitch leaPumSta "Lead pump status"
    annotation (Placement(transformation(extent={{60,60},{80,80}})));
  Buildings.Controls.OBC.CDL.Logical.LogicalSwitch lagPumSta "Lag pump status"
    annotation (Placement(transformation(extent={{60,30},{80,50}})));
  Buildings.Controls.OBC.CDL.Routing.RealReplicator reaRep(
    final nout=pumNum)
    "Replicate pump speed setpoint"
    annotation (Placement(transformation(extent={{120,-70},{140,-50}})));
  Buildings.Controls.OBC.CDL.Continuous.Product pro[pumNum] "Calculate pump speed"
    annotation (Placement(transformation(extent={{180,-20},{200,0}})));
  Buildings.Controls.OBC.CDL.Continuous.AddParameter addPar1(
    final p=1, final k=2)
    "Double current stage number"
    annotation (Placement(transformation(extent={{-200,20},{-180,40}})));

protected
  Buildings.Controls.OBC.CDL.Continuous.Sources.Constant con1[2*staNum](
    final k=conWatPumSpeSet) "Condenser water pump speed setpoint"
    annotation (Placement(transformation(extent={{-120,-70},{-100,-50}})));
  Buildings.Controls.OBC.CDL.Continuous.Sources.Constant con2[2*staNum](
    final k=conWatPumOnSet) "Number of condenser water pump should be on"
    annotation (Placement(transformation(extent={{-120,60},{-100,80}})));
  Buildings.Controls.OBC.CDL.Logical.Sources.Constant onSta(
    final k=true) "Pump in ON status"
    annotation (Placement(transformation(extent={{-20,0},{0,20}})));
  Buildings.Controls.OBC.CDL.Logical.Sources.Constant offSta(
    final k=false) "Pump in OFF status"
    annotation (Placement(transformation(extent={{-20,-30},{0,-10}})));
  Buildings.Controls.OBC.CDL.Conversions.RealToInteger pumSpeSta
    "Convert real number to integer"
    annotation (Placement(transformation(extent={{-120,-40},{-100,-20}})));
  Buildings.Controls.OBC.CDL.Conversions.IntegerToReal intToRea
    "Convert integer to real number"
    annotation (Placement(transformation(extent={{-200,60},{-180,80}})));
  Buildings.Controls.OBC.CDL.Continuous.AddParameter addPar(final p=1, final k=1)
    "Current stage plus WSE on status"
    annotation (Placement(transformation(extent={{-160,20},{-140,40}})));
  Buildings.Controls.OBC.CDL.Conversions.BooleanToReal booToRea[pumNum]
    "Convert device status to real number"
    annotation (Placement(transformation(extent={{120,-10},{140,10}})));
  Buildings.Controls.OBC.CDL.Logical.Switch swi "Check if it should consider WSE"
    annotation (Placement(transformation(extent={{-160,-40},{-140,-20}})));

equation
  connect(con1.y, conWatPumSpe.u)
    annotation (Line(points={{-99,-60},{-82,-60}}, color={0,0,127}));
  connect(con2.y, conWatPumOn.u)
    annotation (Line(points={{-99,70},{-82,70}},  color={0,0,127}));
  connect(leaPumSta.y, equRot.uLeaSta)
    annotation (Line(points={{81,70},{120,70},{120,66},{138,66}}, color={255,0,255}));
  connect(lagPumSta.y, equRot.uLagSta)
    annotation (Line(points={{81,40},{120,40},{120,54},{138,54}}, color={255,0,255}));
  connect(conWatPumSpe.y, reaRep.u)
    annotation (Line(points={{-59,-60},{118,-60}},color={0,0,127}));
  connect(reaRep.y, pro.u2)
    annotation (Line(points={{141,-60},{160,-60},{160,-16},{178,-16}}, color={0,0,127}));
  connect(equRot.yDevSta, booToRea.u)
    annotation (Line(points={{161,66},{180,66},{180,20},{100,20},{100,0},{118,0}},
      color={255,0,255}));
  connect(booToRea.y, pro.u1)
    annotation (Line(points={{141,0},{160,0},{160,-4},{178,-4}}, color={0,0,127}));
  connect(pro.y, yConWatPum)
    annotation (Line(points={{201,-10},{212,-10},{212,0},{230,0}}, color={0,0,127}));
  connect(uWSE, swi.u2)
    annotation (Line(points={{-242,-30},{-162,-30}}, color={255,0,255}));
  connect(addPar.y, swi.u1)
    annotation (Line(points={{-139,30},{-120,30},{-120,0},{-180,0},{-180,-22},
      {-162,-22}}, color={0,0,127}));
  connect(swi.y, pumSpeSta.u)
    annotation (Line(points={{-139,-30},{-122,-30}}, color={0,0,127}));
  connect(pumSpeSta.y, conWatPumOn.index)
    annotation (Line(points={{-99,-30},{-90,-30},{-90,40},{-70,40},{-70,58}},
      color={255,127,0}));
  connect(pumSpeSta.y, conWatPumSpe.index)
    annotation (Line(points={{-99,-30},{-90,-30},{-90,-80},{-70,-80},{-70,-72}},
      color={255,127,0}));
  connect(uChiSta, intToRea.u)
    annotation (Line(points={{-240,70},{-202,70}}, color={255,127,0}));
  connect(intToRea.y, addPar1.u)
    annotation (Line(points={{-179,70},{-160,70},{-160,50},{-210,50},{-210,30},
      {-202,30}}, color={0,0,127}));
  connect(addPar1.y, addPar.u)
    annotation (Line(points={{-179,30},{-162,30}}, color={0,0,127}));
  connect(addPar1.y, swi.u3)
    annotation (Line(points={{-179,30},{-170,30},{-170,-38},{-162,-38}}, color={0,0,127}));
  connect(conWatPumOn.y, zerPum.u)
    annotation (Line(points={{-59,70},{-22,70}}, color={0,0,127}));
  connect(zerPum.y, leaPumSta.u2)
    annotation (Line(points={{1,70},{58,70}}, color={255,0,255}));
  connect(conWatPumOn.y, mulPum.u)
    annotation (Line(points={{-59,70},{-40,70},{-40,40},{-22,40}}, color={0,0,127}));
  connect(onSta.y, leaPumSta.u1)
    annotation (Line(points={{1,10},{20,10},{20,78},{58,78}}, color={255,0,255}));
  connect(offSta.y, leaPumSta.u3)
    annotation (Line(points={{1,-20},{40,-20},{40,62},{58,62}}, color={255,0,255}));
  connect(mulPum.y, lagPumSta.u2)
    annotation (Line(points={{1,40},{58,40}}, color={255,0,255}));
  connect(onSta.y, lagPumSta.u1)
    annotation (Line(points={{1,10},{20,10},{20,48},{58,48}}, color={255,0,255}));
  connect(offSta.y, lagPumSta.u3)
    annotation (Line(points={{1,-20},{40,-20},{40,32},{58,32}}, color={255,0,255}));

annotation (
  defaultComponentName="conWatPum",
  Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-220,-100},{220,100}})),
  Icon(graphics={
        Rectangle(
        extent={{-100,-100},{100,100}},
        lineColor={0,0,127},
        fillColor={255,255,255},
        fillPattern=FillPattern.Solid),
        Text(
          extent={{-96,52},{-50,32}},
          lineColor={0,0,127},
          pattern=LinePattern.Dash,
          textString="uChiSta"),
        Text(
          extent={{-100,-32},{-60,-44}},
          lineColor={0,0,127},
          pattern=LinePattern.Dash,
          textString="uWSE"),
        Text(
          extent={{28,18},{96,-18}},
          lineColor={0,0,127},
          textString="yConWatPum"),
        Text(
          extent={{-100,150},{100,110}},
          lineColor={0,0,255},
          textString="%name")}),
  Documentation(info="<html>
<p>
Block that output condenser water pumps speed <code>yConWatPumSpe</code>, 
according to ASHRAE RP-1711 Advanced Sequences of Operation for HVAC Systems Phase II –
Central Plants and Hydronic Systems (Draft 4 on August 15, 2018), section 3.2.8
Condenser water pumps.
</p>
<p>
a. Condenser water pumps shall be lead-lag alternated.
</p>
<p>
b. The number of operating condenser water pumps and condenser water pump speed
shall be set by chiller stage per the table below.
</p>

<table summary=\"summary\" border=\"1\">
<tr>
<th>Chiller stage </th> 
<th>Number of pump ON</th>  
<th>Pump speed setpoint</th>
</tr>
<tr>
<td align=\"center\">0</td>
<td align=\"center\">0</td>
<td align=\"left\">N/A, Off</td>
</tr>
<tr>
<td align=\"center\">0+WSE</td>
<td align=\"center\">1</td>
<td align=\"left\">Per TAB to provide design flow through HX</td>
</tr>
<tr>
<td align=\"center\">1</td>
<td align=\"center\">1</td>
<td align=\"left\">Per TAB to provide design flow through chiller</td>
</tr>
<tr>
<td align=\"center\">1+WSE</td>
<td align=\"center\">2</td>
<td align=\"left\">Per TAB to provide at least design flow through both chiller and WSE</td>
</tr>
<tr>
<td align=\"center\">2</td>
<td align=\"center\">2</td>
<td align=\"left\">Per TAB to provide at least design flow through both chillers</td>
</tr>
<tr>
<td align=\"center\">2+WSE</td>
<td align=\"center\">2</td>
<td align=\"left\">Per TAB to provide at least design flow through both chillers and WSE, 
or 100% speed if design flow cannot be achieved.</td>
</tr>
</table>
<br/>
<p>
b. Control pump ON/OFF staging according to 
<a href=\"modelica://Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.Staging.Generic.UpProcess\">
Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.Staging.Generic.UpProcess</a>.
and
<a href=\"modelica://Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.Staging.Generic.DownProcess\">
Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.Staging.Generic.DownProcess</a>.
</p>
</html>", revisions="<html>
<ul>
<li>
January 17, 2019, by Jianjun Hu:<br/>
First implementation.
</li>
</ul>
</html>"));
end CondenserWater;
