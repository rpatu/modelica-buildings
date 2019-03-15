within Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.Tower.FanSpeed.ReturnWaterTemperature;
block Controller
  "Cooling tower speed control based on condenser water return temperature control"

  parameter Integer nChi=2 "Total number of chillers";
  parameter Integer nTowCel=4 "Total number of cooling tower cells";
  parameter Integer nConWatPum=2 "Total number of condenser water pumps";
  parameter Boolean haveWSE=true "Flag to indicate if the plant has waterside economizer";
  parameter Boolean closeCoupledPlant=true "Flag to indicate if the plant is close coupled";
  parameter Modelica.SIunits.HeatFlowRate desCap = 1e6 "Plant design capacity";
  parameter Real minTowSpe=0.1 "Minimum tower fan speed";
  parameter Modelica.SIunits.Temperature TTowSet=283.15 "Tower temperature setpoint"
    annotation (Dialog(tab="Tower enable"));
  parameter Real LIFT_min[nChi]={12,12} "Minimum LIFT of each chiller"
    annotation (Dialog(tab="Condenser water return temperature setpoint"));
  parameter Real LIFT_max[nChi]={25,25} "Maximum LIFT of each chiller"
    annotation (Dialog(tab="Condenser water return temperature setpoint"));
  parameter Modelica.SIunits.Time iniPlaTim=600
    "Time to hold return temperature to initial setpoint after plant being enabled"
    annotation (Dialog(tab="Condenser water return temperature setpoint",
                       group="Plant startup"));
  parameter Modelica.SIunits.Time ramTim=180
    "Time to ramp return water temperature from initial value to setpoint"
    annotation (Dialog(tab="Condenser water return temperature setpoint",
                       group="Plant startup"));
  parameter Modelica.SIunits.Temperature TConWatRet_nominal=303.15
    "Design condenser water return temperature"
    annotation (Dialog(tab="Condenser water return temperature setpoint",
                       group="Plant startup"));
  parameter Buildings.Controls.OBC.CDL.Types.SimpleController couPlaCon=
    Buildings.Controls.OBC.CDL.Types.SimpleController.PI
    "Type of controller"
    annotation (Dialog(tab="Coupled plant", group="Controller", enable=closeCoupledPlant));
  parameter Real kCouPla=1 "Gain of controller"
    annotation (Dialog(tab="Coupled plant", group="Controller", enable=closeCoupledPlant));
  parameter Modelica.SIunits.Time TiCouPla=0.5
    "Time constant of integrator block"
    annotation (Dialog(tab="Coupled plant", group="Controller", enable=closeCoupledPlant));
  parameter Real yCouPlaMax=1 "Upper limit of output"
    annotation (Dialog(tab="Coupled plant", group="Controller", enable=closeCoupledPlant));
  parameter Real yCouPlaMin=0 "Lower limit of output"
    annotation (Dialog(tab="Coupled plant", group="Controller", enable=closeCoupledPlant));
  parameter Modelica.SIunits.Time TdCouPla=0.1
    "Time constant of derivative block"
    annotation (Dialog(tab="Coupled plant", group="Controller", enable=closeCoupledPlant));
  parameter Modelica.SIunits.TemperatureDifference desTemDif=8
    "Design condenser water temperature difference"
    annotation (Dialog(tab="Less coupled plant", enable=not closeCoupledPlant));
  parameter Buildings.Controls.OBC.CDL.Types.SimpleController retWatCon=
    Buildings.Controls.OBC.CDL.Types.SimpleController.PI "Type of controller"
    annotation (Dialog(tab="Less coupled plant",
                       group="Return water temperature controller",
                       enable=not closeCoupledPlant));
  parameter Real kRetCon=1 "Gain of controller"
    annotation (Dialog(tab="Less coupled plant",
                       group="Return water temperature controller",
                       enable=not closeCoupledPlant));
  parameter Modelica.SIunits.Time TiRetCon=0.5
    "Time constant of integrator block"
    annotation (Dialog(tab="Less coupled plant",
                       group="Return water temperature controller",
                       enable=not closeCoupledPlant));
  parameter Modelica.SIunits.Time TdRetCon=0.1
    "Time constant of derivative block"
    annotation (Dialog(tab="Less coupled plant",
                       group="Return water temperature controller",
                       enable=not closeCoupledPlant));
  parameter Real yRetConMax=1 "Upper limit of output"
    annotation (Dialog(tab="Less coupled plant",
                       group="Return water temperature controller",
                       enable=not closeCoupledPlant));
  parameter Real yRetConMin=0 "Lower limit of output"
    annotation (Dialog(tab="Less coupled plant",
                       group="Return water temperature controller",
                       enable=not closeCoupledPlant));
  parameter Buildings.Controls.OBC.CDL.Types.SimpleController supWatCon=
    Buildings.Controls.OBC.CDL.Types.SimpleController.PI "Type of controller"
    annotation (Dialog(tab="Less coupled plant",
                       group="Supply water temperature controller",
                       enable=not closeCoupledPlant));
  parameter Real kSupCon=1 "Gain of controller"
    annotation (Dialog(tab="Less coupled plant",
                       group="Supply water temperature controller",
                       enable=not closeCoupledPlant));
  parameter Modelica.SIunits.Time TiSupCon=0.5 "Time constant of integrator block"
    annotation (Dialog(tab="Less coupled plant",
                       group="Supply water temperature controller",
                       enable=not closeCoupledPlant));
  parameter Modelica.SIunits.Time TdSupCon=0.1 "Time constant of derivative block"
    annotation (Dialog(tab="Less coupled plant",
                       group="Supply water temperature controller",
                       enable=not closeCoupledPlant));
  parameter Real ySupConMax=1 "Upper limit of output"
    annotation (Dialog(tab="Less coupled plant",
                       group="Supply water temperature controller",
                       enable=not closeCoupledPlant));
  parameter Real ySupConMin=0 "Lower limit of output"
    annotation (Dialog(tab="Less coupled plant",
                       group="Supply water temperature controller",
                       enable=not closeCoupledPlant));
  parameter Real speChe=0.005 "Lower threshold value to check fan or pump speed"
    annotation (Dialog(tab="Advanced"));

  Buildings.Controls.OBC.CDL.Interfaces.RealInput uTowSpeWSE(
     final min=0,
     final max=1,
     final unit="1") if haveWSE
    "Cooling tower speed when the waterside economizer is enabled"
    annotation (Placement(transformation(extent={{-200,220},{-160,260}}),
      iconTransformation(extent={{-220,180},{-200,200}})));
  Buildings.Controls.OBC.CDL.Interfaces.BooleanInput uChi[nChi]
    "Chiller enabling status: true=ON"
    annotation (Placement(transformation(extent={{-200,180},{-160,220}}),
      iconTransformation(extent={{-220,150},{-200,170}})));
  Buildings.Controls.OBC.CDL.Interfaces.BooleanInput uWSE if haveWSE
    "Waterside economizer status: true=ON"
    annotation (Placement(transformation(extent={{-200,140},{-160,180}}),
      iconTransformation(extent={{-220,120},{-200,140}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealInput reqPlaCap(
    final unit="W",
    final quantity="Power") "Current required plant capacity"
    annotation (Placement(transformation(extent={{-200,80},{-160,120}}),
      iconTransformation(extent={{-220,90},{-200,110}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealInput uMaxTowSpeSet[nChi](
    each final min=0,
    each final max=1,
    each final unit="1")
    "Maximum cooling tower speed setpoint from each chiller head pressure control loop"
    annotation (Placement(transformation(extent={{-200,20},{-160,60}}),
      iconTransformation(extent={{-220,60},{-200,80}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealInput uTowSpe(
    final min=0,
    final max=1,
    final unit="1") "Measured speed of current enabled tower fans"
    annotation (Placement(transformation(extent={{-200,-10},{-160,30}}),
      iconTransformation(extent={{-220,30},{-200,50}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealInput TTow(
    final quantity="ThermodynamicTemperature",
    final unit="K") "Measured tower temperature"
    annotation (Placement(transformation(extent={{-200,-40},{-160,0}}),
      iconTransformation(extent={{-220,0},{-200,20}})));
  Buildings.Controls.OBC.CDL.Interfaces.BooleanInput uTowSta[nTowCel]
    "Cooling tower operating status: true=running tower cell"
    annotation (Placement(transformation(extent={{-200,-70},{-160,-30}}),
      iconTransformation(extent={{-220,-30},{-200,-10}})));
  Buildings.Controls.OBC.CDL.Interfaces.IntegerInput uConWatPumNum(
    final min=0,
    final max=nConWatPum) "Number of enabling condenser water pumps"
    annotation (Placement(transformation(extent={{-200,-100},{-160,-60}}),
      iconTransformation(extent={{-220,-60},{-200,-40}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealInput TChiWatSupSet(
    final quantity="ThermodynamicTemperature",
    final unit="K") "Chilled water supply setpoint temperature"
    annotation (Placement(transformation(extent={{-200,-140},{-160,-100}}),
      iconTransformation(extent={{-220,-90},{-200,-70}})));
  Buildings.Controls.OBC.CDL.Interfaces.BooleanInput uPla
    "Plant enabling status"
    annotation (Placement(transformation(extent={{-200,-180},{-160,-140}}),
      iconTransformation(extent={{-220,-120},{-200,-100}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealInput TConWatRet(
    final quantity="ThermodynamicTemperature",
    final unit="K") "Condenser water return temperature"
    annotation (Placement(transformation(extent={{-200,-220},{-160,-180}}),
      iconTransformation(extent={{-220,-150},{-200,-130}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealInput uConWatPumSpe[nConWatPum](
    each final min=0,
    each final max=1,
    each final unit="1")
    "Current condenser water pump speed"
    annotation (Placement(transformation(extent={{-200,-260},{-160,-220}}),
      iconTransformation(extent={{-220,-180},{-200,-160}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealInput TConWatSup(
    final quantity="ThermodynamicTemperature",
    final unit="K") "Condenser water supply temperature"
    annotation (Placement(transformation(extent={{-200,-300},{-160,-260}}),
      iconTransformation(extent={{-220,-200},{-200,-180}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealOutput yTowSpe(
    final min=0,
    final max=1,
    final unit="1")
    "Cooling tower fan speed"
    annotation (Placement(transformation(extent={{160,190},{180,210}}),
      iconTransformation(extent={{200,70},{220,90}})));
  Buildings.Controls.OBC.CDL.Interfaces.BooleanOutput yTow
    "Tower fan status: true=enable fans; false=disable all fans"
    annotation (Placement(transformation(extent={{160,10},{180,30}}),
      iconTransformation(extent={{200,-90},{220,-70}})));

protected
  Buildings.Controls.OBC.CDL.Logical.MultiOr mulOr(
    final nu=nChi) "Multiple logical or"
    annotation (Placement(transformation(extent={{-120,190},{-100,210}})));
  Buildings.Controls.OBC.CDL.Logical.Not not1 if haveWSE "Logical not"
    annotation (Placement(transformation(extent={{-120,150},{-100,170}})));
  Buildings.Controls.OBC.CDL.Logical.And and2 "Logical and"
    annotation (Placement(transformation(extent={{-20,190},{0,210}})));
  Buildings.Controls.OBC.CDL.Continuous.Gain parLoaRat(
    final k=1/desCap) "Plant partial load ratio"
    annotation (Placement(transformation(extent={{-120,90},{-100,110}})));
  Buildings.Controls.OBC.CDL.Continuous.Line plrTowMaxSpe "Tower maximum speed"
    annotation (Placement(transformation(extent={{-20,90},{0,110}})));
  Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.Tower.FanSpeed.ReturnWaterTemperature.Subsequences.Setpoint conWatRetSet(
    final nChi=nChi,
    final LIFT_min=LIFT_min,
    final LIFT_max=LIFT_max,
    final iniPlaTim=iniPlaTim,
    final ramTim=ramTim,
    final TConWatRet_nominal=TConWatRet_nominal) "Condenser water return temperature setpoint"
    annotation (Placement(transformation(extent={{40,-80},{60,-60}})));
  Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.Tower.FanSpeed.ReturnWaterTemperature.Subsequences.Enable enaTow(
    final nChi=nChi,
    final nTowCel=nTowCel,
    final fanSpeChe=speChe,
    final minTowSpe=minTowSpe,
    final TTowSet=TTowSet) "Enable cooling tower"
    annotation (Placement(transformation(extent={{40,10},{60,30}})));
  Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.Tower.FanSpeed.ReturnWaterTemperature.Subsequences.CoupledSpeed couTowSpe(
    final nChi=nChi,
    final nConWatPum=nConWatPum,
    final minTowSpe=minTowSpe,
    final pumSpeChe=speChe,
    final controllerType=couPlaCon,
    final k=kCouPla,
    final Ti=TiCouPla,
    final Td=TdCouPla,
    final yMax=yCouPlaMax,
    final yMin=yCouPlaMin) if closeCoupledPlant
    "Tower fan speed control when the plant is closed coupled"
    annotation (Placement(transformation(extent={{40,-140},{60,-120}})));
  Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.Tower.FanSpeed.ReturnWaterTemperature.Subsequences.LessCoupledSpeed lesCouTowSpe(
    final nChi=nChi,
    final nConWatPum=nConWatPum,
    final desTemDif=desTemDif,
    final pumSpeChe=speChe,
    final minTowSpe=minTowSpe,
    final retWatCon=retWatCon,
    final kRetCon=kRetCon,
    final TiRetCon=TiRetCon,
    final TdRetCon=TdRetCon,
    final yRetConMax=yRetConMax,
    final yRetConMin=yRetConMin,
    final supWatCon=supWatCon,
    final kSupCon=kSupCon,
    final TiSupCon=TiSupCon,
    final TdSupCon=TdSupCon,
    final ySupConMax=ySupConMax,
    final ySupConMin=ySupConMin) if not closeCoupledPlant
    annotation (Placement(transformation(extent={{40,-190},{60,-170}})));
  Buildings.Controls.OBC.CDL.Logical.Switch swi
    annotation (Placement(transformation(extent={{120,-10},{140,10}})));
  Buildings.Controls.OBC.CDL.Logical.Switch swi1
    annotation (Placement(transformation(extent={{100,190},{120,210}})));
  Buildings.Controls.OBC.CDL.Continuous.Sources.Constant lowPlrTowMaxSpe(
    final k=0.7)
    "Lower bound of tower maximum speed"
    annotation (Placement(transformation(extent={{-120,120},{-100,140}})));
  Buildings.Controls.OBC.CDL.Continuous.Sources.Constant zer(
    final k=0)
    "Zero constant"
    annotation (Placement(transformation(extent={{-60,120},{-40,140}})));
  Buildings.Controls.OBC.CDL.Continuous.Sources.Constant hal(
    final k=0.5) "Constant 0.5"
    annotation (Placement(transformation(extent={{-120,60},{-100,80}})));
  Buildings.Controls.OBC.CDL.Continuous.Sources.Constant uppPlrTowMaxSpe(
    final k=1)
    "Upper bound of tower maximum speed"
    annotation (Placement(transformation(extent={{-60,60},{-40,80}})));
  Buildings.Controls.OBC.CDL.Continuous.Sources.Constant zer1(final k=0)
    "Zero constant"
    annotation (Placement(transformation(extent={{40,-30},{60,-10}})));
  Buildings.Controls.OBC.CDL.Logical.Sources.Constant tru(
    final k=true) if not haveWSE "True constant"
    annotation (Placement(transformation(extent={{-80,150},{-60,170}})));
  Buildings.Controls.OBC.CDL.Continuous.Sources.Constant zer2(
    final k=0) if not haveWSE
    "Zero constant"
    annotation (Placement(transformation(extent={{40,150},{60,170}})));

equation
  connect(uWSE, not1.u)
    annotation (Line(points={{-180,160},{-122,160}}, color={255,0,255}));
  connect(mulOr.y, and2.u1)
    annotation (Line(points={{-98.3,200},{-22,200}},  color={255,0,255}));
  connect(not1.y, and2.u2) annotation (Line(points={{-99,160},{-90,160},{-90,192},
          {-22,192}},      color={255,0,255}));
  connect(reqPlaCap, parLoaRat.u)
    annotation (Line(points={{-180,100},{-122,100}}, color={0,0,127}));
  connect(zer.y, plrTowMaxSpe.x1) annotation (Line(points={{-39,130},{-30,130},{
          -30,108},{-22,108}}, color={0,0,127}));
  connect(lowPlrTowMaxSpe.y, plrTowMaxSpe.f1) annotation (Line(points={{-99,130},
          {-70,130},{-70,104},{-22,104}}, color={0,0,127}));
  connect(parLoaRat.y, plrTowMaxSpe.u)
    annotation (Line(points={{-99,100},{-22,100}}, color={0,0,127}));
  connect(hal.y, plrTowMaxSpe.x2) annotation (Line(points={{-99,70},{-70,70},{-70,
          96},{-22,96}}, color={0,0,127}));
  connect(uppPlrTowMaxSpe.y, plrTowMaxSpe.f2) annotation (Line(points={{-39,70},
          {-30,70},{-30,92},{-22,92}}, color={0,0,127}));
  connect(uChi, conWatRetSet.uChi) annotation (Line(points={{-180,200},{-140,200},
          {-140,-62},{38,-62}}, color={255,0,255}));
  connect(parLoaRat.y, conWatRetSet.plaParLoaRat) annotation (Line(points={{-99,
          100},{-80,100},{-80,-68},{38,-68}}, color={0,0,127}));
  connect(conWatRetSet.TChiWatSupSet, TChiWatSupSet) annotation (Line(points={{38,
          -72},{-80,-72},{-80,-120},{-180,-120}}, color={0,0,127}));
  connect(conWatRetSet.uPla, uPla) annotation (Line(points={{38,-78},{-60,-78},{
          -60,-160},{-180,-160}}, color={255,0,255}));
  connect(enaTow.uMaxTowSpeSet, uMaxTowSpeSet) annotation (Line(points={{38,28},
          {-120,28},{-120,40},{-180,40}}, color={0,0,127}));
  connect(enaTow.uTowSpe, uTowSpe) annotation (Line(points={{38,24},{-116,24},{-116,
          10},{-180,10}}, color={0,0,127}));
  connect(enaTow.TTow, TTow) annotation (Line(points={{38,20},{-112,20},{-112,-20},
          {-180,-20}}, color={0,0,127}));
  connect(enaTow.uTowSta, uTowSta) annotation (Line(points={{38,16},{-106,16},{-106,
          -50},{-180,-50}}, color={255,0,255}));
  connect(enaTow.uConWatPumNum, uConWatPumNum) annotation (Line(points={{38,12},
          {-100,12},{-100,-80},{-180,-80}}, color={255,127,0}));
  connect(conWatRetSet.TConWatRetSet, couTowSpe.TConWatRetSet) annotation (Line(
        points={{61,-70},{80,-70},{80,-100},{26,-100},{26,-122},{38,-122}},
        color={0,0,127}));
  connect(couTowSpe.TConWatRet, TConWatRet) annotation (Line(points={{38,-126},{
          -40,-126},{-40,-200},{-180,-200}}, color={0,0,127}));
  connect(couTowSpe.uConWatPumSpe, uConWatPumSpe) annotation (Line(points={{38,-130},
          {-34,-130},{-34,-240},{-180,-240}}, color={0,0,127}));
  connect(uMaxTowSpeSet, couTowSpe.uMaxTowSpeSet) annotation (Line(points={{-180,
          40},{-120,40},{-120,-134},{38,-134}}, color={0,0,127}));
  connect(plrTowMaxSpe.y, couTowSpe.plrTowMaxSpe) annotation (Line(points={{1,100},
          {20,100},{20,-138},{38,-138}}, color={0,0,127}));
  connect(conWatRetSet.TConWatRetSet, lesCouTowSpe.TConWatRetSet) annotation (
      Line(points={{61,-70},{80,-70},{80,-100},{26,-100},{26,-170},{38,-170}},
        color={0,0,127}));
  connect(TConWatRet, lesCouTowSpe.TConWatRet) annotation (Line(points={{-180,-200},
          {-40,-200},{-40,-174},{38,-174}}, color={0,0,127}));
  connect(uConWatPumSpe, lesCouTowSpe.uConWatPumSpe) annotation (Line(points={{-180,
          -240},{-34,-240},{-34,-178},{38,-178}}, color={0,0,127}));
  connect(lesCouTowSpe.TConWatSup, TConWatSup) annotation (Line(points={{38,-182},
          {-28,-182},{-28,-280},{-180,-280}}, color={0,0,127}));
  connect(uMaxTowSpeSet, lesCouTowSpe.uMaxTowSpeSet) annotation (Line(points={{-180,
          40},{-120,40},{-120,-186},{38,-186}}, color={0,0,127}));
  connect(plrTowMaxSpe.y, lesCouTowSpe.plrTowMaxSpe) annotation (Line(points={{1,
          100},{20,100},{20,-190},{38,-190}}, color={0,0,127}));
  connect(enaTow.yTow, swi.u2) annotation (Line(points={{61,20},{80,20},{80,0},{
          118,0}}, color={255,0,255}));
  connect(couTowSpe.yTowSpe, swi.u1) annotation (Line(points={{61,-130},{100,-130},
          {100,8},{118,8}}, color={0,0,127}));
  connect(lesCouTowSpe.yTowSpe, swi.u1) annotation (Line(points={{61,-180},{100,
          -180},{100,8},{118,8}}, color={0,0,127}));
  connect(zer1.y, swi.u3) annotation (Line(points={{61,-20},{80,-20},{80,-8},{118,
          -8}}, color={0,0,127}));
  connect(enaTow.yTow, yTow)
    annotation (Line(points={{61,20},{170,20}}, color={255,0,255}));
  connect(tru.y, and2.u2) annotation (Line(points={{-59,160},{-40,160},{-40,192},
          {-22,192}}, color={255,0,255}));
  connect(and2.y, swi1.u2)
    annotation (Line(points={{1,200},{98,200}}, color={255,0,255}));
  connect(swi.y, swi1.u1) annotation (Line(points={{141,0},{150,0},{150,180},{60,
          180},{60,208},{98,208}}, color={0,0,127}));
  connect(uTowSpeWSE, swi1.u3) annotation (Line(points={{-180,240},{80,240},{80,
          192},{98,192}}, color={0,0,127}));
  connect(zer2.y, swi1.u3) annotation (Line(points={{61,160},{80,160},{80,192},{
          98,192}}, color={0,0,127}));
  connect(swi1.y, yTowSpe)
    annotation (Line(points={{121,200},{170,200}}, color={0,0,127}));
  connect(uChi, mulOr.u)
    annotation (Line(points={{-180,200},{-122,200}}, color={255,0,255}));

annotation (
  defaultComponentName="towFanSpe",
  Icon(coordinateSystem(preserveAspectRatio=false, extent={{-200,-200},
            {200,200}}), graphics={
        Rectangle(
        extent={{-200,-200},{200,200}},
        lineColor={0,0,127},
        fillColor={255,255,255},
        fillPattern=FillPattern.Solid),
        Text(
          extent={{-240,270},{200,210}},
          lineColor={0,0,255},
          textString="%name")}),
                          Diagram(coordinateSystem(preserveAspectRatio=false,
          extent={{-160,-300},{160,280}}), graphics={
          Text(
          extent={{-148,280},{-78,262}},
          pattern=LinePattern.None,
          fillColor={210,210,210},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,127},
          horizontalAlignment=TextAlignment.Left,
          textString="When there is no WSE:"),
          Text(
          extent={{-148,264},{-32,258}},
          pattern=LinePattern.None,
          fillColor={210,210,210},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,127},
          horizontalAlignment=TextAlignment.Left,
          textString="- if no chiller enabled, then tower fan speed being zero;"),
          Text(
          extent={{-148,258},{-30,248}},
          pattern=LinePattern.None,
          fillColor={210,210,210},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,127},
          horizontalAlignment=TextAlignment.Left,
          textString="- if any chiller enabled, then control fan speed with sequence here;"),
          Text(
          extent={{6,278},{70,266}},
          pattern=LinePattern.None,
          fillColor={210,210,210},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,127},
          horizontalAlignment=TextAlignment.Left,
          textString="When there is WSE:"),
          Text(
          extent={{6,266},{142,256}},
          pattern=LinePattern.None,
          fillColor={210,210,210},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,127},
          horizontalAlignment=TextAlignment.Left,
          textString="- if no chiller enabled, then contorl tower fan speed with uTowSpeWSE;"),
          Text(
          extent={{6,256},{150,248}},
          pattern=LinePattern.None,
          fillColor={210,210,210},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,127},
          horizontalAlignment=TextAlignment.Left,
          textString="- if any chiller enabled and WSE not running, then control fan speed with sequence here;"),
          Text(
          extent={{6,248},{150,240}},
          pattern=LinePattern.None,
          fillColor={210,210,210},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,127},
          horizontalAlignment=TextAlignment.Left,
          textString="- if any chiller enabled and WSE is running, then control fan speed with uTowSpeWSE;")}));
end Controller;
