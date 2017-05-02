within Buildings.Experimental.OpenBuildingControl.ASHRAE.G36.CompositeSequences;
model Economizer "Economizer control block"

  AtomicSequences.EconEnableDisable econEnableDisable
    annotation (Placement(transformation(extent={{-20,-60},{0,-40}})));
  AtomicSequences.EconDamperPositionLimitsMultiZone
                                           ecoEnaDis
    annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
  AtomicSequences.EconModulationSingleZone
                                 ecoMod
    annotation (Placement(transformation(extent={{40,0},{60,20}})));
  CDL.Interfaces.RealInput TCooSet
    "Output of a ***TSupSet sequence. The economizer modulates to the TCoo rather 
    than to the THea. If Zone State is Cooling, economizer modulates to a temperature 
    slightly lower than the TCoo [PART5.P.1]."
    annotation (Placement(transformation(extent={{-120,70},{-100,90}})));
  CDL.Interfaces.RealInput TSup
    "Measured supply air temperature. Sensor output."
    annotation (Placement(transformation(extent={{-120,50},{-100,70}})));
  CDL.Interfaces.RealInput uCoo(min=0, max=1)
    "Cooling control signal."
    annotation (Placement(transformation(extent={{-120,-30},{-100,-10}})));
  CDL.Interfaces.RealInput uHea(min=0, max=1)
    "Heating control signal."
    annotation (Placement(transformation(extent={{-120,-50},{-100,-30}})));
  CDL.Interfaces.BooleanInput uSupFan "Supply Fan Status, on or off"
    annotation (Placement(transformation(extent={{-120,-70},{-100,-50}})));
  CDL.Interfaces.RealInput TOut "Outdoor temperature"
    annotation (Placement(transformation(extent={{-120,90}, {-100,110}}),
    iconTransformation(extent={{-120,90},{-100,110}})));
  CDL.Interfaces.BooleanInput uFre(start=false) "Freezestat status"
    annotation (Placement(transformation(extent={{-120,-90},{-100,-70}}),
    iconTransformation(extent={{-120,-90},{-100,-70}})));
  CDL.Interfaces.RealOutput yRetDamPos "Return air damper position"
    annotation (Placement(transformation(extent={{100,10},{120,30}}),
    iconTransformation(extent={{100,10}, {120,30}})));
  CDL.Interfaces.RealOutput yOutDamPos "Economizer damper position"
    annotation (Placement(transformation(extent={{100,-30},{120,-10}}),
    iconTransformation(extent={{100,-30}, {120,-10}})));
  CDL.Interfaces.BooleanInput uAHUMod
    "AHU Mode, fixme: see pg. 103 in G36 for the full list of modes, here we use true = \"occupied\""
    annotation (Placement(transformation(extent={{-120,-10},{-100,10}})));
  CDL.Interfaces.RealInput uVOut
    "Measured outdoor airflow rate. Sensor output. Location: after the economizer damper intake."
    annotation (Placement(transformation(extent={{-120,10},{-100,30}})));
  CDL.Interfaces.RealInput uVOutMinSet
    "Minimum outdoor airflow requirement, output of a separate sequence that calculates this value based on ASHRAE Standard 62.1-2013 or California Title 24"
    annotation (Placement(transformation(extent={{-120,30},{-100,50}})));
equation
  connect(econEnableDisable.uOutDamPosMax, ecoEnaDis.yOutDamPosMax) annotation (
     Line(points={{-22,-57.7778},{-42,-57.7778},{-42,30.125},{-59.4444,30.125}},
                                                          color={0,0,127}));
  connect(econEnableDisable.uOutDamPosMin, ecoEnaDis.yOutDamPosMin) annotation (
     Line(points={{-22,-53.3333},{-40,-53.3333},{-40,22},{-40,31.875},{-59.4444,
          31.875}},                                                    color={0,
          0,127}));
  connect(ecoEnaDis.yRetDamPosMin, ecoMod.uRetDamPosMin) annotation (Line(
        points={{-59.4444,28.125},{-26,28.125},{-26,3.07143},{39.3571,3.07143}},
                                                     color={0,0,127}));
  connect(ecoEnaDis.yRetDamPosMax, ecoMod.uRetDamPosMax) annotation (Line(
        points={{-59.4444,26.125},{-30,26.125},{-30,1.07143},{39.3571,1.07143}},
                                                       color={0,0,127}));
  connect(ecoEnaDis.yOutDamPosMin, ecoMod.uOutDamPosMin) annotation (Line(
        points={{-59.4444,31.875},{-20,31.875},{-20,7.21429},{39.3571,7.21429}},
        color={0,0,127}));
  connect(econEnableDisable.yOutDamPosMax, ecoMod.uOutDamPosMax) annotation (
      Line(points={{1.9,-51.2222},{10,-51.2222},{10,5.21429},{39.3571,5.21429}},
                                                            color={0,0,127}));
  connect(ecoMod.yRetDamPos, yRetDamPos) annotation (Line(points={{60.7143,
          11.4286},{80,11.4286},{80,20},{110,20}},
                             color={0,0,127}));
  connect(ecoMod.yOutDamPos, yOutDamPos) annotation (Line(points={{60.7143,
          8.57143},{80,8.57143},{80,-20},{110,-20}},
                               color={0,0,127}));
  connect(TCooSet, ecoMod.TCooSet) annotation (Line(points={{-110,80},{-46,80},
          {20,80},{20,18.0714},{39.3571,18.0714}},
                                   color={0,0,127}));
  connect(TSup, ecoMod.TSup) annotation (Line(points={{-110,60},{10,60},{10,
          16.2143},{39.3571,16.2143}},
                    color={0,0,127}));
  connect(uCoo, ecoMod.uCoo) annotation (Line(points={{-110,-20},{-36,-20},{-36,
          14.0714},{39.3571,14.0714}},
                        color={0,0,127}));
  connect(uHea, ecoMod.uHea) annotation (Line(points={{-110,-40},{-38,-40},{-38,
          11.7857},{39.2143,11.7857}},
                      color={0,0,127}));
  connect(TOut, econEnableDisable.TOut) annotation (Line(points={{-110,100},{
          -40,100},{-40,-42.2222},{-22,-42.2222}},
                                     color={0,0,127}));
  connect(TSup, econEnableDisable.TSup) annotation (Line(points={{-110,60},{-50,
          60},{-50,-46},{-22,-46}}, color={0,0,127}));
  connect(uSupFan, ecoEnaDis.uSupFan) annotation (Line(points={{-110,-60},{-88,
          -60},{-88,28},{-81.1111,28},{-81.1111,28.375}},
                              color={255,0,255}));
  connect(uVOut, ecoEnaDis.uVOut) annotation (Line(points={{-110,20},{-98,20},{
          -98,32.5},{-81.1111,32.5}},
                         color={0,0,127}));
  connect(uVOutMinSet, ecoEnaDis.uVOutMinSet) annotation (Line(points={{-110,40},
          {-98,40},{-98,36.375},{-81.1111,36.375}},
                                       color={0,0,127}));
  connect(uAHUMod, ecoEnaDis.uAHUMod) annotation (Line(points={{-110,0},{-92,0},
          {-92,24},{-81.1111,24},{-81.1111,24.375}},
                              color={255,0,255}));
  connect(uFre, econEnableDisable.uFre) annotation (Line(points={{-110,-80},{-66,
          -80},{-66,-50},{-22,-50}}, color={255,0,255}));
  connect(uSupFan, ecoMod.uSupFan) annotation (Line(points={{-110,-60},{-36,-60},
          {-36,9.5},{39.3571,9.5}},
                           color={255,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
        extent={{-100,-100},{100,100}},
        lineColor={0,0,127},
        fillColor={255,255,255},
        fillPattern=FillPattern.Solid),
        Line(points={{-66,-36},{-42,-36},{-4,40},{34,40}}, color={28,108,200},
          thickness=0.5),
        Line(
          points={{-64,40},{-38,40},{2,-40},{66,-40}},
          color={28,108,200},
          pattern=LinePattern.Dash,
          thickness=0.5),
        Line(
          points={{34,40},{34,-36},{34,-36},{66,-36}},
          color={28,108,200},
          thickness=0.5),
        Text(
          extent={{100,62},{170,26}},
          lineColor={0,0,127},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          textString="yRetDamPos",
          fontSize=40),
        Text(
          extent={{100,18},{170,-18}},
          lineColor={0,0,127},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          textString="yOutDamPos",
          fontSize=40)}), Diagram(coordinateSystem(preserveAspectRatio=false)));
end Economizer;
