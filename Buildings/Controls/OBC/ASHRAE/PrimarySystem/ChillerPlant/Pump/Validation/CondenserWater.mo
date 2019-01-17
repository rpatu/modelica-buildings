within Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.Pump.Validation;
model CondenserWater "Validate the condenser water pump control sequence"
  Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.Pump.CondenserWater
                                                                             conWatPum(
      stagingRuntime=20*60*60)
                        "Chilled water pump controller"
    annotation (Placement(transformation(extent={{60,20},{80,40}})));

  CDL.Continuous.Sources.Ramp                        ramp1(
    duration=24*3600,
    offset=0,
    height=2)   "Block that generates ramp signal"
    annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
  CDL.Continuous.Round                        round1(n=0)
    "Round real number to given digits"
    annotation (Placement(transformation(extent={{-40,20},{-20,40}})));
  CDL.Conversions.RealToInteger                        reaToInt
    "Convert real to integer"
    annotation (Placement(transformation(extent={{0,20},{20,40}})));
  CDL.Logical.Sources.Pulse wseSta(
    width=0.2,
    period=24*3600,
    startTime=7*3600) "Water side economizer status"
    annotation (Placement(transformation(extent={{0,-40},{20,-20}})));
equation

  connect(ramp1.y,round1. u)
    annotation (Line(points={{-59,30},{-42,30}},
                                               color={0,0,127}));
  connect(round1.y,reaToInt. u)
    annotation (Line(points={{-19,30},{-2,30}},
                                              color={0,0,127}));
  connect(reaToInt.y, conWatPum.uChiSta) annotation (Line(points={{21,30},{40,
          30},{40,34},{58,34}}, color={255,127,0}));
  connect(wseSta.y, conWatPum.uWSE) annotation (Line(points={{21,-30},{40,-30},
          {40,26},{58,26}}, color={255,0,255}));
annotation (
  experiment(StopTime=3600.0, Tolerance=1e-06),
  __Dymola_Commands(file="modelica://Buildings/Resources/Scripts/Dymola/Controls/OBC/ASHRAE/PrimarySystem/ChillerPlant/Pump/Validation/ChilledWater.mos"
    "Simulate and plot"),
    Documentation(info="<html>
<p>
This example validates
<a href=\"modelica://Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.Pump.ChilledWater\">
Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.Pump.ChilledWater</a>.
</p>
</html>", revisions="<html>
<ul>
<li>
March 12, 2018, by Jianjun Hu:<br/>
First implementation.
</li>
</ul>
</html>"),
Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Ellipse(lineColor = {75,138,73},
                fillColor={255,255,255},
                fillPattern = FillPattern.Solid,
                extent = {{-100,-100},{100,100}}),
        Polygon(lineColor = {0,0,255},
                fillColor = {75,138,73},
                pattern = LinePattern.None,
                fillPattern = FillPattern.Solid,
                points = {{-36,60},{64,0},{-36,-60},{-36,60}})}),Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end CondenserWater;
