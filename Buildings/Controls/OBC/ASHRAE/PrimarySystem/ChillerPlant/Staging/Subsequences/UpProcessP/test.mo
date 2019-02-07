within Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.Staging.Subsequences.UpProcessP;
model test
  CDL.Logical.Edge edg
    annotation (Placement(transformation(extent={{-40,20},{-20,40}})));
  CDL.Logical.Timer tim
    annotation (Placement(transformation(extent={{40,20},{60,40}})));
  CDL.Logical.Sources.Pulse booPul(period=5, startTime=1)
    annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
  CDL.Logical.Latch lat
    annotation (Placement(transformation(extent={{0,20},{20,40}})));
  CDL.Continuous.GreaterEqualThreshold greEquThr1(threshold=2)
    annotation (Placement(transformation(extent={{-60,-20},{-40,0}})));
  CDL.Logical.Pre pre
    annotation (Placement(transformation(extent={{-20,-20},{0,0}})));
  CDL.Logical.Edge edg1
    annotation (Placement(transformation(extent={{-40,60},{-20,80}})));
  CDL.Logical.Sources.Pulse booPul1(period=5, startTime=1)
    annotation (Placement(transformation(extent={{-80,60},{-60,80}})));
  CDL.Logical.Sources.Constant con(k=true)
    annotation (Placement(transformation(extent={{-40,90},{-20,110}})));
  CDL.Logical.And and2
    annotation (Placement(transformation(extent={{20,90},{40,110}})));
equation
  connect(edg.u, booPul.y)
    annotation (Line(points={{-42,30},{-59,30}}, color={255,0,255}));
  connect(edg.y, lat.u)
    annotation (Line(points={{-19,30},{-1,30}}, color={255,0,255}));
  connect(lat.y, tim.u)
    annotation (Line(points={{21,30},{38,30}}, color={255,0,255}));
  connect(tim.y, greEquThr1.u) annotation (Line(points={{61,30},{80,30},{80,-40},
          {-80,-40},{-80,-10},{-62,-10}}, color={0,0,127}));
  connect(greEquThr1.y, pre.u)
    annotation (Line(points={{-39,-10},{-22,-10}}, color={255,0,255}));
  connect(pre.y, lat.u0) annotation (Line(points={{1,-10},{20,-10},{20,10},{-10,
          10},{-10,24},{-1,24}}, color={255,0,255}));
  connect(edg1.u, booPul1.y)
    annotation (Line(points={{-42,70},{-59,70}}, color={255,0,255}));
  connect(con.y, and2.u1)
    annotation (Line(points={{-19,100},{18,100}}, color={255,0,255}));
  connect(edg1.y, and2.u2) annotation (Line(points={{-19,70},{0,70},{0,92},{18,
          92}}, color={255,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end test;
