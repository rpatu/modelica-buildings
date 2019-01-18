within Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.Staging.Generic;
block UpProcess
  "Sequences to control equipments when chiller stage up"
  parameter Integer num = 2
    "Total number of chillers, the same number applied to isolation valves, CW pumps, CHW pumps";
  parameter Real chiDemRedFac(final min=0, final max=0) = 0.75
    "Factor of current chiller demand when there is a stage-up command";
  parameter Modelica.SIunits.Time holChiDemTim = 300
    "Time to hold limited chiller demand";
  parameter Modelica.SIunits.Time byPasSetTim = 300
    "Time to change minimum flow setpoint from old one to new one";
  parameter Modelica.SIunits.VolumeFlowRate minFloSet[num] = {0.0089, 0.0177}
    "Minimum flow rate at each chiller stage";
  parameter Modelica.SIunits.Time turOnChiWatIsoTim = 300
    "Time to open a new chilled water isolation valve";

  Buildings.Controls.OBC.CDL.Interfaces.IntegerInput uChiSta
    "Current chiller stage"
    annotation (Placement(transformation(extent={{-280,400},{-240,440}}),
      iconTransformation(extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-110,90})));
  Buildings.Controls.OBC.CDL.Interfaces.RealInput uChiCur[num](
    final quantity="ElectricCurrent",
    final unit="A") "Chiller demand measured by electric current"
    annotation (Placement(transformation(extent={{-280,340},{-240,380}}),
      iconTransformation(extent={{-120,50},{-100,70}})));
  Buildings.Controls.OBC.CDL.Interfaces.BooleanInput uChi[num]
    "Chiller status"
     annotation (Placement(transformation(extent={{-280,300},{-240,340}}),
       iconTransformation(extent={{-120,20},{-100,40}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealInput uConWatIsoVal[num](
    final unit="1",
    final min=0,
    final max=1) "Condense water isolation valve position"
    annotation (Placement(transformation(extent={{-280,-78},{-240,-38}}),
      iconTransformation(extent={{-120,-60},{-100,-40}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealInput uChiWatIsoVal[num](
    final unit="1",
    final min=0,
    final max=1) "Chilled water isolation valve position"
    annotation (Placement(transformation(extent={{-280,-340},{-240,-300}}),
      iconTransformation(extent={{-120,-100},{-100,-80}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealOutput yChiCur[num](
    final quantity="ElectricCurrent",
    final unit="A") "Current setpoint to chillers"
    annotation (Placement(transformation(extent={{220,370},{240,390}}),
      iconTransformation(extent={{100,80},{120,100}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealOutput yMinFloSet(
    final unit="m3/s") "Minimum flow setpoint"
    annotation (Placement(transformation(extent={{220,170},{240,190}}),
      iconTransformation(extent={{100,50},{120,70}})));
  CDL.Interfaces.RealOutput                           yConWatPum[num]
    "Condenser water pump speed"
    annotation (Placement(transformation(extent={{220,60},{240,80}}),
      iconTransformation(extent={{100,20},{120,40}})));
  Buildings.Controls.OBC.CDL.Interfaces.BooleanOutput yConWatIsoVal[num]
    "Condenser water isolation valve status"
    annotation (Placement(transformation(extent={{220,-10},{240,10}}),
      iconTransformation(extent={{100,-20},{120,0}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealOutput yChiWatIsoValSet[num](
    final min=0,
    final max=1,
    final unit="1") "Chilled water isolvation valve position setpoint"
    annotation (Placement(transformation(extent={{220,-260},{240,-240}}),
      iconTransformation(extent={{100,-60},{120,-40}})));

  Buildings.Controls.OBC.CDL.Discrete.TriggeredSampler triSam[num]
    "Triggered sampler to sample current chiller demand"
    annotation (Placement(transformation(extent={{-160,350},{-140,370}})));
  Buildings.Controls.OBC.CDL.Routing.BooleanReplicator booRep1(
    final nout=num) "Replicate input "
    annotation (Placement(transformation(extent={{-120,430},{-100,450}})));
  Buildings.Controls.OBC.CDL.Continuous.Gain gai[num](each final k=chiDemRedFac)
    "Reduce demand to a factor of current load"
    annotation (Placement(transformation(extent={{-80,350},{-60,370}})));
  Buildings.Controls.OBC.CDL.Continuous.Hysteresis hys[num](each final uLow=
        chiDemRedFac + 0.5 - 0.1, each final uHigh=chiDemRedFac + 0.5 + 0.1)
    "Check if actual demand has already reduced at instant when receiving stage change signal"
    annotation (Placement(transformation(extent={{-40,280},{-20,300}})));
  Buildings.Controls.OBC.CDL.Continuous.Division div[num]
    "Output result of first input divided by second input"
    annotation (Placement(transformation(extent={{20,320},{40,340}})));
  Buildings.Controls.OBC.CDL.Continuous.Sources.Constant con[num](
    each final k=0.2)
    "Constant value to avoid zero as the denominator"
    annotation (Placement(transformation(extent={{-160,280},{-140,300}})));
  Buildings.Controls.OBC.CDL.Logical.Switch swi[num]
    "Change zero input to a given constant if the chiller is not enabled"
    annotation (Placement(transformation(extent={{-100,310},{-80,330}})));
  Buildings.Controls.OBC.CDL.Logical.Not not1[num] "Logical not"
    annotation (Placement(transformation(extent={{0,280},{20,300}})));
  Buildings.Controls.OBC.CDL.Logical.TrueDelay truDel(
    final delayTime=holChiDemTim) "Wait a giving time before proceeding"
    annotation (Placement(transformation(extent={{80,280},{100,300}})));
  Buildings.Controls.OBC.CDL.Logical.MultiAnd mulAnd(final nu=num)
    "Output true when elements of input vector are true"
    annotation (Placement(transformation(extent={{40,280},{60,300}})));
  Buildings.Controls.OBC.CDL.Integers.Change cha
    "Check chiller stage change status"
    annotation (Placement(transformation(extent={{-180,410},{-160,430}})));
  Buildings.Controls.OBC.CDL.Routing.RealExtractor curMinSet(nin=num)
    "Targeted minimum flow setpoint at current stage"
    annotation (Placement(transformation(extent={{-120,210},{-100,230}})));
  Buildings.Controls.OBC.CDL.Continuous.Sources.Constant con1[num](
    final k=minFloSet)
    "Minimum flow setpoint"
    annotation (Placement(transformation(extent={{-180,210},{-160,230}})));
  Buildings.Controls.OBC.CDL.Integers.Add addInt(final k2=-1)
    "One stage lower than current one"
    annotation (Placement(transformation(extent={{-160,140},{-140,160}})));
  Buildings.Controls.OBC.CDL.Integers.Sources.Constant conInt(final k=1)
    "Constant one"
    annotation (Placement(transformation(extent={{-200,140},{-180,160}})));
  Buildings.Controls.OBC.CDL.Routing.RealExtractor oldMinSet(final nin=num)
    "Minimum flow setpoint at old stage"
    annotation (Placement(transformation(extent={{-120,160},{-100,180}})));
  Buildings.Controls.OBC.CDL.Continuous.Line lin
    "Minimum flow setpoint at current stage"
    annotation (Placement(transformation(extent={{-20,160},{0,180}})));
  Buildings.Controls.OBC.CDL.Continuous.Sources.Constant con2(final k=0)
    "Constant zero"
    annotation (Placement(transformation(extent={{-80,210},{-60,230}})));
  Buildings.Controls.OBC.CDL.Continuous.Sources.Constant con3(
    final k=byPasSetTim)
    "Duration time to change old setpoint to new setpoint"
    annotation (Placement(transformation(extent={{-80,140},{-60,160}})));
  Buildings.Controls.OBC.CDL.Logical.Timer tim
    "Time after suppress chiller demand"
    annotation (Placement(transformation(extent={{-20,210},{0,230}})));
  Buildings.Controls.OBC.CDL.Continuous.Hysteresis hys2(
    final uLow=byPasSetTim + 60 - 5,
    final uHigh=byPasSetTim + 60 + 5)
    "Check if it is 1 minute after new setpoint achieved"
    annotation (Placement(transformation(extent={{60,140},{80,160}})));
  Buildings.Controls.OBC.CDL.Integers.LessThreshold intLesThr(
    final threshold=1)
    "Check if it is zero stage"
    annotation (Placement(transformation(extent={{40,180},{60,200}})));
  Buildings.Controls.OBC.CDL.Logical.Switch swi1
    "Switch to current stage setpoint"
    annotation (Placement(transformation(extent={{100,170},{120,190}})));
  Buildings.Controls.OBC.CDL.Continuous.Sources.Constant con4(final k=0)
    "Zero minimal flow setpoint when it is zero stage"
    annotation (Placement(transformation(extent={{40,210},{60,230}})));
  Buildings.Controls.OBC.CDL.Continuous.Hysteresis hys1[num](
    each final uLow=0.095,
    each final uHigh=0.105)
    "Check if the enabled isolation valve is open more than 10%"
    annotation (Placement(transformation(extent={{-200,-68},{-180,-48}})));
  Buildings.Controls.OBC.CDL.Logical.LogicalSwitch logSwi7[num] "Logical switch"
    annotation (Placement(transformation(extent={{-120,-68},{-100,-48}})));
  Buildings.Controls.OBC.CDL.Logical.Sources.Constant con16[num](
    each final k=true) "Constant true"
    annotation (Placement(transformation(extent={{-200,-98},{-180,-78}})));
  Buildings.Controls.OBC.CDL.Logical.MultiAnd mulAnd3(final nu=num)
    annotation (Placement(transformation(extent={{-60,-68},{-40,-48}})));
  Buildings.Controls.OBC.CDL.Logical.TrueDelay truDel1(final delayTime=30)
    "Wait a giving time before proceeding"
    annotation (Placement(transformation(extent={{-20,-68},{0,-48}})));
  Buildings.Controls.OBC.CDL.Logical.Timer tim1
    "Time after starting CW pump and enabling CW isolation valve"
    annotation (Placement(transformation(extent={{-80,-190},{-60,-170}})));
  Buildings.Controls.OBC.CDL.Continuous.Line lin1
    "Chilled water isolation valve setpoint"
    annotation (Placement(transformation(extent={{20,-190},{40,-170}})));
  Buildings.Controls.OBC.CDL.Continuous.Sources.Constant con6(final k=0)
    "Constant zero"
    annotation (Placement(transformation(extent={{-80,-160},{-60,-140}})));
  Buildings.Controls.OBC.CDL.Continuous.Sources.Constant con7(
    final k=turOnChiWatIsoTim)
    "Time to turn on chilled water isolation valve"
    annotation (Placement(transformation(extent={{-80,-220},{-60,-200}})));
  Buildings.Controls.OBC.CDL.Continuous.Sources.Constant con8(final k=1)
    "Constant 1"
    annotation (Placement(transformation(extent={{-20,-220},{0,-200}})));
  Buildings.Controls.OBC.CDL.Continuous.Sources.Constant con9(final k=0)
    "Constant zero"
    annotation (Placement(transformation(extent={{-20,-160},{0,-140}})));
  Buildings.Controls.OBC.CDL.Logical.Switch swi2[num]
    "Position setpoint of chilled water isolation valve"
    annotation (Placement(transformation(extent={{160,-260},{180,-240}})));
  Buildings.Controls.OBC.CDL.Routing.RealReplicator reaRep(nout=num)
    "Replicate real input"
    annotation (Placement(transformation(extent={{60,-190},{80,-170}})));
  Buildings.Controls.OBC.CDL.Continuous.Hysteresis hys3[num](
    each final uLow=0.025,
    each final uHigh=0.05)
    "Check if isolation valve is enabled"
    annotation (Placement(transformation(extent={{-200,-330},{-180,-310}})));
  Buildings.Controls.OBC.CDL.Continuous.Hysteresis hys4[num](
    each final uLow=0.925,
    each final uHigh=0.975)
    "Check if isolation valve is open more than 95%"
    annotation (Placement(transformation(extent={{-200,-390},{-180,-370}})));
  Buildings.Controls.OBC.CDL.Logical.And and3[num] "Logical and"
    annotation (Placement(transformation(extent={{-60,-330},{-40,-310}})));
  Buildings.Controls.OBC.CDL.Logical.Not not3[num] "Logical not"
    annotation (Placement(transformation(extent={{-120,-360},{-100,-340}})));
  Buildings.Controls.OBC.CDL.Logical.Not not4[num] "Logical not"
    annotation (Placement(transformation(extent={{-120,-390},{-100,-370}})));
  Buildings.Controls.OBC.CDL.Logical.And and4[num] "Logical and"
    annotation (Placement(transformation(extent={{-60,-370},{-40,-350}})));
  Buildings.Controls.OBC.CDL.Logical.Or or2[num] "Logicla or"
    annotation (Placement(transformation(extent={{0,-350},{20,-330}})));
  Buildings.Controls.OBC.CDL.Continuous.Hysteresis hys5(
    each final uLow=turOnChiWatIsoTim - 5,
    each final uHigh=turOnChiWatIsoTim + 5)
    "Check if it has past the target time of open CHW isolation valve "
    annotation (Placement(transformation(extent={{20,-300},{40,-280}})));
  Buildings.Controls.OBC.CDL.Logical.MultiAnd mulAnd1(nu=num)
    annotation (Placement(transformation(extent={{42,-350},{62,-330}})));
  Buildings.Controls.OBC.CDL.Logical.And and5 "Check if the isolation valve has been fully open"
    annotation (Placement(transformation(extent={{102,-330},{122,-310}})));
  Buildings.Controls.OBC.CDL.Interfaces.BooleanOutput yChi[num]
    "Chiller status"
    annotation (Placement(transformation(extent={{220,-440},{240,-420}}),
      iconTransformation(extent={{100,-100},{120,-80}})));
  Buildings.Controls.OBC.CDL.Logical.Switch swi4[num]
    "Current setpoint to chillers"
    annotation (Placement(transformation(extent={{180,370},{200,390}})));
  Buildings.Controls.OBC.CDL.Logical.Not not5 "Logical not"
    annotation (Placement(transformation(extent={{-60,410},{-40,430}})));
  Buildings.Controls.OBC.CDL.Logical.Or or1
    "Check if it is before stage change or all other changes have been made"
    annotation (Placement(transformation(extent={{80,410},{100,430}})));
  Buildings.Controls.OBC.CDL.Routing.BooleanReplicator booRep2(final nout=num)
    "Replicate input "
    annotation (Placement(transformation(extent={{120,410},{140,430}})));

  Pump.CondenserWater conWatPum(pumNum=num)
    annotation (Placement(transformation(extent={{100,60},{120,80}})));
  CDL.Logical.Switch                        swi5
    "Switch to current stage setpoint"
    annotation (Placement(transformation(extent={{-20,60},{0,80}})));
  CDL.Interfaces.BooleanInput uWSE
    "Water side economizer status: true = ON, false = OFF" annotation (
      Placement(transformation(extent={{-280,10},{-240,50}}),
        iconTransformation(extent={{-120,-20},{-100,0}})));
  CDL.Conversions.IntegerToReal intToRea
    annotation (Placement(transformation(extent={{-200,60},{-180,80}})));
  CDL.Continuous.AddParameter addPar(p=-1, k=1) "Reduce one stage"
    annotation (Placement(transformation(extent={{-140,40},{-120,60}})));
  CDL.Conversions.RealToInteger reaToInt "Convert real to integer number"
    annotation (Placement(transformation(extent={{20,60},{40,80}})));
  ChillerRotation chiRot(chiNum=num)
    "Enable condenser water isolation valve for the chiller being enabled"
    annotation (Placement(transformation(extent={{160,-10},{180,10}})));
  CDL.Logical.And and6
    annotation (Placement(transformation(extent={{-80,244},{-60,264}})));
  CDL.Logical.And and7
    "Check if it is staging up and by pass minflow has changed"
    annotation (Placement(transformation(extent={{-140,90},{-120,110}})));
  CDL.Logical.Timer                        tim2
    "Time after changeing condenser water pump "
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  CDL.Continuous.Hysteresis                        hys6(final uLow=10 - 1,
      final uHigh=10 + 1)
    "Check if it is 10 seconds after condenser water pump change"
    annotation (Placement(transformation(extent={{-20,-10},{0,10}})));
  CDL.Logical.Switch                        swi6
    "Switch to current stage setpoint"
    annotation (Placement(transformation(extent={{40,-10},{60,10}})));
  CDL.Conversions.RealToInteger reaToInt1 "Convert real to integer number"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  CDL.Logical.And and2 "Check if CW isolation valve have finished open process"
    annotation (Placement(transformation(extent={{-200,-260},{-180,-240}})));
  CDL.Logical.Switch                        swi3 "Switch to current stage"
    annotation (Placement(transformation(extent={{-120,-260},{-100,-240}})));
  CDL.Conversions.RealToInteger reaToInt2 "Convert real to integer number"
    annotation (Placement(transformation(extent={{-80,-260},{-60,-240}})));
  ChillerRotation chiRot1(chiNum=num)
    "Enable chilled water isolation valve for the chiller being enabled"
    annotation (Placement(transformation(extent={{-20,-260},{0,-240}})));
  CDL.Logical.Edge edg[num]
    "Check if there is any valve changes from OFF to ON"
    annotation (Placement(transformation(extent={{20,-260},{40,-240}})));
  ChillerRotation chiRot2(chiNum=num)
    "Enable chilled water isolation valve for the chiller being enabled"
    annotation (Placement(transformation(extent={{-20,-440},{0,-420}})));
  CDL.Logical.And and1 "Check if CW isolation valve have finished open process"
    annotation (Placement(transformation(extent={{-200,-440},{-180,-420}})));
  CDL.Logical.Switch                        swi7 "Switch to current stage"
    annotation (Placement(transformation(extent={{-120,-440},{-100,-420}})));
  CDL.Conversions.RealToInteger reaToInt3 "Convert real to integer number"
    annotation (Placement(transformation(extent={{-80,-440},{-60,-420}})));
equation
  connect(uChiCur, triSam.u)
    annotation (Line(points={{-260,360},{-162,360}}, color={0,0,127}));
  connect(booRep1.y, triSam.trigger)
    annotation (Line(points={{-99,440},{-80,440},{-80,400},{-180,400},{-180,340},
          {-150,340},{-150,348.2}},        color={255,0,255}));
  connect(triSam.y, gai.u)
    annotation (Line(points={{-139,360},{-82,360}}, color={0,0,127}));
  connect(uChi, swi.u2)
    annotation (Line(points={{-260,320},{-102,320}}, color={255,0,255}));
  connect(con.y, swi.u3)
    annotation (Line(points={{-139,290},{-120,290},{-120,312},{-102,312}},
      color={0,0,127}));
  connect(uChiCur, div.u1)
    annotation (Line(points={{-260,360},{-200,360},{-200,336},{18,336}},
      color={0,0,127}));
  connect(swi.y, div.u2)
    annotation (Line(points={{-79,320},{0,320},{0,324},{18,324}},
      color={0,0,127}));
  connect(hys.y, not1.u)
    annotation (Line(points={{-19,290},{-2,290}}, color={255,0,255}));
  connect(not1.y, mulAnd.u)
    annotation (Line(points={{21,290},{38,290}}, color={255,0,255}));
  connect(mulAnd.y, truDel.u)
    annotation (Line(points={{61.7,290},{78,290}}, color={255,0,255}));
  connect(uChiSta, cha.u)
    annotation (Line(points={{-260,420},{-182,420}}, color={255,127,0}));
  connect(cha.up, booRep1.u)
    annotation (Line(points={{-159,426},{-140,426},{-140,440},{-122,440}},
      color={255,0,255}));
  connect(con1.y,curMinSet. u)
    annotation (Line(points={{-159,220},{-122,220}},color={0,0,127}));
  connect(uChiSta, addInt.u1)
    annotation (Line(points={{-260,420},{-210,420},{-210,200},{-170,200},{-170,156},
          {-162,156}},        color={255,127,0}));
  connect(conInt.y, addInt.u2)
    annotation (Line(points={{-179,150},{-170,150},{-170,144},{-162,144}},
      color={255,127,0}));
  connect(con1.y, oldMinSet.u)
    annotation (Line(points={{-159,220},{-140,220},{-140,170},{-122,170}},
      color={0,0,127}));
  connect(uChiSta,curMinSet. index)
    annotation (Line(points={{-260,420},{-210,420},{-210,200},{-110,200},{-110,208}},
                   color={255,127,0}));
  connect(div.y, hys.u)
    annotation (Line(points={{41,330},{60,330},{60,312},{-60,312},{-60,290},{-42,
          290}},  color={0,0,127}));
  connect(triSam.y, swi.u1)
    annotation (Line(points={{-139,360},{-120,360},{-120,328},{-102,328}},
      color={0,0,127}));
  connect(con2.y, lin.x1)
    annotation (Line(points={{-59,220},{-46,220},{-46,178},{-22,178}},
      color={0,0,127}));
  connect(con3.y, lin.x2)
    annotation (Line(points={{-59,150},{-40,150},{-40,166},{-22,166}},
      color={0,0,127}));
  connect(tim.y, lin.u)
    annotation (Line(points={{1,220},{20,220},{20,200},{-40,200},{-40,170},{-22,
          170}},  color={0,0,127}));
  connect(oldMinSet.y, lin.f1)
    annotation (Line(points={{-99,170},{-46,170},{-46,174},{-22,174}},
      color={0,0,127}));
  connect(tim.y, hys2.u)
    annotation (Line(points={{1,220},{20,220},{20,150},{58,150}},
      color={0,0,127}));
  connect(addInt.y, oldMinSet.index)
    annotation (Line(points={{-139,150},{-110,150},{-110,158}}, color={255,127,0}));
  connect(uChiSta, intLesThr.u)
    annotation (Line(points={{-260,420},{-210,420},{-210,240},{30,240},{30,190},
          {38,190}},      color={255,127,0}));
  connect(con4.y, swi1.u1)
    annotation (Line(points={{61,220},{90,220},{90,188},{98,188}}, color={0,0,127}));
  connect(intLesThr.y, swi1.u2)
    annotation (Line(points={{61,190},{80,190},{80,180},{98,180}}, color={255,0,255}));
  connect(lin.y, swi1.u3)
    annotation (Line(points={{1,170},{80,170},{80,172},{98,172}}, color={0,0,127}));
  connect(swi1.y, yMinFloSet)
    annotation (Line(points={{121,180},{230,180}}, color={0,0,127}));
  connect(curMinSet.y, lin.f2)
    annotation (Line(points={{-99,220},{-90,220},{-90,180},{-52,180},{-52,162},{
          -22,162}},
                 color={0,0,127}));
  connect(uConWatIsoVal, hys1.u)
    annotation (Line(points={{-260,-58},{-202,-58}},
                                                   color={0,0,127}));
  connect(hys1.y, logSwi7.u1)
    annotation (Line(points={{-179,-58},{-150,-58},{-150,-50},{-122,-50}},
      color={255,0,255}));
  connect(con16.y, logSwi7.u3)
    annotation (Line(points={{-179,-88},{-140,-88},{-140,-66},{-122,-66}},
      color={255,0,255}));
  connect(logSwi7.y, mulAnd3.u)
    annotation (Line(points={{-99,-58},{-62,-58}},
                                                 color={255,0,255}));
  connect(mulAnd3.y, truDel1.u)
    annotation (Line(points={{-38.3,-58},{-22,-58}},
                                                   color={255,0,255}));
  connect(truDel1.y, tim1.u)
    annotation (Line(points={{1,-58},{40,-58},{40,-110},{-210,-110},{-210,-180},
          {-82,-180}},
                   color={255,0,255}));
  connect(con6.y, lin1.f1)
    annotation (Line(points={{-59,-150},{-30,-150},{-30,-176},{18,-176}},
      color={0,0,127}));
  connect(con9.y, lin1.x1)
    annotation (Line(points={{1,-150},{10,-150},{10,-172},{18,-172}},
      color={0,0,127}));
  connect(con7.y, lin1.x2)
    annotation (Line(points={{-59,-210},{-30,-210},{-30,-184},{18,-184}},
      color={0,0,127}));
  connect(con8.y, lin1.f2)
    annotation (Line(points={{1,-210},{10,-210},{10,-188},{18,-188}},
      color={0,0,127}));
  connect(tim1.y, lin1.u)
    annotation (Line(points={{-59,-180},{18,-180}}, color={0,0,127}));
  connect(lin1.y, reaRep.u)
    annotation (Line(points={{41,-180},{58,-180}},
                                                color={0,0,127}));
  connect(uChiWatIsoVal, hys3.u)
    annotation (Line(points={{-260,-320},{-202,-320}}, color={0,0,127}));
  connect(uChiWatIsoVal, hys4.u)
    annotation (Line(points={{-260,-320},{-210,-320},{-210,-380},{-202,-380}},
      color={0,0,127}));
  connect(hys3.y, and3.u1)
    annotation (Line(points={{-179,-320},{-62,-320}}, color={255,0,255}));
  connect(hys4.y, and3.u2)
    annotation (Line(points={{-179,-380},{-140,-380},{-140,-328},{-62,-328}},
      color={255,0,255}));
  connect(hys3.y, not3.u)
    annotation (Line(points={{-179,-320},{-130,-320},{-130,-350},{-122,-350}},
      color={255,0,255}));
  connect(hys4.y, not4.u)
    annotation (Line(points={{-179,-380},{-122,-380}}, color={255,0,255}));
  connect(not3.y, and4.u1)
    annotation (Line(points={{-99,-350},{-80,-350},{-80,-360},{-62,-360}},
      color={255,0,255}));
  connect(not4.y, and4.u2)
    annotation (Line(points={{-99,-380},{-79.5,-380},{-79.5,-368},{-62,-368}},
      color={255,0,255}));
  connect(and3.y, or2.u1)
    annotation (Line(points={{-39,-320},{-20,-320},{-20,-340},{-2,-340}},
      color={255,0,255}));
  connect(and4.y, or2.u2)
    annotation (Line(points={{-39,-360},{-20,-360},{-20,-348},{-2,-348}},
      color={255,0,255}));
  connect(or2.y, mulAnd1.u)
    annotation (Line(points={{21,-340},{40,-340}},  color={255,0,255}));
  connect(hys5.y, and5.u1)
    annotation (Line(points={{41,-290},{80,-290},{80,-320},{100,-320}},
      color={255,0,255}));
  connect(mulAnd1.y, and5.u2)
    annotation (Line(points={{63.7,-340},{80,-340},{80,-328},{100,-328}},
      color={255,0,255}));
  connect(cha.y, not5.u)
    annotation (Line(points={{-159,420},{-62,420}}, color={255,0,255}));
  connect(swi4.y, yChiCur)
    annotation (Line(points={{201,380},{230,380}}, color={0,0,127}));
  connect(not5.y, or1.u1)
    annotation (Line(points={{-39,420},{78,420}}, color={255,0,255}));
  connect(and5.y, or1.u2)
    annotation (Line(points={{123,-320},{140,-320},{140,400},{60,400},{60,412},{
          78,412}},
                 color={255,0,255}));
  connect(or1.y, booRep2.u)
    annotation (Line(points={{101,420},{118,420}}, color={255,0,255}));
  connect(booRep2.y, swi4.u2)
    annotation (Line(points={{141,420},{160,420},{160,380},{178,380}},
      color={255,0,255}));
  connect(gai.y, swi4.u3)
    annotation (Line(points={{-59,360},{60,360},{60,372},{178,372}},
      color={0,0,127}));
  connect(uChiCur, swi4.u1)
    annotation (Line(points={{-260,360},{-200,360},{-200,388},{178,388}},
      color={0,0,127}));
  connect(tim1.y, hys5.u)
    annotation (Line(points={{-59,-180},{-40,-180},{-40,-290},{18,-290}},
      color={0,0,127}));

  connect(uChiSta, intToRea.u) annotation (Line(points={{-260,420},{-210,420},{-210,
          70},{-202,70}},        color={255,127,0}));
  connect(intToRea.y, addPar.u)
    annotation (Line(points={{-179,70},{-160,70},{-160,50},{-142,50}},
                                                     color={0,0,127}));
  connect(conWatPum.yConWatPum, yConWatPum) annotation (Line(points={{121,70},{230,
          70}},                          color={0,0,127}));
  connect(intToRea.y, swi5.u1) annotation (Line(points={{-179,70},{-160,70},{-160,
          78},{-22,78}},        color={0,0,127}));
  connect(addPar.y, swi5.u3) annotation (Line(points={{-119,50},{-100,50},{-100,
          62},{-22,62}},   color={0,0,127}));
  connect(truDel.y, and6.u1) annotation (Line(points={{101,290},{120,290},{120,272},
          {-100,272},{-100,254},{-82,254}},      color={255,0,255}));
  connect(cha.up, and6.u2) annotation (Line(points={{-159,426},{-140,426},{-140,
          440},{-220,440},{-220,246},{-82,246}}, color={255,0,255}));
  connect(and6.y, tim.u) annotation (Line(points={{-59,254},{-40,254},{-40,220},
          {-22,220}}, color={255,0,255}));
  connect(hys2.y, and7.u1) annotation (Line(points={{81,150},{100,150},{100,120},
          {-160,120},{-160,100},{-142,100}}, color={255,0,255}));
  connect(cha.up, and7.u2) annotation (Line(points={{-159,426},{-140,426},{-140,
          440},{-220,440},{-220,92},{-142,92}},   color={255,0,255}));
  connect(and7.y, swi5.u2) annotation (Line(points={{-119,100},{-80,100},{-80,70},
          {-22,70}},       color={255,0,255}));
  connect(swi5.y, reaToInt.u)
    annotation (Line(points={{1,70},{18,70}},   color={0,0,127}));
  connect(reaToInt.y, conWatPum.uChiSta) annotation (Line(points={{41,70},{60,70},
          {60,74},{98,74}},        color={255,127,0}));
  connect(uWSE, conWatPum.uWSE) annotation (Line(points={{-260,30},{80,30},{80,66},
          {98,66}},       color={255,0,255}));
  connect(and7.y, tim2.u) annotation (Line(points={{-119,100},{-80,100},{-80,0},
          {-62,0}},  color={255,0,255}));
  connect(tim2.y, hys6.u)
    annotation (Line(points={{-39,0},{-22,0}},   color={0,0,127}));
  connect(hys6.y, swi6.u2)
    annotation (Line(points={{1,0},{38,0}},   color={255,0,255}));
  connect(addPar.y, swi6.u3) annotation (Line(points={{-119,50},{20,50},{20,-8},
          {38,-8}}, color={0,0,127}));
  connect(intToRea.y, swi6.u1) annotation (Line(points={{-179,70},{-160,70},{-160,
          20},{30,20},{30,8},{38,8}},        color={0,0,127}));
  connect(swi6.y, reaToInt1.u)
    annotation (Line(points={{61,0},{98,0}},   color={0,0,127}));
  connect(reaToInt1.y, chiRot.uChiSta)
    annotation (Line(points={{121,0},{158,0}},   color={255,127,0}));
  connect(chiRot.yChiOpeSta, yConWatIsoVal)
    annotation (Line(points={{181,0},{230,0}},   color={255,0,255}));
  connect(chiRot.yChiOpeSta, logSwi7.u2) annotation (Line(points={{181,0},{200,0},
          {200,-30},{-140,-30},{-140,-58},{-122,-58}},   color={255,0,255}));
  connect(truDel1.y, and2.u1) annotation (Line(points={{1,-58},{40,-58},{40,-110},
          {-210,-110},{-210,-250},{-202,-250}}, color={255,0,255}));
  connect(cha.up, and2.u2) annotation (Line(points={{-159,426},{-140,426},{-140,
          440},{-220,440},{-220,-258},{-202,-258}}, color={255,0,255}));
  connect(intToRea.y, swi3.u1) annotation (Line(points={{-179,70},{-160,70},{-160,
          -242},{-122,-242}}, color={0,0,127}));
  connect(addPar.y, swi3.u3) annotation (Line(points={{-119,50},{-100,50},{-100,
          36},{-156,36},{-156,-258},{-122,-258}}, color={0,0,127}));
  connect(and2.y, swi3.u2)
    annotation (Line(points={{-179,-250},{-122,-250}}, color={255,0,255}));
  connect(swi3.y, reaToInt2.u)
    annotation (Line(points={{-99,-250},{-82,-250}}, color={0,0,127}));
  connect(reaToInt2.y, chiRot1.uChiSta)
    annotation (Line(points={{-59,-250},{-22,-250}}, color={255,127,0}));
  connect(chiRot1.yChiOpeSta, edg.u)
    annotation (Line(points={{1,-250},{18,-250}}, color={255,0,255}));
  connect(edg.y, swi2.u2)
    annotation (Line(points={{41,-250},{158,-250}}, color={255,0,255}));
  connect(reaRep.y, swi2.u1) annotation (Line(points={{81,-180},{100,-180},{100,
          -242},{158,-242}}, color={0,0,127}));
  connect(uChiWatIsoVal, swi2.u3) annotation (Line(points={{-260,-320},{-210,-320},
          {-210,-270},{100,-270},{100,-258},{158,-258}}, color={0,0,127}));
  connect(swi2.y, yChiWatIsoValSet)
    annotation (Line(points={{181,-250},{230,-250}}, color={0,0,127}));
  connect(and5.y, and1.u1) annotation (Line(points={{123,-320},{140,-320},{140,-400},
          {-210,-400},{-210,-430},{-202,-430}}, color={255,0,255}));
  connect(cha.up, and1.u2) annotation (Line(points={{-159,426},{-140,426},{-140,
          440},{-220,440},{-220,-438},{-202,-438}}, color={255,0,255}));
  connect(and1.y, swi7.u2)
    annotation (Line(points={{-179,-430},{-122,-430}}, color={255,0,255}));
  connect(intToRea.y, swi7.u1) annotation (Line(points={{-179,70},{-160,70},{-160,
          -422},{-122,-422}}, color={0,0,127}));
  connect(addPar.y, swi7.u3) annotation (Line(points={{-119,50},{-100,50},{-100,
          36},{-156,36},{-156,-438},{-122,-438}}, color={0,0,127}));
  connect(swi7.y, reaToInt3.u)
    annotation (Line(points={{-99,-430},{-82,-430}}, color={0,0,127}));
  connect(reaToInt3.y, chiRot2.uChiSta)
    annotation (Line(points={{-59,-430},{-22,-430}}, color={255,127,0}));
  connect(chiRot2.yChiOpeSta, yChi)
    annotation (Line(points={{1,-430},{230,-430}}, color={255,0,255}));
annotation (
  defaultComponentName = "staUp",
  Diagram(coordinateSystem(preserveAspectRatio=false,
    extent={{-240,-460},{220,460}}), graphics={
                                             Rectangle(
          extent={{-238,-122},{218,-278}},
          fillColor={210,210,210},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),         Rectangle(
          extent={{-238,18},{218,-18}},
          fillColor={210,210,210},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),         Rectangle(
          extent={{-238,458},{218,282}},
          fillColor={210,210,210},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),         Rectangle(
          extent={{-238,238},{218,142}},
          fillColor={210,210,210},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),         Rectangle(
          extent={{-238,118},{218,22}},
          fillColor={210,210,210},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),         Rectangle(
          extent={{-238,-42},{218,-98}},
          fillColor={210,210,210},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),         Rectangle(
          extent={{-238,-302},{218,-398}},
          fillColor={210,210,210},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),         Rectangle(
          extent={{-238,-402},{218,-458}},
          fillColor={210,210,210},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
          Text(
          extent={{38,460},{210,438}},
          pattern=LinePattern.None,
          fillColor={210,210,210},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,127},
          horizontalAlignment=TextAlignment.Left,
          textString="Check if there is stage change, if it is stage up"),
          Text(
          extent={{66,372},{212,336}},
          pattern=LinePattern.None,
          fillColor={210,210,210},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,127},
          horizontalAlignment=TextAlignment.Right,
          textString="Limit chiller demand to 0.75 of 
current load"),
          Text(
          extent={{-18,332},{214,294}},
          pattern=LinePattern.None,
          fillColor={210,210,210},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,127},
          horizontalAlignment=TextAlignment.Right,
          textString="Ensure actual demand has been less than
0.8 by more than 5 minutes"),
          Text(
          extent={{64,238},{212,200}},
          pattern=LinePattern.None,
          fillColor={210,210,210},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,127},
          horizontalAlignment=TextAlignment.Right,
          textString="Slowly change minimum 
flow rate setpoint"),
          Text(
          extent={{52,178},{210,140}},
          pattern=LinePattern.None,
          fillColor={210,210,210},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,127},
          horizontalAlignment=TextAlignment.Right,
          textString="After new setpoint is 
achieved, wait 1 minute"),
          Text(
          extent={{144,106},{216,94}},
          pattern=LinePattern.None,
          fillColor={210,210,210},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,127},
          horizontalAlignment=TextAlignment.Right,
          textString="Start next CW pump"),
          Text(
          extent={{-216,10},{-126,-12}},
          pattern=LinePattern.None,
          fillColor={210,210,210},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,127},
          horizontalAlignment=TextAlignment.Left,
          textString="Enable CW 
isolation valve"),
          Text(
          extent={{-90,-56},{212,-84}},
          pattern=LinePattern.None,
          fillColor={210,210,210},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,127},
          horizontalAlignment=TextAlignment.Right,
          textString="Check if all the enabled CW isolation valves have
open more than 0.1, then wait 30 seconds"),
          Text(
          extent={{84,-120},{212,-154}},
          pattern=LinePattern.None,
          fillColor={210,210,210},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,127},
          horizontalAlignment=TextAlignment.Right,
          textString="Slowly open next CHW 
isolation valve"),
          Text(
          extent={{-16,-360},{210,-392}},
          pattern=LinePattern.None,
          fillColor={210,210,210},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,127},
          horizontalAlignment=TextAlignment.Right,
          textString="Check if all enabled CHW isolation valves 
have been fully open"),
          Text(
          extent={{152,-434},{212,-456}},
          pattern=LinePattern.None,
          fillColor={210,210,210},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,127},
          horizontalAlignment=TextAlignment.Right,
          textString="Start next chiller")}),
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
          extent={{-100,34},{-74,26}},
          lineColor={0,0,127},
          pattern=LinePattern.Dash,
          textString="uChi"),
        Text(
          extent={{-96,68},{-66,56}},
          lineColor={0,0,127},
          pattern=LinePattern.Dash,
          textString="uChiCur"),
        Text(
          extent={{-96,-36},{-32,-60}},
          lineColor={0,0,127},
          pattern=LinePattern.Dash,
          textString="uConWatIsoVal"),
        Text(
          extent={{-96,-82},{-32,-94}},
          lineColor={0,0,127},
          pattern=LinePattern.Dash,
          textString="uChiWatIsoVal"),
        Text(
          extent={{74,-86},{102,-96}},
          lineColor={0,0,127},
          pattern=LinePattern.Dash,
          textString="yChi"),
        Text(
          extent={{64,96},{96,86}},
          lineColor={0,0,127},
          pattern=LinePattern.Dash,
          textString="yChiCur"),
        Text(
          extent={{-16,4.5},{16,-4.5}},
          lineColor={0,0,127},
          pattern=LinePattern.Dash,
          textString="uChiSta",
          origin={-82,92.5},
          rotation=0),
        Text(
          extent={{44,38},{96,24}},
          lineColor={0,0,127},
          pattern=LinePattern.Dash,
          textString="yConWatPum"),
        Text(
          extent={{40,-2},{98,-16}},
          lineColor={0,0,127},
          pattern=LinePattern.Dash,
          textString="yConWatIsoVal"),
        Text(
          extent={{28,-44},{98,-58}},
          lineColor={0,0,127},
          pattern=LinePattern.Dash,
          textString="yChiWatIsoValSet"),
        Text(
          extent={{56,66},{98,54}},
          lineColor={0,0,127},
          pattern=LinePattern.Dash,
          textString="yMinFloSet"),
        Text(
          extent={{-100,-6},{-74,-14}},
          lineColor={0,0,127},
          pattern=LinePattern.Dash,
          textString="uWSE")}),
Documentation(info="<html>
<p>
Block that generates signals to control devices when there is chiller plant 
stage-up command, according to ASHRAE RP-1711 Advanced Sequences of Operation for HVAC Systems Phase II –
Central Plants and Hydronic Systems (Draft 4 on August 15, 2018), section 3.2.4.12.
</p>
<p>Whenever there is a stage-up command (<code>uChiSta</code> increases):</p>
<p>
a. Command operating chillers (true elements in <code>uChi</code> vector) to 
reduce demand (currents) to 75% of their load (<code>uChiCur</code>). Wait until
actual demand becomes less than 80% up to a maximum of <code>holChiDemTim</code>
(e.g. 5 minutes) before proceeding.
</p>

<p>
b. Slowly change the minimum bypass controller setpoint <code>yMinFloSet</code> 
to that appropriate for the stage as indicated below. For example, this could 
be accomplished by resetting the setpoint X GPM/second, where X = (NewSetpoint 
- OldSetpoint) / <code>byPasSetTim</code>. The minimum flow rate are as follows
(based on manufactures' minimum flow rate plus 10% to ensure control variations
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
<p>
After new setpoint is achieved wait 1 minute to allow loop to stabilize.
</p>

<p>
c. Start the next CW pump and/or change CW pump speed to that required of 
the new stage, refer to 
<a href=\"modelica://Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.Pump.CondenserWater\">
Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.Pump.CondenserWater</a>.
After 10 seconds, enable head pressure control of the chiller being enabled. 
In this sequence, it controls CW isolation/head pressure control valve <code>uConWatIsoVal</code>. 
Wait 30 seconds.
</p>

<p>
d. Slowly open CHW isolation valve of the chiller being enabled,
e.g. change the open position setpoint <code>yChiWatIsoValSet</code>
to be nonzero. The purpose of slow-opening is to prevent sudden disruption to 
flow through active chillers. Valve timing <code>turOnChiWatIsoTim</code> to 
be determined in the field as that required to prevent nuisance trips.
</p>

<p>
e. Start the next stage chiller <code>uChi</code> after CHW isolation valve is fully open.
</p>

<p>
f. Release the demand limit <code>yChiCur</code>.
</p>

</html>",
revisions="<html>
<ul>
<li>
July 28, 2018, by Jianjun Hu:<br/>
First implementation.
</li>
</ul>
</html>"));
end UpProcess;
