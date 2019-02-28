within Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.Tower.Staging;
block Processes "Sequence for enabling and disabling cells"

  final parameter Integer twoCelInd[nTowCel]={i for i in 1:nTowCel}
    "Tower cell index, {1,2,...,n}";

  CDL.Interfaces.IntegerInput uEnaCelInd[nTowCel]
    "Array of cells to be enabled" annotation (Placement(transformation(extent={
            {-180,100},{-140,140}}), iconTransformation(extent={{-120,80},{-100,
            100}})));
  CDL.Interfaces.BooleanInput uEnaCel
    "Enabling cell status: true=start to enable cell" annotation (Placement(
        transformation(extent={{-180,-40},{-140,0}}),   iconTransformation(
          extent={{-120,40},{-100,60}})));
  CDL.Interfaces.RealInput uIsoVal[nTowCel](
    each final unit="1",
    each final min=0,
    each final max=1) "Cooling tower cells isolation valve position"
    annotation (Placement(transformation(extent={{-180,20},{-140,60}}),
        iconTransformation(extent={{-140,20},{-100,60}})));
  CDL.Integers.Sources.Constant conInt[nTowCel](final k=towCelInd)
    "Cooling tower cell index array"
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
  CDL.Logical.Edge edg
    annotation (Placement(transformation(extent={{-100,-30},{-80,-10}})));
  CDL.Logical.FallingEdge falEdg
    annotation (Placement(transformation(extent={{-100,-60},{-80,-40}})));
protected
  CDL.Integers.Equal                        intEqu[nChi]
    "Check next enabling isolation valve"
    annotation (Placement(transformation(extent={{-40,110},{-20,130}})));
  CDL.Logical.Switch                        swi2[nChi] "Logical switch"
    annotation (Placement(transformation(extent={{20,110},{40,130}})));
  CDL.Logical.Latch                        lat
    "Logical latch, maintain ON signal until condition changes"
    annotation (Placement(transformation(extent={{-40,-30},{-20,-10}})));
  CDL.Logical.Timer                        tim
    "Count the time after changing up-stream device status"
    annotation (Placement(transformation(extent={{-100,190},{-80,210}})));
  CDL.Continuous.Sources.Constant                        con6(final k=iniValPos)
    "Initial isolation valve position"
    annotation (Placement(transformation(extent={{-40,220},{-20,240}})));
  CDL.Continuous.Sources.Constant                        con9(final k=0)
    "Constant zero"
    annotation (Placement(transformation(extent={{0,220},{20,240}})));
  CDL.Continuous.Sources.Constant                        con7(final k=
        chaChiWatIsoTim)     "Time to change chilled water isolation valve"
    annotation (Placement(transformation(extent={{-40,160},{-20,180}})));
  CDL.Continuous.Sources.Constant                        con8(final k=endValPos)
    "Ending valve position"
    annotation (Placement(transformation(extent={{0,160},{20,180}})));
  CDL.Continuous.Line                        lin1
    "Chilled water isolation valve setpoint"
    annotation (Placement(transformation(extent={{40,190},{60,210}})));
equation
  connect(uEnaCelInd, intEqu.u1)
    annotation (Line(points={{-160,120},{-42,120}}, color={255,127,0}));
  connect(conInt.y, intEqu.u2) annotation (Line(points={{-79,90},{-60,90},{-60,
          112},{-42,112}}, color={255,127,0}));
  connect(intEqu.y, swi2.u2)
    annotation (Line(points={{-19,120},{18,120}}, color={255,0,255}));
  connect(uEnaCel, edg.u)
    annotation (Line(points={{-160,-20},{-102,-20}}, color={255,0,255}));
  connect(edg.y, lat.u)
    annotation (Line(points={{-79,-20},{-41,-20}}, color={255,0,255}));
  connect(uEnaCel, falEdg.u) annotation (Line(points={{-160,-20},{-120,-20},{
          -120,-50},{-102,-50}}, color={255,0,255}));
  connect(falEdg.y, lat.u0) annotation (Line(points={{-79,-50},{-60,-50},{-60,
          -26},{-41,-26}}, color={255,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-140,-200},
            {140,200}})), Diagram(coordinateSystem(preserveAspectRatio=false,
          extent={{-140,-200},{140,200}})));
end Processes;
