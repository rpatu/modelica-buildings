within Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.Staging.Subsequences.UpProcessP;
block EnableHeadControl
  "Sequences for enabling headi pressure control for the chiller being enabled"
  CDL.Interfaces.IntegerInput uNexEnaChi "Index of next enabling chiller"
    annotation (Placement(transformation(extent={{-180,-100},{-140,-60}}),
        iconTransformation(extent={{-112,58},{-72,98}})));
  CDL.Logical.Timer tim
    annotation (Placement(transformation(extent={{-20,60},{0,80}})));
  CDL.Logical.Edge edg
    annotation (Placement(transformation(extent={{-120,110},{-100,130}})));
  CDL.Logical.Latch lat
    annotation (Placement(transformation(extent={{-60,60},{-40,80}})));
  CDL.Interfaces.BooleanInput uPumSpeChe
    "Check if condenser water pump speed has achieved its new setpoint"
    annotation (Placement(transformation(extent={{-180,100},{-140,140}}),
        iconTransformation(extent={{-140,40},{-100,80}})));
  CDL.Continuous.Hysteresis hys(uLow=thrTimEnb - 1, uHigh=thrTimEnb + 1)
    "Check if it is 10 seconds after condenser water pump achieves its new setpoint"
    annotation (Placement(transformation(extent={{20,60},{40,80}})));
  CDL.Interfaces.BooleanInput uChiHeaCon[num]
    "Chillers head pressure control status" annotation (Placement(
        transformation(extent={{-180,-50},{-140,-10}}), iconTransformation(
          extent={{-140,40},{-100,80}})));
  CDL.Discrete.TriggeredSampler triSam[num]
    "Record the old chiller head pressure control status"
    annotation (Placement(transformation(extent={{-60,-40},{-40,-20}})));
  CDL.Conversions.BooleanToReal booToRea[num]
    "Convert boolean input to real output"
    annotation (Placement(transformation(extent={{-120,-40},{-100,-20}})));
  CDL.Interfaces.BooleanOutput yChiHeaCon[num]
    "Chiller head pressure control enabling status" annotation (Placement(
        transformation(extent={{220,80},{240,100}}), iconTransformation(extent=
            {{212,80},{232,100}})));
  CDL.Continuous.MultiSum mulSum
    annotation (Placement(transformation(extent={{-20,-40},{0,-20}})));
  CDL.Continuous.MultiSum mulSum1
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  CDL.Continuous.Feedback feedback
    annotation (Placement(transformation(extent={{20,-10},{40,10}})));
  CDL.Continuous.Hysteresis hys1(uLow=-0.5, uHigh=0.5)
    "Check if total enabling head pressure control is equal"
    annotation (Placement(transformation(extent={{60,-10},{80,10}})));
  CDL.Interfaces.BooleanOutput yEnaHeaCon
    "Status of heat pressure control: true=enabled head pressure control"
    annotation (Placement(transformation(extent={{220,30},{240,50}}),
        iconTransformation(extent={{210,30},{230,50}})));
  CDL.Routing.BooleanReplicator booRep(nout=num)
    annotation (Placement(transformation(extent={{-120,10},{-100,30}})));
  CDL.Logical.And and2
    annotation (Placement(transformation(extent={{-120,60},{-100,80}})));
  CDL.Interfaces.BooleanInput                        uStaUp
    "Indicate if there is stage up"
    annotation (Placement(transformation(extent={{-180,42},{-140,82}}),
      iconTransformation(extent={{-140,-22},{-100,18}})));
equation
  connect(uPumSpeChe, edg.u)
    annotation (Line(points={{-160,120},{-122,120}},
                                                   color={255,0,255}));
  connect(lat.y, tim.u)
    annotation (Line(points={{-39,70},{-22,70}}, color={255,0,255}));
  connect(tim.y, hys.u)
    annotation (Line(points={{1,70},{18,70}},   color={0,0,127}));
  connect(uChiHeaCon, booToRea.u) annotation (Line(points={{-160,-30},{-122,-30}},
                              color={255,0,255}));
  connect(booToRea.y, triSam.u)
    annotation (Line(points={{-99,-30},{-62,-30}},
                                               color={0,0,127}));
  connect(feedback.y, hys1.u)
    annotation (Line(points={{41,0},{58,0}},   color={0,0,127}));
  connect(mulSum.y, feedback.u2)
    annotation (Line(points={{1,-30},{30,-30},{30,-12}}, color={0,0,127}));
  connect(mulSum1.y, feedback.u1)
    annotation (Line(points={{-39,0},{18,0}}, color={0,0,127}));
  connect(hys1.y, lat.u0) annotation (Line(points={{81,0},{100,0},{100,40},{-70,
          40},{-70,64},{-61,64}}, color={255,0,255}));
  connect(hys.y, yEnaHeaCon) annotation (Line(points={{41,70},{140,70},{140,40},
          {230,40}}, color={255,0,255}));
  connect(booRep.y, triSam.trigger) annotation (Line(points={{-99,20},{-80,20},
          {-80,-60},{-50,-60},{-50,-41.8}}, color={255,0,255}));
  connect(edg.y, and2.u1) annotation (Line(points={{-99,120},{-80,120},{-80,100},
          {-130,100},{-130,70},{-122,70}}, color={255,0,255}));
  connect(uStaUp, and2.u2)
    annotation (Line(points={{-160,62},{-122,62}}, color={255,0,255}));
  connect(and2.y, lat.u)
    annotation (Line(points={{-99,70},{-61,70}}, color={255,0,255}));
  connect(and2.y, booRep.u) annotation (Line(points={{-99,70},{-80,70},{-80,40},
          {-130,40},{-130,20},{-122,20}}, color={255,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-140,-140},
            {220,140}})), Diagram(coordinateSystem(preserveAspectRatio=false,
          extent={{-140,-140},{220,140}})));
end EnableHeadControl;
