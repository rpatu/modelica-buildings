within Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.MinimumFlowBypass;
block Controller
  "Controller for chilled water minimum flow bypass valve"
  CDL.Interfaces.BooleanInput uStaUp "Indicate if there is stage up"
    annotation (Placement(transformation(extent={{-300,120},{-260,160}}),
        iconTransformation(extent={{-426,70},{-386,110}})));
  CDL.Interfaces.BooleanInput uOnOff
    "Indicate if the stage require one chiller to be enabled while another is disabled"
    annotation (Placement(transformation(extent={{-300,-90},{-260,-50}}),
        iconTransformation(extent={{-426,70},{-386,110}})));
  CDL.Interfaces.IntegerInput uSta "Current stage index" annotation (Placement(
        transformation(extent={{-300,20},{-260,60}}), iconTransformation(extent=
           {{-414,56},{-374,96}})));
  CDL.Continuous.Sources.Constant con[num](final k=minFloSet)
    "Minimum bypass flow setpoint at each stage, equal to the sum of minimum chilled water flowrate of the chillers being enabled at the stage"
    annotation (Placement(transformation(extent={{-220,50},{-200,70}})));
  CDL.Routing.RealExtractor                        curMinSet(nin=num)
    "Targeted minimum flow setpoint at current stage"
    annotation (Placement(transformation(extent={{-120,50},{-100,70}})));
  CDL.Integers.Sources.Constant                        conInt(final k=1)
    "Constant one"
    annotation (Placement(transformation(extent={{-220,-180},{-200,-160}})));
  CDL.Integers.Add                        addInt
    "One stage lower than current one"
    annotation (Placement(transformation(extent={{-180,-200},{-160,-180}})));
  CDL.Continuous.Sources.Constant                        con3(final k=
        byPasSetTim)
    "Duration time to change old setpoint to new setpoint"
    annotation (Placement(transformation(extent={{-60,90},{-40,110}})));
  CDL.Continuous.Line upSet
    "Minimum flow setpoint when there is stage up command"
    annotation (Placement(transformation(extent={{80,30},{100,50}})));
  CDL.Continuous.Sources.Constant                        con2(final k=0)
    "Constant zero"
    annotation (Placement(transformation(extent={{0,90},{20,110}})));
  CDL.Logical.Timer                        tim
    "Time after suppress chiller demand"
    annotation (Placement(transformation(extent={{0,130},{20,150}})));
  CDL.Interfaces.BooleanInput uStaDow "Indicate if there is stage down"
    annotation (Placement(transformation(extent={{-300,-240},{-260,-200}}),
        iconTransformation(extent={{-426,70},{-386,110}})));
  CDL.Integers.Sources.Constant                        conInt1(final k=-1)
    "Constant one"
    annotation (Placement(transformation(extent={{-220,0},{-200,20}})));
  CDL.Integers.Add                        addInt1
    "One stage lower than current one"
    annotation (Placement(transformation(extent={{-180,-20},{-160,0}})));
  CDL.Routing.RealExtractor lowMinSet(nin=num)
    "Minimum flow setpoint at previous low stage"
    annotation (Placement(transformation(extent={{-120,10},{-100,30}})));
  CDL.Routing.RealExtractor uppMinSet(nin=num)
    "Minimum flow setpoint at previous upper stage"
    annotation (Placement(transformation(extent={{-120,-170},{-100,-150}})));
  CDL.Continuous.Line dowSet
    "Minimum flow setpoint when there is stage down command"
    annotation (Placement(transformation(extent={{80,-150},{100,-130}})));
  CDL.Logical.Timer                        tim1
    "Time after suppress chiller demand"
    annotation (Placement(transformation(extent={{0,-230},{20,-210}})));
  CDL.Logical.Switch swi
    annotation (Placement(transformation(extent={{20,-40},{40,-20}})));
  CDL.Continuous.Add add2
    annotation (Placement(transformation(extent={{-40,-20},{-20,0}})));
  CDL.Logical.Switch swi1
    annotation (Placement(transformation(extent={{20,-120},{40,-100}})));
  CDL.Continuous.Add add1
    annotation (Placement(transformation(extent={{-40,-100},{-20,-80}})));
  CDL.Logical.Switch byPasSet "Minimum flow bypass setpoint"
    annotation (Placement(transformation(extent={{160,-70},{180,-50}})));
  CDL.Interfaces.BooleanInput uChiWatPum
    "Indicate if there is any chilled water pump is proven on: true=ON, false=OFF"
    annotation (Placement(transformation(extent={{-300,180},{-260,220}}),
        iconTransformation(extent={{-426,70},{-386,110}})));
  CDL.Continuous.LimPID valPos(
    yMax=1,
    yMin=0,                    reset=Buildings.Controls.OBC.CDL.Types.Reset.Parameter,
      y_reset=1) "By pass valve position"
    annotation (Placement(transformation(extent={{220,210},{240,230}})));

Buildings.Controls.OBC.CDL.Interfaces.RealInput VBypas_flow(
    min=0,
    each final unit="m3/s",
    each quantity="VolumeFlowRate") "Measured bypass flow rate" annotation (
      Placement(transformation(extent={{-300,150},{-260,190}}),
        iconTransformation(extent={{-120,-100},{-100,-80}})));


  CDL.Logical.Not not1
    annotation (Placement(transformation(extent={{-220,190},{-200,210}})));
equation
  connect(curMinSet.u, con.y)
    annotation (Line(points={{-122,60},{-199,60}}, color={0,0,127}));
  connect(con.y, lowMinSet.u) annotation (Line(points={{-199,60},{-140,60},{-140,
          20},{-122,20}}, color={0,0,127}));
  connect(addInt1.y, lowMinSet.index) annotation (Line(points={{-159,-10},{-110,
          -10},{-110,8}}, color={255,127,0}));
  connect(con2.y, upSet.x1) annotation (Line(points={{21,100},{50,100},{50,48},{
          78,48}}, color={0,0,127}));
  connect(lowMinSet.y, upSet.f1) annotation (Line(points={{-99,20},{-80,20},{-80,
          44},{78,44}}, color={0,0,127}));
  connect(tim.y, upSet.u) annotation (Line(points={{21,140},{40,140},{40,40},{78,
          40}}, color={0,0,127}));
  connect(con3.y, upSet.x2) annotation (Line(points={{-39,100},{-10,100},{-10,36},
          {78,36}}, color={0,0,127}));
  connect(addInt.y, uppMinSet.index) annotation (Line(points={{-159,-190},{-110,
          -190},{-110,-172}}, color={255,127,0}));
  connect(uppMinSet.y, dowSet.f1) annotation (Line(points={{-99,-160},{-80,-160},
          {-80,-136},{78,-136}}, color={0,0,127}));
  connect(uStaDow, tim1.u)
    annotation (Line(points={{-280,-220},{-2,-220}}, color={255,0,255}));
  connect(conInt1.y, addInt1.u1) annotation (Line(points={{-199,10},{-190,10},{-190,
          -4},{-182,-4}}, color={255,127,0}));
  connect(uSta, addInt1.u2) annotation (Line(points={{-280,40},{-240,40},{-240,-16},
          {-182,-16}}, color={255,127,0}));
  connect(uSta, curMinSet.index) annotation (Line(points={{-280,40},{-110,40},{-110,
          48}}, color={255,127,0}));
  connect(uStaUp, tim.u)
    annotation (Line(points={{-280,140},{-2,140}}, color={255,0,255}));
  connect(curMinSet.y, add2.u1) annotation (Line(points={{-99,60},{-60,60},{-60,
          -4},{-42,-4}}, color={0,0,127}));
  connect(lowMinSet.y, add2.u2) annotation (Line(points={{-99,20},{-80,20},{-80,
          -16},{-42,-16}}, color={0,0,127}));
  connect(uOnOff, swi.u2) annotation (Line(points={{-280,-70},{-220,-70},{-220,-30},
          {18,-30}}, color={255,0,255}));
  connect(add2.y, swi.u1) annotation (Line(points={{-19,-10},{0,-10},{0,-22},{18,
          -22}}, color={0,0,127}));
  connect(curMinSet.y, swi.u3) annotation (Line(points={{-99,60},{-60,60},{-60,-38},
          {18,-38}}, color={0,0,127}));
  connect(swi.y, upSet.f2) annotation (Line(points={{41,-30},{60,-30},{60,32},{78,
          32}}, color={0,0,127}));
  connect(con.y, uppMinSet.u) annotation (Line(points={{-199,60},{-140,60},{-140,
          -160},{-122,-160}}, color={0,0,127}));
  connect(uOnOff, swi1.u2) annotation (Line(points={{-280,-70},{-220,-70},{-220,
          -110},{18,-110}}, color={255,0,255}));
  connect(curMinSet.y, add1.u1) annotation (Line(points={{-99,60},{-60,60},{-60,
          -84},{-42,-84}}, color={0,0,127}));
  connect(uppMinSet.y, add1.u2) annotation (Line(points={{-99,-160},{-80,-160},{
          -80,-96},{-42,-96}}, color={0,0,127}));
  connect(add1.y, swi1.u1) annotation (Line(points={{-19,-90},{0,-90},{0,-102},{
          18,-102}}, color={0,0,127}));
  connect(curMinSet.y, swi1.u3) annotation (Line(points={{-99,60},{-60,60},{-60,
          -118},{18,-118}}, color={0,0,127}));
  connect(con2.y, dowSet.x1) annotation (Line(points={{21,100},{50,100},{50,-132},
          {78,-132}}, color={0,0,127}));
  connect(con3.y, dowSet.x2) annotation (Line(points={{-39,100},{-10,100},{-10,-144},
          {78,-144}}, color={0,0,127}));
  connect(swi1.y, dowSet.f2) annotation (Line(points={{41,-110},{60,-110},{60,-148},
          {78,-148}}, color={0,0,127}));
  connect(uSta, addInt.u2) annotation (Line(points={{-280,40},{-240,40},{-240,-196},
          {-182,-196}}, color={255,127,0}));
  connect(conInt.y, addInt.u1) annotation (Line(points={{-199,-170},{-190,-170},
          {-190,-184},{-182,-184}}, color={255,127,0}));
  connect(tim1.y, dowSet.u) annotation (Line(points={{21,-220},{40,-220},{40,-140},
          {78,-140}}, color={0,0,127}));
  connect(upSet.y, byPasSet.u1) annotation (Line(points={{101,40},{140,40},{140,
          -52},{158,-52}}, color={0,0,127}));
  connect(dowSet.y, byPasSet.u3) annotation (Line(points={{101,-140},{140,-140},
          {140,-68},{158,-68}}, color={0,0,127}));
  connect(uStaUp, byPasSet.u2) annotation (Line(points={{-280,140},{-20,140},{-20,
          120},{120,120},{120,-60},{158,-60}}, color={255,0,255}));
  connect(uChiWatPum, not1.u)
    annotation (Line(points={{-280,200},{-222,200}}, color={255,0,255}));
  connect(not1.y, valPos.trigger) annotation (Line(points={{-199,200},{222,200},
          {222,208}}, color={255,0,255}));
  connect(byPasSet.y, valPos.u_s) annotation (Line(points={{181,-60},{200,-60},
          {200,220},{218,220}}, color={0,0,127}));
  connect(VBypas_flow, valPos.u_m) annotation (Line(points={{-280,170},{230,170},
          {230,208}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-260,-240},
            {260,240}})), Diagram(coordinateSystem(preserveAspectRatio=false,
          extent={{-260,-240},{260,240}})));
end Controller;
