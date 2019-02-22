within Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.Staging.Subsequences.UpProcess;
block DownController
  "Sequence for controlling devices when there is a stage-down command"
  Subsequences.DownStart staDow
    annotation (Placement(transformation(extent={{-60,340},{-40,360}})));
  CDL.Interfaces.BooleanInput uStaDow "Stage down status: true=stage-down"
    annotation (Placement(transformation(extent={{-440,400},{-400,440}}),
        iconTransformation(extent={{-326,376},{-286,416}})));
  CDL.Interfaces.RealInput uChiLoa[nChi] "Current chiller load" annotation (
      Placement(transformation(extent={{-440,360},{-400,400}}),
        iconTransformation(extent={{-300,336},{-260,376}})));
  CDL.Interfaces.BooleanInput uChi[nChi] "Chiller status: true=ON" annotation (
      Placement(transformation(extent={{-440,330},{-400,370}}),
        iconTransformation(extent={{-296,334},{-256,374}})));
  CDL.Interfaces.RealInput VBypas_flow "Measured bypass flow rate" annotation (
      Placement(transformation(extent={{-440,300},{-400,340}}),
        iconTransformation(extent={{-324,322},{-284,362}})));
  CDL.Interfaces.IntegerInput uSta "Current stage index" annotation (Placement(
        transformation(extent={{-440,270},{-400,310}}), iconTransformation(
          extent={{-268,294},{-228,334}})));
  CDL.Interfaces.IntegerInput uChiPri[nChi] "Chiller enabling priority"
    annotation (Placement(transformation(extent={{-440,440},{-400,480}}),
        iconTransformation(extent={{-372,434},{-332,474}})));
  CDL.Interfaces.BooleanInput uChiHeaCon[nChi]
    "Chillers head pressure control status" annotation (Placement(
        transformation(extent={{-440,240},{-400,280}}), iconTransformation(
          extent={{-282,314},{-242,354}})));
  CDL.Interfaces.RealInput uChiWatIsoVal[nChi]
    "Chilled water isolation valve position" annotation (Placement(
        transformation(extent={{-440,210},{-400,250}}), iconTransformation(
          extent={{-366,200},{-326,240}})));
  CDL.Interfaces.BooleanInput                        uChiWatReq[nChi]
    "Chilled water requst status for each chiller"
    annotation (Placement(transformation(extent={{-440,90},{-400,130}}),
      iconTransformation(extent={{-120,-20},{-100,0}})));
  CDL.Interfaces.BooleanInput                        uConWatReq[nChi]
    "Condenser water requst status for each chiller"
    annotation (Placement(transformation(extent={{-440,-30},{-400,10}}),
      iconTransformation(extent={{-120,-60},{-100,-40}})));
protected
  Subsequences.NextChiller                                                                                         nexChi(
    final nChi=nChi,
    final havePonChi=havePonChi,
    final upOnOffSta=upOnOffSta,
    final dowOnOffSta=dowOnOffSta)
    "Identify next enabling chiller"
    annotation (Placement(transformation(extent={{-160,400},{-140,420}})));
  CDL.Logical.Sources.Constant                        con(final k=false)
    "False constant"
    annotation (Placement(transformation(extent={{-240,430},{-220,450}})));
  CDL.Conversions.BooleanToReal                        booToRea1[nChi]
    "Convert boolean input to real output"
    annotation (Placement(transformation(extent={{-360,100},{-340,120}})));
  CDL.Routing.RealExtractor                         curDisChi(final nin=nChi)
    "Current disabling chiller"
    annotation (Placement(transformation(extent={{-200,100},{-180,120}})));
  CDL.Continuous.LessEqualThreshold                           lesEquThr( final
      threshold=0.5)
    "Convert real input to boolean output"
    annotation (Placement(transformation(extent={{-160,100},{-140,120}})));
  CDL.Logical.And                        and4 "Logical and"
    annotation (Placement(transformation(extent={{-160,140},{-140,160}})));
  Subsequences.EnableChiIsoVal                                                                                         disChiIsoVal(
    final nChi=nChi,
    final iniValPos=1,
    final endValPos=0) "Disable isolation valve of the chiller being disabled"
    annotation (Placement(transformation(extent={{80,170},{100,190}})));
  CDL.Logical.LogicalSwitch logSwi2 "Logical switch"
    annotation (Placement(transformation(extent={{-80,130},{-60,150}})));
  CDL.Logical.And                        and1 "Logical and"
    annotation (Placement(transformation(extent={{20,130},{40,150}})));
  CDL.Routing.BooleanReplicator                        booRep4(final nout=nChi)
    "Replicate boolean input"
    annotation (Placement(transformation(extent={{-80,190},{-60,210}})));
  CDL.Logical.Switch                               swi    [nChi]
    "Logical switch"
    annotation (Placement(transformation(extent={{20,190},{40,210}})));
  CDL.Conversions.BooleanToReal                        booToRea2[nChi]
    "Convert boolean input to real output"
    annotation (Placement(transformation(extent={{-360,-20},{-340,0}})));
  CDL.Routing.RealExtractor                        curDisChi1(final nin=nChi)
    "Current disabling chiller"
    annotation (Placement(transformation(extent={{-200,-20},{-180,0}})));
  CDL.Continuous.LessEqualThreshold                           lesEquThr1(final
      threshold=0.5)
    "Check if the disabled chiller is not requiring condenser water"
    annotation (Placement(transformation(extent={{-160,-20},{-140,0}})));
  CDL.Logical.And3                       and5 "Logical and"
    annotation (Placement(transformation(extent={{-80,-20},{-60,0}})));
  Subsequences.EnableHeadControl                                                                                         disHeaCon(final
      nChi=nChi, final heaStaCha=false)
    "Disable head pressure control of the chiller being disabled"
    annotation (Placement(transformation(extent={{80,10},{100,30}})));
  CDL.Routing.BooleanReplicator                        booRep1(final nout=nChi)
    "Replicate boolean input"
    annotation (Placement(transformation(extent={{-80,40},{-60,60}})));
  CDL.Logical.LogicalSwitch                        logSwi [nChi]
    "Logical switch"
    annotation (Placement(transformation(extent={{20,40},{40,60}})));
  Subsequences.EnableCWPump
    enaNexCWP
    "Identify correct stage number for enabling next condenser water pump"
    annotation (Placement(transformation(extent={{-20,-82},{0,-62}})));
  Pump.CondenserWaterP.Controller                                                          conWatPumCon(
    final isheadered=isheadered,
    final haveWSE=haveWSE,
    final nSta=nSta,
    final chiNum=chiNum,
    final uLow=uLow,
    final uHigh=uHigh) "Enabling next condenser water pump or change pump speed"
    annotation (Placement(transformation(extent={{40,-122},{60,-102}})));
equation
  connect(staDow.uChiLoa, uChiLoa) annotation (Line(points={{-61,357},{-280.5,
          357},{-280.5,380},{-420,380}}, color={0,0,127}));
  connect(staDow.VBypas_flow, VBypas_flow) annotation (Line(points={{-61,353},{
          -280.5,353},{-280.5,320},{-420,320}},  color={0,0,127}));
  connect(uSta, staDow.uSta) annotation (Line(points={{-420,290},{-260,290},{
          -260,351},{-61,351}},  color={255,127,0}));
  connect(nexChi.uChiPri, uChiPri) annotation (Line(points={{-162,418},{-320,
          418},{-320,460},{-420,460}}, color={255,127,0}));
  connect(uChi, nexChi.uChiEna) annotation (Line(points={{-420,350},{-320,350},
          {-320,414},{-162,414}}, color={255,0,255}));
  connect(con.y, nexChi.uStaUp) annotation (Line(points={{-219,440},{-180,440},
          {-180,410},{-162,410}}, color={255,0,255}));
  connect(uSta, nexChi.uSta) annotation (Line(points={{-420,290},{-260,290},{
          -260,406},{-162,406}}, color={255,127,0}));
  connect(uStaDow, nexChi.uStaDow) annotation (Line(points={{-420,420},{-380,
          420},{-380,402},{-162,402}}, color={255,0,255}));
  connect(uStaDow, staDow.uStaDow) annotation (Line(points={{-420,420},{-380,
          420},{-380,359},{-61,359}},  color={255,0,255}));
  connect(nexChi.yOnOff, staDow.uOnOff) annotation (Line(points={{-139,410},{
          -120,410},{-120,349},{-61,349}},  color={255,0,255}));
  connect(nexChi.yEnaSmaChi, staDow.uNexEnaChi) annotation (Line(points={{-139,
          401},{-90,401},{-90,347},{-61,347}},    color={255,127,0}));
  connect(staDow.uChiHeaCon, uChiHeaCon) annotation (Line(points={{-61,345},{
          -220,345},{-220,260},{-420,260}}, color={255,0,255}));
  connect(staDow.uChiWatIsoVal, uChiWatIsoVal) annotation (Line(points={{-61,343},
          {-180,343},{-180,230},{-420,230}},      color={0,0,127}));
  connect(nexChi.yLasDisChi, staDow.uNexDisChi) annotation (Line(points={{-139,
          406},{-100,406},{-100,341},{-61,341}},  color={255,127,0}));
  connect(uChiWatReq, booToRea1.u)
    annotation (Line(points={{-420,110},{-362,110}}, color={255,0,255}));
  connect(booToRea1.y, curDisChi.u)
    annotation (Line(points={{-339,110},{-202,110}}, color={0,0,127}));
  connect(curDisChi.y, lesEquThr.u)
    annotation (Line(points={{-179,110},{-162,110}}, color={0,0,127}));
  connect(nexChi.yOnOff, logSwi2.u2) annotation (Line(points={{-139,410},{-120,
          410},{-120,140},{-82,140}}, color={255,0,255}));
  connect(uStaDow, and4.u2) annotation (Line(points={{-420,420},{-380,420},{
          -380,142},{-162,142}}, color={255,0,255}));
  connect(staDow.yReaDemLim, and4.u1) annotation (Line(points={{-39,341},{-34,
          341},{-34,220},{-180,220},{-180,150},{-162,150}}, color={255,0,255}));
  connect(and4.y, logSwi2.u1) annotation (Line(points={{-139,150},{-90,150},{
          -90,148},{-82,148}}, color={255,0,255}));
  connect(uStaDow, logSwi2.u3) annotation (Line(points={{-420,420},{-380,420},{
          -380,132},{-82,132}}, color={255,0,255}));
  connect(nexChi.yLasDisChi, curDisChi.index) annotation (Line(points={{-139,
          406},{-100,406},{-100,240},{-260,240},{-260,90},{-190,90},{-190,98}},
        color={255,127,0}));
  connect(lesEquThr.y, and1.u2) annotation (Line(points={{-139,110},{-40,110},{
          -40,132},{18,132}}, color={255,0,255}));
  connect(logSwi2.y, and1.u1)
    annotation (Line(points={{-59,140},{18,140}}, color={255,0,255}));
  connect(nexChi.yLasDisChi, disChiIsoVal.uNexChaChi) annotation (Line(points={
          {-139,406},{-100,406},{-100,188},{78,188}}, color={255,127,0}));
  connect(and1.y, disChiIsoVal.yUpsDevSta) annotation (Line(points={{41,140},{
          60,140},{60,176},{78,176}}, color={255,0,255}));
  connect(uStaDow, disChiIsoVal.uStaCha) annotation (Line(points={{-420,420},{
          -380,420},{-380,172},{78,172}}, color={255,0,255}));
  connect(nexChi.yOnOff, booRep4.u) annotation (Line(points={{-139,410},{-120,
          410},{-120,200},{-82,200}}, color={255,0,255}));
  connect(booRep4.y, swi.u2)
    annotation (Line(points={{-59,200},{18,200}}, color={255,0,255}));
  connect(uChiWatIsoVal, swi.u3) annotation (Line(points={{-420,230},{-40,230},
          {-40,192},{18,192}}, color={0,0,127}));
  connect(staDow.yChiWatIsoVal, swi.u1) annotation (Line(points={{-39,350},{-30,
          350},{-30,208},{18,208}}, color={0,0,127}));
  connect(swi.y, disChiIsoVal.uChiWatIsoVal) annotation (Line(points={{41,200},
          {60,200},{60,184},{78,184}}, color={0,0,127}));
  connect(uConWatReq, booToRea2.u)
    annotation (Line(points={{-420,-10},{-362,-10}}, color={255,0,255}));
  connect(booToRea2.y, curDisChi1.u)
    annotation (Line(points={{-339,-10},{-202,-10}}, color={0,0,127}));
  connect(curDisChi1.y, lesEquThr1.u)
    annotation (Line(points={{-179,-10},{-162,-10}}, color={0,0,127}));
  connect(logSwi2.y, and5.u1) annotation (Line(points={{-59,140},{-50,140},{-50,
          100},{-110,100},{-110,-2},{-82,-2}}, color={255,0,255}));
  connect(disChiIsoVal.yEnaChiWatIsoVal, and5.u2) annotation (Line(points={{101,
          186},{120,186},{120,92},{-90,92},{-90,-10},{-82,-10}}, color={255,0,
          255}));
  connect(lesEquThr1.y, and5.u3) annotation (Line(points={{-139,-10},{-108,-10},
          {-108,-18},{-82,-18}}, color={255,0,255}));
  connect(uChi, staDow.uChi) annotation (Line(points={{-420,350},{-320,350},{
          -320,355},{-61,355}}, color={255,0,255}));
  connect(nexChi.yLasDisChi, curDisChi1.index) annotation (Line(points={{-139,
          406},{-100,406},{-100,240},{-260,240},{-260,-32},{-190,-32},{-190,-22}},
        color={255,127,0}));
  connect(nexChi.yOnOff, booRep1.u) annotation (Line(points={{-139,410},{-120,
          410},{-120,50},{-82,50}}, color={255,0,255}));
  connect(booRep1.y, logSwi.u2)
    annotation (Line(points={{-59,50},{18,50}}, color={255,0,255}));
  connect(uChiHeaCon, logSwi.u3) annotation (Line(points={{-420,260},{-220,260},
          {-220,30},{0,30},{0,42},{18,42}}, color={255,0,255}));
  connect(staDow.yChiHeaCon, logSwi.u1) annotation (Line(points={{-39,355},{-26,
          355},{-26,58},{18,58}}, color={255,0,255}));
  connect(and5.y, disHeaCon.uUpsDevSta) annotation (Line(points={{-59,-10},{40,
          -10},{40,28},{78,28}}, color={255,0,255}));
  connect(uStaDow, disHeaCon.uStaCha) annotation (Line(points={{-420,420},{-380,
          420},{-380,24},{78,24}}, color={255,0,255}));
  connect(nexChi.yLasDisChi, disHeaCon.uNexChaChi) annotation (Line(points={{
          -139,406},{-100,406},{-100,16},{78,16}}, color={255,127,0}));
  connect(logSwi.y, disHeaCon.uChiHeaCon) annotation (Line(points={{41,50},{60,
          50},{60,12},{78,12}}, color={255,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-400,
            -360},{420,440}})), Diagram(coordinateSystem(preserveAspectRatio=
            false, extent={{-400,-360},{420,440}})));
end DownController;
