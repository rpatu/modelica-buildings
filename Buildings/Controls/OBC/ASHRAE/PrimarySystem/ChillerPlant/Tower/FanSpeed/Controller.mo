within Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.Tower.FanSpeed;
block Controller "Tower fan speed control"

  parameter Integer nChi=2 "Total number of chillers";
  parameter Integer nTowCel=4 "Total number of cooling tower cells";
  parameter Integer nConWatPum=2 "Total number of condenser water pumps";
  parameter Boolean closeCoupledPlant=true
    "Flag to indicate if the plant is close coupled";
  parameter Boolean haveWSE=true
    "Flag to indicate if the plant has waterside economizer";
  parameter Modelica.SIunits.HeatFlowRate desCap=1e6 "Plant design capacity";
  parameter Real minTowSpe=0.1 "Minimum tower fan speed";
  parameter Real maxTowSpe=1 "Maximum tower fan speed"
    annotation (Dialog(enable=haveWSE));
  parameter Modelica.SIunits.HeatFlowRate minUnLTon[nChi]={1e4,1e4}
    "Minimum cyclining load below which chiller will begin cycling"
    annotation (Dialog(tab="WSE Enabled", group="Integrated",enable=haveWSE));
  parameter Real minSpe=0.1
    "Allowed minimum value of waterside economizer tower maximum speed"
    annotation (Dialog(tab="WSE Enabled", group="Integrated",enable=haveWSE));
  parameter Buildings.Controls.OBC.CDL.Types.SimpleController intOpeCon=
    Buildings.Controls.OBC.CDL.Types.SimpleController.PI
    "Type of controller"
    annotation (Dialog(tab="WSE Enabled", group="Integrated",enable=haveWSE));
  parameter Real kIntOpe=1 "Gain of controller"
    annotation (Dialog(tab="WSE Enabled", group="Integrated",enable=haveWSE));
  parameter Modelica.SIunits.Time TiIntOpe=0.5
    "Time constant of integrator block"
    annotation (Dialog(tab="WSE Enabled", group="Integrated",enable=haveWSE));
  parameter Modelica.SIunits.Time TdIntOpe=0.1
    "Time constant of derivative block"
    annotation (Dialog(tab="WSE Enabled", group="Integrated",enable=haveWSE));
  parameter Buildings.Controls.OBC.CDL.Types.SimpleController chiWatCon=
    Buildings.Controls.OBC.CDL.Types.SimpleController.PID
    "Type of controller"
    annotation (Dialog(tab="WSE Enabled", group="WSE-only",enable=haveWSE));
  parameter Real kWSE=1 "Gain of controller"
    annotation (Dialog(tab="WSE Enabled", group="WSE-only",enable=haveWSE));
  parameter Modelica.SIunits.Time TiWSE=0.5 "Time constant of integrator block"
    annotation (Dialog(tab="WSE Enabled", group="WSE-only",enable=haveWSE));
  parameter Modelica.SIunits.Time TdWSE=0.1 "Time constant of derivative block"
    annotation (Dialog(tab="WSE Enabled", group="WSE-only",enable=haveWSE));

  parameter Modelica.SIunits.Temperature TTowSet=283.15
    "Tower temperature setpoint"
    annotation (Dialog(tab="Return temperature control", group="Tower enable"));
  parameter Real LIFT_min[nChi]={12,12} "Minimum LIFT of each chiller"
    annotation (Dialog(tab="Return temperature control", group="Setpoint"));
  parameter Real LIFT_max[nChi]={25,25} "Maximum LIFT of each chiller"
    annotation (Dialog(tab="Return temperature control", group="Setpoint"));
  parameter Modelica.SIunits.Time iniPlaTim=600
    "Time to hold return temperature to initial setpoint after plant being enabled"
    annotation (Dialog(tab="Return temperature control", group="Setpoint"));
  parameter Modelica.SIunits.Time ramTim=180
    "Time to ramp return water temperature from initial value to setpoint"
    annotation (Dialog(tab="Return temperature control", group="Setpoint"));
  parameter Modelica.SIunits.Temperature TConWatRet_nominal=303.15
    "Design condenser water return temperature"
    annotation (Dialog(tab="Return temperature control", group="Setpoint"));

  parameter Buildings.Controls.OBC.CDL.Types.SimpleController couPlaCon=
    Buildings.Controls.OBC.CDL.Types.SimpleController.PI "Type of controller"
    annotation (Dialog(tab="Return temperature control",
                       group="Coupled plant", enable=closeCoupledPlant));
  parameter Real kCouPla=1 "Gain of controller"
    annotation (Dialog(tab="Return temperature control",
                       group="Coupled plant", enable=closeCoupledPlant));
  parameter Modelica.SIunits.Time TiCouPla=0.5 "Time constant of integrator block"
    annotation (Dialog(tab="Return temperature control",
                       group="Coupled plant", enable=closeCoupledPlant));
  parameter Real yCouPlaMax=1 "Upper limit of output"
    annotation (Dialog(tab="Return temperature control",
                       group="Coupled plant", enable=closeCoupledPlant));
  parameter Real yCouPlaMin=0 "Lower limit of output"
    annotation (Dialog(tab="Return temperature control",
                       group="Coupled plant", enable=closeCoupledPlant));
  parameter Modelica.SIunits.Time TdCouPla=0.1 "Time constant of derivative block"
    annotation (Dialog(tab="Return temperature control",
                       group="Coupled plant", enable=closeCoupledPlant));

  parameter Modelica.SIunits.TemperatureDifference desTemDif=8
    "Design condenser water temperature difference"
    annotation (Dialog(tab="Return temperature control",
                       group="Less coupled plant", enable=not closeCoupledPlant));
  parameter Buildings.Controls.OBC.CDL.Types.SimpleController retWatCon=
    Buildings.Controls.OBC.CDL.Types.SimpleController.PI "Type of controller"
    annotation (Dialog(tab="Return temperature control",
                       group="Less coupled plant", enable=not closeCoupledPlant));
  parameter Real kRetCon=1 "Gain of controller"
    annotation (Dialog(tab="Return temperature control",
                       group="Less coupled plant", enable=not closeCoupledPlant));
  parameter Modelica.SIunits.Time TiRetCon=0.5 "Time constant of integrator block"
    annotation (Dialog(tab="Return temperature control",
                       group="Less coupled plant", enable=not closeCoupledPlant));
  parameter Modelica.SIunits.Time TdRetCon=0.1 "Time constant of derivative block"
    annotation (Dialog(tab="Return temperature control",
                       group="Less coupled plant", enable=not closeCoupledPlant));
  parameter Real yRetConMax=1 "Upper limit of output"
    annotation (Dialog(tab="Return temperature control",
                       group="Less coupled plant", enable=not closeCoupledPlant));
  parameter Real yRetConMin=0 "Lower limit of output"
    annotation (Dialog(tab="Return temperature control",
                       group="Less coupled plant", enable=not closeCoupledPlant));
  parameter Buildings.Controls.OBC.CDL.Types.SimpleController supWatCon=
    Buildings.Controls.OBC.CDL.Types.SimpleController.PI "Type of controller"
    annotation (Dialog(tab="Return temperature control",
                       group="Less coupled plant", enable=not closeCoupledPlant));
  parameter Real kSupCon=1 "Gain of controller"
    annotation (Dialog(tab="Return temperature control",
                       group="Less coupled plant", enable=not closeCoupledPlant));
  parameter Modelica.SIunits.Time TiSupCon=0.5 "Time constant of integrator block"
    annotation (Dialog(tab="Return temperature control",
                       group="Less coupled plant", enable=not closeCoupledPlant));
  parameter Modelica.SIunits.Time TdSupCon=0.1 "Time constant of derivative block"
    annotation (Dialog(tab="Return temperature control",
                       group="Less coupled plant", enable=not closeCoupledPlant));
  parameter Real ySupConMax=1 "Upper limit of output"
    annotation (Dialog(tab="Return temperature control",
                       group="Less coupled plant", enable=not closeCoupledPlant));
  parameter Real ySupConMin=0 "Lower limit of output"
    annotation (Dialog(tab="Return temperature control",
                       group="Less coupled plant", enable=not closeCoupledPlant));
  parameter Real speChe=0.005 "Lower threshold value to check fan or pump speed"
    annotation (Dialog(tab="Advanced"));

  Buildings.Controls.OBC.CDL.Interfaces.RealInput chiLoa[nChi](
    each final unit="W",
    each final quantity="Power") if haveWSE "Current load of each chiller"
    annotation (Placement(transformation(extent={{-140,120},{-100,160}}),
      iconTransformation(extent={{-120,170},{-100,190}})));
  Buildings.Controls.OBC.CDL.Interfaces.BooleanInput uChi[nChi]
    "Chiller enabling status: true=ON"
    annotation (Placement(transformation(extent={{-140,100},{-100,140}}),
      iconTransformation(extent={{-120,150},{-100,170}})));
  Buildings.Controls.OBC.CDL.Interfaces.BooleanInput uWSE if haveWSE
    "Waterside economizer enabling status: true=ON"
    annotation (Placement(transformation(extent={{-140,80},{-100,120}}),
      iconTransformation(extent={{-120,130},{-100,150}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealInput uTowSpe(
     final min=0,
     final max=1,
     final unit="1") "Tower fan speed"
     annotation (Placement(transformation(extent={{-140,60},{-100,100}}),
       iconTransformation(extent={{-120,90},{-100,110}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealInput TChiWatSup(
    final unit="K",
    final quantity="ThermodynamicTemperature") if haveWSE
    "Chilled water supply temperature"
    annotation (Placement(transformation(extent={{-140,40},{-100,80}}),
      iconTransformation(extent={{-120,70},{-100,90}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealInput TChiWatSupSet(
    final unit="K",
    final quantity="ThermodynamicTemperature")
    "Chilled water supply temperature setpoint"
    annotation (Placement(transformation(extent={{-140,20},{-100,60}}),
      iconTransformation(extent={{-120,50},{-100,70}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealInput reqPlaCap(
    final unit="W",
    final quantity="Power") "Current required plant capacity"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}}),
      iconTransformation(extent={{-120,10},{-100,30}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealInput uMaxTowSpeSet[nChi](
    each final min=0,
    each final max=1,
    each final unit="1")
    "Maximum cooling tower speed setpoint from each chiller head pressure control loop"
    annotation (Placement(transformation(extent={{-140,-40},{-100,0}}),
      iconTransformation(extent={{-120,-10},{-100,10}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealInput TTow(
    final unit="K",
    final quantity="ThermodynamicTemperature") "Measured tower temperature"
    annotation (Placement(transformation(extent={{-140,-60},{-100,-20}}),
      iconTransformation(extent={{-120,-30},{-100,-10}})));
  Buildings.Controls.OBC.CDL.Interfaces.BooleanInput uTowSta[nTowCel]
    "Cooling tower cell operating status: true=running tower cell"
    annotation (Placement(transformation(extent={{-140,-80},{-100,-40}}),
      iconTransformation(extent={{-120,-70},{-100,-50}})));
  Buildings.Controls.OBC.CDL.Interfaces.IntegerInput uConWatPumNum
    "Number of enabled condenser water pumps"
    annotation (Placement(transformation(extent={{-140,-100},{-100,-60}}),
      iconTransformation(extent={{-120,-90},{-100,-70}})));
  Buildings.Controls.OBC.CDL.Interfaces.BooleanInput uPla
    "Plant enabling status"
    annotation (Placement(transformation(extent={{-140,-120},{-100,-80}}),
      iconTransformation(extent={{-120,-110},{-100,-90}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealInput TConWatRet(
    final unit="K",
    final quantity="ThermodynamicTemperature")
    "Condenser water return temperature"
    annotation (Placement(transformation(extent={{-140,-140},{-100,-100}}),
      iconTransformation(extent={{-120,-150},{-100,-130}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealInput uConWatPumSpe[nConWatPum](
    each final min=0,
    each final max=1,
    each final unit="1") "Current condenser water pump speed"
    annotation (Placement(transformation(extent={{-140,-160},{-100,-120}}),
      iconTransformation(extent={{-120,-170},{-100,-150}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealInput TConWatSup(
    final unit="K",
    final quantity="ThermodynamicTemperature") if not closeCoupledPlant
    "Condenser water supply temperature"
    annotation (Placement(transformation(extent={{-140,-180},{-100,-140}}),
      iconTransformation(extent={{-120,-190},{-100,-170}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealOutput yTowSpe(
    final min=0,
    final max=1,
    final unit="1") "Cooling tower fan speed"
    annotation (Placement(transformation(extent={{100,-30},{120,-10}}),
      iconTransformation(extent={{100,-10},{120,10}})));
  Buildings.Controls.OBC.CDL.Interfaces.BooleanOutput yTow
    "Tower fan status: true=enable fans; false=disable all fans"
    annotation (Placement(transformation(extent={{100,-70},{120,-50}}),
      iconTransformation(extent={{100,-50},{120,-30}})));

protected
  Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.Tower.FanSpeed.ReturnWaterTemperature.Controller
    fanSpeRetTem(
    final nChi=nChi,
    final nTowCel=nTowCel,
    final nConWatPum=nConWatPum,
    final haveWSE=haveWSE,
    final closeCoupledPlant=closeCoupledPlant,
    final desCap=desCap,
    final minTowSpe=minTowSpe,
    final TTowSet=TTowSet,
    final LIFT_min=LIFT_min,
    final LIFT_max=LIFT_max,
    final iniPlaTim=iniPlaTim,
    final ramTim=ramTim,
    final TConWatRet_nominal=TConWatRet_nominal,
    final couPlaCon=couPlaCon,
    final kCouPla=kCouPla,
    final TiCouPla=TiCouPla,
    final yCouPlaMax=yCouPlaMax,
    final yCouPlaMin=yCouPlaMin,
    final TdCouPla=TdCouPla,
    final desTemDif=desTemDif,
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
    final ySupConMin=ySupConMin,
    final speChe=speChe)
    "Fan speed control based on condenser water return temperature control"
    annotation (Placement(transformation(extent={{20,-60},{60,-20}})));
  Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.Tower.FanSpeed.EnabledWSE.Controller
    fanSpeWse(
    final nChi=nChi,
    final minUnLTon=minUnLTon,
    final minSpe=minSpe,
    final intOpeCon=intOpeCon,
    final kIntOpe=kIntOpe,
    final TiIntOpe=TiIntOpe,
    final TdIntOpe=TdIntOpe,
    final minTowSpe=minTowSpe,
    final maxTowSpe=maxTowSpe,
    final fanSpeChe=speChe,
    final chiWatCon=chiWatCon,
    final kWSE=kWSE,
    final TiWSE=TiWSE,
    final TdWSE=TdWSE) if haveWSE
    "Tower fan speed when waterside economizer is enabled"
    annotation (Placement(transformation(extent={{-40,40},{-20,60}})));

equation
  connect(fanSpeWse.yTowSpe, fanSpeRetTem.uTowSpeWSE) annotation (Line(points={{-19,50},
          {0,50},{0,-21},{19,-21}},  color={0,0,127}));
  connect(fanSpeWse.chiLoa, chiLoa) annotation (Line(points={{-42,60},{-60,60},{
          -60,140},{-120,140}}, color={0,0,127}));
  connect(fanSpeWse.uChi, uChi) annotation (Line(points={{-42,56},{-64,56},{-64,
          120},{-120,120}}, color={255,0,255}));
  connect(fanSpeWse.uWSE, uWSE) annotation (Line(points={{-42,52},{-68,52},{-68,
          100},{-120,100}}, color={255,0,255}));
  connect(fanSpeWse.uTowSpe, uTowSpe) annotation (Line(points={{-42,48},{-72,48},
          {-72,80},{-120,80}},   color={0,0,127}));
  connect(fanSpeWse.TChiWatSup, TChiWatSup) annotation (Line(points={{-42,44},{-76,
          44},{-76,60},{-120,60}}, color={0,0,127}));
  connect(fanSpeWse.TChiWatSupSet, TChiWatSupSet)
    annotation (Line(points={{-42,40},{-120,40}}, color={0,0,127}));
  connect(uChi, fanSpeRetTem.uChi) annotation (Line(points={{-120,120},{-64,120},
          {-64,-24},{19,-24}}, color={255,0,255}));
  connect(uWSE, fanSpeRetTem.uWSE) annotation (Line(points={{-120,100},{-68,100},
          {-68,-27},{19,-27}}, color={255,0,255}));
  connect(fanSpeRetTem.reqPlaCap, reqPlaCap) annotation (Line(points={{19,-30},{
          -76,-30},{-76,0},{-120,0}},   color={0,0,127}));
  connect(fanSpeRetTem.uMaxTowSpeSet, uMaxTowSpeSet) annotation (Line(points={{19,-33},
          {-80,-33},{-80,-20},{-120,-20}},  color={0,0,127}));
  connect(uTowSpe, fanSpeRetTem.uTowSpe) annotation (Line(points={{-120,80},{-72,
          80},{-72,-36},{19,-36}},  color={0,0,127}));
  connect(fanSpeRetTem.TTow, TTow) annotation (Line(points={{19,-39},{-72,-39},{
          -72,-40},{-120,-40}}, color={0,0,127}));
  connect(fanSpeRetTem.uTowSta, uTowSta) annotation (Line(points={{19,-42},{-68,
          -42},{-68,-60},{-120,-60}}, color={255,0,255}));
  connect(fanSpeRetTem.uConWatPumNum, uConWatPumNum) annotation (Line(points={{19,-45},
          {-64,-45},{-64,-80},{-120,-80}},      color={255,127,0}));
  connect(TChiWatSupSet, fanSpeRetTem.TChiWatSupSet) annotation (Line(points={{-120,40},
          {-60,40},{-60,-48},{19,-48}},     color={0,0,127}));
  connect(fanSpeRetTem.uPla, uPla) annotation (Line(points={{19,-51},{-60,-51},{
          -60,-100},{-120,-100}}, color={255,0,255}));
  connect(fanSpeRetTem.TConWatRet, TConWatRet) annotation (Line(points={{19,-54},
          {-56,-54},{-56,-120},{-120,-120}}, color={0,0,127}));
  connect(fanSpeRetTem.uConWatPumSpe, uConWatPumSpe) annotation (Line(points={{19,-57},
          {-52,-57},{-52,-140},{-120,-140}},      color={0,0,127}));
  connect(fanSpeRetTem.TConWatSup, TConWatSup) annotation (Line(points={{19,-59},
          {-48,-59},{-48,-160},{-120,-160}}, color={0,0,127}));
  connect(fanSpeRetTem.yTowSpe, yTowSpe) annotation (Line(points={{61,-32},{80,-32},
          {80,-20},{110,-20}}, color={0,0,127}));
  connect(fanSpeRetTem.yTow, yTow) annotation (Line(points={{61,-48},{80,-48},{80,
          -60},{110,-60}}, color={255,0,255}));

annotation (
  defaultComponentName="towFanSpe",
  Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-200},{100,200}}),
        graphics={
        Rectangle(
        extent={{-100,-200},{100,200}},
        lineColor={0,0,127},
        fillColor={255,255,255},
        fillPattern=FillPattern.Solid),
        Text(
          extent={{-120,248},{100,210}},
          lineColor={0,0,255},
          textString="%name")}),
                          Diagram(coordinateSystem(preserveAspectRatio=false,
          extent={{-100,-180},{100,160}})));
end Controller;
