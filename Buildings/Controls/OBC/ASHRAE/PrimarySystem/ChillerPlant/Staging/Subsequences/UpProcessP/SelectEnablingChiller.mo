within Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.Staging.Subsequences.UpProcessP;
block SelectEnablingChiller
  "Sequence for selecting chiller to be enabled"
  parameter Integer num = 2 "Total number of chillers";

  Buildings.Controls.OBC.CDL.Interfaces.IntegerInput uChiPri[num]
    "Chiller enabling priority"
    annotation (Placement(transformation(extent={{-200,40},{-160,80}}),
      iconTransformation(extent={{-140,60},{-100,100}})));
  Buildings.Controls.OBC.CDL.Interfaces.BooleanInput uChiEna[num]
    "Chiller enabling status: true=ON"
    annotation (Placement(transformation(extent={{-200,-50},{-160,-10}}),
      iconTransformation(extent={{-140,-20},{-100,20}})));
  Buildings.Controls.OBC.CDL.Interfaces.BooleanInput uStaUp
    "Stage up status: true=stage-up"
    annotation (Placement(transformation(extent={{-200,-80},{-160,-40}}),
      iconTransformation(extent={{-140,-100},{-100,-60}})));
  Buildings.Controls.OBC.CDL.Interfaces.IntegerOutput yNexEnaChi
    "Next enabling chiller index"
    annotation (Placement(transformation(extent={{120,10},{140,30}}),
      iconTransformation(extent={{100,-10},{120,10}})));

protected
  Buildings.Controls.OBC.CDL.Conversions.IntegerToReal intToRea[num]
    "Convert integer to real number"
    annotation (Placement(transformation(extent={{0,50},{20,70}})));
  Buildings.Controls.OBC.CDL.Conversions.BooleanToReal booToRea[num]
    "Convert boolean input to real output"
    annotation (Placement(transformation(extent={{-140,-40},{-120,-20}})));
  Buildings.Controls.OBC.CDL.Continuous.MultiSum mulSum(final nin=num)
    annotation (Placement(transformation(extent={{-100,-40},{-80,-20}})));
  Buildings.Controls.OBC.CDL.Continuous.AddParameter addPar(
    final p=1, final k=1)
    "Enabling one more chiller"
    annotation (Placement(transformation(extent={{-60,-40},{-40,-20}})));
  Buildings.Controls.OBC.CDL.Conversions.RealToInteger reaToInt
    "Convert real input to integer output"
    annotation (Placement(transformation(extent={{20,-70},{40,-50}})));
  Buildings.Controls.OBC.CDL.Routing.RealExtractor extIndSig(
    final nin=num)
    "Select index of next enabling chiller"
    annotation (Placement(transformation(extent={{-100,10},{-80,30}})));
  Buildings.Controls.OBC.CDL.Conversions.RealToInteger reaToInt1
    "Convert real input to integer output"
    annotation (Placement(transformation(extent={{80,50},{100,70}})));
  Buildings.Controls.OBC.CDL.Logical.Switch swi
    annotation (Placement(transformation(extent={{-20,-70},{0,-50}})));
  Buildings.Controls.OBC.CDL.Conversions.RealToInteger reaToInt2
    "Convert real input to integer output"
    annotation (Placement(transformation(extent={{0,10},{20,30}})));
  Buildings.Controls.OBC.CDL.Routing.RealExtractor curOpeChi(
    final nin=num)
    "New operating chiller at current stage"
    annotation (Placement(transformation(extent={{40,50},{60,70}})));

equation
  connect(uChiPri,intToRea. u)
    annotation (Line(points={{-180,60},{-2,60}},  color={255,127,0}));
  connect(intToRea.y,curOpeChi. u)
    annotation (Line(points={{21,60},{38,60}}, color={0,0,127}));
  connect(uChiEna, booToRea.u)
    annotation (Line(points={{-180,-30},{-142,-30}}, color={255,0,255}));
  connect(mulSum.y, addPar.u)
    annotation (Line(points={{-79,-30},{-62,-30}}, color={0,0,127}));
  connect(curOpeChi.y, reaToInt1.u)
    annotation (Line(points={{61,60},{78,60}}, color={0,0,127}));
  connect(uStaUp, swi.u2)
    annotation (Line(points={{-180,-60},{-22,-60}}, color={255,0,255}));
  connect(addPar.y, swi.u1)
    annotation (Line(points={{-39,-30},{-30,-30},{-30,-52},{-22,-52}},
      color={0,0,127}));
  connect(mulSum.y, swi.u3)
    annotation (Line(points={{-79,-30},{-70,-30},{-70,-68},{-22,-68}},
      color={0,0,127}));
  connect(swi.y, reaToInt.u)
    annotation (Line(points={{1,-60},{18,-60}}, color={0,0,127}));
  connect(reaToInt.y, curOpeChi.index)
    annotation (Line(points={{41,-60},{50,-60},{50,48}}, color={255,127,0}));
  connect(reaToInt1.y, extIndSig.index)
    annotation (Line(points={{101,60},{110,60},{110,0},{-90,0},{-90,8}},
      color={255,127,0}));
  connect(booToRea.y, extIndSig.u)
    annotation (Line(points={{-119,-30},{-110,-30},{-110,20},{-102,20}},
      color={0,0,127}));
  connect(extIndSig.y, reaToInt2.u)
    annotation (Line(points={{-79,20},{-2,20}}, color={0,0,127}));
  connect(reaToInt2.y, yNexEnaChi)
    annotation (Line(points={{21,20},{130,20}}, color={255,127,0}));
  connect(booToRea.y, mulSum.u)
    annotation (Line(points={{-119,-30},{-102,-30}}, color={0,0,127}));

annotation (
  defaultComponentName="nexChi",
  Diagram(coordinateSystem(preserveAspectRatio=false,
          extent={{-160,-100},{120,100}})),
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
          extent={{-100,86},{-64,76}},
          lineColor={255,127,0},
          pattern=LinePattern.Dash,
          textString="uChiPri"),
        Text(
          extent={{-98,8},{-56,-4}},
          lineColor={255,0,255},
          pattern=LinePattern.Dash,
          textString="uChiEna"),
        Text(
          extent={{-98,-72},{-56,-84}},
          lineColor={255,0,255},
          pattern=LinePattern.Dash,
          textString="uStaUp"),
        Text(
          extent={{50,10},{98,-10}},
          lineColor={255,127,0},
          pattern=LinePattern.Dash,
          textString="yNexEnaChi")}));
end SelectEnablingChiller;
