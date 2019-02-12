within Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.Staging.Subsequences.UpProcessP;
block SelectEnablingChiller
  "Sequence for selecting chiller to be enabled"
  parameter Integer num = 2 "Total number of chillers";

  Buildings.Controls.OBC.CDL.Interfaces.IntegerInput uChiPri[num]
    "Chiller enabling priority"
    annotation (Placement(transformation(extent={{-180,30},{-140,70}}),
      iconTransformation(extent={{-140,60},{-100,100}})));
  Buildings.Controls.OBC.CDL.Interfaces.BooleanInput uChiEna[num]
    "Chiller enabling status: true=ON"
    annotation (Placement(transformation(extent={{-180,-40},{-140,0}}),
      iconTransformation(extent={{-140,-20},{-100,20}})));
  Buildings.Controls.OBC.CDL.Interfaces.BooleanInput uStaUp
    "Stage up status: true=stage-up"
    annotation (Placement(transformation(extent={{-180,-80},{-140,-40}}),
      iconTransformation(extent={{-140,-100},{-100,-60}})));
  Buildings.Controls.OBC.CDL.Interfaces.IntegerOutput yNexEnaChi
    "Next enabling chiller index"
    annotation (Placement(transformation(extent={{140,40},{160,60}}),
      iconTransformation(extent={{100,-10},{120,10}})));

protected
  Buildings.Controls.OBC.CDL.Conversions.IntegerToReal intToRea[num]
    "Convert integer to real number"
    annotation (Placement(transformation(extent={{20,40},{40,60}})));
  Buildings.Controls.OBC.CDL.Conversions.BooleanToReal booToRea[num]
    "Convert boolean input to real output"
    annotation (Placement(transformation(extent={{-120,-30},{-100,-10}})));
  Buildings.Controls.OBC.CDL.Continuous.MultiSum mulSum(final nin=num)
    annotation (Placement(transformation(extent={{-80,-30},{-60,-10}})));
  Buildings.Controls.OBC.CDL.Continuous.AddParameter addPar(
    final p=1, final k=1)
    "Enabling one more chiller"
    annotation (Placement(transformation(extent={{-40,-30},{-20,-10}})));
  Buildings.Controls.OBC.CDL.Conversions.RealToInteger reaToInt
    "Convert real input to integer output"
    annotation (Placement(transformation(extent={{40,-70},{60,-50}})));
  Buildings.Controls.OBC.CDL.Conversions.RealToInteger reaToInt1
    "Convert real input to integer output"
    annotation (Placement(transformation(extent={{100,40},{120,60}})));
  Buildings.Controls.OBC.CDL.Logical.Switch swi
    annotation (Placement(transformation(extent={{0,-70},{20,-50}})));
  Buildings.Controls.OBC.CDL.Routing.RealExtractor curOpeChi(
    final nin=num)
    "New operating chiller at current stage"
    annotation (Placement(transformation(extent={{60,40},{80,60}})));

equation
  connect(uChiPri,intToRea. u)
    annotation (Line(points={{-160,50},{18,50}},  color={255,127,0}));
  connect(intToRea.y,curOpeChi. u)
    annotation (Line(points={{41,50},{58,50}}, color={0,0,127}));
  connect(uChiEna, booToRea.u)
    annotation (Line(points={{-160,-20},{-122,-20}}, color={255,0,255}));
  connect(mulSum.y, addPar.u)
    annotation (Line(points={{-59,-20},{-42,-20}}, color={0,0,127}));
  connect(curOpeChi.y, reaToInt1.u)
    annotation (Line(points={{81,50},{98,50}}, color={0,0,127}));
  connect(uStaUp, swi.u2)
    annotation (Line(points={{-160,-60},{-2,-60}},  color={255,0,255}));
  connect(addPar.y, swi.u1)
    annotation (Line(points={{-19,-20},{-10,-20},{-10,-52},{-2,-52}},
      color={0,0,127}));
  connect(mulSum.y, swi.u3)
    annotation (Line(points={{-59,-20},{-50,-20},{-50,-68},{-2,-68}},
      color={0,0,127}));
  connect(swi.y, reaToInt.u)
    annotation (Line(points={{21,-60},{38,-60}},color={0,0,127}));
  connect(reaToInt.y, curOpeChi.index)
    annotation (Line(points={{61,-60},{70,-60},{70,38}}, color={255,127,0}));
  connect(booToRea.y, mulSum.u)
    annotation (Line(points={{-99,-20},{-82,-20}},   color={0,0,127}));

  connect(reaToInt1.y, yNexEnaChi)
    annotation (Line(points={{121,50},{150,50}}, color={255,127,0}));
annotation (
  defaultComponentName="nexChi",
  Diagram(coordinateSystem(preserveAspectRatio=false,
          extent={{-140,-80},{140,80}})),
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
