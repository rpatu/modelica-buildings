within Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.Staging.Subsequences.UpProcessP;
block OpenChiIsoVal "Sequence of open chilled water isolation valve"
  CDL.Continuous.Sources.Constant                        con7(final k=
        turOnChiWatIsoTim)
    "Time to turn on chilled water isolation valve"
    annotation (Placement(transformation(extent={{-40,-40},{-20,-20}})));
  CDL.Continuous.Sources.Constant                        con8(final k=1)
    "Constant 1"
    annotation (Placement(transformation(extent={{20,-40},{40,-20}})));
  CDL.Continuous.Sources.Constant                        con6(final k=0)
    "Constant zero"
    annotation (Placement(transformation(extent={{-40,20},{-20,40}})));
  CDL.Continuous.Sources.Constant                        con9(final k=0)
    "Constant zero"
    annotation (Placement(transformation(extent={{20,20},{40,40}})));
  CDL.Continuous.Line                        lin1
    "Chilled water isolation valve setpoint"
    annotation (Placement(transformation(extent={{60,-10},{80,10}})));
  CDL.Interfaces.IntegerInput                        uChiSta
    "Current chiller stage"
    annotation (Placement(transformation(extent={{-180,50},{-140,90}}),
      iconTransformation(extent={{-140,60},{-100,100}})));
  CDL.Interfaces.RealInput                        uChiWatIsoVal[num](
    final unit="1",
    final min=0,
    final max=1) "Chilled water isolation valve position"
    annotation (Placement(transformation(extent={{-180,-60},{-140,-20}}),
      iconTransformation(extent={{-120,-100},{-100,-80}})));
  CDL.Interfaces.IntegerInput uChiPri[chiNum] "Chiller enabling priority"
    annotation (Placement(transformation(extent={{-180,100},{-140,140}}),
        iconTransformation(extent={{-140,60},{-100,100}})));
  CDL.Conversions.IntegerToReal intToRea[chiNum]
    "Convert integer to real number"
    annotation (Placement(transformation(extent={{-120,110},{-100,130}})));
protected
  CDL.Continuous.Sources.Constant                        con[num](final k=
        newStaChi) "Chilled water isolation valve"
    annotation (Placement(transformation(extent={{62,82},{82,102}})));
  CDL.Routing.RealExtractor                        curOpeChi(final nin=chiNum)
    "New operating chiller at current stage"
    annotation (Placement(transformation(extent={{-80,110},{-60,130}})));
equation
  connect(uChiPri, intToRea.u)
    annotation (Line(points={{-160,120},{-122,120}}, color={255,127,0}));
  connect(intToRea.y, curOpeChi.u)
    annotation (Line(points={{-99,120},{-82,120}}, color={0,0,127}));
  connect(uChiSta, curOpeChi.index) annotation (Line(points={{-160,70},{-70,70},
          {-70,108}}, color={255,127,0}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-140,
            -140},{140,140}})), Diagram(coordinateSystem(preserveAspectRatio=
            false, extent={{-140,-140},{140,140}})));
end OpenChiIsoVal;
