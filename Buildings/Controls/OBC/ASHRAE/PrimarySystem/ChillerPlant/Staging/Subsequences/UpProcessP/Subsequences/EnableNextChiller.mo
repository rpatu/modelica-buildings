within Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.Staging.Subsequences.UpProcessP.Subsequences;
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
    annotation (Placement(transformation(extent={{-240,250},{-200,290}}),
      iconTransformation(extent={{-120,100},{-100,120}})));
  Buildings.Controls.OBC.CDL.Interfaces.BooleanInput uStaUp
    "Indicate if there is stage up"
    annotation (Placement(transformation(extent={{-240,190},{-200,230}}),
      iconTransformation(extent={{-120,80},{-100,100}})));
  Buildings.Controls.OBC.CDL.Interfaces.BooleanInput uEnaChiWatIsoVal
    "Status of chiller chilled water isolation valve control: true=enabled valve is fully open"
    annotation (Placement(transformation(extent={{-240,160},{-200,200}}),
        iconTransformation(extent={{-120,60},{-100,80}})));
  Buildings.Controls.OBC.CDL.Interfaces.BooleanInput uChi[num]
    "Chiller status: true=ON"
     annotation (Placement(transformation(extent={{-240,130},{-200,170}}),
       iconTransformation(extent={{-120,40},{-100,60}})));
  Buildings.Controls.OBC.CDL.Interfaces.BooleanInput uOnOff
    "Indicate if the stage require one chiller to be enabled while another is disabled"
    annotation (Placement(transformation(extent={{-240,80},{-200,120}}),
      iconTransformation(extent={{-120,20},{-100,40}})));
  Buildings.Controls.OBC.CDL.Interfaces.IntegerInput uNexDisChi
    "Next disabling chiller when there is any stage up that need one chiller on and another off"
    annotation (Placement(transformation(extent={{-240,-20},{-200,20}}),
        iconTransformation(extent={{-120,0},{-100,20}})));
  Buildings.Controls.OBC.CDL.Interfaces.BooleanInput uChiWatReq[num]
    "Chilled water requst status for each chiller"
    annotation (Placement(transformation(extent={{-240,-80},{-200,-40}}),
      iconTransformation(extent={{-120,-20},{-100,0}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealInput uChiWatIsoVal[num](
    each final unit="1",
    each final min=0,
    each final max=1) "Chilled water isolation valve position"
    annotation (Placement(transformation(extent={{-240,-106},{-200,-66}}),
      iconTransformation(extent={{-120,-40},{-100,-20}})));
  Buildings.Controls.OBC.CDL.Interfaces.BooleanInput uConWatReq[num]
    "Condenser water requst status for each chiller"
    annotation (Placement(transformation(extent={{-240,-170},{-200,-130}}),
      iconTransformation(extent={{-120,-60},{-100,-40}})));
  Buildings.Controls.OBC.CDL.Interfaces.BooleanInput uChiHeaCon[num]
    "Chillers head pressure control status"
    annotation (Placement(transformation(extent={{-240,-200},{-200,-160}}),
      iconTransformation(extent={{-120,-80},{-100,-60}})));
  Buildings.Controls.OBC.CDL.Interfaces.IntegerInput uSta
    "Current stage index"
    annotation (Placement(transformation(extent={{-240,-240},{-200,-200}}),
      iconTransformation(extent={{-120,-100},{-100,-80}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealInput VBypas_flow(
    final unit="m3/s")
    "Measured bypass flow rate"
    annotation (Placement(transformation(extent={{-240,-284},{-200,-244}}),
      iconTransformation(extent={{-120,-120},{-100,-100}})));
  Buildings.Controls.OBC.CDL.Interfaces.BooleanOutput yChi[num]
    "Chiller enabling status"
    annotation (Placement(transformation(extent={{200,90},{220,110}}),
      iconTransformation(extent={{100,80},{120,100}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealOutput yChiWatIsoVal[num](
    each final min=0,
    each final max=1,
    each final unit="1")
    "Chiller chilled water isolation valve position"
    annotation (Placement(transformation(extent={{200,-30},{220,-10}}),
      iconTransformation(extent={{100,50},{120,70}})));
  Buildings.Controls.OBC.CDL.Interfaces.BooleanOutput yChiHeaCon[num]
    "Chiller head pressure control enabling status"
    annotation (Placement(transformation(extent={{200,-140},{220,-120}}),
      iconTransformation(extent={{100,20},{120,40}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealOutput yChiWatBypSet(
    final unit="m3/s")
    "Chilled water minimum flow bypass setpoint"
    annotation (Placement(transformation(extent={{200,-200},{220,-180}}),
      iconTransformation(extent={{100,-40},{120,-20}})));
  Buildings.Controls.OBC.CDL.Interfaces.BooleanOutput yMinBypRes
    "Minimum chilled water flow bypass setpoint reset status"
    annotation (Placement(transformation(extent={{200,-250},{220,-230}}),
      iconTransformation(extent={{100,-70},{120,-50}})));
  Buildings.Controls.OBC.CDL.Interfaces.BooleanOutput yEndSta
    "Flag to indicate if the staging process is finished"
    annotation (Placement(transformation(extent={{200,-320},{220,-300}}),
      iconTransformation(extent={{100,-100},{120,-80}})));

protected
  Buildings.Controls.OBC.CDL.Logical.LogicalSwitch logSwi[num] "Logical switch"
    annotation (Placement(transformation(extent={{100,260},{120,280}})));
  Buildings.Controls.OBC.CDL.Logical.And and2
    annotation (Placement(transformation(extent={{-160,200},{-140,220}})));
  Buildings.Controls.OBC.CDL.Routing.BooleanReplicator booRep(
    final nout=num) "Replicate boolean input"
    annotation (Placement(transformation(extent={{-100,200},{-80,220}})));
  Buildings.Controls.OBC.CDL.Logical.And and1[num] "Logical and"
    annotation (Placement(transformation(extent={{-40,260},{-20,280}})));
  Buildings.Controls.OBC.CDL.Logical.Sources.Constant con[num](
    each final k=true) "True constant"
    annotation (Placement(transformation(extent={{-40,290},{-20,310}})));
  Buildings.Controls.OBC.CDL.Continuous.Hysteresis hys(
    final uLow=proOnTim - 1,
    final uHigh=proOnTim + 1)
    "Check the newly enabled chiller being operated by more than 5 minutes"
    annotation (Placement(transformation(extent={{-60,30},{-40,50}})));
  Buildings.Controls.OBC.CDL.Conversions.BooleanToReal booToRea[num]
    "Convert boolean input to real output"
    annotation (Placement(transformation(extent={{-160,140},{-140,160}})));
  Buildings.Controls.OBC.CDL.Continuous.GreaterEqualThreshold greEquThr[num](
    each final threshold=0.5)
    "Convert real input to boolean output"
    annotation (Placement(transformation(extent={{20,140},{40,160}})));
  Buildings.Controls.OBC.CDL.Logical.LogicalSwitch logSwi1[num]
    "Logical switch"
    annotation (Placement(transformation(extent={{100,30},{120,50}})));
  Buildings.Controls.OBC.CDL.Logical.And and3[num] "Logical and"
    annotation (Placement(transformation(extent={{40,30},{60,50}})));
  Buildings.Controls.OBC.CDL.Logical.Sources.Constant con1[num](
    each final k=false) "False constant"
    annotation (Placement(transformation(extent={{40,60},{60,80}})));
  Buildings.Controls.OBC.CDL.Logical.LogicalSwitch logSwi2[num]
    "Logical switch"
    annotation (Placement(transformation(extent={{160,90},{180,110}})));
  Buildings.Controls.OBC.CDL.Logical.Or or2 "Logical or"
    annotation (Placement(transformation(extent={{40,90},{60,110}})));
  Buildings.Controls.OBC.CDL.Conversions.BooleanToReal booToRea1[num]
    "Convert boolean input to real output"
    annotation (Placement(transformation(extent={{-160,-70},{-140,-50}})));
  Buildings.Controls.OBC.CDL.Continuous.GreaterEqualThreshold greEquThr1(
    final threshold=0.5)
    "Convert real input to boolean output"
    annotation (Placement(transformation(extent={{-80,-70},{-60,-50}})));
  Buildings.Controls.OBC.CDL.Logical.And and4 "Logical and"
    annotation (Placement(transformation(extent={{20,-50},{40,-30}})));
  Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.Staging.Subsequences.EnableChiIsoVal disChiIsoVal(
    final num=num,
    final iniValPos=1,
    final endValPos=0) "Disable isolation valve of the chiller being disabled"
    annotation (Placement(transformation(extent={{100,-100},{120,-80}})));
  Buildings.Controls.OBC.CDL.Logical.Sources.Constant con2(
    final k=true) "True constant"
    annotation (Placement(transformation(extent={{-100,-120},{-80,-100}})));
  Buildings.Controls.OBC.CDL.Conversions.BooleanToReal booToRea2[num]
    "Convert boolean input to real output"
    annotation (Placement(transformation(extent={{-160,-160},{-140,-140}})));
  Buildings.Controls.OBC.CDL.Continuous.GreaterEqualThreshold greEquThr2(
    final threshold=0.5)
    "Convert real input to boolean output"
    annotation (Placement(transformation(extent={{-80,-160},{-60,-140}})));
  Buildings.Controls.OBC.CDL.Logical.And and5 "Logical and"
    annotation (Placement(transformation(extent={{-20,-160},{0,-140}})));
  Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.Staging.Subsequences.EnableHeadControl disHeaCon(
    final num=num,
    final heaStaCha=false)
    "Disable head pressure control of the chiller being disabled"
    annotation (Placement(transformation(extent={{80,-160},{100,-140}})));
  Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.MinimumFlowBypass.Subsequences.FlowSetpoint minBypSet(
    final num=num,
    final byPasSetTim=byPasSetTim,
    final minFloSet=minFloSet)
    annotation (Placement(transformation(extent={{80,-220},{100,-200}})));
  Buildings.Controls.OBC.CDL.Logical.Sources.Constant con3(final k=false)
    "False constant"
    annotation (Placement(transformation(extent={{-60,-210},{-40,-190}})));
  Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.Staging.Subsequences.ResetMinBypassSetpoint minBypSet1(
    final aftByPasSetTim=aftByPasSetTim,
    final minFloDif=minFloDif)
    "Check if minimum bypass flow has been resetted"
    annotation (Placement(transformation(extent={{80,-270},{100,-250}})));
  Buildings.Controls.OBC.CDL.Routing.IntegerReplicator intRep(final nout=num)
    "Replicate integer input"
    annotation (Placement(transformation(extent={{-160,260},{-140,280}})));
  Buildings.Controls.OBC.CDL.Integers.Equal intEqu[num]
    "Check next enabling isolation valve"
    annotation (Placement(transformation(extent={{-100,260},{-80,280}})));
  Buildings.Controls.OBC.CDL.Logical.Timer tim
    "Count the time after new chiller has been enabled"
    annotation (Placement(transformation(extent={{-100,30},{-80,50}})));
  Buildings.Controls.OBC.CDL.Discrete.TriggeredSampler triSam[num]
    "Record the old chiller chilled water isolation valve status"
    annotation (Placement(transformation(extent={{-20,140},{0,160}})));
  Buildings.Controls.OBC.CDL.Routing.BooleanReplicator booRep1(final nout=num)
    "Replicate boolean input"
    annotation (Placement(transformation(extent={{-60,120},{-40,140}})));
  Buildings.Controls.OBC.CDL.Logical.Edge edg
    "Rising edge, output true at the moment when input turns from false to true"
    annotation (Placement(transformation(extent={{-100,120},{-80,140}})));
  Buildings.Controls.OBC.CDL.Routing.IntegerReplicator intRep1(final nout=num)
    "Replicate integer input"
    annotation (Placement(transformation(extent={{-160,-10},{-140,10}})));
  Buildings.Controls.OBC.CDL.Integers.Equal intEqu1[num]
    "Check next enabling isolation valve"
    annotation (Placement(transformation(extent={{-100,-10},{-80,10}})));
  Buildings.Controls.OBC.CDL.Routing.BooleanReplicator booRep2(final nout=num)
    "Replicate boolean input"
    annotation (Placement(transformation(extent={{-20,30},{0,50}})));
  Buildings.Controls.OBC.CDL.Routing.BooleanReplicator booRep3(final nout=num)
    "Replicate boolean input"
    annotation (Placement(transformation(extent={{80,90},{100,110}})));
  Buildings.Controls.OBC.CDL.Logical.Not not2 "Logical not"
    annotation (Placement(transformation(extent={{-160,90},{-140,110}})));
  Buildings.Controls.OBC.CDL.Logical.Not not1 "Logical not"
    annotation (Placement(transformation(extent={{-20,70},{0,90}})));
  Buildings.Controls.OBC.CDL.Routing.RealExtractor  curDisChi(final nin=num)
    "Current disabling chiller"
    annotation (Placement(transformation(extent={{-120,-70},{-100,-50}})));
  Buildings.Controls.OBC.CDL.Routing.RealExtractor curDisChi1(final nin=num)
    "Current disabling chiller"
    annotation (Placement(transformation(extent={{-120,-160},{-100,-140}})));
  Buildings.Controls.OBC.CDL.Logical.LogicalSwitch logSwi3[num]
    "Logical switch"
    annotation (Placement(transformation(extent={{160,-140},{180,-120}})));
  Buildings.Controls.OBC.CDL.Routing.BooleanReplicator booRep4(final nout=num)
    "Replicate boolean input"
    annotation (Placement(transformation(extent={{-60,-30},{-40,-10}})));
  Buildings.Controls.OBC.CDL.Logical.Switch chiWatIso[num]
    "Chilled water isolation valve"
    annotation (Placement(transformation(extent={{160,-30},{180,-10}})));
  Buildings.Controls.OBC.CDL.Logical.LogicalSwitch logSwi4
    "Logical switch"
    annotation (Placement(transformation(extent={{160,-250},{180,-230}})));
  Buildings.Controls.OBC.CDL.Logical.Switch chiWatByp
    "Chilled water bypass flow setpoint"
    annotation (Placement(transformation(extent={{160,-200},{180,-180}})));
  Buildings.Controls.OBC.CDL.Logical.LogicalSwitch logSwi5 "Logical switch"
    annotation (Placement(transformation(extent={{160,-320},{180,-300}})));

equation
  connect(uNexEnaChi, intRep.u)
    annotation (Line(points={{-220,270},{-162,270}}, color={255,127,0}));
  connect(intRep.y, intEqu.u1)
    annotation (Line(points={{-139,270},{-102,270}}, color={255,127,0}));
  connect(uEnaChiWatIsoVal, and2.u2) annotation (Line(points={{-220,180},{-180,180},
          {-180,202},{-162,202}},      color={255,0,255}));
  connect(uStaUp, and2.u1)
    annotation (Line(points={{-220,210},{-162,210}}, color={255,0,255}));
  connect(and2.y, booRep.u)
    annotation (Line(points={{-139,210},{-102,210}}, color={255,0,255}));
  connect(intEqu.y, and1.u1)
    annotation (Line(points={{-79,270},{-42,270}},   color={255,0,255}));
  connect(booRep.y, and1.u2) annotation (Line(points={{-79,210},{-60,210},{-60,262},
          {-42,262}},            color={255,0,255}));
  connect(and1.y, logSwi.u2)
    annotation (Line(points={{-19,270},{98,270}}, color={255,0,255}));
  connect(con.y, logSwi.u1) annotation (Line(points={{-19,300},{0,300},{0,278},{
          98,278}},       color={255,0,255}));
  connect(tim.y, hys.u)
    annotation (Line(points={{-79,40},{-62,40}},   color={0,0,127}));
  connect(uChi, booToRea.u)
    annotation (Line(points={{-220,150},{-162,150}}, color={255,0,255}));
  connect(and2.y, edg.u) annotation (Line(points={{-139,210},{-120,210},{-120,130},
          {-102,130}},      color={255,0,255}));
  connect(booToRea.y, triSam.u)
    annotation (Line(points={{-139,150},{-22,150}},  color={0,0,127}));
  connect(edg.y, booRep1.u)
    annotation (Line(points={{-79,130},{-62,130}},   color={255,0,255}));
  connect(booRep1.y, triSam.trigger) annotation (Line(points={{-39,130},{-10,130},
          {-10,138.2}},      color={255,0,255}));
  connect(triSam.y, greEquThr.u)
    annotation (Line(points={{1,150},{18,150}},    color={0,0,127}));
  connect(greEquThr.y, logSwi.u3) annotation (Line(points={{41,150},{60,150},{60,
          262},{98,262}},      color={255,0,255}));
  connect(and2.y, tim.u) annotation (Line(points={{-139,210},{-120,210},{-120,40},
          {-102,40}},     color={255,0,255}));
  connect(uNexDisChi, intRep1.u)
    annotation (Line(points={{-220,0},{-162,0}},     color={255,127,0}));
  connect(intRep1.y, intEqu1.u1)
    annotation (Line(points={{-139,0},{-102,0}},     color={255,127,0}));
  connect(hys.y, booRep2.u)
    annotation (Line(points={{-39,40},{-22,40}},   color={255,0,255}));
  connect(booRep2.y, and3.u1)
    annotation (Line(points={{1,40},{38,40}},    color={255,0,255}));
  connect(intEqu1.y, and3.u2) annotation (Line(points={{-79,0},{20,0},{20,32},{38,
          32}},              color={255,0,255}));
  connect(and3.y, logSwi1.u2)
    annotation (Line(points={{61,40},{98,40}},  color={255,0,255}));
  connect(con1.y, logSwi1.u1) annotation (Line(points={{61,70},{80,70},{80,48},{
          98,48}}, color={255,0,255}));
  connect(uChi, logSwi1.u3) annotation (Line(points={{-220,150},{-180,150},{-180,
          20},{80,20},{80,32},{98,32}},    color={255,0,255}));
  connect(booRep3.y, logSwi2.u2)
    annotation (Line(points={{101,100},{158,100}}, color={255,0,255}));
  connect(uOnOff, not2.u)
    annotation (Line(points={{-220,100},{-162,100}}, color={255,0,255}));
  connect(logSwi1.y, logSwi2.u3) annotation (Line(points={{121,40},{140,40},{140,
          92},{158,92}},color={255,0,255}));
  connect(logSwi.y, logSwi2.u1)
    annotation (Line(points={{121,270},{140,270},{140,108},{158,108}},
      color={255,0,255}));
  connect(logSwi2.y, yChi)
    annotation (Line(points={{181,100},{210,100}}, color={255,0,255}));
  connect(not2.y, or2.u1)
    annotation (Line(points={{-139,100},{38,100}},color={255,0,255}));
  connect(hys.y, not1.u)
    annotation (Line(points={{-39,40},{-30,40},{-30,80},{-22,80}},
      color={255,0,255}));
  connect(not1.y, or2.u2)
    annotation (Line(points={{1,80},{20,80},{20,92},{38,92}}, color={255,0,255}));
  connect(or2.y, booRep3.u)
    annotation (Line(points={{61,100},{78,100}},color={255,0,255}));
  connect(booToRea1.y,curDisChi. u)
    annotation (Line(points={{-139,-60},{-122,-60}}, color={0,0,127}));
  connect(uChiWatReq, booToRea1.u)
    annotation (Line(points={{-220,-60},{-162,-60}}, color={255,0,255}));
  connect(curDisChi.y, greEquThr1.u)
    annotation (Line(points={{-99,-60},{-82,-60}},   color={0,0,127}));
  connect(hys.y, and4.u1)
    annotation (Line(points={{-39,40},{-30,40},{-30,-40},{18,-40}},
      color={255,0,255}));
  connect(greEquThr1.y, and4.u2)
    annotation (Line(points={{-59,-60},{0,-60},{0,-48},{18,-48}},
      color={255,0,255}));
  connect(uNexDisChi,disChiIsoVal. uNexChaChi)
    annotation (Line(points={{-220,0},{-180,0},{-180,-82},{98,-82}},
      color={255,127,0}));
  connect(uChiWatIsoVal,disChiIsoVal. uChiWatIsoVal)
    annotation (Line(points={{-220,-86},{98,-86}},    color={0,0,127}));
  connect(and4.y,disChiIsoVal. yUpsDevSta) annotation (Line(points={{41,-40},{60,
          -40},{60,-94},{98,-94}},         color={255,0,255}));
  connect(con2.y,disChiIsoVal. uStaCha) annotation (Line(points={{-79,-110},{20,
          -110},{20,-98},{98,-98}},         color={255,0,255}));
  connect(uConWatReq, booToRea2.u)
    annotation (Line(points={{-220,-150},{-162,-150}}, color={255,0,255}));
  connect(booToRea2.y, curDisChi1.u)
    annotation (Line(points={{-139,-150},{-122,-150}}, color={0,0,127}));
  connect(uNexDisChi, curDisChi1.index) annotation (Line(points={{-220,0},{-180,
          0},{-180,-170},{-110,-170},{-110,-162}},   color={255,127,0}));
  connect(curDisChi1.y, greEquThr2.u)
    annotation (Line(points={{-99,-150},{-82,-150}}, color={0,0,127}));
  connect(greEquThr2.y, and5.u1)
    annotation (Line(points={{-59,-150},{-22,-150}}, color={255,0,255}));
  connect(disChiIsoVal.yEnaChiWatIsoVal, and5.u2)
    annotation (Line(points={{121,-84},{160,-84},{160,-70},{-40,-70},{-40,-158},
      {-22,-158}}, color={255,0,255}));
  connect(con2.y, disHeaCon.uStaCha) annotation (Line(points={{-79,-110},{20,-110},
          {20,-146},{78,-146}}, color={255,0,255}));
  connect(and5.y, disHeaCon.uUpsDevSta) annotation (Line(points={{1,-150},{40,-150},
          {40,-142},{78,-142}}, color={255,0,255}));
  connect(uNexDisChi, disHeaCon.uNexChaChi)
    annotation (Line(points={{-220,0},{-180,0},{-180,-170},{40,-170},
      {40,-154},{78,-154}}, color={255,127,0}));
  connect(disHeaCon.uChiHeaCon, uChiHeaCon) annotation (Line(points={{78,-158},{
          60,-158},{60,-180},{-220,-180}}, color={255,0,255}));
  connect(uNexDisChi, curDisChi.index) annotation (Line(points={{-220,0},{-180,0},
          {-180,-82},{-110,-82},{-110,-72}},        color={255,127,0}));
  connect(con3.y, minBypSet.uStaUp) annotation (Line(points={{-39,-200},{20,-200},
          {20,-202},{78,-202}},  color={255,0,255}));
  connect(con3.y, minBypSet.uOnOff) annotation (Line(points={{-39,-200},{20,-200},
          {20,-214},{78,-214}},  color={255,0,255}));
  connect(con3.y, minBypSet.uStaDow) annotation (Line(points={{-39,-200},{20,-200},
          {20,-218},{78,-218}},  color={255,0,255}));
  connect(uSta, minBypSet.uSta)
    annotation (Line(points={{-220,-220},{-20,-220},{-20,-210},{78,-210}},
      color={255,127,0}));
  connect(disHeaCon.yEnaHeaCon, minBypSet.uUpsDevSta)
    annotation (Line(points={{101,-144},{120,-144},{120,-190},{40,-190},
      {40,-206},{78,-206}}, color={255,0,255}));
  connect(disHeaCon.yEnaHeaCon, minBypSet1.uUpsDevSta)
    annotation (Line(points={{101,-144},{120,-144},{120,-184},{40,-184},
      {40,-252},{78,-252}}, color={255,0,255}));
  connect(con2.y, minBypSet1.uStaCha) annotation (Line(points={{-79,-110},{20,-110},
          {20,-256},{78,-256}}, color={255,0,255}));
  connect(minBypSet.yChiWatBypSet, minBypSet1.VBypas_setpoint)
    annotation (Line(points={{101,-210},{120,-210},{120,-228},{60,-228},
      {60,-268},{78,-268}}, color={0,0,127}));
  connect(minBypSet1.VBypas_flow, VBypas_flow)
    annotation (Line(points={{78,-264},{-220,-264}}, color={0,0,127}));
  connect(not2.y, booRep4.u) annotation (Line(points={{-139,100},{-130,100},{-130,
          -20},{-62,-20}}, color={255,0,255}));
  connect(uChiHeaCon, logSwi3.u1) annotation (Line(points={{-220,-180},{130,-180},
          {130,-122},{158,-122}}, color={255,0,255}));
  connect(disHeaCon.yChiHeaCon, logSwi3.u3) annotation (Line(points={{101,-156},
          {140,-156},{140,-138},{158,-138}}, color={255,0,255}));
  connect(logSwi3.y, yChiHeaCon)
    annotation (Line(points={{181,-130},{210,-130}}, color={255,0,255}));
  connect(booRep4.y, logSwi3.u2) annotation (Line(points={{-39,-20},{50,-20},{50,
          -130},{158,-130}}, color={255,0,255}));
  connect(booRep4.y, chiWatIso.u2)
    annotation (Line(points={{-39,-20},{158,-20}}, color={255,0,255}));
  connect(uChiWatIsoVal, chiWatIso.u1) annotation (Line(points={{-220,-86},{80,-86},
          {80,-12},{158,-12}}, color={0,0,127}));
  connect(disChiIsoVal.yChiWatIsoVal, chiWatIso.u3) annotation (Line(points={{121,-90},
          {140,-90},{140,-28},{158,-28}},  color={0,0,127}));
  connect(chiWatIso.y, yChiWatIsoVal)
    annotation (Line(points={{181,-20},{210,-20}}, color={0,0,127}));
  connect(not2.y, logSwi4.u2) annotation (Line(points={{-139,100},{-130,100},{-130,
          -240},{158,-240}}, color={255,0,255}));
  connect(con2.y, logSwi4.u1) annotation (Line(points={{-79,-110},{20,-110},{20,
          -232},{158,-232}}, color={255,0,255}));
  connect(minBypSet1.yMinBypRes, logSwi4.u3) annotation (Line(points={{101,-260},
          {120,-260},{120,-248},{158,-248}}, color={255,0,255}));
  connect(logSwi4.y, yMinBypRes)
    annotation (Line(points={{181,-240},{210,-240}}, color={255,0,255}));
  connect(not2.y, chiWatByp.u2) annotation (Line(points={{-139,100},{-130,100},{
          -130,-190},{158,-190}}, color={255,0,255}));
  connect(minBypSet.yChiWatBypSet, chiWatByp.u3) annotation (Line(points={{101,-210},
          {120,-210},{120,-198},{158,-198}}, color={0,0,127}));
  connect(VBypas_flow, chiWatByp.u1) annotation (Line(points={{-220,-264},{40,-264},
          {40,-280},{140,-280},{140,-182},{158,-182}}, color={0,0,127}));
  connect(chiWatByp.y, yChiWatBypSet)
    annotation (Line(points={{181,-190},{210,-190}}, color={0,0,127}));
  connect(not2.y, logSwi5.u2) annotation (Line(points={{-139,100},{-130,100},{-130,
          -310},{158,-310}}, color={255,0,255}));
  connect(hys.y, logSwi5.u1) annotation (Line(points={{-39,40},{-30,40},{-30,-302},
          {158,-302}}, color={255,0,255}));
  connect(logSwi4.y, logSwi5.u3) annotation (Line(points={{181,-240},{190,-240},
          {190,-290},{140,-290},{140,-318},{158,-318}}, color={255,0,255}));
  connect(logSwi5.y, yEndSta)
    annotation (Line(points={{181,-310},{210,-310}}, color={255,0,255}));

annotation (
  defaultComponentName="enaNexChi",
  Diagram(coordinateSystem(preserveAspectRatio=false,
          extent={{-200,-320},{200,320}}), graphics={
          Rectangle(
          extent={{-198,318},{198,122}},
          fillColor={210,210,210},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
          Text(
          extent={{-4,162},{196,126}},
          pattern=LinePattern.None,
          fillColor={210,210,210},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,127},
          horizontalAlignment=TextAlignment.Right,
          textString="Check next chiller when 
there is no chiller needs 
to be disabled"),
          Rectangle(
          extent={{-198,118},{198,22}},
          fillColor={210,210,210},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
          Text(
          extent={{116,38},{194,30}},
          pattern=LinePattern.None,
          fillColor={210,210,210},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,127},
          horizontalAlignment=TextAlignment.Right,
          textString="Disable 
small chiller"),
          Rectangle(
          extent={{-198,-22},{198,-98}},
          fillColor={210,210,210},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
          Text(
          extent={{52,-48},{194,-56}},
          pattern=LinePattern.None,
          fillColor={210,210,210},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,127},
          horizontalAlignment=TextAlignment.Right,
          textString="Close chilled water 
isolation valve"),
          Rectangle(
          extent={{-198,-122},{198,-158}},
          fillColor={210,210,210},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
          Text(
          extent={{76,-144},{192,-152}},
          pattern=LinePattern.None,
          fillColor={210,210,210},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,127},
          horizontalAlignment=TextAlignment.Right,
          textString="Disable head
pressure control"),
          Rectangle(
          extent={{-198,-178},{198,-278}},
          fillColor={210,210,210},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
          Text(
          extent={{-182,-248},{-66,-256}},
          pattern=LinePattern.None,
          fillColor={210,210,210},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,127},
          horizontalAlignment=TextAlignment.Right,
          textString="Reset minimum 
bypass setpoint"),
          Rectangle(
          extent={{-198,-282},{198,-318}},
          fillColor={210,210,210},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
          Text(
          extent={{-168,-292},{-52,-300}},
          pattern=LinePattern.None,
          fillColor={210,210,210},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,127},
          horizontalAlignment=TextAlignment.Right,
          textString="End stage-up process")}),
    Icon(graphics={
        Rectangle(
        extent={{-100,-100},{100,100}},
        lineColor={0,0,127},
        fillColor={255,255,255},
        fillPattern=FillPattern.Solid),
        Text(
          extent={{-120,146},{100,108}},
          lineColor={0,0,255},
          textString="%name")}));
end EnableNextChiller;
