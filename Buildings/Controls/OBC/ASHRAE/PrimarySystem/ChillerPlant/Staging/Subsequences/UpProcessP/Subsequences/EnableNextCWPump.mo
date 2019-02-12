within Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.Staging.Subsequences.UpProcessP.Subsequences;
block EnableNextCWPump
  "Start the next condenser water pump and/or change condenser water pump speed"

  Buildings.Controls.OBC.CDL.Interfaces.BooleanInput uMinBypRes
    "Status of minimum flow bypass reset: true=reset is finished"
    annotation (Placement(transformation(extent={{-160,30},{-120,70}}),
      iconTransformation(extent={{-140,60},{-100,100}})));
  Buildings.Controls.OBC.CDL.Interfaces.BooleanInput uStaUp
    "Indicate if there is stage up"
    annotation (Placement(transformation(extent={{-160,-30},{-120,10}}),
      iconTransformation(extent={{-140,-22},{-100,18}})));
  Buildings.Controls.OBC.CDL.Interfaces.IntegerInput uSta
    "Current stage index"
    annotation (Placement(transformation(extent={{-160,-70},{-120,-30}}),
      iconTransformation(extent={{-140,-100},{-100,-60}})));
  Buildings.Controls.OBC.CDL.Interfaces.IntegerOutput ySta
    "Stage for enabling condenser water pumps"
    annotation (Placement(transformation(extent={{120,-20},{140,0}}),
      iconTransformation(extent={{100,-10},{120,10}})));

protected
  Buildings.Controls.OBC.CDL.Conversions.IntegerToReal intToRea
    "Convert integer input to real output"
    annotation (Placement(transformation(extent={{-100,-60},{-80,-40}})));
  Buildings.Controls.OBC.CDL.Logical.Switch swi "Logical switch"
    annotation (Placement(transformation(extent={{40,-20},{60,0}})));
  Buildings.Controls.OBC.CDL.Logical.And and2 "Logicla and"
    annotation (Placement(transformation(extent={{-40,40},{-20,60}})));
  Buildings.Controls.OBC.CDL.Logical.Switch swi1 "Logical switch"
    annotation (Placement(transformation(extent={{0,40},{20,60}})));
  Buildings.Controls.OBC.CDL.Continuous.AddParameter addPar(
    final p=-1, final k=1)
    "One stage lower than current stage"
    annotation (Placement(transformation(extent={{-40,0},{-20,20}})));
  Buildings.Controls.OBC.CDL.Conversions.RealToInteger reaToInt
    "Convert real input to integer output"
    annotation (Placement(transformation(extent={{80,-20},{100,0}})));

equation
  connect(uSta, intToRea.u)
    annotation (Line(points={{-140,-50},{-102,-50}}, color={255,127,0}));
  connect(uStaUp, swi.u2)
    annotation (Line(points={{-140,-10},{38,-10}}, color={255,0,255}));
  connect(intToRea.y, swi.u3)
    annotation (Line(points={{-79,-50},{-60,-50},{-60,-18},{38,-18}},
      color={0,0,127}));
  connect(uMinBypRes, and2.u1)
    annotation (Line(points={{-140,50},{-42,50}}, color={255,0,255}));
  connect(uStaUp, and2.u2)
    annotation (Line(points={{-140,-10},{-100,-10},{-100,42},{-42,42}},
      color={255,0,255}));
  connect(and2.y, swi1.u2)
    annotation (Line(points={{-19,50},{-2,50}}, color={255,0,255}));
  connect(addPar.y, swi1.u3)
    annotation (Line(points={{-19,10},{-10,10},{-10,42},{-2,42}},
      color={0,0,127}));
  connect(intToRea.y, swi1.u1)
    annotation (Line(points={{-79,-50},{-60,-50},{-60,70},{-10,70},{-10,58},
      {-2,58}}, color={0,0,127}));
  connect(swi1.y, swi.u1)
    annotation (Line(points={{21,50},{30,50},{30,-2},{38,-2}},
      color={0,0,127}));
  connect(swi.y, reaToInt.u)
    annotation (Line(points={{61,-10},{78,-10}}, color={0,0,127}));
  connect(reaToInt.y, ySta)
    annotation (Line(points={{101,-10},{130,-10}}, color={255,127,0}));
  connect(intToRea.y, addPar.u)
    annotation (Line(points={{-79,-50},{-60,-50},{-60,10},{-42,10}},
      color={0,0,127}));

annotation (
  defaultComponentName="enaNexCWP",
  Diagram(coordinateSystem(preserveAspectRatio=false,
          extent={{-120,-100},{120,100}})),
    Icon(graphics={
        Rectangle(
        extent={{-100,-100},{100,100}},
        lineColor={0,0,127},
        fillColor={255,255,255},
        fillPattern=FillPattern.Solid),
        Text(extent={{-120,146},{100,108}},
          lineColor={0,0,255},
          textString="%name"),
        Text(
          extent={{-98,-74},{-76,-86}},
          lineColor={255,127,0},
          pattern=LinePattern.Dash,
          textString="uSta"),
        Text(
          extent={{-98,88},{-50,72}},
          lineColor={255,0,255},
          pattern=LinePattern.Dash,
          textString="uMinBypRes"),
        Text(
          extent={{-98,6},{-64,-6}},
          lineColor={255,0,255},
          pattern=LinePattern.Dash,
          textString="uStaUp"),
        Text(
          extent={{76,8},{98,-4}},
          lineColor={255,127,0},
          pattern=LinePattern.Dash,
          textString="ySta")}),
  Documentation(info="<html>
<p>
This block generates stage signal as input to condenser water pump block. 
</p>
<ul>
<li>
When there is no stage up command (<code>uStaUp</code> = false), it outputs 
current stage.
</li>
<li>
When there is stage up command (<code>uStaUp</code> = true) which means current 
stage has changed up to new stage,  and the minimum bypass flow has not been 
reset (<code>uMinBypSet</code> = false), it outputs previous stage 
(<code>ySta</code> = <code>uSta</code> - 1).
</li>
<li>
When there is stage up command (<code>uStaUp</code> = true)  and the minimum 
bypass flow has been reset (<code>uMinBypSet</code> = true), it outputs 
current stage so to enable new condenser water pump for current stage.
</li>
</ul>
</html>",
revisions="<html>
<ul>
<li>
Febuary 4, 2019, by Jianjun Hu:<br/>
First implementation.
</li>
</ul>
</html>"));
end EnableNextCWPump;
