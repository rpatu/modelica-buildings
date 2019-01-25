within Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.Staging.Subsequences;
block DownProcess
  "Sequences to control equipments when chiller stage down"
  parameter Integer num = 2
    "Total number of chillers, the same number applied to isolation valves, CW pumps, CHW pumps";
  parameter Modelica.SIunits.Time chiStaTim = 240*3600
    "Threshold running time to switch lead and lag chiller";
  parameter Modelica.SIunits.ElectricCurrent lowChiCur = 0.05
    "Low limit to check if the chiller is running";
  parameter Modelica.SIunits.Time turOffChiWatIsoTim = 300
    "Time to close chilled water isolation valve";
  parameter Modelica.SIunits.Time byPasSetTim = 300
    "Time to change minimum flow setpoint from old one to new one";
  parameter Modelica.SIunits.VolumeFlowRate minFloSet[num] = {0.0089, 0.0177}
    "Minimum flow rate at each chiller stage";

  Buildings.Controls.OBC.CDL.Interfaces.BooleanInput uWSE
    "Water side economizer status: true = ON, false = OFF"
    annotation (Placement(transformation(extent={{-260,-200},{-220,-160}}),
      iconTransformation(extent={{-120,-20},{-100,0}})));
  Buildings.Controls.OBC.CDL.Interfaces.IntegerInput uChiSta
    "Current chiller stage"
    annotation (Placement(transformation(extent={{-260,360},{-220,400}}),
      iconTransformation(extent={{-10,-10},{10,10}}, rotation=0, origin={-110,90})));
  Buildings.Controls.OBC.CDL.Interfaces.RealInput uChiCur[num](
    final quantity="ElectricCurrent",
    final unit="A") "Chiller demand measured by electric current"
    annotation (Placement(transformation(extent={{-260,250},{-220,290}}),
      iconTransformation(extent={{-120,30},{-100,50}})));
  Buildings.Controls.OBC.CDL.Interfaces.BooleanInput uChi[num] "Chiller status"
     annotation (Placement(transformation(extent={{-260,310},{-220,350}}),
       iconTransformation(extent={{-120,50},{-100,70}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealInput uConWatIsoVal[num](
    final unit="1",
    final min=0,
    final max=1) "Condense water isolation valve position"
    annotation (Placement(transformation(extent={{-260,-110},{-220,-70}}),
      iconTransformation(extent={{-120,-50},{-100,-30}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealInput uChiWatIsoVal[num](
    final unit="1",
    final min=0,
    final max=1) "Chilled water isolation valve position"
    annotation (Placement(transformation(extent={{-260,40},{-220,80}}),
      iconTransformation(extent={{-120,0},{-100,20}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealInput uConWatPumSpe[num](
    final unit="1",
    final min=0,
    final max=1) "Condenser water pump speed"
    annotation (Placement(transformation(extent={{-260,-240},{-220,-200}}),
      iconTransformation(extent={{-120,-100},{-100,-80}})));
  Buildings.Controls.OBC.CDL.Interfaces.BooleanOutput yConWatIsoVal[num]
    "Condenser water isolation valve status"
    annotation (Placement(transformation(extent={{240,-30},{260,-10}}),
      iconTransformation(extent={{100,-30},{120,-10}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealOutput yChiWatIsoValSet[num](
    final min=0,
    final max=1,
    final unit="1") "Chilled water isolvation valve position setpoint"
    annotation (Placement(transformation(extent={{240,90},{260,110}}),
      iconTransformation(extent={{100,10},{120,30}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealOutput yMinFloSet(
    final unit="m3/s") "Minimum flow setpoint"
    annotation (Placement(transformation(extent={{240,-350},{260,-330}}),
      iconTransformation(extent={{100,-100},{120,-80}})));
  Buildings.Controls.OBC.CDL.Interfaces.BooleanOutput yChi[num]
    "Chiller status"
    annotation (Placement(transformation(extent={{240,330},{260,350}}),
      iconTransformation(extent={{100,60},{120,80}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealOutput yConWatPum[num]
    "Condenser water pump speed"
    annotation (Placement(transformation(extent={{240,-170},{260,-150}}),
        iconTransformation(extent={{100,20},{120,40}})));


  Buildings.Controls.OBC.CDL.Integers.Change cha
    "Check chiller stage change status"
    annotation (Placement(transformation(extent={{-160,370},{-140,390}})));
  Buildings.Controls.OBC.CDL.Continuous.Hysteresis hys[num](
    final uLow=lowChiCur,
    final uHigh=lowChiCur + 0.2) "Check if the chiller current becomes zero"
    annotation (Placement(transformation(extent={{-160,260},{-140,280}})));
  Buildings.Controls.OBC.CDL.Integers.Equal intEqu[num] "Check equality of integer inputs"
    annotation (Placement(transformation(extent={{-20,290},{0,310}})));
  Buildings.Controls.OBC.CDL.Logical.Timer tim
    annotation (Placement(transformation(extent={{-100,170},{-80,190}})));
  Buildings.Controls.OBC.CDL.Continuous.Line lin1
    "Minimum flow setpoint at current stage"
    annotation (Placement(transformation(extent={{40,170},{60,190}})));
  Buildings.Controls.OBC.CDL.Logical.Switch swi[num] "Logical switch"
    annotation (Placement(transformation(extent={{140,90},{160,110}})));
  Buildings.Controls.OBC.CDL.Routing.RealReplicator reaRep(final nout=num)
    "Replicate real input"
    annotation (Placement(transformation(extent={{80,170},{100,190}})));
  Buildings.Controls.OBC.CDL.Logical.And and5 "Logical and"
    annotation (Placement(transformation(extent={{100,310},{120,330}})));
  Buildings.Controls.OBC.CDL.Continuous.Hysteresis hys2[num](
    final uLow=0.05,
    final uHigh=0.1)
    "Check if isolation valve is not closed"
    annotation (Placement(transformation(extent={{-180,-100},{-160,-80}})));
  Buildings.Controls.OBC.CDL.Integers.Equal intEqu2[num]
    "Check equality of integer inputs"
    annotation (Placement(transformation(extent={{-20,-90},{0,-70}})));
  Buildings.Controls.OBC.CDL.Routing.RealExtractor curMinSet(final nin=num)
    "Targeted minimum flow setpoint at current stage"
    annotation (Placement(transformation(extent={{-110,-290},{-90,-270}})));
  Buildings.Controls.OBC.CDL.Routing.RealExtractor oldMinSet(
    final nin=num)
    "Minimum flow setpoint at old stage"
    annotation (Placement(transformation(extent={{-110,-390},{-90,-370}})));
  Buildings.Controls.OBC.CDL.Continuous.Line lin
    "Minimum flow setpoint at current stage"
    annotation (Placement(transformation(extent={{80,-380},{100,-360}})));
  Buildings.Controls.OBC.CDL.Logical.Timer tim1
    "Time after fully closed CW isolation valve"
    annotation (Placement(transformation(extent={{20,-270},{40,-250}})));
  Buildings.Controls.OBC.CDL.Integers.GreaterThreshold intGreThr(
    final threshold=0)
    "Check if it is not zero stage"
    annotation (Placement(transformation(extent={{140,-350},{160,-330}})));
  Buildings.Controls.OBC.CDL.Logical.Switch swi2
    "Switch to current stage setpoint"
    annotation (Placement(transformation(extent={{200,-350},{220,-330}})));
  Buildings.Controls.OBC.CDL.Continuous.Hysteresis hys4[num](
    final uLow=0.05,
    final uHigh=0.1)
    "Check if CWP equals to the setpoints"
    annotation (Placement(transformation(extent={{-80,-220},{-60,-200}})));
  Buildings.Controls.OBC.CDL.Integers.Add addInt
    "One stage lower than current one"
    annotation (Placement(transformation(extent={{-140,-420},{-120,-400}})));
  Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.Staging.Subsequences.ChillerRotation chiRot2(
    final chiNum=num,
    final stagingRuntime=chiStaTim) "Shut off the last stage chiller"
    annotation (Placement(transformation(extent={{-160,330},{-140,350}})));
  Buildings.Controls.OBC.CDL.Continuous.AddParameter addPar(p=1, k=1)
    annotation (Placement(transformation(extent={{-160,140},{-140,160}})));
  Buildings.Controls.OBC.CDL.Logical.Switch swi1 "Logical switch"
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
  Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.Staging.Subsequences.ChillerRotation chiIsoVal(
    final chiNum=num,
    final stagingRuntime=chiStaTim)
    "Chiller isolation valve position, it operates with the corresponded chiller"
    annotation (Placement(transformation(extent={{0,80},{20,100}})));
  Buildings.Controls.OBC.CDL.Logical.FallingEdge falEdg[num]
    "Check if there is any device changes from ON to OFF"
    annotation (Placement(transformation(extent={{40,80},{60,100}})));
  Buildings.Controls.OBC.CDL.Continuous.Hysteresis hys1(
    final uLow=turOffChiWatIsoTim - 5,
    final uHigh= turOffChiWatIsoTim + 5)
    "Check if chilled water isolation valve has been closed"
    annotation (Placement(transformation(extent={{-160,10},{-140,30}})));
  Buildings.Controls.OBC.CDL.Logical.Not not5 "Logical not"
    annotation (Placement(transformation(extent={{-60,370},{-40,390}})));
  Buildings.Controls.OBC.CDL.Logical.Or or4
    "Check if it is before stage change or all other changes have been made"
    annotation (Placement(transformation(extent={{-160,80},{-140,100}})));
  Buildings.Controls.OBC.CDL.Logical.Or or1
    "Check if it is before stage change or all other changes have been made"
    annotation (Placement(transformation(extent={{-160,-30},{-140,-10}})));
  Buildings.Controls.OBC.CDL.Logical.Switch swi3 "Logical switch"
    annotation (Placement(transformation(extent={{-100,-30},{-80,-10}})));
  Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.Staging.Subsequences.ChillerRotation conWatIsoValRot(
    final chiNum=num,
    final stagingRuntime=chiStaTim)
    "Condenser water isolation valve position, it operates with the corresponded chiller"
    annotation (Placement(transformation(extent={{0,-30},{20,-10}})));
  Buildings.Controls.OBC.CDL.Logical.Or or2
    "Check if it is before stage change or all other changes have been made"
    annotation (Placement(transformation(extent={{-160,-170},{-140,-150}})));
  Buildings.Controls.OBC.CDL.Logical.Switch swi4 "Logical switch"
    annotation (Placement(transformation(extent={{-100,-170},{-80,-150}})));
  Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.Pump.CondenserWater conWatPum(
    final pumNum=num)
    annotation (Placement(transformation(extent={{20,-170},{40,-150}})));
  Buildings.Controls.OBC.CDL.Continuous.Add add2[num](k1=-1)
    "Calculate the difference between setpoint and current values"
    annotation (Placement(transformation(extent={{-160,-220},{-140,-200}})));
  Buildings.Controls.OBC.CDL.Continuous.Abs abs[num] "Absolate value of input"
    annotation (Placement(transformation(extent={{-120,-220},{-100,-200}})));
  Buildings.Controls.OBC.CDL.Logical.Switch swi5
    "Switch to current stage setpoint"
    annotation (Placement(transformation(extent={{140,-310},{160,-290}})));

protected
  Buildings.Controls.OBC.Buildings.Controls.OBC.CDL.Integers.Sources.Constant conInt(
    final k=1)
    "Constant one"
    annotation (Placement(transformation(extent={{-200,-420},{-180,-400}})));
  Buildings.Controls.OBC.CDL.Continuous.Sources.Constant con(final k=0)
    "Zero constant"
    annotation (Placement(transformation(extent={{0,210},{20,230}})));
  Buildings.Controls.OBC.CDL.Continuous.Sources.Constant con1(final k=1)
    "Constant 1"
    annotation (Placement(transformation(extent={{-40,210},{-20,230}})));
  Buildings.Controls.OBC.CDL.Continuous.Sources.Constant con2(
    final k=turOffChiWatIsoTim)
    "Total time to turn off chiller water isolation valve"
    annotation (Placement(transformation(extent={{-40,130},{-20,150}})));
  Buildings.Controls.OBC.CDL.Continuous.Sources.Constant con3(
    final k=0) "Consant 0"
    annotation (Placement(transformation(extent={{0,130},{20,150}})));
  Buildings.Controls.OBC.CDL.Continuous.Sources.Constant con6[num](
    final k=minFloSet)
    "Minimum flow setpoint"
    annotation (Placement(transformation(extent={{-180,-290},{-160,-270}})));
  Buildings.Controls.OBC.CDL.Continuous.Sources.Constant con7(final k=0)
    "Constant zero"
    annotation (Placement(transformation(extent={{-60,-270},{-40,-250}})));
  Buildings.Controls.OBC.CDL.Continuous.Sources.Constant con8(
    final k=byPasSetTim)
    "Duration time to change old setpoint to new setpoint"
    annotation (Placement(transformation(extent={{-60,-420},{-40,-400}})));
  Buildings.Controls.OBC.CDL.Continuous.Sources.Constant con9(final k=0)
    "Zero minimal flow setpoint when it is zero stage"
    annotation (Placement(transformation(extent={{140,-390},{160,-370}})));
  Buildings.Controls.OBC.CDL.Logical.And and4
    "Check if chilled water isolation valve has been disabled"
    annotation (Placement(transformation(extent={{100,-90},{120,-70}})));
  Buildings.Controls.OBC.CDL.Logical.MultiAnd mulAnd(nu=num)
    "Check if the disabled chiller has been really disabled"
    annotation (Placement(transformation(extent={{20,290},{40,310}})));
  Buildings.Controls.OBC.CDL.Logical.MultiAnd mulAnd2(final nu=num)
    "Check if the disabled isolation valve has been really disabled"
    annotation (Placement(transformation(extent={{20,-90},{40,-70}})));
  Buildings.Controls.OBC.CDL.Logical.MultiAnd mulAnd3(final nu=2)
    "Check if the disabled chiller has been really disabled"
    annotation (Placement(transformation(extent={{-40,-220},{-20,-200}})));
  Buildings.Controls.OBC.CDL.Conversions.BooleanToInteger booToInt[num]
    "Convert boolean intput to integer"
    annotation (Placement(transformation(extent={{-80,290},{-60,310}})));
  Buildings.Controls.OBC.CDL.Conversions.BooleanToInteger booToInt1[num]
    "Convert boolean intput to integer"
    annotation (Placement(transformation(extent={{-80,260},{-60,280}})));
  Buildings.Controls.OBC.CDL.Conversions.BooleanToInteger booToInt4[num]
    "Convert boolean intput to integer"
    annotation (Placement(transformation(extent={{-80,-70},{-60,-50}})));
  Buildings.Controls.OBC.CDL.Conversions.BooleanToInteger booToInt5[num]
    "Convert boolean intput to integer"
    annotation (Placement(transformation(extent={{-80,-100},{-60,-80}})));
  Buildings.Controls.OBC.CDL.Conversions.IntegerToReal intToRea
    annotation (Placement(transformation(extent={{-160,200},{-140,220}})));
  Buildings.Controls.OBC.CDL.Conversions.RealToInteger reaToInt2
    annotation (Placement(transformation(extent={{-40,-170},{-20,-150}})));
  Buildings.Controls.OBC.CDL.Conversions.RealToInteger reaToInt
    annotation (Placement(transformation(extent={{-40,80},{-20,100}})));
  Buildings.Controls.OBC.CDL.Conversions.RealToInteger reaToInt1
    annotation (Placement(transformation(extent={{-40,-30},{-20,-10}})));

equation
  connect(uChiSta, cha.u)
    annotation (Line(points={{-240,380},{-162,380}}, color={255,127,0}));
  connect(uChiCur, hys.u)
    annotation (Line(points={{-240,270},{-162,270}}, color={0,0,127}));
  connect(hys.y, booToInt1.u)
    annotation (Line(points={{-139,270},{-82,270}},  color={255,0,255}));
  connect(booToInt1.y, intEqu.u2)
    annotation (Line(points={{-59,270},{-40,270},{-40,292},{-22,292}},
      color={255,127,0}));
  connect(booToInt.y, intEqu.u1)
    annotation (Line(points={{-59,300},{-22,300}}, color={255,127,0}));
  connect(intEqu.y, mulAnd.u)
    annotation (Line(points={{1,300},{18,300}}, color={255,0,255}));
  connect(con.y, lin1.x1)
    annotation (Line(points={{21,220},{30,220},{30,188},{38,188}},
      color={0,0,127}));
  connect(con1.y, lin1.f1)
    annotation (Line(points={{-19,220},{-10,220},{-10,184},{38,184}},
      color={0,0,127}));
  connect(tim.y, lin1.u)
    annotation (Line(points={{-79,180},{38,180}},   color={0,0,127}));
  connect(con2.y, lin1.x2)
    annotation (Line(points={{-19,140},{-10,140},{-10,176},{38,176}},
      color={0,0,127}));
  connect(con3.y, lin1.f2)
    annotation (Line(points={{21,140},{30,140},{30,172},{38,172}},
      color={0,0,127}));
  connect(lin1.y, reaRep.u)
    annotation (Line(points={{61,180},{78,180}},  color={0,0,127}));
  connect(cha.down, and5.u1)
    annotation (Line(points={{-139,374},{-80,374},{-80,320},{98,320}},
      color={255,0,255}));
  connect(mulAnd.y, and5.u2)
    annotation (Line(points={{41.7,300},{70,300},{70,312},{98,312}},
      color={255,0,255}));
  connect(and5.y, tim.u)
    annotation (Line(points={{121,320},{180,320},{180,250},{-180,250},{-180,180},
          {-102,180}},       color={255,0,255}));
  connect(uConWatIsoVal, hys2.u)
    annotation (Line(points={{-240,-90},{-182,-90}},   color={0,0,127}));
  connect(hys2.y, booToInt5.u)
    annotation (Line(points={{-159,-90},{-82,-90}},   color={255,0,255}));
  connect(booToInt4.y, intEqu2.u1)
    annotation (Line(points={{-59,-60},{-40,-60},{-40,-80},{-22,-80}},
      color={255,127,0}));
  connect(booToInt5.y, intEqu2.u2)
    annotation (Line(points={{-59,-90},{-40,-90},{-40,-88},{-22,-88}},
      color={255,127,0}));
  connect(intEqu2.y, mulAnd2.u)
    annotation (Line(points={{1,-80},{18,-80}},   color={255,0,255}));
  connect(mulAnd2.y, and4.u2)
    annotation (Line(points={{41.7,-80},{60,-80},{60,-88},{98,-88}},
      color={255,0,255}));
  connect(con6.y,curMinSet. u)
    annotation (Line(points={{-159,-280},{-112,-280}}, color={0,0,127}));
  connect(conInt.y,addInt. u2)
    annotation (Line(points={{-179,-410},{-160,-410},{-160,-416},{-142,-416}},
      color={255,127,0}));
  connect(con6.y,oldMinSet. u)
    annotation (Line(points={{-159,-280},{-140,-280},{-140,-380},{-112,-380}},
      color={0,0,127}));
  connect(con7.y,lin. x1)
    annotation (Line(points={{-39,-260},{-20,-260},{-20,-362},{78,-362}},
      color={0,0,127}));
  connect(con8.y,lin. x2)
    annotation (Line(points={{-39,-410},{60,-410},{60,-374},{78,-374}},
      color={0,0,127}));
  connect(tim1.y, lin.u)
    annotation (Line(points={{41,-260},{60,-260},{60,-370},{78,-370}},
                             color={0,0,127}));
  connect(oldMinSet.y,lin. f1)
    annotation (Line(points={{-89,-380},{-20,-380},{-20,-366},{78,-366}},
      color={0,0,127}));
  connect(addInt.y,oldMinSet. index)
    annotation (Line(points={{-119,-410},{-100,-410},{-100,-392}},
      color={255,127,0}));
  connect(curMinSet.y,lin. f2)
    annotation (Line(points={{-89,-280},{0,-280},{0,-378},{78,-378}},
                             color={0,0,127}));
  connect(uChiSta, addInt.u1)
    annotation (Line(points={{-240,380},{-200,380},{-200,-340},{-160,-340},{-160,
          -404},{-142,-404}},   color={255,127,0}));
  connect(uChiSta, curMinSet.index)
    annotation (Line(points={{-240,380},{-200,380},{-200,-340},{-100,-340},{-100,
          -292}},  color={255,127,0}));

  connect(uChiSta, chiRot2.uChiSta) annotation (Line(points={{-240,380},{-200,380},
          {-200,340},{-162,340}}, color={255,127,0}));
  connect(chiRot2.yChiOpeSta, yChi)
    annotation (Line(points={{-139,340},{250,340}}, color={255,0,255}));
  connect(chiRot2.yChiOpeSta, booToInt.u) annotation (Line(points={{-139,340},{-100,
          340},{-100,300},{-82,300}}, color={255,0,255}));
  connect(uChiSta, intToRea.u) annotation (Line(points={{-240,380},{-200,380},{-200,
          210},{-162,210}}, color={255,127,0}));
  connect(addPar.y, swi1.u3) annotation (Line(points={{-139,150},{-124,150},{-124,
          82},{-102,82}}, color={0,0,127}));
  connect(swi1.y, reaToInt.u)
    annotation (Line(points={{-79,90},{-42,90}}, color={0,0,127}));
  connect(reaToInt.y, chiIsoVal.uChiSta)
    annotation (Line(points={{-19,90},{-2,90}}, color={255,127,0}));
  connect(chiIsoVal.yChiOpeSta, falEdg.u)
    annotation (Line(points={{21,90},{38,90}}, color={255,0,255}));
  connect(falEdg.y, swi.u2) annotation (Line(points={{61,90},{80,90},{80,100},{138,
          100}}, color={255,0,255}));
  connect(uChiWatIsoVal, swi.u3) annotation (Line(points={{-240,60},{120,60},{120,
          92},{138,92}}, color={0,0,127}));
  connect(reaRep.y, swi.u1) annotation (Line(points={{101,180},{120,180},{120,108},
          {138,108}}, color={0,0,127}));
  connect(swi.y, yChiWatIsoValSet)
    annotation (Line(points={{161,100},{250,100}}, color={0,0,127}));
  connect(tim.y, hys1.u) annotation (Line(points={{-79,180},{-60,180},{-60,40},{
          -180,40},{-180,20},{-162,20}}, color={0,0,127}));
  connect(cha.y, not5.u)
    annotation (Line(points={{-139,380},{-62,380}}, color={255,0,255}));
  connect(and5.y, or4.u1) annotation (Line(points={{121,320},{180,320},{180,250},
          {-180,250},{-180,90},{-162,90}}, color={255,0,255}));
  connect(or4.y, swi1.u2)
    annotation (Line(points={{-139,90},{-102,90}}, color={255,0,255}));
  connect(not5.y, or4.u2) annotation (Line(points={{-39,380},{-20,380},{-20,400},
          {-210,400},{-210,82},{-162,82}}, color={255,0,255}));
  connect(hys1.y, or1.u1) annotation (Line(points={{-139,20},{-100,20},{-100,0},
          {-180,0},{-180,-20},{-162,-20}}, color={255,0,255}));
  connect(not5.y, or1.u2) annotation (Line(points={{-39,380},{-20,380},{-20,400},
          {-210,400},{-210,-28},{-162,-28}}, color={255,0,255}));
  connect(or1.y, swi3.u2)
    annotation (Line(points={{-139,-20},{-102,-20}}, color={255,0,255}));
  connect(intToRea.y, addPar.u) annotation (Line(points={{-139,210},{-120,210},{
          -120,190},{-170,190},{-170,150},{-162,150}}, color={0,0,127}));
  connect(intToRea.y, swi1.u1) annotation (Line(points={{-139,210},{-120,210},{-120,
          98},{-102,98}}, color={0,0,127}));
  connect(intToRea.y, swi3.u1) annotation (Line(points={{-139,210},{-120,210},{-120,
          -12},{-102,-12}}, color={0,0,127}));
  connect(addPar.y, swi3.u3) annotation (Line(points={{-139,150},{-124,150},{-124,
          -28},{-102,-28}}, color={0,0,127}));
  connect(swi3.y, reaToInt1.u)
    annotation (Line(points={{-79,-20},{-42,-20}}, color={0,0,127}));
  connect(reaToInt1.y, conWatIsoValRot.uChiSta)
    annotation (Line(points={{-19,-20},{-2,-20}}, color={255,127,0}));
  connect(conWatIsoValRot.yChiOpeSta, yConWatIsoVal)
    annotation (Line(points={{21,-20},{250,-20}}, color={255,0,255}));
  connect(conWatIsoValRot.yChiOpeSta, booToInt4.u) annotation (Line(points={{21,
          -20},{40,-20},{40,-40},{-100,-40},{-100,-60},{-82,-60}}, color={255,0,
          255}));
  connect(hys1.y, and4.u1) annotation (Line(points={{-139,20},{80,20},{80,-80},{
          98,-80}}, color={255,0,255}));
  connect(and4.y, or2.u1) annotation (Line(points={{121,-80},{140,-80},{140,-130},
          {-180,-130},{-180,-160},{-162,-160}}, color={255,0,255}));
  connect(or2.y, swi4.u2)
    annotation (Line(points={{-139,-160},{-102,-160}}, color={255,0,255}));
  connect(intToRea.y, swi4.u1) annotation (Line(points={{-139,210},{-120,210},{-120,
          -152},{-102,-152}}, color={0,0,127}));
  connect(addPar.y, swi4.u3) annotation (Line(points={{-139,150},{-124,150},{-124,
          -168},{-102,-168}}, color={0,0,127}));
  connect(swi4.y, reaToInt2.u)
    annotation (Line(points={{-79,-160},{-42,-160}}, color={0,0,127}));
  connect(reaToInt2.y, conWatPum.uChiSta) annotation (Line(points={{-19,-160},{0,
          -160},{0,-156},{18,-156}}, color={255,127,0}));
  connect(uWSE, conWatPum.uWSE) annotation (Line(points={{-240,-180},{0,-180},{0,
          -164},{18,-164}}, color={255,0,255}));
  connect(conWatPum.yConWatPum, yConWatPum)
    annotation (Line(points={{41,-160},{250,-160}}, color={0,0,127}));
  connect(conWatPum.yConWatPum, add2.u1) annotation (Line(points={{41,-160},{60,
          -160},{60,-186},{-180,-186},{-180,-204},{-162,-204}}, color={0,0,127}));
  connect(uConWatPumSpe, add2.u2) annotation (Line(points={{-240,-220},{-180,-220},
          {-180,-216},{-162,-216}}, color={0,0,127}));
  connect(add2.y, abs.u)
    annotation (Line(points={{-139,-210},{-122,-210}}, color={0,0,127}));
  connect(abs.y, hys4.u)
    annotation (Line(points={{-99,-210},{-82,-210}}, color={0,0,127}));
  connect(hys4.y, mulAnd3.u[1:2]) annotation (Line(points={{-59,-210},{-50,-210},
          {-50,-213.5},{-42,-213.5}}, color={255,0,255}));
  connect(not5.y, or2.u2) annotation (Line(points={{-39,380},{-20,380},{-20,400},
          {-210,400},{-210,-168},{-162,-168}}, color={255,0,255}));
  connect(mulAnd3.y, tim1.u) annotation (Line(points={{-18.3,-210},{0,-210},{0,-260},
          {18,-260}}, color={255,0,255}));
  connect(not5.y, swi5.u2) annotation (Line(points={{-39,380},{-20,380},{-20,400},
          {-210,400},{-210,-300},{138,-300}}, color={255,0,255}));
  connect(curMinSet.y, swi5.u1) annotation (Line(points={{-89,-280},{0,-280},{0,
          -292},{138,-292}}, color={0,0,127}));
  connect(lin.y, swi5.u3) annotation (Line(points={{101,-370},{120,-370},{120,-308},
          {138,-308}}, color={0,0,127}));
  connect(uChiSta, intGreThr.u) annotation (Line(points={{-240,380},{-200,380},{
          -200,-340},{138,-340}}, color={255,127,0}));
  connect(intGreThr.y, swi2.u2)
    annotation (Line(points={{161,-340},{198,-340}}, color={255,0,255}));
  connect(con9.y, swi2.u3) annotation (Line(points={{161,-380},{180,-380},{180,-348},
          {198,-348}}, color={0,0,127}));
  connect(swi5.y, swi2.u1) annotation (Line(points={{161,-300},{180,-300},{180,-332},
          {198,-332}}, color={0,0,127}));
  connect(swi2.y, yMinFloSet)
    annotation (Line(points={{221,-340},{250,-340}}, color={0,0,127}));
annotation (
  defaultComponentName = "staDow",
  Diagram(coordinateSystem(preserveAspectRatio=false,
    extent={{-220,-440},{240,440}}), graphics={
                                             Rectangle(
          extent={{-218,-2},{238,-118}},
          fillColor={210,210,210},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),         Rectangle(
          extent={{-218,-142},{238,-218}},
          fillColor={210,210,210},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),         Rectangle(
          extent={{-218,418},{238,262}},
          fillColor={210,210,210},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),         Rectangle(
          extent={{-218,-242},{238,-418}},
          fillColor={210,210,210},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
          Text(
          extent={{82,-242},{230,-280}},
          pattern=LinePattern.None,
          fillColor={210,210,210},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,127},
          horizontalAlignment=TextAlignment.Right,
          textString="Slowly change minimum 
flow rate setpoint"),
          Text(
          extent={{78,-140},{228,-176}},
          pattern=LinePattern.None,
          fillColor={210,210,210},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,127},
          horizontalAlignment=TextAlignment.Right,
          textString="Shut off last stage condenser 
water pump"),
          Text(
          extent={{136,-30},{234,-58}},
          pattern=LinePattern.None,
          fillColor={210,210,210},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,127},
          horizontalAlignment=TextAlignment.Right,
          textString="Dsiable CW isolation valve"),
                                             Rectangle(
          extent={{-218,238},{238,42}},
          fillColor={210,210,210},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
          Text(
          extent={{64,232},{228,186}},
          pattern=LinePattern.None,
          fillColor={210,210,210},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,127},
          horizontalAlignment=TextAlignment.Right,
          textString="Close isolation valve
of the closed chiller"),
          Text(
          extent={{110,414},{222,382}},
          pattern=LinePattern.None,
          fillColor={210,210,210},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,127},
          horizontalAlignment=TextAlignment.Right,
          textString="Shut off last stage chiller")}),
    Icon(graphics={
        Rectangle(
        extent={{-100,-100},{100,100}},
        lineColor={0,0,127},
        fillColor={255,255,255},
        fillPattern=FillPattern.Solid),
        Text(
          extent={{-120,146},{100,108}},
          lineColor={0,0,255},
          textString="%name"),
        Text(
          extent={{-96,66},{-74,56}},
          lineColor={0,0,127},
          pattern=LinePattern.Dash,
          textString="uChi"),
        Text(
          extent={{-96,-82},{-30,-96}},
          lineColor={0,0,127},
          pattern=LinePattern.Dash,
          textString="uConWatPumSpe"),
        Text(
          extent={{-96,48},{-66,36}},
          lineColor={0,0,127},
          pattern=LinePattern.Dash,
          textString="uChiCur"),
        Text(
          extent={{-96,-12},{-28,-26}},
          lineColor={0,0,127},
          pattern=LinePattern.Dash,
          textString="uConWatIsoValSta"),
        Text(
          extent={{-96,18},{-34,8}},
          lineColor={0,0,127},
          pattern=LinePattern.Dash,
          textString="uChiWatIsoVal"),
        Text(
          extent={{74,74},{102,64}},
          lineColor={0,0,127},
          pattern=LinePattern.Dash,
          textString="yChi"),
        Text(
          extent={{-16,4.5},{16,-4.5}},
          lineColor={0,0,127},
          pattern=LinePattern.Dash,
          textString="uChiSta",
          origin={-82,92.5},
          rotation=0),
        Text(
          extent={{44,-52},{96,-66}},
          lineColor={0,0,127},
          pattern=LinePattern.Dash,
          textString="yConWatPum"),
        Text(
          extent={{40,-12},{98,-26}},
          lineColor={0,0,127},
          pattern=LinePattern.Dash,
          textString="yConWatIsoVal"),
        Text(
          extent={{26,26},{96,12}},
          lineColor={0,0,127},
          pattern=LinePattern.Dash,
          textString="yChiWatIsoValSet"),
        Text(
          extent={{56,-84},{98,-96}},
          lineColor={0,0,127},
          pattern=LinePattern.Dash,
          textString="yMinFloSet"),
        Text(
          extent={{-96,-62},{-46,-76}},
          lineColor={0,0,127},
          pattern=LinePattern.Dash,
          textString="uConWatPum"),
        Text(
          extent={{-96,-32},{-36,-42}},
          lineColor={0,0,127},
          pattern=LinePattern.Dash,
          textString="uConWatIsoVal")}),
Documentation(info="<html>
<p>
Block that generates signals to control devices when there is chiller plant 
stage-down command, according to ASHRAE Fundamentals of Chilled Water Plant 
Design and Control SDL, Chapter 7, Appendix B, 1.01.B.5.
</p>
<p>Whenever there is a stage-down command (<code>uChiSta</code> decrease):</p>
<p>
a. Shut off last stage chiller
</p>

<p>
b. When the controller of the chiller being shut off (<code>uChiCur</code> 
becoms less than <code>lowChiCur</code>) indicates no request for 
chilled water flow, slowly close the chiller's chilled water isolation valve
to avoid sudden change in flow through other operating chiller. For example, 
this could be accomplished by closing the valve in <code>turOffChiWatIsoTim</code>.
</p>

<p>
c. Disable condenser water isolation valve and when it is fully closed, shut
off last stage condenser water pump.
</p>

<p>
d. Change the minimum by pass controller setpoint to that appropriate for the
stage. For example, this could be accomplished by resetting the setpoint 
X GPM/second, where X = (NewSetpoint - OldSetpoint) / <code>byPasSetTim</code>. 
The minimum flow rate are as follows (based on manufactures' minimum flow rate 
plus 10% to ensure control variations
do not cause flow to go below actual minimum):
</p>
<table summary=\"summary\" border=\"1\">
<tr>
<th> Chiller stage </th> 
<th> Minimum flow </th>  
</tr>
<tr>
<td align=\"center\">0</td>
<td align=\"center\">0</td>
</tr>
<tr>
<td align=\"center\">1</td>
<td align=\"center\"><code>minFloSet</code>[1]</td>
</tr>
<tr>
<td align=\"center\">2</td>
<td align=\"center\"><code>minFloSet</code>[2]</td>
</tr>
<tr>
<td align=\"center\">...</td>
<td align=\"center\">...</td>
</tr>
</table>
<br/>

</html>",
revisions="<html>
<ul>
<li>
August 18, 2018, by Jianjun Hu:<br/>
First implementation.
</li>
</ul>
</html>"));
end DownProcess;
