within Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.Staging.Subsequences.UpProcessP;
block OpenChiIsoVal "Sequence of open chilled water isolation valve"
  CDL.Continuous.Sources.Constant                        con7(final k=
        turOnChiWatIsoTim)
    "Time to turn on chilled water isolation valve"
    annotation (Placement(transformation(extent={{0,0},{20,20}})));
  CDL.Continuous.Sources.Constant                        con8(final k=1)
    "Constant 1"
    annotation (Placement(transformation(extent={{40,0},{60,20}})));
  CDL.Continuous.Sources.Constant                        con6(final k=0)
    "Constant zero"
    annotation (Placement(transformation(extent={{0,60},{20,80}})));
  CDL.Continuous.Sources.Constant                        con9(final k=0)
    "Constant zero"
    annotation (Placement(transformation(extent={{40,60},{60,80}})));
  CDL.Continuous.Line                        lin1
    "Chilled water isolation valve setpoint"
    annotation (Placement(transformation(extent={{80,30},{100,50}})));
  CDL.Interfaces.RealInput                        uChiWatIsoVal[num](
    final unit="1",
    final min=0,
    final max=1) "Chilled water isolation valve position"
    annotation (Placement(transformation(extent={{-180,-50},{-140,-10}}),
      iconTransformation(extent={{-120,-100},{-100,-80}})));
  CDL.Interfaces.BooleanInput yEnaHeaCon
    "Status of heat pressure control: true=enabled head pressure control"
    annotation (Placement(transformation(extent={{-180,20},{-140,60}}),
        iconTransformation(extent={{-140,40},{-100,80}})));
  CDL.Logical.Timer tim
    annotation (Placement(transformation(extent={{-20,30},{0,50}})));
  CDL.Logical.Edge edg
    annotation (Placement(transformation(extent={{-100,30},{-80,50}})));
  CDL.Logical.Latch lat
    annotation (Placement(transformation(extent={{-60,30},{-40,50}})));
  CDL.Interfaces.IntegerInput uNexEnaChi "Index of next enabling chiller"
    annotation (Placement(transformation(extent={{-180,-100},{-140,-60}}),
        iconTransformation(extent={{-112,58},{-72,98}})));
  CDL.Discrete.TriggeredSampler triSam[num]
    "Record the old chiller head pressure control status"
    annotation (Placement(transformation(extent={{-60,-40},{-40,-20}})));
  CDL.Routing.BooleanReplicator booRep(nout=num)
    annotation (Placement(transformation(extent={{-100,-10},{-80,10}})));
  CDL.Interfaces.BooleanInput                        uStaUp
    "Indicate if there is stage up"
    annotation (Placement(transformation(extent={{-180,60},{-140,100}}),
      iconTransformation(extent={{-140,-22},{-100,18}})));
  CDL.Interfaces.RealOutput yChiWatIsoVal[num]
    "Chiller chilled water isolation valve position" annotation (Placement(
        transformation(extent={{140,30},{160,50}}), iconTransformation(extent={
            {130,30},{150,50}})));
  CDL.Logical.And and2
    annotation (Placement(transformation(extent={{-100,70},{-80,90}})));
equation
  connect(yEnaHeaCon, edg.u)
    annotation (Line(points={{-160,40},{-102,40}},     color={255,0,255}));
  connect(edg.y, lat.u)
    annotation (Line(points={{-79,40},{-61,40}},     color={255,0,255}));
  connect(edg.y, booRep.u) annotation (Line(points={{-79,40},{-70,40},{-70,20},
          {-110,20},{-110,0},{-102,0}}, color={255,0,255}));
  connect(booRep.y, triSam.trigger) annotation (Line(points={{-79,0},{-70,0},{
          -70,-50},{-50,-50},{-50,-41.8}}, color={255,0,255}));
  connect(uChiWatIsoVal, triSam.u)
    annotation (Line(points={{-160,-30},{-62,-30}}, color={0,0,127}));
  connect(lat.y, tim.u)
    annotation (Line(points={{-39,40},{-22,40}}, color={255,0,255}));
  connect(con9.y, lin1.x1) annotation (Line(points={{61,70},{70,70},{70,48},{78,
          48}}, color={0,0,127}));
  connect(con6.y, lin1.f1) annotation (Line(points={{21,70},{30,70},{30,44},{78,
          44}}, color={0,0,127}));
  connect(con7.y, lin1.x2) annotation (Line(points={{21,10},{30,10},{30,36},{78,
          36}}, color={0,0,127}));
  connect(con8.y, lin1.f2) annotation (Line(points={{61,10},{70,10},{70,32},{78,
          32}}, color={0,0,127}));
  connect(tim.y, lin1.u)
    annotation (Line(points={{1,40},{78,40}}, color={0,0,127}));
  connect(uStaUp, and2.u1)
    annotation (Line(points={{-160,80},{-102,80}}, color={255,0,255}));
  connect(yEnaHeaCon, and2.u2) annotation (Line(points={{-160,40},{-120,40},{
          -120,72},{-102,72}}, color={255,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-140,
            -140},{140,140}})), Diagram(coordinateSystem(preserveAspectRatio=
            false, extent={{-140,-140},{140,140}})));
end OpenChiIsoVal;
