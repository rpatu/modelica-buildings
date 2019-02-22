within Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.Staging.Subsequences.DownProcessP.Subsequences;
block DisableLastChiller "Sequence for disabling last chiller"
  UpProcess.Subsequences.ReduceChillerDemand chiDemRed "Reduce chiller demand"
    annotation (Placement(transformation(extent={{-240,240},{-220,260}})));
  ResetMinBypassSetpoint minBypRes
    "Slowly change the minimum flow bypass setpoint"
    annotation (Placement(transformation(extent={{-160,190},{-140,210}})));
  EnableHeadControl enaHeaCon(nChi=nChi)
    "Enable head pressure control of the chiller being enabled"
    annotation (Placement(transformation(extent={{-240,80},{-220,100}})));
  EnableChiIsoVal enaChiIsoVal
    annotation (Placement(transformation(extent={{-240,0},{-220,20}})));
  CDL.Interfaces.BooleanInput uStaDow "Stage down status: true=stage-down"
    annotation (Placement(transformation(extent={{-420,280},{-380,320}}),
        iconTransformation(extent={{-394,360},{-354,400}})));
  CDL.Interfaces.RealInput uChiLoa[nChi] "Current chiller load" annotation (
      Placement(transformation(extent={{-420,230},{-380,270}}),
        iconTransformation(extent={{-376,310},{-336,350}})));
  CDL.Interfaces.BooleanInput uChi[nChi] "Chiller status: true=ON" annotation (
      Placement(transformation(extent={{-420,200},{-380,240}}),
        iconTransformation(extent={{-400,280},{-360,320}})));
  CDL.Interfaces.RealInput VBypas_flow "Measured bypass flow rate" annotation (
      Placement(transformation(extent={{-420,170},{-380,210}}),
        iconTransformation(extent={{-398,244},{-358,284}})));
  CDL.Interfaces.IntegerInput uSta "Current stage index" annotation (Placement(
        transformation(extent={{-420,130},{-380,170}}), iconTransformation(
          extent={{-374,150},{-334,190}})));
  CDL.Interfaces.BooleanInput uOnOff
    "Indicate if the stage require one chiller to be enabled while another is disabled"
    annotation (Placement(transformation(extent={{-420,100},{-380,140}}),
        iconTransformation(extent={{-394,146},{-354,186}})));
  CDL.Interfaces.IntegerInput uNexChaChi
    "Index of next enabling or disabling chiller" annotation (Placement(
        transformation(extent={{-420,60},{-380,100}}), iconTransformation(
          extent={{-384,66},{-344,106}})));
  CDL.Interfaces.BooleanInput uChiHeaCon[nChi]
    "Chillers head pressure control status" annotation (Placement(
        transformation(extent={{-420,30},{-380,70}}), iconTransformation(extent=
           {{-402,32},{-362,72}})));
  CDL.Interfaces.RealInput uChiWatIsoVal[nChi]
    "Chilled water isolation valve position" annotation (Placement(
        transformation(extent={{-420,0},{-380,40}}), iconTransformation(extent=
            {{-396,-8},{-356,32}})));
protected
  MinimumFlowBypass.Subsequences.FlowSetpoint minBypSet(
    final nSta=nSta,
    final byPasSetTim=byPasSetTim,
    final minFloSet=minFloSet) "Reset minimum bypass flow setpoint"
    annotation (Placement(transformation(extent={{-240,130},{-220,150}})));
  CDL.Logical.Sources.Constant                        con3(final k=false)
    "False constant"
    annotation (Placement(transformation(extent={{-320,160},{-300,180}})));
equation
  connect(chiDemRed.uStaCha, uStaDow) annotation (Line(points={{-242,256},{-360,
          256},{-360,300},{-400,300}}, color={255,0,255}));
  connect(chiDemRed.uChiLoa, uChiLoa)
    annotation (Line(points={{-242,250},{-400,250}}, color={0,0,127}));
  connect(chiDemRed.uChi, uChi) annotation (Line(points={{-242,244},{-260,244},
          {-260,220},{-400,220}}, color={255,0,255}));
  connect(con3.y, minBypSet.uStaUp) annotation (Line(points={{-299,170},{-280,
          170},{-280,148},{-242,148}}, color={255,0,255}));
  connect(chiDemRed.yChiDemRed, minBypSet.uUpsDevSta) annotation (Line(points={
          {-219,246},{-200,246},{-200,160},{-260,160},{-260,144},{-242,144}},
        color={255,0,255}));
  connect(minBypSet.uSta, uSta) annotation (Line(points={{-242,140},{-340,140},
          {-340,150},{-400,150}}, color={255,127,0}));
  connect(minBypSet.uStaDow, uStaDow) annotation (Line(points={{-242,132},{-360,
          132},{-360,300},{-400,300}}, color={255,0,255}));
  connect(minBypSet.uOnOff, uOnOff) annotation (Line(points={{-242,136},{-320,
          136},{-320,120},{-400,120}}, color={255,0,255}));
  connect(chiDemRed.yChiDemRed, minBypRes.uUpsDevSta) annotation (Line(points={
          {-219,246},{-200,246},{-200,208},{-162,208}}, color={255,0,255}));
  connect(uStaDow, minBypRes.uStaCha) annotation (Line(points={{-400,300},{-360,
          300},{-360,204},{-162,204}}, color={255,0,255}));
  connect(minBypSet.yChiWatBypSet, minBypRes.VBypas_setpoint) annotation (Line(
        points={{-219,140},{-180,140},{-180,192},{-162,192}}, color={0,0,127}));
  connect(VBypas_flow, minBypRes.VBypas_flow) annotation (Line(points={{-400,
          190},{-280,190},{-280,196},{-162,196}}, color={0,0,127}));
  connect(minBypRes.yMinBypRes, enaHeaCon.uUpsDevSta) annotation (Line(points={
          {-139,200},{-120,200},{-120,120},{-260,120},{-260,98},{-242,98}},
        color={255,0,255}));
  connect(uStaDow, enaHeaCon.uStaCha) annotation (Line(points={{-400,300},{-360,
          300},{-360,94},{-242,94}}, color={255,0,255}));
  connect(enaHeaCon.uNexChaChi, uNexChaChi) annotation (Line(points={{-242,86},
          {-300,86},{-300,80},{-400,80}}, color={255,127,0}));
  connect(enaHeaCon.uChiHeaCon, uChiHeaCon) annotation (Line(points={{-242,82},
          {-260,82},{-260,50},{-400,50}}, color={255,0,255}));
  connect(uNexChaChi, enaChiIsoVal.uNexChaChi) annotation (Line(points={{-400,
          80},{-300,80},{-300,18},{-242,18}}, color={255,127,0}));
  connect(enaChiIsoVal.uChiWatIsoVal, uChiWatIsoVal) annotation (Line(points={{
          -242,14},{-310,14},{-310,20},{-400,20}}, color={0,0,127}));
  connect(enaHeaCon.yEnaHeaCon, enaChiIsoVal.yUpsDevSta) annotation (Line(
        points={{-219,96},{-200,96},{-200,40},{-260,40},{-260,6},{-242,6}},
        color={255,0,255}));
  connect(uStaDow, enaChiIsoVal.uStaCha) annotation (Line(points={{-400,300},{
          -360,300},{-360,2},{-242,2}}, color={255,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-380,-400},{380,
            400}})));
end DisableLastChiller;
