within Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.Staging.Subsequences.UpProcessP;
block ReduceChillerDemand
  "Sequence for reducing operating chiller demand"

  parameter Integer num = 2 "Total number of chillers in the plant";
  parameter Real chiDemRedFac = 0.75
    "Demand reducing factor of current operating chillers";
  parameter Modelica.SIunits.Time holChiDemTim = 300
    "Time of actual demand less than center percentage of currnet load";

  Buildings.Controls.OBC.CDL.Interfaces.RealInput uChiCur[num](
    each final quantity="ElectricCurrent",
    each final unit="A") "Chiller demand measured by electric current"
    annotation (Placement(transformation(extent={{-200,10},{-160,50}}),
      iconTransformation(extent={{-140,-20},{-100,20}})));
  Buildings.Controls.OBC.CDL.Interfaces.BooleanInput uChi[num]
    "Chiller status: true=ON"
     annotation (Placement(transformation(extent={{-200,-70},{-160,-30}}),
       iconTransformation(extent={{-140,-80},{-100,-40}})));
  Buildings.Controls.OBC.CDL.Interfaces.BooleanInput uStaUp
    "Stage up status: true=stage-up"
    annotation (Placement(transformation(extent={{-200,90},{-160,130}}),
      iconTransformation(extent={{-140,40},{-100,80}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealOutput yChiCur[num](
    each final quantity="ElectricCurrent",
    each final unit="A") "Current setpoint to chillers"
    annotation (Placement(transformation(extent={{160,70},{180,90}}),
      iconTransformation(extent={{100,30},{120,50}})));
  Buildings.Controls.OBC.CDL.Interfaces.BooleanOutput yChiDemRed
    "Indicate if the chiller demand reduction process has finished"
    annotation (Placement(transformation(extent={{160,-110},{180,-90}}),
      iconTransformation(extent={{100,-50},{120,-30}})));

protected
  Buildings.Controls.OBC.CDL.Discrete.TriggeredSampler triSam[num]
    "Triggered sampler to sample current chiller demand"
    annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
  Buildings.Controls.OBC.CDL.Routing.BooleanReplicator booRep(
    final nout=num)
    "Replicate boolean input "
    annotation (Placement(transformation(extent={{-140,100},{-120,120}})));
  Buildings.Controls.OBC.CDL.Logical.Switch swi4[num]
    "Current setpoint to chillers"
    annotation (Placement(transformation(extent={{80,70},{100,90}})));
  Buildings.Controls.OBC.CDL.Continuous.Gain gai[num](
    each final k=chiDemRedFac)
    "Reduce demand to a factor of current load"
    annotation (Placement(transformation(extent={{-20,20},{0,40}})));
  Buildings.Controls.OBC.CDL.Continuous.Sources.Constant con[num](
    each final k=0.2)
    "Constant value to avoid zero as the denominator"
    annotation (Placement(transformation(extent={{-140,-110},{-120,-90}})));
  Buildings.Controls.OBC.CDL.Logical.Switch swi[num]
    "Change zero input to a given constant if the chiller is not enabled"
    annotation (Placement(transformation(extent={{-80,-60},{-60,-40}})));
  Buildings.Controls.OBC.CDL.Continuous.Hysteresis hys[num](
    each final uLow=chiDemRedFac + 0.5 - 0.1,
    each final uHigh=chiDemRedFac + 0.5 + 0.1)
    "Check if actual demand has already reduced at instant when receiving stage change signal"
    annotation (Placement(transformation(extent={{-20,-110},{0,-90}})));
  Buildings.Controls.OBC.CDL.Continuous.Division div[num]
    "Output result of first input divided by second input"
    annotation (Placement(transformation(extent={{-20,-60},{0,-40}})));
  Buildings.Controls.OBC.CDL.Logical.Not not1[num] "Logical not"
    annotation (Placement(transformation(extent={{20,-110},{40,-90}})));
  Buildings.Controls.OBC.CDL.Logical.MultiAnd mulAnd(final nu=num)
    "Output true when elements of input vector are true"
    annotation (Placement(transformation(extent={{60,-110},{80,-90}})));
  Buildings.Controls.OBC.CDL.Logical.TrueDelay truDel(
    final delayTime=holChiDemTim)
    "Wait a giving time before proceeding"
    annotation (Placement(transformation(extent={{100,-110},{120,-90}})));

equation
  connect(uStaUp, booRep.u)
    annotation (Line(points={{-180,110},{-142,110}}, color={255,0,255}));
  connect(booRep.y, triSam.trigger)
    annotation (Line(points={{-119,110},{-100,110},{-100,10},{-70,10},
      {-70,18.2}}, color={255,0,255}));
  connect(uChiCur, triSam.u)
    annotation (Line(points={{-180,30},{-82,30}}, color={0,0,127}));
  connect(triSam.y, gai.u)
    annotation (Line(points={{-59,30},{-22,30}}, color={0,0,127}));
  connect(uChiCur, swi4.u3)
    annotation (Line(points={{-180,30},{-120,30},{-120,72},{78,72}}, color={0,0,127}));
  connect(gai.y, swi4.u1)
    annotation (Line(points={{1,30},{60,30},{60,88},{78,88}},color={0,0,127}));
  connect(booRep.y, swi4.u2)
    annotation (Line(points={{-119,110},{-100,110},{-100,80},{78,80}},
      color={255,0,255}));
  connect(uChi, swi.u2)
    annotation (Line(points={{-180,-50},{-82,-50}}, color={255,0,255}));
  connect(con.y, swi.u3)
    annotation (Line(points={{-119,-100},{-100,-100},{-100,-58},{-82,-58}},
      color={0,0,127}));
  connect(triSam.y, swi.u1)
    annotation (Line(points={{-59,30},{-40,30},{-40,-10},{-100,-10},
      {-100,-42},{-82,-42}}, color={0,0,127}));
  connect(swi.y, div.u2)
    annotation (Line(points={{-59,-50},{-40,-50},{-40,-56},{-22,-56}}, color={0,0,127}));
  connect(uChiCur, div.u1)
    annotation (Line(points={{-180,30},{-120,30},{-120,-30},{-40,-30},
      {-40,-44},{-22,-44}}, color={0,0,127}));
  connect(div.y, hys.u)
    annotation (Line(points={{1,-50},{20,-50},{20,-70},{-40,-70},
      {-40,-100},{-22,-100}}, color={0,0,127}));
  connect(hys.y, not1.u)
    annotation (Line(points={{1,-100},{18,-100}}, color={255,0,255}));
  connect(not1.y, mulAnd.u)
    annotation (Line(points={{41,-100},{58,-100}}, color={255,0,255}));
  connect(mulAnd.y, truDel.u)
    annotation (Line(points={{81.7,-100},{98,-100}}, color={255,0,255}));
  connect(swi4.y, yChiCur)
    annotation (Line(points={{101,80},{170,80}}, color={0,0,127}));
  connect(truDel.y, yChiDemRed)
    annotation (Line(points={{121,-100},{170,-100}}, color={255,0,255}));

annotation (
  defaultComponentName="chiDemRed",
  Icon(graphics={
        Rectangle(
        extent={{-100,-100},{100,100}},
        lineColor={0,0,127},
        fillColor={255,255,255},
        fillPattern=FillPattern.Solid),
        Text(
          extent={{-15,6.5},{15,-6.5}},
          lineColor={0,0,127},
          pattern=LinePattern.Dash,
          origin={-85,-57.5},
          rotation=0,
          textString="uChi"),
        Text(
          extent={{-21,9.5},{21,-9.5}},
          lineColor={0,0,127},
          pattern=LinePattern.Dash,
          origin={-77,1.5},
          rotation=0,
          textString="uChiCur"),
        Text(
          extent={{-120,146},{100,108}},
          lineColor={0,0,255},
          textString="%name"),
        Text(
          extent={{-98,70},{-54,54}},
          lineColor={255,0,255},
          pattern=LinePattern.Dash,
          textString="uStaUp"),
        Text(
          extent={{-21,9.5},{21,-9.5}},
          lineColor={0,0,127},
          pattern=LinePattern.Dash,
          origin={75,41.5},
          rotation=0,
          textString="yChiCur"),
        Text(
          extent={{30,-30},{96,-46}},
          lineColor={255,0,255},
          pattern=LinePattern.Dash,
          textString="yChiDemRed")}),
  Diagram(coordinateSystem(preserveAspectRatio=false,
          extent={{-160,-140},{160,140}})),
  Documentation(info="<html>
<p>
Block that reduces demand of current operating chillers when there is a stage-up
command, according to ASHRAE RP-1711 Advanced Sequences of Operation for 
HVAC Systems Phase II – Central Plants and Hydronic Systems (Draft 4 on 
January 7, 2019), section 5.2.4.18, part 5.2.4.18.1.
It is for primary-only parallel chiller plants with headered chilled water pumps
and headered condenser water pumps.
</p>
<p>
When there is a stage-up command, 
</p>
<ul>
<li>
Command operating chillers to reduce demand to <code>chiDemRedFac</code> of 
their current load, e.g. 75%.  
Fixme: exactly, what is demand? what is current load?
</li>
<li>
Wait until actual demand &lt; 80% of current load up to a maximum of 
<code>holChiDemTim</code> before proceeding.
</li>
</ul>

</html>",
revisions="<html>
<ul>
<li>
January 31, 2019, by Jianjun Hu:<br/>
First implementation.
</li>
</ul>
</html>"));
end ReduceChillerDemand;
