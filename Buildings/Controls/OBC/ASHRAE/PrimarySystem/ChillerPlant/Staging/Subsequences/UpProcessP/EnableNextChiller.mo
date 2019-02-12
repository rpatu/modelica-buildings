within Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.Staging.Subsequences.UpProcessP;
block EnableNextChiller "Sequence for enabling next chiller"

  parameter Integer num = 2 "Total number of chillers";

  parameter Modelica.SIunits.Time proOnTim = 300
    "Threshold time to check if newly enabled chiller being operated by more than 5 minutes";

  parameter Modelica.SIunits.VolumeFlowRate minFloSet[num+1]={0,0.0089,0.0177}
    "Minimum bypass flow rate at each chiller stage";
  parameter Modelica.SIunits.Time byPasSetTim=300
    "Time to slowly reset minimum by-pass flow";
  parameter Modelica.SIunits.Time aftByPasSetTim=60
    "Time after minimum bypass flow being resetted to new setpoint";
  parameter Modelica.SIunits.VolumeFlowRate minFloDif=0.01
    "Minimum flow rate difference to check if bybass flow achieves setpoint";

  Buildings.Controls.OBC.CDL.Interfaces.IntegerInput uNexEnaChi
    "Index of next enabling chiller"
    annotation (Placement(transformation(extent={{-240,230},{-200,270}}),
      iconTransformation(extent={{-140,60},{-100,100}})));
  Buildings.Controls.OBC.CDL.Interfaces.BooleanInput uStaUp
    "Indicate if there is stage up"
    annotation (Placement(transformation(extent={{-240,170},{-200,210}}),
      iconTransformation(extent={{-140,-100},{-100,-60}})));
  Buildings.Controls.OBC.CDL.Interfaces.BooleanInput uEnaChiWatIsoVal
    "Status of chiller chilled water isolation valve control: true=enabled valve is fully open"
    annotation (Placement(transformation(extent={{-240,140},{-200,180}}),
        iconTransformation(extent={{-140,-60},{-100,-20}})));
  Buildings.Controls.OBC.CDL.Interfaces.BooleanInput uChi[num]
    "Chiller status: true=ON"
     annotation (Placement(transformation(extent={{-240,110},{-200,150}}),
       iconTransformation(extent={{-140,-80},{-100,-40}})));
  Buildings.Controls.OBC.CDL.Interfaces.IntegerInput uNexDisChi
    "Next disabling chiller when there is any stage up that need one chiller on and another off"
    annotation (Placement(transformation(extent={{-240,-40},{-200,0}}),
        iconTransformation(extent={{-140,60},{-100,100}})));
  Buildings.Controls.OBC.CDL.Interfaces.BooleanInput uOnOff
    "Indicate if the stage require one chiller to be enabled while another is disabled"
    annotation (Placement(transformation(extent={{-240,60},{-200,100}}),
      iconTransformation(extent={{-120,-70},{-100,-50}})));
  Buildings.Controls.OBC.CDL.Interfaces.BooleanInput uChiWatReq[num]
    "Chilled water requst status for each chiller"
    annotation (Placement(transformation(extent={{-240,-100},{-200,-60}}),
      iconTransformation(extent={{-140,-20},{-100,20}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealInput uChiWatIsoVal[num](
    each final unit="1",
    each final min=0,
    each final max=1) "Chilled water isolation valve position"
    annotation (Placement(transformation(extent={{-240,-126},{-200,-86}}),
      iconTransformation(extent={{-140,20},{-100,60}})));
  Buildings.Controls.OBC.CDL.Interfaces.BooleanInput uConWatReq[num]
    "Condenser water requst status for each chiller"
    annotation (Placement(transformation(extent={{-240,-190},{-200,-150}}),
      iconTransformation(extent={{-140,-20},{-100,20}})));
  Buildings.Controls.OBC.CDL.Interfaces.BooleanInput uChiHeaCon[num]
    "Chillers head pressure control status"
    annotation (Placement(transformation(extent={{-240,-220},{-200,-180}}),
      iconTransformation(extent={{-300,-230},{-260,-190}})));
  Buildings.Controls.OBC.CDL.Interfaces.IntegerInput uSta
    "Current stage index"
    annotation (Placement(transformation(extent={{-240,-260},{-200,-220}}),
      iconTransformation(extent={{-120,-10},{-100,10}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealInput VBypas_flow(
    final unit="m3/s")
    "Measured bypass flow rate"
    annotation (Placement(transformation(extent={{-240,-304},{-200,-264}}),
      iconTransformation(extent={{-294,-294},{-254,-254}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealOutput yChiWatIsoVal[num](
    each final min=0,
    each final max=1,
    each final unit="1")
    "Chiller chilled water isolation valve position"
    annotation (Placement(transformation(extent={{200,-50},{220,-30}}),
      iconTransformation(extent={{84,-110},{104,-90}})));
  Buildings.Controls.OBC.CDL.Interfaces.BooleanOutput yChiHeaCon[num]
    "Chiller head pressure control enabling status"
    annotation (Placement(transformation(extent={{200,-160},{220,-140}}),
      iconTransformation(extent={{70,-176},{90,-156}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealOutput yChiWatBypSet(
    final unit="m3/s")
    "Chilled water minimum flow bypass setpoint"
    annotation (Placement(transformation(extent={{200,-220},{220,-200}}),
      iconTransformation(extent={{70,-240},{90,-220}})));
  Buildings.Controls.OBC.CDL.Interfaces.BooleanOutput yChi[num]
    "Chiller enabling status"
    annotation (Placement(transformation(extent={{200,70},{220,90}}),
      iconTransformation(extent={{12,250},{32,270}})));
  Buildings.Controls.OBC.CDL.Interfaces.BooleanOutput yMinBypRes
    "Minimum chilled water flow bypass setpoint reset status"
    annotation (Placement(transformation(extent={{200,-270},{220,-250}}),
      iconTransformation(extent={{72,-280},{92,-260}})));

protected
  Buildings.Controls.OBC.CDL.Logical.LogicalSwitch logSwi[num] "Logical switch"
    annotation (Placement(transformation(extent={{100,240},{120,260}})));
  Buildings.Controls.OBC.CDL.Logical.And and2
    annotation (Placement(transformation(extent={{-160,180},{-140,200}})));
  Buildings.Controls.OBC.CDL.Routing.BooleanReplicator booRep(
    final nout=num) "Replicate boolean input"
    annotation (Placement(transformation(extent={{-100,180},{-80,200}})));
  Buildings.Controls.OBC.CDL.Logical.And and1[num] "Logical and"
    annotation (Placement(transformation(extent={{-40,240},{-20,260}})));
  Buildings.Controls.OBC.CDL.Logical.Sources.Constant con[num](
    each final k=true) "True constant"
    annotation (Placement(transformation(extent={{-40,270},{-20,290}})));
  Buildings.Controls.OBC.CDL.Continuous.Hysteresis hys(
    final uLow=proOnTim - 1,
    final uHigh=proOnTim + 1)
    "Check the newly enabled chiller being operated by more than 5 minutes"
    annotation (Placement(transformation(extent={{-60,10},{-40,30}})));
  Buildings.Controls.OBC.CDL.Conversions.BooleanToReal booToRea[num]
    "Convert boolean input to real output"
    annotation (Placement(transformation(extent={{-160,120},{-140,140}})));
  Buildings.Controls.OBC.CDL.Continuous.GreaterEqualThreshold greEquThr[num](
    each final threshold=0.5)
    "Convert real input to boolean output"
    annotation (Placement(transformation(extent={{20,120},{40,140}})));
  Buildings.Controls.OBC.CDL.Logical.LogicalSwitch logSwi1[num] "Logical switch"
    annotation (Placement(transformation(extent={{100,10},{120,30}})));
  Buildings.Controls.OBC.CDL.Logical.And and3[num] "Logical and"
    annotation (Placement(transformation(extent={{40,10},{60,30}})));
  Buildings.Controls.OBC.CDL.Logical.Sources.Constant con1[num](
    each final k=false) "False constant"
    annotation (Placement(transformation(extent={{40,40},{60,60}})));
  Buildings.Controls.OBC.CDL.Logical.LogicalSwitch logSwi2[num]
    "Logical switch"
    annotation (Placement(transformation(extent={{160,70},{180,90}})));
  Buildings.Controls.OBC.CDL.Logical.Or or2 "Logical or"
    annotation (Placement(transformation(extent={{40,70},{60,90}})));
  Buildings.Controls.OBC.CDL.Conversions.BooleanToReal booToRea1[num]
    "Convert boolean input to real output"
    annotation (Placement(transformation(extent={{-160,-90},{-140,-70}})));
  Buildings.Controls.OBC.CDL.Continuous.GreaterEqualThreshold greEquThr1(
    final threshold=0.5)
    "Convert real input to boolean output"
    annotation (Placement(transformation(extent={{-80,-90},{-60,-70}})));
  Buildings.Controls.OBC.CDL.Logical.And and4 "Logical and"
    annotation (Placement(transformation(extent={{20,-70},{40,-50}})));
  Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.Staging.Subsequences.EnableChiIsoVal disChiIsoVal(
    final num=num,
    final iniValPos=1,
    final endValPos=0) "Disable isolation valve of the chiller being disabled"
    annotation (Placement(transformation(extent={{100,-120},{120,-100}})));
  Buildings.Controls.OBC.CDL.Logical.Sources.Constant con2(
    final k=true) "True constant"
    annotation (Placement(transformation(extent={{-100,-140},{-80,-120}})));
  Buildings.Controls.OBC.CDL.Conversions.BooleanToReal booToRea2[num]
    "Convert boolean input to real output"
    annotation (Placement(transformation(extent={{-160,-180},{-140,-160}})));
  Buildings.Controls.OBC.CDL.Continuous.GreaterEqualThreshold greEquThr2(
    final threshold=0.5)
    "Convert real input to boolean output"
    annotation (Placement(transformation(extent={{-80,-180},{-60,-160}})));
  Buildings.Controls.OBC.CDL.Logical.And and5 "Logical and"
    annotation (Placement(transformation(extent={{-20,-180},{0,-160}})));
  Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.Staging.Subsequences.EnableHeadControl disHeaCon(
    final num=num,
    final heaStaCha=false)
    "Disable head pressure control of the chiller being disabled"
    annotation (Placement(transformation(extent={{80,-180},{100,-160}})));
  Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.MinimumFlowBypass.Subsequences.FlowSetpoint minBypSet(
    final num=num,
    final byPasSetTim=byPasSetTim,
    final minFloSet=minFloSet)
    annotation (Placement(transformation(extent={{80,-240},{100,-220}})));
  Buildings.Controls.OBC.CDL.Logical.Sources.Constant con3(final k=false)
    "False constant"
    annotation (Placement(transformation(extent={{-60,-230},{-40,-210}})));
  Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.Staging.Subsequences.ResetMinBypassSetpoint minBypSet1(
    final aftByPasSetTim=aftByPasSetTim,
    final minFloDif=minFloDif)
    "Check if minimum bypass flow has been resetted"
    annotation (Placement(transformation(extent={{80,-290},{100,-270}})));
  Buildings.Controls.OBC.CDL.Routing.IntegerReplicator intRep(final nout=num)
    "Replicate integer input"
    annotation (Placement(transformation(extent={{-160,240},{-140,260}})));
  Buildings.Controls.OBC.CDL.Integers.Equal intEqu[num]
    "Check next enabling isolation valve"
    annotation (Placement(transformation(extent={{-100,240},{-80,260}})));
  Buildings.Controls.OBC.CDL.Logical.Timer tim
    "Count the time after new chiller has been enabled"
    annotation (Placement(transformation(extent={{-100,10},{-80,30}})));
  Buildings.Controls.OBC.CDL.Discrete.TriggeredSampler triSam[num]
    "Record the old chiller chilled water isolation valve status"
    annotation (Placement(transformation(extent={{-20,120},{0,140}})));
  Buildings.Controls.OBC.CDL.Routing.BooleanReplicator booRep1(final nout=num)
    "Replicate boolean input"
    annotation (Placement(transformation(extent={{-60,100},{-40,120}})));
  Buildings.Controls.OBC.CDL.Logical.Edge edg
    "Rising edge, output true at the moment when input turns from false to true"
    annotation (Placement(transformation(extent={{-100,100},{-80,120}})));
  Buildings.Controls.OBC.CDL.Routing.IntegerReplicator intRep1(final nout=num)
    "Replicate integer input"
    annotation (Placement(transformation(extent={{-160,-30},{-140,-10}})));
  Buildings.Controls.OBC.CDL.Integers.Equal intEqu1[num]
    "Check next enabling isolation valve"
    annotation (Placement(transformation(extent={{-100,-30},{-80,-10}})));
  Buildings.Controls.OBC.CDL.Routing.BooleanReplicator booRep2(final nout=num)
    "Replicate boolean input"
    annotation (Placement(transformation(extent={{-20,10},{0,30}})));
  Buildings.Controls.OBC.CDL.Routing.BooleanReplicator booRep3(final nout=num)
    "Replicate boolean input"
    annotation (Placement(transformation(extent={{80,70},{100,90}})));
  Buildings.Controls.OBC.CDL.Logical.Not not2 "Logical not"
    annotation (Placement(transformation(extent={{-160,70},{-140,90}})));
  Buildings.Controls.OBC.CDL.Logical.Not not1 "Logical not"
    annotation (Placement(transformation(extent={{-20,50},{0,70}})));
  Buildings.Controls.OBC.CDL.Routing.RealExtractor  curDisChi(final nin=num)
    "Current disabling chiller"
    annotation (Placement(transformation(extent={{-120,-90},{-100,-70}})));
  Buildings.Controls.OBC.CDL.Routing.RealExtractor curDisChi1(final nin=num)
    "Current disabling chiller"
    annotation (Placement(transformation(extent={{-120,-180},{-100,-160}})));
  Buildings.Controls.OBC.CDL.Logical.LogicalSwitch logSwi3[num]
    "Logical switch"
    annotation (Placement(transformation(extent={{160,-160},{180,-140}})));
  Buildings.Controls.OBC.CDL.Routing.BooleanReplicator booRep4(final nout=num)
    "Replicate boolean input"
    annotation (Placement(transformation(extent={{-60,-50},{-40,-30}})));
  Buildings.Controls.OBC.CDL.Logical.Switch chiWatIso[num]
    "Chilled water isolation valve"
    annotation (Placement(transformation(extent={{160,-50},{180,-30}})));
  Buildings.Controls.OBC.CDL.Logical.LogicalSwitch logSwi4
    "Logical switch"
    annotation (Placement(transformation(extent={{160,-270},{180,-250}})));
  Buildings.Controls.OBC.CDL.Logical.Switch chiWatByp
    "Chilled water bypass flow setpoint"
    annotation (Placement(transformation(extent={{160,-220},{180,-200}})));

equation
  connect(uNexEnaChi, intRep.u)
    annotation (Line(points={{-220,250},{-162,250}}, color={255,127,0}));
  connect(intRep.y, intEqu.u1)
    annotation (Line(points={{-139,250},{-102,250}}, color={255,127,0}));
  connect(uEnaChiWatIsoVal, and2.u2) annotation (Line(points={{-220,160},{-180,160},
          {-180,182},{-162,182}},      color={255,0,255}));
  connect(uStaUp, and2.u1)
    annotation (Line(points={{-220,190},{-162,190}}, color={255,0,255}));
  connect(and2.y, booRep.u)
    annotation (Line(points={{-139,190},{-102,190}}, color={255,0,255}));
  connect(intEqu.y, and1.u1)
    annotation (Line(points={{-79,250},{-42,250}},   color={255,0,255}));
  connect(booRep.y, and1.u2) annotation (Line(points={{-79,190},{-60,190},{-60,242},
          {-42,242}},            color={255,0,255}));
  connect(and1.y, logSwi.u2)
    annotation (Line(points={{-19,250},{98,250}}, color={255,0,255}));
  connect(con.y, logSwi.u1) annotation (Line(points={{-19,280},{0,280},{0,258},{
          98,258}},       color={255,0,255}));
  connect(tim.y, hys.u)
    annotation (Line(points={{-79,20},{-62,20}},   color={0,0,127}));
  connect(uChi, booToRea.u)
    annotation (Line(points={{-220,130},{-162,130}}, color={255,0,255}));
  connect(and2.y, edg.u) annotation (Line(points={{-139,190},{-120,190},{-120,110},
          {-102,110}},      color={255,0,255}));
  connect(booToRea.y, triSam.u)
    annotation (Line(points={{-139,130},{-22,130}},  color={0,0,127}));
  connect(edg.y, booRep1.u)
    annotation (Line(points={{-79,110},{-62,110}},   color={255,0,255}));
  connect(booRep1.y, triSam.trigger) annotation (Line(points={{-39,110},{-10,110},
          {-10,118.2}},      color={255,0,255}));
  connect(triSam.y, greEquThr.u)
    annotation (Line(points={{1,130},{18,130}},    color={0,0,127}));
  connect(greEquThr.y, logSwi.u3) annotation (Line(points={{41,130},{60,130},{60,
          242},{98,242}},      color={255,0,255}));
  connect(and2.y, tim.u) annotation (Line(points={{-139,190},{-120,190},{-120,20},
          {-102,20}},     color={255,0,255}));
  connect(uNexDisChi, intRep1.u)
    annotation (Line(points={{-220,-20},{-162,-20}}, color={255,127,0}));
  connect(intRep1.y, intEqu1.u1)
    annotation (Line(points={{-139,-20},{-102,-20}}, color={255,127,0}));
  connect(hys.y, booRep2.u)
    annotation (Line(points={{-39,20},{-22,20}},   color={255,0,255}));
  connect(booRep2.y, and3.u1)
    annotation (Line(points={{1,20},{38,20}},    color={255,0,255}));
  connect(intEqu1.y, and3.u2) annotation (Line(points={{-79,-20},{20,-20},{20,12},
          {38,12}},          color={255,0,255}));
  connect(and3.y, logSwi1.u2)
    annotation (Line(points={{61,20},{98,20}},  color={255,0,255}));
  connect(con1.y, logSwi1.u1) annotation (Line(points={{61,50},{80,50},{80,28},{
          98,28}}, color={255,0,255}));
  connect(uChi, logSwi1.u3) annotation (Line(points={{-220,130},{-180,130},{-180,
          0},{80,0},{80,12},{98,12}},      color={255,0,255}));
  connect(booRep3.y, logSwi2.u2)
    annotation (Line(points={{101,80},{158,80}},
                                               color={255,0,255}));
  connect(uOnOff, not2.u)
    annotation (Line(points={{-220,80},{-162,80}}, color={255,0,255}));
  connect(logSwi1.y, logSwi2.u3) annotation (Line(points={{121,20},{140,20},{140,
          72},{158,72}},color={255,0,255}));
  connect(logSwi.y, logSwi2.u1) annotation (Line(points={{121,250},{140,250},{140,
          88},{158,88}},color={255,0,255}));
  connect(logSwi2.y, yChi)
    annotation (Line(points={{181,80},{210,80}}, color={255,0,255}));
  connect(not2.y, or2.u1)
    annotation (Line(points={{-139,80},{38,80}},  color={255,0,255}));
  connect(hys.y, not1.u) annotation (Line(points={{-39,20},{-30,20},{-30,60},{-22,
          60}},       color={255,0,255}));
  connect(not1.y, or2.u2) annotation (Line(points={{1,60},{20,60},{20,72},{38,72}},
                    color={255,0,255}));
  connect(or2.y, booRep3.u)
    annotation (Line(points={{61,80},{78,80}},  color={255,0,255}));
  connect(booToRea1.y,curDisChi. u)
    annotation (Line(points={{-139,-80},{-122,-80}}, color={0,0,127}));
  connect(uChiWatReq, booToRea1.u)
    annotation (Line(points={{-220,-80},{-162,-80}}, color={255,0,255}));
  connect(curDisChi.y, greEquThr1.u)
    annotation (Line(points={{-99,-80},{-82,-80}},   color={0,0,127}));
  connect(hys.y, and4.u1) annotation (Line(points={{-39,20},{-30,20},{-30,-60},
          {18,-60}},        color={255,0,255}));
  connect(greEquThr1.y, and4.u2) annotation (Line(points={{-59,-80},{0,-80},{0,
          -68},{18,-68}},         color={255,0,255}));
  connect(uNexDisChi,disChiIsoVal. uNexChaChi) annotation (Line(points={{-220,-20},
          {-180,-20},{-180,-102},{98,-102}},       color={255,127,0}));
  connect(uChiWatIsoVal,disChiIsoVal. uChiWatIsoVal)
    annotation (Line(points={{-220,-106},{98,-106}},  color={0,0,127}));
  connect(and4.y,disChiIsoVal. yUpsDevSta) annotation (Line(points={{41,-60},{60,
          -60},{60,-114},{98,-114}},       color={255,0,255}));
  connect(con2.y,disChiIsoVal. uStaCha) annotation (Line(points={{-79,-130},{20,
          -130},{20,-118},{98,-118}},       color={255,0,255}));
  connect(uConWatReq, booToRea2.u)
    annotation (Line(points={{-220,-170},{-162,-170}}, color={255,0,255}));
  connect(booToRea2.y, curDisChi1.u)
    annotation (Line(points={{-139,-170},{-122,-170}}, color={0,0,127}));
  connect(uNexDisChi, curDisChi1.index) annotation (Line(points={{-220,-20},{-180,
          -20},{-180,-190},{-110,-190},{-110,-182}}, color={255,127,0}));
  connect(curDisChi1.y, greEquThr2.u)
    annotation (Line(points={{-99,-170},{-82,-170}}, color={0,0,127}));
  connect(greEquThr2.y, and5.u1)
    annotation (Line(points={{-59,-170},{-22,-170}}, color={255,0,255}));
  connect(disChiIsoVal.yEnaChiWatIsoVal, and5.u2) annotation (Line(points={{121,
          -104},{160,-104},{160,-90},{-40,-90},{-40,-178},{-22,-178}}, color={255,
          0,255}));
  connect(con2.y, disHeaCon.uStaCha) annotation (Line(points={{-79,-130},{20,-130},
          {20,-166},{78,-166}}, color={255,0,255}));
  connect(and5.y, disHeaCon.uUpsDevSta) annotation (Line(points={{1,-170},{40,-170},
          {40,-162},{78,-162}}, color={255,0,255}));
  connect(uNexDisChi, disHeaCon.uNexChaChi) annotation (Line(points={{-220,-20},
          {-180,-20},{-180,-190},{40,-190},{40,-174},{78,-174}}, color={255,127,
          0}));
  connect(disHeaCon.uChiHeaCon, uChiHeaCon) annotation (Line(points={{78,-178},
          {60,-178},{60,-200},{-220,-200}},color={255,0,255}));
  connect(uNexDisChi, curDisChi.index) annotation (Line(points={{-220,-20},{-180,
          -20},{-180,-102},{-110,-102},{-110,-92}}, color={255,127,0}));
  connect(con3.y, minBypSet.uStaUp) annotation (Line(points={{-39,-220},{20,-220},
          {20,-222},{78,-222}},  color={255,0,255}));
  connect(con3.y, minBypSet.uOnOff) annotation (Line(points={{-39,-220},{20,-220},
          {20,-234},{78,-234}},  color={255,0,255}));
  connect(con3.y, minBypSet.uStaDow) annotation (Line(points={{-39,-220},{20,-220},
          {20,-238},{78,-238}},  color={255,0,255}));
  connect(uSta, minBypSet.uSta)
    annotation (Line(points={{-220,-240},{-20,-240},{-20,-230},{78,-230}},
                                                     color={255,127,0}));
  connect(disHeaCon.yEnaHeaCon, minBypSet.uUpsDevSta) annotation (Line(points={{101,
          -164},{120,-164},{120,-210},{40,-210},{40,-226},{78,-226}},     color=
         {255,0,255}));
  connect(disHeaCon.yEnaHeaCon, minBypSet1.uUpsDevSta) annotation (Line(points={{101,
          -164},{120,-164},{120,-204},{40,-204},{40,-272},{78,-272}},
        color={255,0,255}));
  connect(con2.y, minBypSet1.uStaCha) annotation (Line(points={{-79,-130},{20,-130},
          {20,-276},{78,-276}}, color={255,0,255}));
  connect(minBypSet.yChiWatBypSet, minBypSet1.VBypas_setpoint) annotation (Line(
        points={{101,-230},{120,-230},{120,-248},{60,-248},{60,-288},{78,-288}},
        color={0,0,127}));
  connect(minBypSet1.VBypas_flow, VBypas_flow)
    annotation (Line(points={{78,-284},{-220,-284}}, color={0,0,127}));

  connect(not2.y, booRep4.u) annotation (Line(points={{-139,80},{-130,80},{-130,
          -40},{-62,-40}}, color={255,0,255}));
  connect(uChiHeaCon, logSwi3.u1) annotation (Line(points={{-220,-200},{130,-200},
          {130,-142},{158,-142}}, color={255,0,255}));
  connect(disHeaCon.yChiHeaCon, logSwi3.u3) annotation (Line(points={{101,-176},
          {140,-176},{140,-158},{158,-158}}, color={255,0,255}));
  connect(logSwi3.y, yChiHeaCon)
    annotation (Line(points={{181,-150},{210,-150}}, color={255,0,255}));
  connect(booRep4.y, logSwi3.u2) annotation (Line(points={{-39,-40},{50,-40},{50,
          -150},{158,-150}}, color={255,0,255}));
  connect(booRep4.y, chiWatIso.u2)
    annotation (Line(points={{-39,-40},{158,-40}}, color={255,0,255}));
  connect(uChiWatIsoVal, chiWatIso.u1) annotation (Line(points={{-220,-106},{80,
          -106},{80,-32},{158,-32}}, color={0,0,127}));
  connect(disChiIsoVal.yChiWatIsoVal, chiWatIso.u3) annotation (Line(points={{121,
          -110},{140,-110},{140,-48},{158,-48}}, color={0,0,127}));
  connect(chiWatIso.y, yChiWatIsoVal)
    annotation (Line(points={{181,-40},{210,-40}}, color={0,0,127}));
  connect(not2.y, logSwi4.u2) annotation (Line(points={{-139,80},{-130,80},{-130,
          -260},{158,-260}}, color={255,0,255}));
  connect(con2.y, logSwi4.u1) annotation (Line(points={{-79,-130},{20,-130},{20,
          -252},{158,-252}}, color={255,0,255}));
  connect(minBypSet1.yMinBypRes, logSwi4.u3) annotation (Line(points={{101,-280},
          {120,-280},{120,-268},{158,-268}}, color={255,0,255}));
  connect(logSwi4.y, yMinBypRes)
    annotation (Line(points={{181,-260},{210,-260}}, color={255,0,255}));
  connect(not2.y, chiWatByp.u2) annotation (Line(points={{-139,80},{-130,80},{-130,
          -210},{158,-210}}, color={255,0,255}));
  connect(minBypSet.yChiWatBypSet, chiWatByp.u3) annotation (Line(points={{101,
          -230},{120,-230},{120,-218},{158,-218}}, color={0,0,127}));
  connect(VBypas_flow, chiWatByp.u1) annotation (Line(points={{-220,-284},{40,-284},
          {40,-300},{140,-300},{140,-202},{158,-202}}, color={0,0,127}));
  connect(chiWatByp.y, yChiWatBypSet)
    annotation (Line(points={{181,-210},{210,-210}}, color={0,0,127}));
annotation (
  defaultComponentName="enaNexChi",
  Diagram(coordinateSystem(preserveAspectRatio=false,
          extent={{-200,-300},{200,300}}), graphics={
          Rectangle(
          extent={{-198,298},{198,102}},
          fillColor={210,210,210},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
          Text(
          extent={{-26,176},{184,142}},
          pattern=LinePattern.None,
          fillColor={210,210,210},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,127},
          horizontalAlignment=TextAlignment.Right,
          textString="Check next chiller when there is no 
chiller needs to be disabled"),
          Rectangle(
          extent={{-198,98},{198,2}},
          fillColor={210,210,210},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
          Text(
          extent={{102,14},{196,4}},
          pattern=LinePattern.None,
          fillColor={210,210,210},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,127},
          horizontalAlignment=TextAlignment.Right,
          textString="Disable small chiller")}));
end EnableNextChiller;
