within Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.Staging.Subsequences.UpProcessP;
block Controller
  "Sequence for control devices when there is stage-up command"
  Subsequences.SelectEnablingChiller nexChi
    annotation (Placement(transformation(extent={{-60,180},{-40,200}})));
  Subsequences.ReduceChillerDemand chiDemRed
    annotation (Placement(transformation(extent={{-60,130},{-40,150}})));
  ResetMinBypassSetpoint minBypSet
    annotation (Placement(transformation(extent={{80,100},{100,120}})));
  Subsequences.EnableNextCWPump enaNexCWP
    annotation (Placement(transformation(extent={{20,10},{40,30}})));
  EnableHeadControl enaHeaCon
    annotation (Placement(transformation(extent={{80,-100},{100,-80}})));
  EnableChiIsoVal enaChiIsoVal
    annotation (Placement(transformation(extent={{80,-140},{100,-120}})));
  Subsequences.EnableNextChiller enaNexChi
    annotation (Placement(transformation(extent={{80,-200},{100,-180}})));
  CDL.Interfaces.BooleanInput uStaUp "Stage up status: true=stage-up"
    annotation (Placement(transformation(extent={{-260,150},{-220,190}}),
        iconTransformation(extent={{-230,142},{-190,182}})));
  CDL.Interfaces.RealInput uChiLoa[num] "Current chiller load" annotation (
      Placement(transformation(extent={{-260,120},{-220,160}}),
        iconTransformation(extent={{-230,110},{-190,150}})));
  CDL.Interfaces.BooleanInput uChi[num] "Chiller status: true=ON" annotation (
      Placement(transformation(extent={{-260,90},{-220,130}}),
        iconTransformation(extent={{-210,80},{-170,120}})));
  CDL.Interfaces.RealInput VBypas_flow "Measured bypass flow rate" annotation (
      Placement(transformation(extent={{-260,60},{-220,100}}),
        iconTransformation(extent={{-220,36},{-180,76}})));
  MinimumFlowBypass.Subsequences.FlowSetpoint minBypSet1
    annotation (Placement(transformation(extent={{20,60},{40,80}})));
  CDL.Interfaces.IntegerInput uSta "Current stage index" annotation (Placement(
        transformation(extent={{-260,0},{-220,40}}), iconTransformation(extent={
            {-220,40},{-180,80}})));
  CDL.Logical.Sources.Constant con(k=false) "False constant"
    annotation (Placement(transformation(extent={{-60,38},{-40,58}})));
  CDL.Interfaces.BooleanInput uOnOff
    "Indicate if the stage require one chiller to be enabled while another is disabled"
    annotation (Placement(transformation(extent={{-260,30},{-220,70}}),
        iconTransformation(extent={{-246,0},{-206,40}})));
  Pump.CondenserWaterP.Controller conWatPumCon
    annotation (Placement(transformation(extent={{80,-40},{100,-20}})));
  CDL.Logical.MultiOr mulOr
    annotation (Placement(transformation(extent={{-60,-20},{-40,0}})));
  CDL.Interfaces.BooleanInput uWSE
    "Water side economizer status: true = ON, false = OFF" annotation (
      Placement(transformation(extent={{-260,-80},{-220,-40}}),
        iconTransformation(extent={{-226,-80},{-186,-40}})));
  CDL.Interfaces.RealInput uConWatPumSpe "Current condenser water pump speed"
    annotation (Placement(transformation(extent={{-260,-100},{-220,-60}}),
        iconTransformation(extent={{-216,-118},{-176,-78}})));
  CDL.Interfaces.BooleanInput uChiHeaCon[num]
    "Chillers head pressure control status" annotation (Placement(
        transformation(extent={{-260,-130},{-220,-90}}), iconTransformation(
          extent={{-244,-156},{-204,-116}})));
  CDL.Interfaces.RealInput uChiWatIsoVal[num]
    "Chilled water isolation valve position" annotation (Placement(
        transformation(extent={{-260,-160},{-220,-120}}), iconTransformation(
          extent={{-246,-186},{-206,-146}})));
  CDL.Interfaces.BooleanInput uChiWatReq[num]
    "Chilled water requst status for each chiller" annotation (Placement(
        transformation(extent={{-260,-210},{-220,-170}}), iconTransformation(
          extent={{0,-214},{40,-174}})));
  CDL.Interfaces.BooleanInput uConWatReq[num]
    "Condenser water requst status for each chiller" annotation (Placement(
        transformation(extent={{-260,-50},{-220,-10}}), iconTransformation(
          extent={{-58,-224},{-18,-184}})));
  CDL.Logical.MultiOr mulOr1
    annotation (Placement(transformation(extent={{-60,-50},{-40,-30}})));
protected
  CDL.Logical.Edge                        edg
    "Rising edge, output true at the moment when input turns from false to true"
    annotation (Placement(transformation(extent={{-160,160},{-140,180}})));
  CDL.Logical.Latch                        lat
    "Logical latch, maintain ON signal until condition changes"
    annotation (Placement(transformation(extent={{-120,160},{-100,180}})));
equation
  connect(chiDemRed.yChiDemRed, minBypSet.uUpsDevSta) annotation (Line(points={{
          -39,136},{0,136},{0,118},{78,118}}, color={255,0,255}));
  connect(uStaUp, edg.u)
    annotation (Line(points={{-240,170},{-162,170}}, color={255,0,255}));
  connect(edg.y, lat.u)
    annotation (Line(points={{-139,170},{-121,170}}, color={255,0,255}));
  connect(lat.y, nexChi.uStaUp) annotation (Line(points={{-99,170},{-80,170},{-80,
          182},{-62,182}}, color={255,0,255}));
  connect(lat.y, chiDemRed.uStaUp) annotation (Line(points={{-99,170},{-80,170},
          {-80,146},{-62,146}}, color={255,0,255}));
  connect(chiDemRed.uChiLoa, uChiLoa)
    annotation (Line(points={{-62,140},{-240,140}}, color={0,0,127}));
  connect(chiDemRed.uChi, uChi) annotation (Line(points={{-62,134},{-200,134},{-200,
          110},{-240,110}}, color={255,0,255}));
  connect(lat.y, minBypSet.uStaCha) annotation (Line(points={{-99,170},{-80,170},
          {-80,114},{78,114}}, color={255,0,255}));
  connect(minBypSet.VBypas_flow, VBypas_flow) annotation (Line(points={{78,106},
          {-120,106},{-120,80},{-240,80}}, color={0,0,127}));
  connect(lat.y, minBypSet1.uStaUp) annotation (Line(points={{-99,170},{-80,170},
          {-80,78},{18,78}}, color={255,0,255}));
  connect(minBypSet1.uSta, uSta) annotation (Line(points={{18,70},{-140,70},{-140,
          20},{-240,20}}, color={255,127,0}));
  connect(chiDemRed.yChiDemRed, minBypSet1.uUpsDevSta) annotation (Line(points={
          {-39,136},{0,136},{0,74},{18,74}}, color={255,0,255}));
  connect(con.y, minBypSet1.uStaDow) annotation (Line(points={{-39,48},{0,48},{
          0,62},{18,62}},
                        color={255,0,255}));
  connect(minBypSet1.uOnOff, uOnOff) annotation (Line(points={{18,66},{-180,66},
          {-180,50},{-240,50}}, color={255,0,255}));
  connect(minBypSet1.yChiWatBypSet, minBypSet.VBypas_setpoint) annotation (Line(
        points={{41,70},{60,70},{60,102},{78,102}}, color={0,0,127}));
  connect(minBypSet.yMinBypRes, enaNexCWP.uMinBypRes) annotation (Line(points={{
          101,110},{120,110},{120,40},{0,40},{0,28},{18,28}}, color={255,0,255}));
  connect(lat.y, enaNexCWP.uStaUp) annotation (Line(points={{-99,170},{-80,170},
          {-80,19.8},{18,19.8}}, color={255,0,255}));
  connect(uSta, enaNexCWP.uSta) annotation (Line(points={{-240,20},{-140,20},{-140,
          12},{18,12}}, color={255,127,0}));
  connect(mulOr.y, conWatPumCon.uLeaChiOn) annotation (Line(points={{-38.3,-10},
          {40,-10},{40,-26},{78,-26}}, color={255,0,255}));
  connect(conWatPumCon.uWSE, uWSE) annotation (Line(points={{78,-34},{20,-34},{20,
          -60},{-240,-60}}, color={255,0,255}));
  connect(conWatPumCon.uConWatPumSpe, uConWatPumSpe) annotation (Line(points={{78,
          -38},{40,-38},{40,-80},{-240,-80}}, color={0,0,127}));
  connect(enaNexCWP.ySta, conWatPumCon.uChiSta) annotation (Line(points={{41,20},
          {60,20},{60,-22},{78,-22}}, color={255,127,0}));
  connect(lat.y, enaHeaCon.uStaCha) annotation (Line(points={{-99,170},{-80,170},
          {-80,-86},{78,-86}}, color={255,0,255}));
  connect(conWatPumCon.yPumSpeChe, enaHeaCon.uUpsDevSta) annotation (Line(
        points={{101,-39},{120,-39},{120,-52},{60,-52},{60,-82},{78,-82}},
        color={255,0,255}));
  connect(nexChi.yNexEnaChi, enaHeaCon.uNexChaChi) annotation (Line(points={{-39,
          190},{-20,190},{-20,-94},{78,-94}}, color={255,127,0}));
  connect(enaHeaCon.uChiHeaCon, uChiHeaCon) annotation (Line(points={{78,-98},{-40,
          -98},{-40,-110},{-240,-110}}, color={255,0,255}));
  connect(nexChi.yNexEnaChi, enaChiIsoVal.uNexChaChi) annotation (Line(points={{
          -39,190},{-20,190},{-20,-122},{78,-122}}, color={255,127,0}));
  connect(enaChiIsoVal.uChiWatIsoVal, uChiWatIsoVal) annotation (Line(points={{78,
          -126},{-60,-126},{-60,-140},{-240,-140}}, color={0,0,127}));
  connect(enaHeaCon.yEnaHeaCon, enaChiIsoVal.yUpsDevSta) annotation (Line(
        points={{101,-84},{120,-84},{120,-112},{60,-112},{60,-134},{78,-134}},
        color={255,0,255}));
  connect(lat.y, enaChiIsoVal.uStaCha) annotation (Line(points={{-99,170},{-80,170},
          {-80,-138},{78,-138}}, color={255,0,255}));
  connect(nexChi.yNexEnaChi, enaNexChi.uNexEnaChi) annotation (Line(points={{-39,
          190},{-20,190},{-20,-179},{79,-179}}, color={255,127,0}));
  connect(lat.y, enaNexChi.uStaUp) annotation (Line(points={{-99,170},{-80,170},
          {-80,-181},{79,-181}}, color={255,0,255}));
  connect(enaChiIsoVal.yEnaChiWatIsoVal, enaNexChi.uEnaChiWatIsoVal)
    annotation (Line(points={{101,-124},{120,-124},{120,-160},{60,-160},{60,-183},
          {79,-183}}, color={255,0,255}));
  connect(uChi, enaNexChi.uChi) annotation (Line(points={{-240,110},{-200,110},{
          -200,-185},{79,-185}}, color={255,0,255}));
  connect(uOnOff, enaNexChi.uOnOff) annotation (Line(points={{-240,50},{-180,50},
          {-180,-187},{79,-187}}, color={255,0,255}));
  connect(enaNexChi.uChiWatReq, uChiWatReq) annotation (Line(points={{79,-191},{
          60,-191},{60,-190},{-240,-190}}, color={255,0,255}));
  connect(enaNexChi.uChiWatIsoVal, uChiWatIsoVal) annotation (Line(points={{79,-193},
          {-60,-193},{-60,-140},{-240,-140}}, color={0,0,127}));
  connect(mulOr1.y, conWatPumCon.uLeaConWatReq) annotation (Line(points={{-38.3,
          -40},{0,-40},{0,-30},{78,-30}}, color={255,0,255}));
  connect(uConWatReq, enaNexChi.uConWatReq) annotation (Line(points={{-240,-30},
          {-160,-30},{-160,-195},{79,-195}}, color={255,0,255}));
  connect(uChiHeaCon, enaNexChi.uChiHeaCon) annotation (Line(points={{-240,-110},
          {-40,-110},{-40,-197},{79,-197}}, color={255,0,255}));
  connect(uSta, enaNexChi.uSta) annotation (Line(points={{-240,20},{-140,20},{-140,
          -199},{79,-199}}, color={255,127,0}));
  connect(VBypas_flow, enaNexChi.VBypas_flow) annotation (Line(points={{-240,80},
          {-120,80},{-120,-201},{79,-201}}, color={0,0,127}));

  connect(uConWatReq, mulOr1.u) annotation (Line(points={{-240,-30},{-160,-30},{
          -160,-40},{-62,-40}},             color={255,0,255}));
  connect(uChi, mulOr.u) annotation (Line(points={{-240,110},{-200,110},{-200,
          -10},{-62,-10}},                  color={255,0,255}));

  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-220,-220},
            {220,220}})), Diagram(coordinateSystem(preserveAspectRatio=false,
          extent={{-220,-220},{220,220}})));
end Controller;
