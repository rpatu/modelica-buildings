within Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.Pump.CondenserWaterP;
block Speed_noWSE
  "Sequence for operating condenser water pumps for plants without waterside economizer"

  parameter Integer num = 2
    "Total number of chiller";
  parameter Real conWatPumSpeSet[num+1] = {0, 0.5, 0.75}
    "Condenser water pump speed setpoint, according to number of operating chillers";

  Buildings.Controls.OBC.CDL.Interfaces.BooleanInput uChiOn[num]
    "Chiller operating status: true = ON, false = OFF"
    annotation (Placement(transformation(extent={{-140,-40},{-100,0}}),
      iconTransformation(extent={{-140,-20},{-100,20}})));
  Buildings.Controls.OBC.CDL.Interfaces.IntegerOutput yConWatPumNum
    "Number of operating condenser water pumps"
    annotation (Placement(transformation(extent={{100,-30},{120,-10}}),
      iconTransformation(extent={{100,-30},{120,-10}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealOutput yConWatPumSpe
    "Condenser water pump speed"
    annotation (Placement(transformation(extent={{100,60},{120,80}}),
      iconTransformation(extent={{100,50},{120,70}})));

protected
  Buildings.Controls.OBC.CDL.Continuous.Sources.Constant con2[num + 1](
    final k=conWatPumSpeSet)
    "Condenser water pump speed when different number of pumps are operating"
    annotation (Placement(transformation(extent={{0,60},{20,80}})));
  Buildings.Controls.OBC.CDL.Routing.RealExtractor conWatPumSpe(
    final nin=num + 1)
    "Condenser water pump speed"
    annotation (Placement(transformation(extent={{40,60},{60,80}})));
  Buildings.Controls.OBC.CDL.Conversions.BooleanToInteger booToInt[num]
    "Convert boolean input to integer output"
    annotation (Placement(transformation(extent={{-80,-30},{-60,-10}})));
  Buildings.Controls.OBC.CDL.Integers.MultiSum mulSumInt(final nin=num)
    "Total number of operating chiller"
    annotation (Placement(transformation(extent={{-40,-30},{-20,-10}})));
  Buildings.Controls.OBC.CDL.Integers.Add addInt
    annotation (Placement(transformation(extent={{20,-10},{40,10}})));
  Buildings.Controls.OBC.CDL.Integers.Sources.Constant conInt(final k=1) "Contant one"
    annotation (Placement(transformation(extent={{-40,10},{-20,30}})));

equation
  connect(uChiOn, booToInt.u)
    annotation (Line(points={{-120,-20},{-82,-20}}, color={255,0,255}));
  connect(con2.y, conWatPumSpe.u)
    annotation (Line(points={{21,70},{38,70}},  color={0,0,127}));
  connect(mulSumInt.y, yConWatPumNum)
    annotation (Line(points={{-18.3,-20},{110,-20}}, color={255,127,0}));
  connect(conWatPumSpe.y, yConWatPumSpe)
    annotation (Line(points={{61,70},{110,70}}, color={0,0,127}));
  connect(mulSumInt.y, addInt.u2)
    annotation (Line(points={{-18.3,-20},{0,-20},{0,-6},{18,-6}},
      color={255,127,0}));
  connect(conInt.y, addInt.u1)
    annotation (Line(points={{-19,20},{0,20},{0,6},{18,6}}, color={255,127,0}));
  connect(addInt.y, conWatPumSpe.index)
    annotation (Line(points={{41,0},{50,0},{50,58}}, color={255,127,0}));
  connect(booToInt.y, mulSumInt.u)
    annotation (Line(points={{-59,-20},{-42,-20}}, color={255,127,0}));

annotation (
  defaultComponentName="conPumSpe",
  Icon(coordinateSystem(preserveAspectRatio=false), graphics={
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
          extent={{36,-6},{96,-30}},
          lineColor={255,127,0},
          pattern=LinePattern.Dash,
          textString="yConWatPumNum")}),
  Diagram(coordinateSystem(preserveAspectRatio=false)),
  Documentation(info="<html>
<p>
Block that enable and disable leading primary chilled water pump, for plants
with headered primary chilled water pumps, 
according to ASHRAE RP-1711 Advanced Sequences of Operation for HVAC Systems Phase II –
Central Plants and Hydronic Systems (Draft 4 on January 7, 2019), 
section 5.2.9 Condenser water pumps, part 5.2.9.4.
</p>
<p>
The number of operating condenser water pumps shall match the number of 
operating chillers. Fixme: the running speed shall be defined per TAB.
</p>
</html>", revisions="<html>
<ul>
<li>
January 28, 2019, by Jianjun Hu:<br/>
First implementation.
</li>
</ul>
</html>"));
end Speed_noWSE;
