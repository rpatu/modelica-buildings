within Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.Generic;
block PlantEnable "Sequence to enable and disable plant"

  parameter Real schTab[4,2] = [0,1; 6*3600,1; 19*3600,1; 24*3600,1]
    "Table matrix (time = first column is time in seconds, unless timeScale <> 1)";
  parameter Buildings.Controls.OBC.CDL.Types.Smoothness tabSmo=
    Buildings.Controls.OBC.CDL.Types.Smoothness.ConstantSegments
    "Smoothness of table interpolation";
  final parameter Buildings.Controls.OBC.CDL.Types.Extrapolation extrapolation=
    Buildings.Controls.OBC.CDL.Types.Extrapolation.Periodic
    "Extrapolation of data outside the definition range";
  parameter Modelica.SIunits.Temperature TChiLocOut
    "Outdoor air lockout temperature below which the chiller plant should be disabled";
  parameter Modelica.SIunits.Time plaThrTim = 15*60
    "Threshold time to check status of chiller plant";
  parameter Modelica.SIunits.Time reqThrTim = 3*60
    "Threshold time to check current chiller plant request";
  parameter Integer ignReq = 0
    "Ignorable chiller plant requests";
  parameter Integer iniSta = 0
    "Lowest chiller plant stage";

  Buildings.Controls.OBC.CDL.Interfaces.BooleanInput uPla
    "Current chiller plant enabling status"
    annotation (Placement(transformation(extent={{-240,120},{-200,160}}),
      iconTransformation(extent={{-140,40},{-100,80}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealInput TOut
    "Outdoor air temperature"
    annotation (Placement(transformation(extent={{-240,-10},{-200,30}}),
      iconTransformation(extent={{-140,-80},{-100,-40}})));
  Buildings.Controls.OBC.CDL.Interfaces.IntegerInput TChiWatSupResReq
    "Cooling chilled water supply temperature setpoint reset request"
    annotation (Placement(transformation(extent={{-240,80},{-200,120}}),
      iconTransformation(extent={{-140,-20},{-100,20}})));
  Buildings.Controls.OBC.CDL.Interfaces.IntegerOutput yIniChiSta
    "Initial chiller plant stage"
    annotation (Placement(transformation(extent={{200,-50},{220,-30}}),
      iconTransformation(extent={{100,-70},{120,-50}})));
  Buildings.Controls.OBC.CDL.Interfaces.BooleanOutput yPla
    "Chiller plant enabling status"
    annotation (Placement(transformation(extent={{200,80},{220,100}}),
      iconTransformation(extent={{100,-10},{120,10}})));

protected
  Buildings.Controls.OBC.CDL.Continuous.Sources.TimeTable enaSch(
    final table=schTab,
    final smoothness=tabSmo,
    final extrapolation=extrapolation)
    "Plant enabling schedule allowing operators to lock out the plant during off-hour"
    annotation (Placement(transformation(extent={{-140,50},{-120,70}})));
  Buildings.Controls.OBC.CDL.Continuous.AddParameter addPar(
    final p=(-1)*TChiLocOut,
    final k=1)
    "Difference between chiller lockout temperature and outdoor temperature"
    annotation (Placement(transformation(extent={{-140,0},{-120,20}})));
  Buildings.Controls.OBC.CDL.Continuous.GreaterEqualThreshold schOn(
    final threshold=0.5)
    "Check if enabling schedule is active"
    annotation (Placement(transformation(extent={{-100,50},{-80,70}})));
  Buildings.Controls.OBC.CDL.Logical.Not not1 "Logical not"
    annotation (Placement(transformation(extent={{-140,130},{-120,150}})));
  Buildings.Controls.OBC.CDL.Logical.Timer disTim
    "Chiller plant disabled time"
    annotation (Placement(transformation(extent={{-100,130},{-80,150}})));
  Buildings.Controls.OBC.CDL.Integers.GreaterThreshold hasReq(
    final threshold=ignReq)
    "Check if the chiller plant request is greater than ignorable request"
    annotation (Placement(transformation(extent={{-140,90},{-120,110}})));
  Buildings.Controls.OBC.CDL.Logical.MultiAnd mulAnd(
    final nu=4)
    annotation (Placement(transformation(extent={{40,80},{60,100}})));
  Buildings.Controls.OBC.CDL.Logical.Timer enaTim "Chiller plant enabled time"
    annotation (Placement(transformation(extent={{-140,-50},{-120,-30}})));
  Buildings.Controls.OBC.CDL.Integers.LessThreshold intLesThr(
    final threshold=ignReq)
    "Check if the chiller plant request is less than ignorable request"
    annotation (Placement(transformation(extent={{-140,-110},{-120,-90}})));
  Buildings.Controls.OBC.CDL.Logical.Timer enaTim1
    "Total time when chiller plant request is less than ignorable request"
    annotation (Placement(transformation(extent={{-100,-110},{-80,-90}})));
  Buildings.Controls.OBC.CDL.Continuous.AddParameter addPar1(
    final p=TChiLocOut - 5/9,
    final k=-1)
    "Difference between chiller lockout temperature and outdoor temperature"
    annotation (Placement(transformation(extent={{-140,-150},{-120,-130}})));
  Buildings.Controls.OBC.CDL.Conversions.RealToInteger reaToInt
    annotation (Placement(transformation(extent={{140,-50},{160,-30}})));
  Buildings.Controls.OBC.CDL.Logical.Not not2 "Logical not"
    annotation (Placement(transformation(extent={{-20,-60},{0,-40}})));
  Buildings.Controls.OBC.CDL.Logical.And and2 "Logical and"
    annotation (Placement(transformation(extent={{40,-20},{60,0}})));
  Buildings.Controls.OBC.CDL.Logical.Latch lat
    "Maintains an on signal until conditions changes"
    annotation (Placement(transformation(extent={{100,80},{120,100}})));
  Buildings.Controls.OBC.CDL.Discrete.TriggeredSampler triSam
    annotation (Placement(transformation(extent={{140,30},{160,50}})));
  Buildings.Controls.OBC.CDL.Logical.Edge edg
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Buildings.Controls.OBC.CDL.Continuous.Sources.Constant con(final k=iniSta)
    "Lowest chiller stage"
    annotation (Placement(transformation(extent={{100,30},{120,50}})));
  Buildings.Controls.OBC.CDL.Continuous.Hysteresis hys(
    final uLow=0,
    final uHigh=0.25)
    "Check if outdoor temperature is higher than chiller lockout temperature"
    annotation (Placement(transformation(extent={{-100,0},{-80,20}})));
  Buildings.Controls.OBC.CDL.Continuous.GreaterEqualThreshold greEquThr(
    final threshold=plaThrTim)
    "Check if chiller plant has been disabled more than threshold time"
    annotation (Placement(transformation(extent={{-60,130},{-40,150}})));
  Buildings.Controls.OBC.CDL.Continuous.GreaterEqualThreshold greEquThr1(
    final threshold=plaThrTim)
    "Check if chiller plant has been enabled more than threshold time"
    annotation (Placement(transformation(extent={{-100,-50},{-80,-30}})));
  Buildings.Controls.OBC.CDL.Continuous.Hysteresis hys3(
    final uLow=0,
    final uHigh=0.25)
    "Check if outdoor temperature is lower than chiller lockout temperature minus 1 degF"
    annotation (Placement(transformation(extent={{-100,-150},{-80,-130}})));
  Buildings.Controls.OBC.CDL.Continuous.GreaterEqualThreshold greEquThr2(
    final threshold=reqThrTim)
    "Check if number of chiller plant request has been less than ignorable request by more than threshold time"
    annotation (Placement(transformation(extent={{-60,-110},{-40,-90}})));
  Buildings.Controls.OBC.CDL.Logical.MultiOr mulOr(final nu=3) "Logical or"
    annotation (Placement(transformation(extent={{40,-110},{60,-90}})));

equation
  connect(addPar.y, hys.u)
    annotation (Line(points={{-119,10},{-102,10}}, color={0,0,127}));
  connect(TOut, addPar.u)
    annotation (Line(points={{-220,10},{-142,10}}, color={0,0,127}));
  connect(enaSch.y[1], schOn.u)
    annotation (Line(points={{-119,60},{-102,60}}, color={0,0,127}));
  connect(uPla, not1.u)
    annotation (Line(points={{-220,140},{-142,140}}, color={255,0,255}));
  connect(not1.y, disTim.u)
    annotation (Line(points={{-119,140},{-102,140}}, color={255,0,255}));
  connect(disTim.y, greEquThr.u)
    annotation (Line(points={{-79,140},{-62,140}}, color={0,0,127}));
  connect(TChiWatSupResReq, hasReq.u)
    annotation (Line(points={{-220,100},{-142,100}}, color={255,127,0}));
  connect(uPla, enaTim.u)
    annotation (Line(points={{-220,140},{-160,140},{-160,-40},{-142,-40}},
      color={255,0,255}));
  connect(enaTim.y, greEquThr1.u)
    annotation (Line(points={{-119,-40},{-102,-40}}, color={0,0,127}));
  connect(TChiWatSupResReq, intLesThr.u)
    annotation (Line(points={{-220,100},{-170,100},{-170,-100},{-142,-100}},
      color={255,127,0}));
  connect(intLesThr.y, enaTim1.u)
    annotation (Line(points={{-119,-100},{-102,-100}}, color={255,0,255}));
  connect(enaTim1.y, greEquThr2.u)
    annotation (Line(points={{-79,-100},{-62,-100}}, color={0,0,127}));
  connect(TOut, addPar1.u)
    annotation (Line(points={{-220,10},{-180,10},{-180,-140},{-142,-140}},
      color={0,0,127}));
  connect(addPar1.y, hys3.u)
    annotation (Line(points={{-119,-140},{-102,-140}}, color={0,0,127}));
  connect(not2.y, mulOr.u[1])
    annotation (Line(points={{1,-50},{20,-50},{20,-95.3333},{38,-95.3333}},
      color={255,0,255}));
  connect(greEquThr2.y, mulOr.u[2])
    annotation (Line(points={{-39,-100},{38,-100}}, color={255,0,255}));
  connect(hys3.y, mulOr.u[3])
    annotation (Line(points={{-79,-140},{20,-140},{20,-104.667},{38,-104.667}},
      color={255,0,255}));
  connect(greEquThr1.y, and2.u1)
    annotation (Line(points={{-79,-40},{-60,-40},{-60,-10},{38,-10}},
      color={255,0,255}));
  connect(greEquThr.y, mulAnd.u[1])
    annotation (Line(points={{-39,140},{-20,140},{-20,95.25},{38,95.25}},
      color={255,0,255}));
  connect(hasReq.y, mulAnd.u[2])
    annotation (Line(points={{-119,100},{-40,100},{-40,91.75},{38,91.75}},
      color={255,0,255}));
  connect(schOn.y, mulAnd.u[3])
    annotation (Line(points={{-79,60},{-40,60},{-40,88.25},{38,88.25}},
      color={255,0,255}));
  connect(hys.y, mulAnd.u[4])
    annotation (Line(points={{-79,10},{-20,10},{-20,84.75},{38,84.75}},
      color={255,0,255}));
  connect(schOn.y, not2.u)
    annotation (Line(points={{-79,60},{-40,60},{-40,-50},{-22,-50}},
      color={255,0,255}));
  connect(mulAnd.y, lat.u)
    annotation (Line(points={{61.7,90},{99,90}}, color={255,0,255}));
  connect(and2.y, lat.u0)
    annotation (Line(points={{61,-10},{80,-10},{80,84},{99,84}}, color={255,0,255}));
  connect(lat.y, yPla)
    annotation (Line(points={{121,90},{210,90}}, color={255,0,255}));
  connect(mulOr.y, and2.u2)
    annotation (Line(points={{61.7,-100},{80,-100},{80,-40},{20,-40},{20,-18},
      {38,-18}}, color={255,0,255}));
  connect(lat.y, edg.u)
    annotation (Line(points={{121,90},{140,90},{140,60},{90,60},{90,0},{98,0}},
      color={255,0,255}));
  connect(edg.y, triSam.trigger)
    annotation (Line(points={{121,0},{150,0},{150,28.2}}, color={255,0,255}));
  connect(con.y, triSam.u)
    annotation (Line(points={{121,40},{138,40}}, color={0,0,127}));
  connect(triSam.y, reaToInt.u)
    annotation (Line(points={{161,40},{180,40},{180,-20},{120,-20},{120,-40},
      {138,-40}}, color={0,0,127}));
  connect(reaToInt.y, yIniChiSta)
    annotation (Line(points={{161,-40},{210,-40}}, color={255,127,0}));

annotation (
  defaultComponentName = "plaEna",
  Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-200,-160},{200,160}})),
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
          extent={{-17,7.5},{17,-7.5}},
          lineColor={0,0,127},
          pattern=LinePattern.Dash,
          origin={-83,59.5},
          rotation=0,
          textString="uPla"),
        Text(
          extent={{-49,9.5},{49,-9.5}},
          lineColor={0,0,127},
          pattern=LinePattern.Dash,
          origin={-47,-0.5},
          rotation=0,
          textString="TChiWatSupResReq"),
        Text(
          extent={{-16,6.5},{16,-6.5}},
          lineColor={0,0,127},
          pattern=LinePattern.Dash,
          origin={-84,-59.5},
          rotation=0,
          textString="TOut"),
        Text(
          extent={{-17,7.5},{17,-7.5}},
          lineColor={0,0,127},
          pattern=LinePattern.Dash,
          origin={81,-0.5},
          rotation=0,
          textString="yPla"),
        Text(
          extent={{-27,9},{27,-9}},
          lineColor={0,0,127},
          pattern=LinePattern.Dash,
          origin={69,-59},
          rotation=0,
          textString="yIniChiSta")}),
 Documentation(info="<html>
<p>
Block that generate chiller plant enable signals, according to
ASHRAE RP-1711 Advanced Sequences of Operation for HVAC Systems Phase II –
Central Plants and Hydronic Systems (Draft 4 on January 7, 2019), section 5.2.2.
</p>
<p>
1. An enabling schedule should be included to allow operators to lock out the 
chiller plant during off-hour, e.g. to allow off-hour operation of HVAC systems
except the chiller plant. The default schedule shall be 24/7 and be adjustable.
</p>
<p>
2. The plant should be enabled in the lowest stage when the plant has been
disabled for at least <code>plaThrTim</code>, e.g. 15 minutes and: 
</p>
<ul>
<li>
Number of chiller plant requests &gt; <code>ignReq</code> (<code>ignReq</code>
should default to 0 and adjustable), and,
</li>
<li>
Outdoor air temperature is greater than chiller lockout temperature, 
<code>TOut</code> &gt; <code>TChiLocOut</code>, and,
</li>
</ul>




</html>",
revisions="<html>
<ul>
<li>
January 24, 2019, by Jianjun Hu:<br/>
First implementation.
</li>
</ul>
</html>"));
end PlantEnable;
