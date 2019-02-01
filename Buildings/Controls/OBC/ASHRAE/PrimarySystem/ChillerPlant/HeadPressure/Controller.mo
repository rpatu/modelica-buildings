within Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.HeadPressure;
block Controller "Controller for head pressure control"

  parameter Real minTowSpe "Minimum cooling tower fan speed";
  parameter Real minConWatPumSpe "Minimum condenser water pump speed"
    annotation (Dialog(enable=hasWSE));
  parameter Real minHeaPreValPos "Minimum head pressure control valve position";
  parameter Boolean hasHeaPreConSig = false
    "Flag to check if there is head pressure control signal from chiller controller"
    annotation (Dialog(group="Plant"));
  parameter Boolean hasWSE = true
    "Flag to check if the plant has waterside economizer"
    annotation (Dialog(group="Plant"));
  parameter Modelica.SIunits.TemperatureDifference minChiLif
    "Minimum allowable lift at minimum load for chiller"
    annotation (Dialog(tab="Loop signal", enable=not hasHeaPreConSig));
  parameter Buildings.Controls.OBC.CDL.Types.SimpleController controllerType=
    Buildings.Controls.OBC.CDL.Types.SimpleController.PI
    "Type of controller"
    annotation (Dialog(tab="Loop signal", group="PID controller", enable=not hasHeaPreConSig));
  parameter Real k=1 "Gain of controller"
    annotation (Dialog(tab="Loop signal", group="PID controller", enable=not hasHeaPreConSig));
  parameter Modelica.SIunits.Time Ti=0.5 "Time constant of integrator block"
    annotation (Dialog(tab="Loop signal", group="PID controller", enable=not hasHeaPreConSig));

  Buildings.Controls.OBC.CDL.Interfaces.RealInput TConWatRet if not hasHeaPreConSig
    "Measured condenser water return temperature"
    annotation (Placement(transformation(extent={{-140,70},{-100,110}}),
      iconTransformation(extent={{-120,50},{-100,70}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealInput TChiWatSup if not hasHeaPreConSig
    "Measured chilled water supply temperature"
    annotation (Placement(transformation(extent={{-140,40},{-100,80}}),
      iconTransformation(extent={{-120,30},{-100,50}})));
  Buildings.Controls.OBC.CDL.Interfaces.BooleanInput uHeaPreEna
    "Status of head pressure control: true = ON, false = OFF"
    annotation (Placement(transformation(extent={{-140,100},{-100,140}}),
      iconTransformation(extent={{-120,70},{-100,90}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealInput uMaxTowSpeSet if hasWSE
    "Current maximum cooling tower speed setpoint"
    annotation (Placement(transformation(extent={{-140,10},{-100,50}}),
      iconTransformation(extent={{-120,10},{-100,30}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealInput uConWatPumSpe if hasWSE
    "Current condenser water pump speed"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}}),
      iconTransformation(extent={{-120,-10},{-100,10}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealInput uConWatPumSpe_nominal if
       hasWSE
    "Design condenser water pump speed for current stage"
    annotation (Placement(transformation(extent={{-140,-50},{-100,-10}}),
    iconTransformation(extent={{-120,-30},{-100,-10}})));
  Buildings.Controls.OBC.CDL.Interfaces.BooleanInput uWSE if hasWSE
    "Status of water side economizer: true = ON, false = OFF"
    annotation (Placement(transformation(extent={{-140,-80},{-100,-40}}),
      iconTransformation(extent={{-120,-50},{-100,-30}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealInput uHeaPreConVal if hasWSE
    "Current head pressure control valve position"
    annotation (Placement(transformation(extent={{-140,-110},{-100,-70}}),
      iconTransformation(extent={{-120,-70},{-100,-50}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealInput uHeaPreCon if hasHeaPreConSig
    "Chiller head pressure control loop signal from chiller controller"
    annotation (Placement(transformation(extent={{-140,-140},{-100,-100}}),
      iconTransformation(extent={{-120,-90},{-100,-70}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealOutput yMaxTowSpeSet
    "Maximum cooling tower speed setpoint"
    annotation (Placement(transformation(extent={{100,46},{120,66}}),
      iconTransformation(extent={{100,50},{120,70}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealOutput yHeaPreConVal
    "Head pressure control valve position"
    annotation (Placement(transformation(extent={{100,10},{120,30}}),
      iconTransformation(extent={{100,-10},{120,10}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealOutput yConWatPumSpe if hasWSE
    "Condenser water pump speed"
    annotation (Placement(transformation(extent={{100,-50},{120,-30}}),
      iconTransformation(extent={{100,-70},{120,-50}})));

protected
  Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.HeadPressure.Subsequences.ControlLoop
    chiHeaPreLoo(
    final minChiLif=minChiLif,
    final controllerType=controllerType,
    final k=k,
    final Ti=Ti) if not hasHeaPreConSig
    "Generate chiller head pressure control loop signal"
    annotation (Placement(transformation(extent={{-20,80},{0,100}})));
  Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.HeadPressure.Subsequences.EquipmentsSet_noWSE noWSE(
    final minTowSpe=minTowSpe,
    final minHeaPreValPos=minHeaPreValPos) if not hasWSE
    "Controlling equipments for plants without waterside economizer"
    annotation (Placement(transformation(extent={{40,40},{60,60}})));
  Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.HeadPressure.Subsequences.EquipmentsSet_hasWSE
    withWSE(
    final minTowSpe=minTowSpe,
    final minConWatPumSpe=minConWatPumSpe,
    final minHeaPreValPos=minHeaPreValPos) if hasWSE
    "Controlling equipments for plants with waterside economizer"
    annotation (Placement(transformation(extent={{40,-20},{60,0}})));
  Buildings.Controls.OBC.CDL.Logical.Switch swi if hasHeaPreConSig
    annotation (Placement(transformation(extent={{-20,-120},{0,-100}})));
  Buildings.Controls.OBC.CDL.Continuous.Sources.Constant con(final k=0) if
       hasHeaPreConSig "Constant"
    annotation (Placement(transformation(extent={{-60,-140},{-40,-120}})));

equation
  connect(chiHeaPreLoo.TConWatRet, TConWatRet)
    annotation (Line(points={{-22,90},{-120,90}}, color={0,0,127}));
  connect(chiHeaPreLoo.TChiWatSup, TChiWatSup)
    annotation (Line(points={{-22,82},{-40,82},{-40,60},{-120,60}}, color={0,0,127}));
  connect(chiHeaPreLoo.uHeaPreEna, uHeaPreEna)
    annotation (Line(points={{-22,98},{-80,98},{-80,120},{-120,120}},
      color={255,0,255}));
  connect(chiHeaPreLoo.yHeaPreCon, noWSE.uHeaPreCon)
    annotation (Line(points={{1,90},{20,90},{20,50},{38,50}}, color={0,0,127}));
  connect(chiHeaPreLoo.yHeaPreCon, withWSE.uHeaPreCon)
    annotation (Line(points={{1,90},{20,90},{20,-5},{39,-5}}, color={0,0,127}));
  connect(uHeaPreEna, noWSE.uHeaPreEna)
    annotation (Line(points={{-120,120},{-80,120},{-80,42},{38,42}},
      color={255,0,255}));
  connect(withWSE.uMaxTowSpeSet, uMaxTowSpeSet)
    annotation (Line(points={{39,-2},{0,-2},{0,30},{-120,30}}, color={0,0,127}));
  connect(withWSE.uConWatPumSpe, uConWatPumSpe)
    annotation (Line(points={{39,-8},{-40,-8},{-40,0},{-120,0}}, color={0,0,127}));
  connect(withWSE.uConWatPumSpe_nominal, uConWatPumSpe_nominal)
    annotation (Line(points={{39,-10},{-40,-10},{-40,-30},{-120,-30}},
      color={0,0,127}));
  connect(withWSE.uWSE, uWSE)
    annotation (Line(points={{39,-12},{-20,-12},{-20,-60},{-120,-60}},
      color={255,0,255}));
  connect(withWSE.uHeaPreConVal, uHeaPreConVal)
    annotation (Line(points={{39,-15},{0,-15},{0,-90},{-120,-90}}, color={0,0,127}));
  connect(uHeaPreEna, withWSE.uHeaPreEna)
    annotation (Line(points={{-120,120},{-80,120},{-80,-18},{39,-18}},
      color={255,0,255}));
  connect(uHeaPreEna, swi.u2)
    annotation (Line(points={{-120,120},{-80,120},{-80,-110},{-22,-110}},
      color={255,0,255}));
  connect(uHeaPreCon, swi.u1)
    annotation (Line(points={{-120,-120},{-70,-120},{-70,-102},{-22,-102}},
      color={0,0,127}));
  connect(con.y, swi.u3)
    annotation (Line(points={{-39,-130},{-30,-130},{-30,-118},{-22,-118}},
      color={0,0,127}));
  connect(swi.y, noWSE.uHeaPreCon)
    annotation (Line(points={{1,-110},{20,-110},{20,50},{38,50}}, color={0,0,127}));
  connect(swi.y, withWSE.uHeaPreCon)
    annotation (Line(points={{1,-110},{20,-110},{20,-5},{39,-5}}, color={0,0,127}));
  connect(noWSE.yMaxTowSpeSet, yMaxTowSpeSet)
    annotation (Line(points={{61,56},{110,56}}, color={0,0,127}));
  connect(noWSE.yHeaPreConVal, yHeaPreConVal)
    annotation (Line(points={{61,44},{90,44},{90,20},{110,20}}, color={0,0,127}));
  connect(withWSE.yHeaPreConVal, yHeaPreConVal)
    annotation (Line(points={{61,-16},{90,-16},{90,20},{110,20}}, color={0,0,127}));
  connect(withWSE.yMaxTowSpeSet, yMaxTowSpeSet)
    annotation (Line(points={{61,-4},{80,-4},{80,56},{110,56}}, color={0,0,127}));
  connect(withWSE.yConWatPumSpe, yConWatPumSpe)
    annotation (Line(points={{61,-10},{80,-10},{80,-40},{110,-40}},
      color={0,0,127}));

annotation (
  defaultComponentName="heaPreCon",
  Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Text(
          extent={{-120,146},{100,108}},
          lineColor={0,0,255},
          textString="%name"),
        Rectangle(
        extent={{-100,-100},{100,100}},
        lineColor={0,0,127},
        fillColor={255,255,255},
        fillPattern=FillPattern.Solid)}),
  Diagram(coordinateSystem(preserveAspectRatio=false,
          extent={{-100,-140},{100,140}})),
  Documentation(info="<html>
<p>
Block that generates control signals for chiller head pressure control, 
according to ASHRAE RP-1711 Advanced Sequences of Operation for HVAC Systems Phase II –
Central Plants and Hydronic Systems (Draft 4 on January 7, 2019), 
section 5.2.10 Head pressure control. 
</p>
<p>
This sequence contains three subsequences:
</p>
<ul>
<li>
First, if the head pressure control signal <code>uHeaPreCon</code> is not 
available from the chiller controller. The signal will be generated by block 
<code>chiHeaPreLoo</code>. See
<a href=\"modelica://Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.HeadPressure.Subsequences.ControlLoop\">
Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.HeadPressure.Subsequences.ControlLoop</a>
for a description.
</li>
<li>
If the chiller plant does not have waterside economizer, block <code>noWSE</code>
will be used for controlling maximum cooling tower speed setpoint 
<code>yMaxTowSpeSet</code> and head pressure control valve position 
<code>yHeaPreConVal</code>. See
<a href=\"modelica://Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.HeadPressure.Subsequences.EquipmentsSet_noWSE\">
Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.HeadPressure.Subsequences.EquipmentsSet_noWSE</a>
for a description.
</li>
<li>
If the chiller plant has waterside economizer, block <code>withWSE</code>
will be used for <code>yMaxTowSpeSet</code>, <code>yHeaPreConVal</code> and 
condenser water pump speed <code>yConWatPumSpe</code>. See
<a href=\"modelica://Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.HeadPressure.Subsequences.EquipmentsSet_hasWSE\">
Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.HeadPressure.Subsequences.EquipmentsSet_hasWSE</a>
for a description.
</li>
</ul>
</html>",
revisions="<html>
<ul>
<li>
January 30, 2019, by Jianjun Hu:<br/>
First implementation.
</li>
</ul>
</html>"));
end Controller;
