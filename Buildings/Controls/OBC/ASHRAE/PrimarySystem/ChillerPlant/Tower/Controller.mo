within Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.Tower;
block Controller "Cooling tower controller"
  Staging.Controller towSta "Staging tower cells"
    annotation (Placement(transformation(extent={{-20,-50},{0,-30}})));
  FanSpeed.Controller towFanSpe "Tower fan speed"
    annotation (Placement(transformation(extent={{-20,0},{0,40}})));
  WaterLevel makUpWat "Make up water control"
    annotation (Placement(transformation(extent={{-20,-250},{0,-230}})));
  CDL.Interfaces.BooleanOutput yTowSta[nTowCell]
    "Cooling tower cell enabling status" annotation (Placement(transformation(
          extent={{100,-10},{120,10}}), iconTransformation(extent={{90,70},{110,
            90}})));
  CDL.Interfaces.RealOutput yIsoVal[nTowCel]
    "Cooling tower cells isolation valve position" annotation (Placement(
        transformation(extent={{100,-90},{120,-70}}), iconTransformation(extent
          ={{90,50},{110,70}})));
  CDL.Logical.Switch swi[nTowCel] "Logical switch"
    annotation (Placement(transformation(extent={{60,-50},{80,-30}})));
  CDL.Continuous.Sources.Constant zer[nTowCel](k=0) "Zero constant"
    annotation (Placement(transformation(extent={{-20,-110},{0,-90}})));
  CDL.Routing.RealReplicator reaRep(nout=nTowCel) "Replicate real input"
    annotation (Placement(transformation(extent={{20,10},{40,30}})));
  CDL.Interfaces.RealOutput yTowSpe[nTowCel]
    "Fan speed of each cooling tower cell" annotation (Placement(transformation(
          extent={{100,-50},{120,-30}}), iconTransformation(extent={{106,50},{
            126,70}})));
  CDL.Interfaces.RealInput chiLoa[nChi] "Current load of each chiller"
    annotation (Placement(transformation(extent={{-140,200},{-100,240}}),
        iconTransformation(extent={{-122,190},{-82,230}})));
  CDL.Interfaces.BooleanInput uChi[nChi] "Chiller enabling status: true=ON"
    annotation (Placement(transformation(extent={{-140,180},{-100,220}}),
        iconTransformation(extent={{-120,170},{-80,210}})));
  CDL.Interfaces.BooleanInput uWSE
    "Waterside economizer enabling status: true=ON" annotation (Placement(
        transformation(extent={{-140,160},{-100,200}}), iconTransformation(
          extent={{-120,150},{-80,190}})));
  CDL.Interfaces.RealInput uTowSpe "Tower fan speed" annotation (Placement(
        transformation(extent={{-140,140},{-100,180}}), iconTransformation(
          extent={{-120,130},{-80,170}})));
  CDL.Interfaces.RealInput TChiWatSup "Chilled water supply temperature"
    annotation (Placement(transformation(extent={{-140,120},{-100,160}}),
        iconTransformation(extent={{-122,110},{-82,150}})));
  CDL.Interfaces.RealInput TChiWatSupSet
    "Chilled water supply temperature setpoint" annotation (Placement(
        transformation(extent={{-140,100},{-100,140}}), iconTransformation(
          extent={{-120,90},{-80,130}})));
  CDL.Interfaces.RealInput reqPlaCap "Current required plant capacity"
    annotation (Placement(transformation(extent={{-140,80},{-100,120}}),
        iconTransformation(extent={{-124,120},{-84,160}})));
  CDL.Interfaces.RealInput uMaxTowSpeSet[nChi]
    "Maximum cooling tower speed setpoint from each chiller head pressure control loop"
    annotation (Placement(transformation(extent={{-140,60},{-100,100}}),
        iconTransformation(extent={{-122,100},{-82,140}})));
  CDL.Interfaces.RealInput TTow "Measured tower temperature" annotation (
      Placement(transformation(extent={{-140,40},{-100,80}}),
        iconTransformation(extent={{-124,80},{-84,120}})));
  CDL.Interfaces.BooleanInput uTowSta[nTowCel]
    "Cooling tower cell operating status: true=running tower cell" annotation (
      Placement(transformation(extent={{-140,20},{-100,60}}),
        iconTransformation(extent={{-120,60},{-80,100}})));
  CDL.Interfaces.IntegerInput uConWatPumNum
    "Number of enabled condenser water pumps" annotation (Placement(
        transformation(extent={{-140,0},{-100,40}}), iconTransformation(extent=
            {{-120,40},{-80,80}})));
  CDL.Interfaces.BooleanInput uPla "Plant enabling status" annotation (
      Placement(transformation(extent={{-140,-20},{-100,20}}),
        iconTransformation(extent={{-124,20},{-84,60}})));
  CDL.Interfaces.RealInput TConWatRet "Condenser water return temperature"
    annotation (Placement(transformation(extent={{-140,-40},{-100,0}}),
        iconTransformation(extent={{-150,-6},{-110,34}})));
  CDL.Interfaces.RealInput uConWatPumSpe[nConWatPum]
    "Current condenser water pump speed" annotation (Placement(transformation(
          extent={{-140,-60},{-100,-20}}), iconTransformation(extent={{-120,-20},
            {-80,20}})));
  CDL.Interfaces.RealInput TConWatSup "Condenser water supply temperature"
    annotation (Placement(transformation(extent={{-140,-80},{-100,-40}}),
        iconTransformation(extent={{-122,-40},{-82,0}})));
  CDL.Interfaces.IntegerInput uChiSta "Current chiller stage" annotation (
      Placement(transformation(extent={{-140,-120},{-100,-80}}),
        iconTransformation(extent={{-120,-80},{-80,-40}})));
  CDL.Interfaces.IntegerInput uTowCelPri[nTowCel]
    "Cooling tower cell enabling priority" annotation (Placement(transformation(
          extent={{-140,-140},{-100,-100}}), iconTransformation(extent={{-120,
            -100},{-80,-60}})));
  CDL.Interfaces.BooleanInput uStaUp "Plant stage up status: true=stage-up"
    annotation (Placement(transformation(extent={{-140,-160},{-100,-120}}),
        iconTransformation(extent={{-120,-120},{-80,-80}})));
  CDL.Interfaces.BooleanInput uTowStaUp "Cooling tower stage-up command"
    annotation (Placement(transformation(extent={{-140,-180},{-100,-140}}),
        iconTransformation(extent={{-120,-140},{-80,-100}})));
  CDL.Interfaces.BooleanInput uStaDow
    "Plant stage down status: true=stage-down" annotation (Placement(
        transformation(extent={{-140,-200},{-100,-160}}), iconTransformation(
          extent={{-120,-160},{-80,-120}})));
  CDL.Interfaces.BooleanInput uTowStaDow "Cooling tower stage-down command"
    annotation (Placement(transformation(extent={{-140,-220},{-100,-180}}),
        iconTransformation(extent={{-122,-180},{-82,-140}})));
  CDL.Interfaces.RealInput uIsoVal[nTowCel]
    "Cooling tower cells isolation valve position" annotation (Placement(
        transformation(extent={{-140,-240},{-100,-200}}), iconTransformation(
          extent={{-120,-200},{-80,-160}})));
  CDL.Interfaces.RealInput watLev "Measured water level" annotation (Placement(
        transformation(extent={{-140,-260},{-100,-220}}), iconTransformation(
          extent={{-118,-220},{-78,-180}})));
  CDL.Interfaces.BooleanOutput yMakUp "Makeup water valve On-Off status"
    annotation (Placement(transformation(extent={{100,-250},{120,-230}}),
        iconTransformation(extent={{90,-210},{110,-190}})));
equation
  connect(towSta.yTowSta, yTowSta) annotation (Line(points={{1,-40},{40,-40},{
          40,0},{110,0}}, color={255,0,255}));
  connect(towSta.yIsoVal, yIsoVal) annotation (Line(points={{1,-49},{40,-49},{
          40,-80},{110,-80}}, color={0,0,127}));
  connect(towSta.yTowSta, swi.u2)
    annotation (Line(points={{1,-40},{58,-40}}, color={255,0,255}));
  connect(towFanSpe.yTowSpe, reaRep.u)
    annotation (Line(points={{1,20},{18,20}}, color={0,0,127}));
  connect(reaRep.y, swi.u1) annotation (Line(points={{41,20},{50,20},{50,-32},{
          58,-32}}, color={0,0,127}));
  connect(zer.y, swi.u3) annotation (Line(points={{1,-100},{50,-100},{50,-48},{
          58,-48}}, color={0,0,127}));
  connect(swi.y, yTowSpe)
    annotation (Line(points={{81,-40},{110,-40}}, color={0,0,127}));
  connect(towFanSpe.chiLoa, chiLoa) annotation (Line(points={{-21,38},{-40,38},
          {-40,220},{-120,220}}, color={0,0,127}));
  connect(towFanSpe.uChi, uChi) annotation (Line(points={{-21,36},{-44,36},{-44,
          200},{-120,200}}, color={255,0,255}));
  connect(towFanSpe.uWSE, uWSE) annotation (Line(points={{-21,34},{-48,34},{-48,
          180},{-120,180}}, color={255,0,255}));
  connect(towFanSpe.uTowSpe, uTowSpe) annotation (Line(points={{-21,30},{-52,30},
          {-52,160},{-120,160}}, color={0,0,127}));
  connect(towFanSpe.TChiWatSup, TChiWatSup) annotation (Line(points={{-21,28},{
          -56,28},{-56,140},{-120,140}}, color={0,0,127}));
  connect(towFanSpe.TChiWatSupSet, TChiWatSupSet) annotation (Line(points={{-21,
          26},{-60,26},{-60,120},{-120,120}}, color={0,0,127}));
  connect(towFanSpe.reqPlaCap, reqPlaCap) annotation (Line(points={{-21,22},{
          -64,22},{-64,100},{-120,100}}, color={0,0,127}));
  connect(towFanSpe.uMaxTowSpeSet, uMaxTowSpeSet) annotation (Line(points={{-21,
          20},{-68,20},{-68,80},{-120,80}}, color={0,0,127}));
  connect(towFanSpe.TTow, TTow) annotation (Line(points={{-21,18},{-72,18},{-72,
          60},{-120,60}}, color={0,0,127}));
  connect(towFanSpe.uTowSta, uTowSta) annotation (Line(points={{-21,14},{-76,14},
          {-76,40},{-120,40}}, color={255,0,255}));
  connect(towFanSpe.uConWatPumNum, uConWatPumNum) annotation (Line(points={{-21,
          12},{-80,12},{-80,20},{-120,20}}, color={255,127,0}));
  connect(towFanSpe.uPla, uPla) annotation (Line(points={{-21,10},{-80,10},{-80,
          0},{-120,0}}, color={255,0,255}));
  connect(towFanSpe.TConWatRet, TConWatRet) annotation (Line(points={{-21,6},{
          -76,6},{-76,-20},{-120,-20}}, color={0,0,127}));
  connect(towFanSpe.uConWatPumSpe, uConWatPumSpe) annotation (Line(points={{-21,
          4},{-72,4},{-72,-40},{-120,-40}}, color={0,0,127}));
  connect(towFanSpe.TConWatSup, TConWatSup) annotation (Line(points={{-21,2},{
          -68,2},{-68,-60},{-120,-60}}, color={0,0,127}));
  connect(towSta.uChiSta, uChiSta) annotation (Line(points={{-21,-31},{-64,-31},
          {-64,-100},{-120,-100}}, color={255,127,0}));
  connect(uWSE, towSta.uWSE) annotation (Line(points={{-120,180},{-48,180},{-48,
          -33},{-21,-33}}, color={255,0,255}));
  connect(uTowSta, towSta.uTowSta) annotation (Line(points={{-120,40},{-76,40},
          {-76,14},{-60,14},{-60,-35},{-21,-35}}, color={255,0,255}));
  connect(towSta.uTowCelPri, uTowCelPri) annotation (Line(points={{-21,-37},{
          -60,-37},{-60,-120},{-120,-120}}, color={255,127,0}));
  connect(towSta.uStaUp, uStaUp) annotation (Line(points={{-21,-40},{-56,-40},{
          -56,-140},{-120,-140}}, color={255,0,255}));
  connect(towSta.uTowStaUp, uTowStaUp) annotation (Line(points={{-21,-43},{-52,
          -43},{-52,-160},{-120,-160}}, color={255,0,255}));
  connect(towSta.uStaDow, uStaDow) annotation (Line(points={{-21,-45},{-48,-45},
          {-48,-180},{-120,-180}}, color={255,0,255}));
  connect(towSta.uTowStaDow, uTowStaDow) annotation (Line(points={{-21,-47},{
          -44,-47},{-44,-200},{-120,-200}}, color={255,0,255}));
  connect(towSta.uIsoVal, uIsoVal) annotation (Line(points={{-21,-49},{-40,-49},
          {-40,-220},{-120,-220}}, color={0,0,127}));
  connect(makUpWat.watLev, watLev)
    annotation (Line(points={{-22,-240},{-120,-240}}, color={0,0,127}));
  connect(makUpWat.yMakUp, yMakUp)
    annotation (Line(points={{1,-240},{110,-240}}, color={255,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -260},{100,260}})), Diagram(coordinateSystem(preserveAspectRatio=
            false, extent={{-100,-260},{100,260}})));
end Controller;
