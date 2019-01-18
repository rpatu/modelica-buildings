within Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.Staging.Generic;
block ChillerRotation "Rotate operating chiller"

  parameter Integer chiNum = 2 "Number of chillers";
  final parameter Integer staNum = chiNum+1
    "Number of total stages, it typically equal to chiller number plus 1";
  parameter Real chiOn[staNum] = {0,1,2}
    "Number of chiller that should be ON at each stage";
  parameter Real stagingRuntime=240*60*60 "Staging runtime"
    annotation (Dialog(group="Equipment roration"));
  parameter Boolean initRoles[chiNum]={true, false}
    "Initial roles: true = lead, false = lag/standby"
    annotation (Dialog(group="Equipment roration"));

  Buildings.Controls.OBC.CDL.Interfaces.IntegerInput uChiSta
    "Current chiller stage"
    annotation (Placement(transformation(extent={{-140,20},{-100,60}}),
      iconTransformation(extent={{-140,-20},{-100,20}})));
  Buildings.Controls.OBC.CDL.Interfaces.BooleanOutput yChiOpeSta[chiNum]
    "Chiller operation status"
    annotation (Placement(transformation(extent={{100,-10},{120,10}}),
      iconTransformation(extent={{100,-10},{120,10}})));

  Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.Generic.EquipmentRotationMult
    equRot(
    final num=chiNum,
    final stagingRuntime=stagingRuntime,
    final initRoles=initRoles) "Rotate lead and lag chiller"
    annotation (Placement(transformation(extent={{40,-16},{60,4}})));
  Buildings.Controls.OBC.CDL.Routing.RealExtractor curChiOn(
    final nin=staNum)
    "Number of chiller should be ON at current stage"
    annotation (Placement(transformation(extent={{20,70},{40,90}})));
  Buildings.Controls.OBC.CDL.Continuous.GreaterEqualThreshold zerChi(
    final threshold=0.5)
    "Check if any chiller should be ON"
    annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
  Buildings.Controls.OBC.CDL.Logical.LogicalSwitch leaChiSta "Lead chiller status"
    annotation (Placement(transformation(extent={{-20,-10},{0,10}})));
  Buildings.Controls.OBC.CDL.Continuous.GreaterEqualThreshold mulChi(
    final threshold=1.5)
    "Check if multiple chiller should be ON"
    annotation (Placement(transformation(extent={{-80,-40},{-60,-20}})));
  Buildings.Controls.OBC.CDL.Logical.LogicalSwitch lagChiSta "Lag chiller status"
    annotation (Placement(transformation(extent={{-20,-40},{0,-20}})));

protected
  Buildings.Controls.OBC.CDL.Continuous.Sources.Constant con1[staNum](
    final k=chiOn)
    "Number of chiller that should be ON at each stage"
    annotation (Placement(transformation(extent={{-40,70},{-20,90}})));
  Buildings.Controls.OBC.CDL.Logical.Sources.Constant onSta(final k=true)
    "Chiller ON status"
    annotation (Placement(transformation(extent={{-80,-70},{-60,-50}})));
  Buildings.Controls.OBC.CDL.Logical.Sources.Constant offSta(final k=false)
    "Chiller OFF status"
    annotation (Placement(transformation(extent={{-80,-100},{-60,-80}})));
  Buildings.Controls.OBC.CDL.Conversions.IntegerToReal intToRea
    "Convert integer to real number"
    annotation (Placement(transformation(extent={{-80,30},{-60,50}})));
  Buildings.Controls.OBC.CDL.Conversions.RealToInteger reaToInt
    annotation (Placement(transformation(extent={{0,30},{20,50}})));
  Buildings.Controls.OBC.CDL.Continuous.AddParameter addPar(final p=1, final k=1)
    "Current stage plus WSE on status"
    annotation (Placement(transformation(extent={{-40,30},{-20,50}})));

equation
  connect(uChiSta, intToRea.u)
    annotation (Line(points={{-120,40},{-82,40}}, color={255,127,0}));
  connect(intToRea.y, addPar.u)
    annotation (Line(points={{-59,40},{-42,40}}, color={0,0,127}));
  connect(con1.y, curChiOn.u)
    annotation (Line(points={{-19,80},{18,80}}, color={0,0,127}));
  connect(addPar.y, reaToInt.u)
    annotation (Line(points={{-19,40},{-2,40}}, color={0,0,127}));
  connect(reaToInt.y, curChiOn.index)
    annotation (Line(points={{21,40},{30,40},{30,68}}, color={255,127,0}));
  connect(zerChi.y, leaChiSta.u2)
    annotation (Line(points={{-59,0},{-22,0}}, color={255,0,255}));
  connect(onSta.y, leaChiSta.u1)
    annotation (Line(points={{-59,-60},{-50,-60},{-50,8},{-22,8}},
      color={255,0,255}));
  connect(onSta.y, lagChiSta.u1)
    annotation (Line(points={{-59,-60},{-50,-60},{-50,-22},{-22,-22}},
      color={255,0,255}));
  connect(mulChi.y, lagChiSta.u2)
    annotation (Line(points={{-59,-30},{-22,-30}}, color={255,0,255}));
  connect(offSta.y, leaChiSta.u3)
    annotation (Line(points={{-59,-90},{-40,-90},{-40,-8},{-22,-8}},
      color={255,0,255}));
  connect(offSta.y, lagChiSta.u3)
    annotation (Line(points={{-59,-90},{-40,-90},{-40,-38},{-22,-38}},
      color={255,0,255}));
  connect(leaChiSta.y, equRot.uLeaSta)
    annotation (Line(points={{1,0},{38,0}}, color={255,0,255}));
  connect(lagChiSta.y, equRot.uLagSta)
    annotation (Line(points={{1,-30},{20,-30},{20,-12},{38,-12}},
      color={255,0,255}));
  connect(curChiOn.y, zerChi.u)
    annotation (Line(points={{41,80},{60,80},{60,20},{-90,20},{-90,0},{-82,0}},
      color={0,0,127}));
  connect(curChiOn.y, mulChi.u)
    annotation (Line(points={{41,80},{60,80},{60,20},{-90,20},{-90,-30},{-82,-30}},
      color={0,0,127}));
  connect(equRot.yDevSta, yChiOpeSta)
    annotation (Line(points={{61,0},{110,0}}, color={255,0,255}));

annotation (
  defaultComponentName="chiRot",
  Icon(graphics={
        Rectangle(
        extent={{-100,-100},{100,100}},
        lineColor={0,0,127},
        fillColor={255,255,255},
        fillPattern=FillPattern.Solid),
        Text(
          extent={{-100,150},{100,110}},
          lineColor={0,0,255},
          textString="%name"),
        Text(
          extent={{-96,12},{-50,-8}},
          lineColor={0,0,127},
          pattern=LinePattern.Dash,
          textString="uChiSta"),
        Text(
          extent={{28,18},{96,-18}},
          lineColor={0,0,127},
          textString="yChiOpeSta")}),
  Diagram(coordinateSystem(preserveAspectRatio=false,
          extent={{-100,-100},{100,100}})));
end ChillerRotation;
