within Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.Tower.Staging;
block cellNumber "Sequence for identifying number of enabling cells"

  parameter Integer staNum = 3
    "Total number of stages, stage zero should be counted as one stage";
  parameter Real towCelOnSet[2*staNum] = {0,2,2,4,4,4}
    "Number of condenser water pumps that should be ON, according to current chiller stage and WSE status"
    annotation (Dialog(group="Setpoint according to stage"));
  final parameter Integer twoCelInd[nTowCel]={i for i in 1:nTowCel}
    "Tower cell index, {1,2,...,n}";

  Buildings.Controls.OBC.CDL.Interfaces.IntegerInput uChiSta
    "Current chiller stage"
    annotation (Placement(transformation(extent={{-340,300},{-300,340}}),
      iconTransformation(extent={{-140,20},{-100,60}})));
  Buildings.Controls.OBC.CDL.Interfaces.BooleanInput uWSE
    "Water side economizer status: true = ON, false = OFF"
    annotation (Placement(transformation(extent={{-340,200},{-300,240}}),
      iconTransformation(extent={{-140,-60},{-100,-20}})));

  CDL.Interfaces.BooleanInput uTowStaUp "Cooling tower stage-up command"
    annotation (Placement(transformation(extent={{-340,-130},{-300,-90}}),
        iconTransformation(extent={{-140,-60},{-100,-20}})));
  CDL.Interfaces.BooleanInput uStaUp "Plant stage up status: true=stage-up"
    annotation (Placement(transformation(extent={{-340,-90},{-300,-50}}),
        iconTransformation(extent={{-240,160},{-200,200}})));
  CDL.Interfaces.BooleanInput uTowSta[nTowCel]
    "Cooling tower operating status: true=running tower cell" annotation (
      Placement(transformation(extent={{-340,140},{-300,180}}),
        iconTransformation(extent={{-240,160},{-200,200}})));
  CDL.Conversions.BooleanToReal booToRea[nTowCel]
    "Convert boolean input to real output"
    annotation (Placement(transformation(extent={{-240,150},{-220,170}})));
  CDL.Continuous.MultiSum mulSum "Total number of running tower cells"
    annotation (Placement(transformation(extent={{-200,150},{-180,170}})));
  CDL.Logical.And and2 "Logical and"
    annotation (Placement(transformation(extent={{-240,-80},{-220,-60}})));
  CDL.Logical.And and1 "Logical and"
    annotation (Placement(transformation(extent={{-240,-180},{-220,-160}})));
  CDL.Interfaces.BooleanInput uTowStaDow "Cooling tower stage-down command"
    annotation (Placement(transformation(extent={{-340,-230},{-300,-190}}),
        iconTransformation(extent={{-140,-60},{-100,-20}})));
  CDL.Interfaces.BooleanInput uStaDow
    "Plant stage down status: true=stage-down" annotation (Placement(
        transformation(extent={{-340,-190},{-300,-150}}),iconTransformation(
          extent={{-240,160},{-200,200}})));
  CDL.Integers.GreaterThreshold intGreThr(threshold=1)
    "More than one additional cell need to be enabled"
    annotation (Placement(transformation(extent={{0,160},{20,180}})));
  CDL.Interfaces.IntegerInput uTowCelPri[nTowCel]
    "Cooling tower cell enabling priority" annotation (Placement(transformation(
          extent={{-340,50},{-300,90}}),  iconTransformation(extent={{-120,80},{
            -100,100}})));
  CDL.Integers.Add addInt(k2=-1)
    annotation (Placement(transformation(extent={{-60,160},{-40,180}})));


  CDL.Conversions.IntegerToReal intToRea1[nTowCel]
    "Convert integer input to real output"
    annotation (Placement(transformation(extent={{-160,10},{-140,30}})));
  CDL.Conversions.IntegerToReal intToRea2[nTowCel]
    "Convert integer input to real output"
    annotation (Placement(transformation(extent={{-240,60},{-220,80}})));
  CDL.Routing.RealReplicator reaRep1(nout=nTowCel)
    annotation (Placement(transformation(extent={{-200,60},{-180,80}})));
protected
  Buildings.Controls.OBC.CDL.Routing.RealExtractor towCelOn(final nin=2*staNum)
    "Number of tower cells shoud be on in current stage"
    annotation (Placement(transformation(extent={{-140,310},{-120,330}})));
  Buildings.Controls.OBC.CDL.Continuous.AddParameter addPar1(
    final p=1,
    final k=2)
    "Double current stage number"
    annotation (Placement(transformation(extent={{-240,270},{-220,290}})));
  Buildings.Controls.OBC.CDL.Conversions.RealToInteger reaToInt
    "Convert real input to integer output"
    annotation (Placement(transformation(extent={{-100,310},{-80,330}})));
  Buildings.Controls.OBC.CDL.Continuous.Sources.Constant con2[2*staNum](final k=
        towCelOnSet) "Number of tower cells shoud be on"
    annotation (Placement(transformation(extent={{-180,310},{-160,330}})));
  Buildings.Controls.OBC.CDL.Conversions.RealToInteger pumSpeSta
    "Convert real number to integer"
    annotation (Placement(transformation(extent={{-160,210},{-140,230}})));
  Buildings.Controls.OBC.CDL.Conversions.IntegerToReal intToRea
    "Convert integer to real number"
    annotation (Placement(transformation(extent={{-240,310},{-220,330}})));
  Buildings.Controls.OBC.CDL.Continuous.AddParameter addPar(
    final p=1,
    final k=1)
    "Current stage plus WSE on status"
    annotation (Placement(transformation(extent={{-200,270},{-180,290}})));
  Buildings.Controls.OBC.CDL.Logical.Switch swi
    "Check if it should consider WSE"
    annotation (Placement(transformation(extent={{-200,210},{-180,230}})));

  CDL.Conversions.RealToInteger                        reaToInt1
    "Convert real input to integer output"
    annotation (Placement(transformation(extent={{-160,150},{-140,170}})));
  CDL.Integers.Sources.Constant conInt[nTowCel](final k=twoCelInd)
    "Tower cell array index"
    annotation (Placement(transformation(extent={{-240,10},{-220,30}})));
equation
  connect(con2.y, towCelOn.u)
    annotation (Line(points={{-159,320},{-142,320}},
                                              color={0,0,127}));
  connect(uWSE,swi. u2)
    annotation (Line(points={{-320,220},{-202,220}},color={255,0,255}));
  connect(addPar.y,swi. u1)
    annotation (Line(points={{-179,280},{-160,280},{-160,250},{-220,250},{-220,228},
          {-202,228}},
                  color={0,0,127}));
  connect(swi.y,pumSpeSta. u)
    annotation (Line(points={{-179,220},{-162,220}},
                                                  color={0,0,127}));
  connect(uChiSta,intToRea. u)
    annotation (Line(points={{-320,320},{-242,320}},
                                                  color={255,127,0}));
  connect(intToRea.y,addPar1. u)
    annotation (Line(points={{-219,320},{-200,320},{-200,300},{-250,300},{-250,280},
          {-242,280}},
                 color={0,0,127}));
  connect(addPar1.y,addPar. u)
    annotation (Line(points={{-219,280},{-202,280}},
                                                 color={0,0,127}));
  connect(addPar1.y,swi. u3)
    annotation (Line(points={{-219,280},{-210,280},{-210,212},{-202,212}},
      color={0,0,127}));
  connect(towCelOn.y, reaToInt.u)
    annotation (Line(points={{-119,320},{-102,320}},
                                               color={0,0,127}));

  connect(pumSpeSta.y, towCelOn.index)
    annotation (Line(points={{-139,220},{-130,220},{-130,308}},
                                                         color={255,127,0}));
  connect(uTowSta, booToRea.u)
    annotation (Line(points={{-320,160},{-242,160}}, color={255,0,255}));
  connect(uStaUp, and2.u1)
    annotation (Line(points={{-320,-70},{-242,-70}},
                                                   color={255,0,255}));
  connect(uTowStaUp, and2.u2) annotation (Line(points={{-320,-110},{-260,-110},
          {-260,-78},{-242,-78}},
                          color={255,0,255}));
  connect(uStaDow, and1.u1)
    annotation (Line(points={{-320,-170},{-242,-170}},
                                                     color={255,0,255}));
  connect(uTowStaDow, and1.u2) annotation (Line(points={{-320,-210},{-260,-210},
          {-260,-178},{-242,-178}},
                                  color={255,0,255}));
  connect(mulSum.y, reaToInt1.u)
    annotation (Line(points={{-179,160},{-162,160}}, color={0,0,127}));
  connect(reaToInt.y, addInt.u1) annotation (Line(points={{-79,320},{-70,320},{-70,
          176},{-62,176}}, color={255,127,0}));
  connect(reaToInt1.y, addInt.u2) annotation (Line(points={{-139,160},{-80,160},
          {-80,164},{-62,164}}, color={255,127,0}));
  connect(addInt.y, intGreThr.u)
    annotation (Line(points={{-39,170},{-2,170}}, color={255,127,0}));
  connect(conInt.y, intToRea1.u)
    annotation (Line(points={{-219,20},{-162,20}}, color={255,127,0}));
  connect(uTowCelPri, intToRea2.u)
    annotation (Line(points={{-320,70},{-242,70}}, color={255,127,0}));
annotation (
  defaultComponentName="conPumSpe",
  Icon(coordinateSystem(preserveAspectRatio=false, extent={{-300,-360},{300,360}}),
                                                    graphics={
        Text(
          extent={{-100,150},{100,110}},
          lineColor={0,0,255},
          textString="%name"),
        Rectangle(
          extent={{-100,-100},{100,100}},
          lineColor={0,0,127},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{36,74},{96,50}},
          lineColor={0,0,127},
          pattern=LinePattern.Dash,
          textString="yConWatPumSpe"),
        Text(
          extent={{-98,8},{-54,-8}},
          lineColor={255,0,255},
          pattern=LinePattern.Dash,
          textString="uChiOn"),
        Text(
          extent={{36,14},{96,-10}},
          lineColor={255,127,0},
          pattern=LinePattern.Dash,
          textString="yConWatPumNum")}),
  Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-300,-360},{300,360}})),
  Documentation(info="<html>
<p>
Block that enable and disable leading primary chilled water pump, for plants
with headered primary chilled water pumps, 
according to ASHRAE RP-1711 Advanced Sequences of Operation for HVAC Systems Phase II –
Central Plants and Hydronic Systems (Draft 4 on January 7, 2019), 
section 5.2.9 Condenser water pumps, part 5.2.9.5.
</p>

<p>
The number of operating condenser water pumps <code>yConWatPumNum</code> and 
condenser water pump speed <code>yConWatPumSpeSet</code> shall be set by chiller 
stage per the table below.
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
</html>", revisions="<html>
<ul>
<li>
January 28, 2019, by Jianjun Hu:<br/>
First implementation.
</li>
</ul>
</html>"));
end cellNumber;
