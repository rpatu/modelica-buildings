within Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.Tower.FanSpeed.ReturnWaterTemperature.Subsequences;
block Setpoint "Calculate condener return water temperature setpoint"

  parameter Integer nChi = 2 "Total number of chillers";
  parameter Real LIFT_min[nChi] = {12, 12} "Minimum LIFT of each chiller";
  parameter Real LIFT_max[nChi] = {25, 25} "Maximum LIFT of each chiller";
  parameter Modelica.SIunits.HeatFlowRate desCap = 1e6
    "Plant design capacity";

  Buildings.Controls.OBC.CDL.Interfaces.BooleanInput uChi[nChi] "Chiller status"
    annotation (Placement(transformation(extent={{-220,10},{-180,50}}),
      iconTransformation(extent={{-140,60},{-100,100}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealInput reqPlaCap(
    final unit="W",
    final quantity="HeatFlowRate")
    "Current plant required capacity"
    annotation (Placement(transformation(extent={{-220,-50},{-180,-10}}),
      iconTransformation(extent={{-140,-20},{-100,20}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealInput TChiWatSupSet(
    final unit="K",
    final quantity="ThermodynamicTemperature")
    "Chilled water supply setpoint temperature"
    annotation (Placement(transformation(extent={{-220,-110},{-180,-70}}),
      iconTransformation(extent={{-140,-100},{-100,-60}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealOutput TConWatRetSet(
    final unit="K",
    final quantity="ThermodynamicTemperature")
    "Condenser water return temperature setpoint"
    annotation (Placement(transformation(extent={{180,-80},{200,-60}}),
      iconTransformation(extent={{100,-10},{120,10}})));

protected
  Buildings.Controls.OBC.CDL.Continuous.Sources.Constant chiLifMax[nChi](
    final k=LIFT_max) "Maximum LIFT of chillers"
    annotation (Placement(transformation(extent={{-140,80},{-120,100}})));
  Buildings.Controls.OBC.CDL.Continuous.MultiMax lifMax(
    final nin=nChi) "Maximum chiller LIFT"
    annotation (Placement(transformation(extent={{-80,80},{-60,100}})));
  Buildings.Controls.OBC.CDL.Continuous.Sources.Constant chiLifMin[nChi](
    final k=LIFT_min)
    "Minimum LIFT of chillers"
    annotation (Placement(transformation(extent={{-140,40},{-120,60}})));
  Buildings.Controls.OBC.CDL.Continuous.Sources.Constant zeoCon[nChi](
    each final k=0) "Zero constant"
    annotation (Placement(transformation(extent={{-140,0},{-120,20}})));
  Buildings.Controls.OBC.CDL.Logical.Switch swi[nChi] "Logical switch"
    annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
  Buildings.Controls.OBC.CDL.Continuous.MultiMax lifMin(
    final nin=nChi) "Minimum chiller LIFT"
    annotation (Placement(transformation(extent={{-20,20},{0,40}})));
  Buildings.Controls.OBC.CDL.Continuous.Add coeA(
    final k1=1.1, final k2=-1.1) "Coefficien A"
    annotation (Placement(transformation(extent={{20,50},{40,70}})));
  Buildings.Controls.OBC.CDL.Continuous.Feedback coeB "Coefficient B"
    annotation (Placement(transformation(extent={{80,80},{100,100}})));
  Buildings.Controls.OBC.CDL.Continuous.Gain plaParLoaRat(
    final k=1/desCap) "Plant part load ratio"
    annotation (Placement(transformation(extent={{-140,-40},{-120,-20}})));
  Buildings.Controls.OBC.CDL.Continuous.Product pro "Product of inputs"
    annotation (Placement(transformation(extent={{80,-10},{100,10}})));
  Buildings.Controls.OBC.CDL.Continuous.Add add2
    annotation (Placement(transformation(extent={{120,-10},{140,10}})));
  Buildings.Controls.OBC.CDL.Continuous.Min min "Minimum value of two inputs"
    annotation (Placement(transformation(extent={{-20,-70},{0,-50}})));
  Buildings.Controls.OBC.CDL.Continuous.Max tarLif "Target chiller LIFT"
    annotation (Placement(transformation(extent={{20,-70},{40,-50}})));
  Buildings.Controls.OBC.CDL.Continuous.Add conWatRet
    "Condenser water return temperature"
    annotation (Placement(transformation(extent={{80,-80},{100,-60}})));

equation
  connect(uChi, swi.u2)
    annotation (Line(points={{-200,30},{-82,30}},  color={255,0,255}));
  connect(zeoCon.y, swi.u3)
    annotation (Line(points={{-119,10},{-100,10},{-100,22},{-82,22}},
      color={0,0,127}));
  connect(chiLifMin.y, swi.u1)
    annotation (Line(points={{-119,50},{-100,50},{-100,38},{-82,38}},
      color={0,0,127}));
  connect(lifMax.y, coeA.u1)
    annotation (Line(points={{-59,90},{10,90},{10,66},{18,66}}, color={0,0,127}));
  connect(lifMin.y, coeA.u2)
    annotation (Line(points={{1,30},{10,30},{10,54},{18,54}}, color={0,0,127}));
  connect(coeA.y, coeB.u2)
    annotation (Line(points={{41,60},{90,60},{90,78}}, color={0,0,127}));
  connect(lifMax.y, coeB.u1)
    annotation (Line(points={{-59,90},{78,90}}, color={0,0,127}));
  connect(reqPlaCap, plaParLoaRat.u)
    annotation (Line(points={{-200,-30},{-142,-30}}, color={0,0,127}));
  connect(coeA.y, pro.u1)
    annotation (Line(points={{41,60},{60,60},{60,6},{78,6}}, color={0,0,127}));
  connect(plaParLoaRat.y, pro.u2)
    annotation (Line(points={{-119,-30},{-100,-30},{-100,-6},{78,-6}},
      color={0,0,127}));
  connect(coeB.y, add2.u1)
    annotation (Line(points={{101,90},{110,90},{110,6},{118,6}}, color={0,0,127}));
  connect(pro.y, add2.u2)
    annotation (Line(points={{101,0},{110,0},{110,-6},{118,-6}}, color={0,0,127}));
  connect(lifMax.y, min.u2)
    annotation (Line(points={{-59,90},{-50,90},{-50,-66},{-22,-66}},
      color={0,0,127}));
  connect(add2.y, min.u1)
    annotation (Line(points={{141,0},{160,0},{160,-30},{-40,-30},{-40,-54},
      {-22,-54}}, color={0,0,127}));
  connect(min.y, tarLif.u2)
    annotation (Line(points={{1,-60},{10,-60},{10,-66},{18,-66}},
      color={0,0,127}));
  connect(lifMin.y, tarLif.u1)
    annotation (Line(points={{1,30},{10,30},{10,-54},{18,-54}}, color={0,0,127}));
  connect(tarLif.y, conWatRet.u1)
    annotation (Line(points={{41,-60},{60,-60},{60,-64},{78,-64}},
      color={0,0,127}));
  connect(TChiWatSupSet, conWatRet.u2)
    annotation (Line(points={{-200,-90},{60,-90},{60,-76},{78,-76}},
      color={0,0,127}));
  connect(conWatRet.y, TConWatRetSet)
    annotation (Line(points={{101,-70},{190,-70}}, color={0,0,127}));
  connect(swi.y, lifMin.u)
    annotation (Line(points={{-59,30},{-22,30}}, color={0,0,127}));
  connect(chiLifMax.y, lifMax.u)
    annotation (Line(points={{-119,90},{-82,90}},  color={0,0,127}));

annotation (
  defaultComponentName="conWatRetSet",
  Diagram(coordinateSystem(preserveAspectRatio=false,
          extent={{-180,-120},{180,120}})),
    Icon(graphics={
        Text(
          extent={{-120,146},{100,108}},
          lineColor={0,0,255},
          textString="%name"),
        Rectangle(
        extent={{-100,-100},{100,100}},
        lineColor={0,0,127},
        fillColor={255,255,255},
        fillPattern=FillPattern.Solid)}));
end Setpoint;
