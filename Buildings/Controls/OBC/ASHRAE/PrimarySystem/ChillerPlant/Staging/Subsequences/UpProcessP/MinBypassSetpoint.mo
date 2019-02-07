within Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.Staging.Subsequences.UpProcessP;
block MinBypassSetpoint
  "Sequence for generating minimum chilled water bypass flow setpoint"

  parameter Modelica.SIunits.Time byPasSetTim = 60;
  parameter Modelica.SIunits.VolumeFlowRate minFloDif = 0.01
    "Minimum flow rate difference to check if bybass flow achieves setpoint";

  Buildings.Controls.OBC.CDL.Interfaces.RealInput VBypas_flow(
    final min=0,
    final unit="m3/s",
    quantity="VolumeFlowRate") "Measured bypass flow rate"
    annotation (Placement(transformation(extent={{-200,-40},{-160,0}}),
      iconTransformation(extent={{-140,-60},{-100,-20}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealInput VBypas_setpoint(
    final min=0,
    final unit="m3/s",
    quantity="VolumeFlowRate") "Bypass flow setpoint"
    annotation (Placement(transformation(extent={{-200,-80},{-160,-40}}),
      iconTransformation(extent={{-140,-100},{-100,-60}})));
  Buildings.Controls.OBC.CDL.Interfaces.BooleanInput uStaUp
    "Indicate if there is stage up"
    annotation (Placement(transformation(extent={{-200,0},{-160,40}}),
      iconTransformation(extent={{-140,20},{-100,60}})));
  Buildings.Controls.OBC.CDL.Interfaces.BooleanInput uChiDemRed
    "Operating chillers demand reduce status: true=finished reducing"
    annotation (Placement(transformation(extent={{-200,30},{-160,70}}),
      iconTransformation(extent={{-140,60},{-100,100}})));
  Buildings.Controls.OBC.CDL.Interfaces.BooleanOutput yMinBypRes
    "Minimum chilled water flow bypass setpoint reset status"
    annotation (Placement(transformation(extent={{160,40},{180,60}}),
      iconTransformation(extent={{100,-10},{120,10}})));

protected
  Buildings.Controls.OBC.CDL.Continuous.Feedback floDif
    "Bypass flow rate difference"
    annotation (Placement(transformation(extent={{-140,-30},{-120,-10}})));
  Buildings.Controls.OBC.CDL.Continuous.Abs abs "Absolute value of input"
    annotation (Placement(transformation(extent={{-100,-30},{-80,-10}})));
  Buildings.Controls.OBC.CDL.Continuous.Hysteresis hys(
    final uLow=minFloDif-0.005,
    final uHigh=minFloDif+0.005)
    "Check if bypass achieves setpoint"
    annotation (Placement(transformation(extent={{-60,-30},{-40,-10}})));
  Buildings.Controls.OBC.CDL.Logical.Not not2 "Logical not"
    annotation (Placement(transformation(extent={{-20,-30},{0,-10}})));
  Buildings.Controls.OBC.CDL.Logical.And and1 "Logical and"
    annotation (Placement(transformation(extent={{120,40},{140,60}})));
  Buildings.Controls.OBC.CDL.Logical.Timer tim "Time after achiving setpoint"
    annotation (Placement(transformation(extent={{20,-30},{40,-10}})));
  Buildings.Controls.OBC.CDL.Logical.And and2 "Logical and"
    annotation (Placement(transformation(extent={{-60,40},{-40,60}})));
  Buildings.Controls.OBC.CDL.Continuous.Hysteresis hys2(
    final uLow=byPasSetTim -1,
    final uHigh=byPasSetTim + 1)
    "Check if it is 1 minute after new setpoint achieved"
    annotation (Placement(transformation(extent={{60,-30},{80,-10}})));

equation
  connect(uChiDemRed, and2.u1)
    annotation (Line(points={{-180,50},{-62,50}}, color={255,0,255}));
  connect(uStaUp, and2.u2)
    annotation (Line(points={{-180,20},{-80,20},{-80,42},{-62,42}},
      color={255,0,255}));
  connect(VBypas_flow, floDif.u1)
    annotation (Line(points={{-180,-20},{-142,-20}}, color={0,0,127}));
  connect(VBypas_setpoint, floDif.u2)
    annotation (Line(points={{-180,-60},{-130,-60},{-130,-32}},
      color={0,0,127}));
  connect(floDif.y, abs.u)
    annotation (Line(points={{-119,-20},{-102,-20}}, color={0,0,127}));
  connect(abs.y, hys.u)
    annotation (Line(points={{-79,-20},{-62,-20}}, color={0,0,127}));
  connect(hys.y, not2.u)
    annotation (Line(points={{-39,-20},{-22,-20}}, color={255,0,255}));
  connect(not2.y, tim.u)
    annotation (Line(points={{1,-20},{18,-20}}, color={255,0,255}));
  connect(tim.y, hys2.u)
    annotation (Line(points={{41,-20},{58,-20}}, color={0,0,127}));
  connect(and2.y, and1.u1)
    annotation (Line(points={{-39,50},{118,50}}, color={255,0,255}));
  connect(and1.y,yMinBypRes)
    annotation (Line(points={{141,50},{170,50}}, color={255,0,255}));
  connect(hys2.y, and1.u2)
    annotation (Line(points={{81,-20},{92,-20},{92,42},{118,42}},
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
          extent={{-96,88},{-36,74}},
          lineColor={255,0,255},
          pattern=LinePattern.Dash,
          textString="uChiDemRed"),
        Text(
          extent={{-96,48},{-58,34}},
          lineColor={255,0,255},
          pattern=LinePattern.Dash,
          textString="uStaUp"),
        Text(
          extent={{32,8},{98,-8}},
          lineColor={255,0,255},
          pattern=LinePattern.Dash,
          textString="yMinBypRes"),
        Text(
          extent={{-98,-34},{-38,-48}},
          lineColor={0,0,127},
          pattern=LinePattern.Dash,
          textString="VBypas_flow"),
        Text(
          extent={{-98,-72},{-16,-86}},
          lineColor={0,0,127},
          pattern=LinePattern.Dash,
          textString="VBypas_setpoint")}),
  Diagram(coordinateSystem(preserveAspectRatio=false,
          extent={{-160,-80},{160,80}})),
  Documentation(info="<html>
<p>
Block that generates minimum bypass flow reset status when there is 
stage-up command.
</p>
<p>
When there is stage-up command (<code>uStaUp</code> = true) and the operating chillers 
have reduced the demand (<code>uChiDemRed</code> = true), 
check if the minimum bypass flow rate <code>VBypas_flow</code> has achieved 
its new set point <code>VBypas_setpoint</code>. 
After new setpoint is achieved, wait for 1 minute (<code>byPasSetTim</code>) to 
allow loop to stabilize. It will then set <code>yMinBypRes</code> to true.
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
end MinBypassSetpoint;
