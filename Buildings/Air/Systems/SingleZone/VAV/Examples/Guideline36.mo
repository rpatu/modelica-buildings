within Buildings.Air.Systems.SingleZone.VAV.Examples;
model Guideline36
  "Variable air volume flow system with single themal zone and ASHRAE Guideline 36 sequence control"
  extends Modelica.Icons.Example;
  extends
    Buildings.Air.Systems.SingleZone.VAV.Examples.BaseClasses.PartialOpenLoop;

  parameter Modelica.SIunits.Temperature TSupChi_nominal=279.15
    "Design value for chiller leaving water temperature";
  Controls.OBC.ASHRAE.G36_PR1.AHUs.SingleZone.VAV.Controller controller(
    have_winSen=true,
    controllerTypeCoo=Buildings.Controls.OBC.CDL.Types.SimpleController.P,
    kCoo=1,
    yHeaMax=0.2,
    AFlo=48,
    VOutMin_flow=0.0144,
    VOutDes_flow=0.025,
    yMin=0.1,
    kHea=4,
    kMod=4,
    have_occSen=true,
    TZonHeaOff=288.15,
    TZonCooOn=298.15,
    TSupSetMax=323.15,
    TSupSetMin=285.15) "VAV controller"
    annotation (Placement(transformation(extent={{-120,-28},{-80,20}})));
  Controls.OBC.CDL.Continuous.Hysteresis hysChiPla(
    uLow=-1,
    uHigh=0)
    "Hysteresis with delay to switch on cooling"
    annotation (Placement(transformation(extent={{-80,-100},{-60,-80}})));
  Modelica.Blocks.Math.Feedback errTRooCoo
    "Control error on room temperature for cooling"
    annotation (Placement(transformation(extent={{-110,-100},{-90,-80}})));
  Controls.SetPoints.OccupancySchedule occSch(occupancy=3600*{8,18})
    "Occupancy schedule"
    annotation (Placement(transformation(extent={{-180,0},{-160,20}})));
  Modelica.Blocks.Sources.BooleanConstant uWin(k=false) "Window opening signal"
    annotation (Placement(transformation(extent={{-180,-40},{-160,-20}})));
protected
  Modelica.Blocks.Sources.Constant TSetSupChiConst(final k=TSupChi_nominal)
    "Set point for chiller temperature"
    annotation (Placement(transformation(extent={{-80,-140},{-60,-120}})));
equation
  connect(controller.yFan, hvac.uFan) annotation (Line(points={{-78,7.07692},{-62,
          7.07692},{-62,18},{-42,18}},
                              color={0,0,127}));
  connect(controller.yHeaCoi, hvac.uHea) annotation (Line(points={{-78,-9.53846},
          {-60,-9.53846},{-60,12},{-42,12}},
                              color={0,0,127}));
  connect(controller.yOutDamPos, hvac.uEco) annotation (Line(points={{-78,-19.6923},
          {-56,-19.6923},{-56,-2},{-42,-2}},
                                 color={0,0,127}));
  connect(TSetSupChiConst.y, hvac.TSetChi) annotation (Line(points={{-59,-130},{
          -46,-130},{-46,-16},{-42,-16},{-42,-15}},
                                     color={0,0,127}));
  connect(errTRooCoo.y, hysChiPla.u)
    annotation (Line(points={{-91,-90},{-82,-90}},   color={0,0,127}));
  connect(zon.TRooAir, errTRooCoo.u1) annotation (Line(points={{81,0},{110,0},{110,
          -152},{-134,-152},{-134,-90},{-108,-90}},       color={0,0,127}));
  connect(hysChiPla.y, hvac.chiOn) annotation (Line(points={{-58,-90},{-48,-90},
          {-48,-10},{-42,-10}},       color={255,0,255}));
  connect(weaBus.TDryBul, controller.TOut) annotation (Line(
      points={{-99,80},{-99,60},{-140,60},{-140,18.1538},{-122,18.1538}},
      color={255,204,51},
      thickness=0.5), Text(
      textString="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(zon.TRooAir, controller.TZon) annotation (Line(points={{81,0},{110,0},
          {110,-152},{-134,-152},{-134,9.84615},{-122,9.84615}},
                                                       color={0,0,127}));
  connect(hvac.TSup, controller.TSup) annotation (Line(points={{1,-8},{10,-8},{10,
          -50},{-130,-50},{-130,-1.23077},{-122,-1.23077}},
                                                 color={0,0,127}));
  connect(hvac.TMix, controller.TMix) annotation (Line(points={{1,-4},{14,-4},{14,
          -46},{-128,-46},{-128,-4.92308},{-122,-4.92308}},
                                                   color={0,0,127}));
  connect(occSch.tNexOcc, controller.tNexOcc) annotation (Line(points={{-159,56},
          {-150,56},{-150,15.3846},{-122,15.3846}},
                                          color={0,0,127}));
  connect(controller.uOcc, occSch.occupied) annotation (Line(points={{-122,6.15385},
          {-152,6.15385},{-152,44},{-159,44}},
                                        color={255,0,255}));
  connect(uWin.y, controller.uWin) annotation (Line(points={{-159,-50},{-148,-50},
          {-148,-12.3077},{-122,-12.3077}},
                                       color={255,0,255}));
  connect(occSch.occupied, occPer.u) annotation (Line(points={{-159,44},{-152,
          44},{-152,0},{-190,0},{-190,-80},{-182,-80}},   color={255,0,255}));
  connect(occPer.y, ppl.u)
    annotation (Line(points={{-159,-80},{-155.2,-80}}, color={0,0,127}));
  connect(ppl.y, controller.nOcc) annotation (Line(points={{-141.4,-80},{-138,-80},
          {-138,-8.61538},{-122,-8.61538}},
                                     color={0,0,127}));
  connect(controller.TZonCooSet, errTRooCoo.u2) annotation (Line(points={{-78,-4},
          {-74,-4},{-74,-40},{-120,-40},{-120,-110},{-100,-110},{-100,-98}},
        color={0,0,127}));
  connect(hvac.uCooVal, controller.yCooCoi) annotation (Line(points={{-42,5},{
          -48,5},{-48,4},{-58,4},{-58,-15.0769},{-78,-15.0769}},
                                                       color={0,0,127}));
  connect(hvac.TRet, controller.TCut) annotation (Line(points={{1,-6},{12,-6},{12,
          -48},{-132,-48},{-132,2.46154},{-122,2.46154}},
                                                 color={0,0,127}));
  annotation (Diagram(coordinateSystem(extent={{-200,-160},{120,100}})),
    experiment(
      StartTime=0,
      StopTime=864000,
      Interval=3600,
      Tolerance=1e-06),
      __Dymola_Commands(file="modelica://Buildings/Resources/Scripts/Dymola/Air/Systems/SingleZone/VAV/Examples/Guideline36.mos"
        "Simulate and plot"),
      Documentation(info="<html>
<p>
Implementation of <a href=\"modelica://Buildings.Air.Systems.SingleZone.VAV.Examples.BaseClasses.PartialOpenLoop\">
Buildings.Air.Systems.SingleZone.VAV.Examples.BaseClasses.PartialOpenLoop</a>
with ASHRAE Guideline 36 control sequence.
</p>
</html>", revisions="<html>
<ul>
<li>
June 22, 2020, by Michael Wetter:<br/>
Removed non-used occupant density.
</li>
<li>
July 29, 2019, by David Blum:<br/>
First implementation.
</li>
</ul>
</html>"),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}})));
end Guideline36;
