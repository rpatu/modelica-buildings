within Buildings.Applications.DHC.Loads.Examples.BaseClasses;
model BuildingSpawnZ1 "One-zone EnergyPlus building model"
  import Buildings;
  extends Buildings.Applications.DHC.Loads.BaseClasses.PartialBuilding(
    redeclare package Medium = Buildings.Media.Water,
    final have_pum=false,
    final have_eleHea=false,
    final have_eleCoo=false);
  package Medium2 = Buildings.Media.Air
    "Load side medium";
  parameter Integer nZon = 1
    "Number of thermal zones";
  parameter String idfName=
    "modelica://Buildings/Resources/Data/ThermalZones/EnergyPlus/Validation/RefBldgSmallOfficeNew2004_Chicago.idf"
    "Name of the IDF file";
  parameter String weaName=
    "modelica://Buildings/Resources/weatherdata/USA_IL_Chicago-OHare.Intl.AP.725300_TMY3.mos"
    "Name of the weather file";
  Modelica.Blocks.Sources.Constant qConGai_flow(k=0) "Convective heat gain"
    annotation (Placement(transformation(extent={{-80,60},{-60,80}})));
  Modelica.Blocks.Sources.Constant qRadGai_flow(k=0) "Radiative heat gain"
    annotation (Placement(transformation(extent={{-80,100},{-60,120}})));
  Modelica.Blocks.Routing.Multiplex3 multiplex3_1
    annotation (Placement(transformation(extent={{-34,60},{-14,80}})));
  Modelica.Blocks.Sources.Constant qLatGai_flow(k=0) "Latent heat gain"
    annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
  Buildings.ThermalZones.EnergyPlus.ThermalZone zon(
    redeclare package Medium = Medium2,
    zoneName="Core_ZN",
    nPorts=2)
    "Thermal zone"
    annotation (Placement(transformation(extent={{40,-20},{80,20}})));
  inner Buildings.ThermalZones.EnergyPlus.Building building(
    idfName=Modelica.Utilities.Files.loadResource(idfName),
    weaName=Modelica.Utilities.Files.loadResource(weaName),
    showWeatherData=false)
    "Building model"
    annotation (Placement(transformation(extent={{40,60},{60,80}})));
  Buildings.Controls.OBC.CDL.Continuous.Sources.Constant minTSet(k=293.15,
      y(final unit="K", displayUnit="degC"))
    "Minimum temperature set point"
    annotation (Placement(transformation(extent={{-280,250},{-260,270}})));
  Buildings.Controls.OBC.CDL.Continuous.Sources.Constant maxTSet(k=297.15,
      y(final unit="K", displayUnit="degC"))
    "Maximum temperature set point"
    annotation (Placement(transformation(extent={{-280,210},{-260,230}})));
  Buildings.Applications.DHC.Loads.Examples.BaseClasses.FanCoil4Pipe terUni(
    redeclare package Medium1 = Medium,
    redeclare package Medium2 = Medium2,
    QHea_flow_nominal=10000,
    QCoo_flow_nominal=-10000,
    T_aLoaHea_nominal=293.15,
    T_aLoaCoo_nominal=297.15,
    T_bHeaWat_nominal=308.15,
    T_bChiWat_nominal=285.15,
    T_aHeaWat_nominal=313.15,
    T_aChiWat_nominal=280.15,
    mLoaHea_flow_nominal=5,
    mLoaCoo_flow_nominal=5) "Terminal unit"
    annotation (Placement(transformation(extent={{-160,-60},{-140,-40}})));
  Buildings.Applications.DHC.Loads.BaseClasses.FlowDistribution disFloHea(
    redeclare package Medium = Medium,
    m_flow_nominal=terUni.mHeaWat_flow_nominal,
    dp_nominal=100000,
    nPorts_a1=nZon,
    nPorts_b1=nZon)
    "Heating water distribution system"
    annotation (Placement(transformation(extent={{-120,-120},{-100,-100}})));
  Buildings.Applications.DHC.Loads.BaseClasses.FlowDistribution disFloCoo(
    redeclare package Medium = Medium,
    m_flow_nominal=terUni.mChiWat_flow_nominal,
    typDis=Buildings.Applications.DHC.Loads.Types.DistributionType.ChilledWater,
    dp_nominal=100000,
    nPorts_a1=nZon,
    nPorts_b1=nZon)
    "Chilled water distribution system"
    annotation (Placement(transformation(extent={{-120, -160},{-100,-140}})));
equation
  connect(qRadGai_flow.y,multiplex3_1.u1[1])  annotation (Line(
      points={{-59,110},{-40,110},{-40,77},{-36,77}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(qConGai_flow.y,multiplex3_1.u2[1]) annotation (Line(
      points={{-59,70},{-48,70},{-42,70},{-36,70}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(multiplex3_1.u3[1],qLatGai_flow.y)
    annotation (Line(points={{-36,63},{-40,63},{-40,30},{-59,30}},  color={0,0,127}));
  connect(multiplex3_1.y, zon.qGai_flow) annotation (Line(points={{-13,70},{16,70},
          {16,10},{38,10}},                                                                       color={0,0,127}));
  connect(ports_a[1], disFloHea.port_a) annotation (Line(points={{-300,0},{-280,
          0},{-280,-110},{-120,-110}},   color={0,127,255}));
  connect(disFloHea.port_b, ports_b[1]) annotation (Line(points={{-100,-110},{280,
          -110},{280,0},{300,0}},     color={0,127,255}));
  connect(ports_a[2], disFloCoo.port_a) annotation (Line(points={{-300,0},{-280,
          0},{-280,-150},{-120,-150}},  color={0,127,255}));
  connect(disFloCoo.port_b, ports_b[2]) annotation (Line(points={{-100,-150},{280,
          -150},{280,0},{300,0}},   color={0,127,255}));
  connect(zon.ports[1], terUni.port_aLoa) annotation (Line(points={{58,-19.2},{
          62,-19.2},{62,-41.6667},{-140,-41.6667}},
                                       color={0,127,255}));
  connect(terUni.port_bHeaWat, disFloHea.ports_a1[1]) annotation (Line(points={{-140,
          -58.3333},{-140,-59.5833},{-100,-59.5833},{-100,-104}}, color={0,127,255}));
  connect(terUni.port_bChiWat, disFloCoo.ports_a1[1]) annotation (Line(points={{-140,
          -56.6667},{-80,-56.6667},{-80,-144},{-100,-144}}, color={0,127,255}));
  connect(disFloHea.ports_b1[1], terUni.port_aHeaWat) annotation (Line(points={{-120,
          -104},{-180,-104},{-180,-58.3333},{-160,-58.3333}}, color={0,127,255}));
  connect(disFloCoo.ports_b1[1], terUni.port_aChiWat) annotation (Line(points={{-120,
          -144},{-200,-144},{-200,-56.6667},{-160,-56.6667}}, color={0,127,255}));
  connect(terUni.PFan, PFan) annotation (Line(points={{-139.167,-50},{260,-50},
          {260,120},{320,120}}, color={0,0,127}));
  connect(terUni.mReqHeaWat_flow, disFloHea.mReq_flow[1]) annotation (Line(points={{
          -139.167,-53.3333},{-132,-53.3333},{-126,-53.3333},{-126,-114},{-121,
          -114}},
        color={0,0,127}));
  connect(terUni.mReqChiWat_flow, disFloCoo.mReq_flow[1]) annotation (Line(points={{
          -139.167,-55},{-139.167,-56},{-130,-56},{-130,-154},{-121,-154}},
                        color={0,0,127}));
  connect(terUni.port_bLoa, zon.ports[2]) annotation (Line(points={{-160,
          -41.6667},{-172,-41.6667},{-180,-41.6667},{-180,-19.2},{62,-19.2}},
                                                                          color=
         {0,127,255}));
  connect(disFloHea.QActTot_flow, QHea_flow) annotation (Line(points={{-99,-116},
          {238,-116},{238,280},{320,280}}, color={0,0,127}));
  connect(disFloCoo.QActTot_flow, QCoo_flow) annotation (Line(points={{-99,-156},
          {242,-156},{242,240},{320,240}}, color={0,0,127}));
  connect(zon.TAir, terUni.TSen) annotation (Line(points={{81,13.8},{100,13.8},
          {100,-32},{-166,-32},{-166,-48.3333},{-160.833,-48.3333}},color={0,0,127}));
  connect(maxTSet.y, terUni.TSetCoo) annotation (Line(points={{-258,220},{-240,
          220},{-240,-46.6667},{-160.833,-46.6667}},
                                                color={0,0,127}));
  connect(minTSet.y, terUni.TSetHea) annotation (Line(points={{-258,260},{-220,
          260},{-220,-45},{-160.833,-45}},
                                      color={0,0,127}));
  annotation (
  Documentation(info="
<html>
<p>
This is a simplified one-zone building model based on EnergyPlus
building envelope model.
The heating and cooling loads are computed with a four-pipe
fan coil unit model derived from
<a href=\"modelica://Buildings.Applications.DHC.Loads.BaseClasses.PartialTerminalUnit\">
Buildings.Applications.DHC.Loads.BaseClasses.PartialTerminalUnit</a>
and connected to the room model by means of fluid ports.
</p>
</html>",
revisions=
"<html>
<ul>
<li>
February 21, 2020, by Antoine Gautier:<br/>
First implementation.
</li>
</ul>
</html>"),
  Icon(graphics={Bitmap(extent={{-108,-100},{92,100}},
  fileName="modelica://Buildings/Resources/Images/ThermalZones/EnergyPlus/EnergyPlusLogo.png")}));
end BuildingSpawnZ1;
