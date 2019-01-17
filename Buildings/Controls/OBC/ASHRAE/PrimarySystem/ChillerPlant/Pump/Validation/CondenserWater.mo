within Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.Pump.Validation;
model CondenserWater "Validate the condenser water pump control sequence"

  Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.Pump.CondenserWater conWatPum(
      stagingRuntime=36000) "Condenser water pump controller"
    annotation (Placement(transformation(extent={{0,-10},{20,10}})));
  CDL.Integers.Sources.Constant conInt(k=1)
    annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
  CDL.Logical.Sources.Pulse wseSta1(
    width=0.2,
    period=24*3600,
    startTime=7*3600) "Water side economizer status"
    annotation (Placement(transformation(extent={{-40,-50},{-20,-30}})));
equation

  connect(conInt.y, conWatPum.uChiSta) annotation (Line(points={{-19,0},{-10,0},
          {-10,4},{-2,4}}, color={255,127,0}));
  connect(wseSta1.y, conWatPum.uWSE) annotation (Line(points={{-19,-40},{-10,-40},
          {-10,-4},{-2,-4}}, color={255,0,255}));
annotation (
  experiment(StopTime=172800.0, Tolerance=1e-06),
  __Dymola_Commands(file="modelica://Buildings/Resources/Scripts/Dymola/Controls/OBC/ASHRAE/PrimarySystem/ChillerPlant/Pump/Validation/CondenserWater.mos"
    "Simulate and plot"),
    Documentation(info="<html>
<p>
This example validates
<a href=\"modelica://Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.Pump.CondenserWater\">
Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.Pump.CondenserWater</a>.
</p>
</html>", revisions="<html>
<ul>
<li>
January 17, 2019, by Jianjun Hu:<br/>
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
