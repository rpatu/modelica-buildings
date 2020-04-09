within Buildings.Applications;
package DHC_Marseille
  extends Modelica.Icons.VariantsPackage;
  package GF
    extends Modelica.Icons.VariantsPackage;
    model HPSHC
      extends Fluid.Interfaces.EightPort_parallel;
      Fluid.Chillers.ElectricReformulatedEIR electricReformulatedEIR
        annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
    equation
      connect(port_a2, electricReformulatedEIR.port_a1) annotation (Line(points=
             {{-100,30},{-60,30},{-60,6},{-10,6}}, color={0,127,255}));
      connect(port_a1, electricReformulatedEIR.port_a1) annotation (Line(points=
             {{-100,80},{-60,80},{-60,6},{-10,6}}, color={0,127,255}));
      connect(electricReformulatedEIR.port_b1, port_b1) annotation (Line(points=
             {{10,6},{60,6},{60,80},{100,80}}, color={0,127,255}));
      connect(electricReformulatedEIR.port_b1, port_b2) annotation (Line(points=
             {{10,6},{60,6},{60,30},{100,30}}, color={0,127,255}));
      connect(electricReformulatedEIR.port_a2, port_a4) annotation (Line(points=
             {{10,-6},{60,-6},{60,-80},{100,-80}}, color={0,127,255}));
      connect(electricReformulatedEIR.port_a2, port_a3) annotation (Line(points=
             {{10,-6},{60,-6},{60,-30},{100,-30}}, color={0,127,255}));
      connect(electricReformulatedEIR.port_b2, port_b4) annotation (Line(points=
             {{-10,-6},{-60,-6},{-60,-80},{-100,-80}}, color={0,127,255}));
      connect(electricReformulatedEIR.port_b2, port_b3) annotation (Line(points=
             {{-10,-6},{-60,-6},{-60,-30},{-100,-30}}, color={0,127,255}));
    end HPSHC;

    model Chiller

      extends Fluid.Interfaces.PartialFourPort
      annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)));

      Fluid.Chillers.ElectricReformulatedEIR electricReformulatedEIR(
        redeclare package Medium1 = Media.Water,
        redeclare package Medium2 = Media.Water,
        dp1_nominal=0.38,
        dp2_nominal=0.31,
        per=Fluid.Chillers.Data.ElectricReformulatedEIR.Test_quantum())
        annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
      Modelica.Blocks.Interfaces.BooleanInput u
        annotation (Placement(transformation(extent={{-140,10},{-100,50}})));
      Modelica.Blocks.Interfaces.RealInput u1
        annotation (Placement(transformation(extent={{-140,-50},{-100,-10}})));
      Modelica.Fluid.Sensors.TemperatureTwoPort THIn(redeclare package Medium =
            Modelica.Media.Water.ConstantPropertyLiquidWater)
        annotation (Placement(transformation(extent={{-60,50},{-40,70}})));
      Modelica.Fluid.Sensors.TemperatureTwoPort TCout(redeclare package Medium =
            Modelica.Media.Water.ConstantPropertyLiquidWater)
        annotation (Placement(transformation(extent={{-40,-70},{-60,-50}})));
      Modelica.Fluid.Sensors.TemperatureTwoPort THOut(redeclare package Medium =
            Modelica.Media.Water.ConstantPropertyLiquidWater)
        annotation (Placement(transformation(extent={{40,50},{60,70}})));
      Modelica.Fluid.Sensors.TemperatureTwoPort TCIn(redeclare package Medium =
            Modelica.Media.Water.ConstantPropertyLiquidWater)
        annotation (Placement(transformation(extent={{60,-70},{40,-50}})));
    equation
      connect(u1, electricReformulatedEIR.TSet) annotation (Line(points={{-120,
              -30},{-66,-30},{-66,-3},{-12,-3}}, color={0,0,127}));
      connect(u, electricReformulatedEIR.on) annotation (Line(points={{-120,30},
              {-66,30},{-66,3},{-12,3}}, color={255,0,255}));
      connect(port_a1, THIn.port_a)
        annotation (Line(points={{-100,60},{-60,60}}, color={0,127,255}));
      connect(THIn.port_b, electricReformulatedEIR.port_a1) annotation (Line(
            points={{-40,60},{-20,60},{-20,6},{-10,6}}, color={0,127,255}));
      connect(electricReformulatedEIR.port_b1, THOut.port_a) annotation (Line(
            points={{10,6},{20,6},{20,60},{40,60}}, color={0,127,255}));
      connect(THOut.port_b, port_b1)
        annotation (Line(points={{60,60},{100,60}}, color={0,127,255}));
      connect(port_a2, TCIn.port_a)
        annotation (Line(points={{100,-60},{60,-60}}, color={0,127,255}));
      connect(TCIn.port_b, electricReformulatedEIR.port_a2) annotation (Line(
            points={{40,-60},{20,-60},{20,-6},{10,-6}}, color={0,127,255}));
      connect(TCout.port_a, electricReformulatedEIR.port_b2) annotation (Line(
            points={{-40,-60},{-20,-60},{-20,-6},{-10,-6}}, color={0,127,255}));
      connect(TCout.port_b, port_b2)
        annotation (Line(points={{-60,-60},{-100,-60}}, color={0,127,255}));
      annotation (Icon(graphics={
            Rectangle(
              extent={{0,-54},{100,-66}},
              lineColor={0,0,255},
              pattern=LinePattern.None,
              fillColor={0,0,255},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-100,-66},{0,-54}},
              lineColor={0,0,127},
              pattern=LinePattern.None,
              fillColor={0,0,127},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-100,54},{0,66}},
              lineColor={0,0,255},
              pattern=LinePattern.None,
              fillColor={255,170,85},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{0,54},{100,66}},
              lineColor={0,0,255},
              pattern=LinePattern.None,
              fillColor={238,46,47},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-20,40},{20,-20}},
              lineColor={28,108,200},
              lineThickness=1,
              fillColor={28,108,200},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{-40,-20},{40,-20},{0,-54},{-40,-20}},
              lineColor={28,108,200},
              lineThickness=1,
              fillColor={28,108,200},
              fillPattern=FillPattern.Solid)}));
    end Chiller;

    model Chiller_carnot

        extends Fluid.Interfaces.PartialFourPort
      annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)));

      Fluid.Chillers.Carnot_TEva chi(
        redeclare package Medium1 = Media.Water,
        redeclare package Medium2 = Media.Water,
        m1_flow_nominal=490/3.6,
        m2_flow_nominal=810/3.6,
        QEva_flow_nominal=-4000000,
        dTEva_nominal=-7,
        dTCon_nominal=5,
        use_eta_Carnot_nominal=false,
        etaCarnot_nominal=5.71,
        COP_nominal=5.71,
        dp1_nominal=0.41,
        dp2_nominal=0.31,
        QEva_flow_min=-4240000)
        annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
      Modelica.Blocks.Sources.RealExpression realExpression(y=4 + 273.15)
        annotation (Placement(transformation(extent={{-100,20},{-80,40}})));
      Modelica.Fluid.Sensors.TemperatureTwoPort THIn(redeclare package Medium
          = Modelica.Media.Water.ConstantPropertyLiquidWater)
        annotation (Placement(transformation(extent={{-80,50},{-60,70}})));
      Modelica.Fluid.Sensors.TemperatureTwoPort TT211(redeclare package Medium
          = Modelica.Media.Water.ConstantPropertyLiquidWater)
        annotation (Placement(transformation(extent={{60,-4},{80,16}})));
      Modelica.Fluid.Sensors.TemperatureTwoPort TCout(redeclare package Medium
          = Modelica.Media.Water.ConstantPropertyLiquidWater)
        annotation (Placement(transformation(extent={{-60,-70},{-80,-50}})));
      Modelica.Fluid.Sensors.TemperatureTwoPort TCIn(redeclare package Medium
          = Modelica.Media.Water.ConstantPropertyLiquidWater)
        annotation (Placement(transformation(extent={{140,-30},{120,-10}})));
      Modelica.Fluid.Valves.ValveLinear CV121(
        redeclare package Medium =
            Modelica.Media.Water.ConstantPropertyLiquidWater,
        dp_nominal=10000,
        m_flow_nominal=500) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={40,-20})));

      Modelica.Fluid.Valves.ValveLinear XV111(
        redeclare package Medium =
            Modelica.Media.Water.ConstantPropertyLiquidWater,
        dp_nominal=10000,
        m_flow_nominal=500) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={-30,-30})));

      Modelica.Fluid.Sensors.Pressure PT221(redeclare package Medium =
            Modelica.Media.Water.ConstantPropertyLiquidWater)
        annotation (Placement(transformation(extent={{-42,6},{-22,26}})));
      Modelica.Fluid.Sensors.Pressure PT211(redeclare package Medium =
            Modelica.Media.Water.ConstantPropertyLiquidWater)
        annotation (Placement(transformation(extent={{18,6},{38,26}})));
      Modelica.Fluid.Sensors.MassFlowRate FT121(redeclare package Medium =
            Modelica.Media.Water.ConstantPropertyLiquidWater) annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={80,-20})));
      Controls.Continuous.LimPID conPID(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=5,
        Ti=10,
        initType=Modelica.Blocks.Types.InitPID.NoInit) annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={40,-70})));
      Modelica.Blocks.Sources.RealExpression Q_set(y=500/3.6)
        annotation (Placement(transformation(extent={{0,-120},{20,-100}})));
      Modelica.Blocks.Math.Add PDT(k2=-1)
        annotation (Placement(transformation(extent={{80,260},{100,280}})));
      Controls.Continuous.LimPID conPID1(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=3,
        Ti=15,
        initType=Modelica.Blocks.Types.InitPID.NoInit) annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={130,310})));
      Modelica.Blocks.Sources.RealExpression PDT_set(y=0.7)
        annotation (Placement(transformation(extent={{80,300},{100,320}})));
      Modelica.Blocks.Interfaces.RealInput TT200_in annotation (Placement(
            transformation(
            extent={{-20,-20},{20,20}},
            rotation=270,
            origin={10,140})));
      Controls.Continuous.LimPID conPID2(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=2.5,
        Ti=1.7,
        initType=Modelica.Blocks.Types.InitPID.NoInit) annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={130,230})));
      Modelica.Blocks.Math.Add TDT(k2=-1)
        annotation (Placement(transformation(extent={{80,180},{100,200}})));
      Modelica.Blocks.Sources.RealExpression TDT_set(y=5 + 273.15)
        annotation (Placement(transformation(extent={{80,220},{100,240}})));
      Controls.Continuous.LimPID conPID3(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=3,
        Ti=1,
        initType=Modelica.Blocks.Types.InitPID.NoInit) annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={130,130})));
      Modelica.Blocks.Sources.RealExpression TT_set(y=30 + 273.15)
        annotation (Placement(transformation(extent={{80,120},{100,140}})));
      Modelica.Blocks.Math.MinMax minMax(nu=3)
        annotation (Placement(transformation(extent={{180,220},{200,240}})));
      Modelica.Fluid.Valves.ValveLinear CV211(
        redeclare package Medium =
            Modelica.Media.Water.ConstantPropertyLiquidWater,
        dp_nominal=10000,
        m_flow_nominal=800) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={110,6})));

      Modelica.Blocks.Interfaces.BooleanInput on(start=false)
        annotation (Placement(transformation(extent={{-160,-150},{-120,-110}})));
      Controls.OBC.CDL.Conversions.BooleanToReal signal
        annotation (Placement(transformation(extent={{-80,-140},{-60,-120}})));
      Modelica.StateGraph.InitialStep GF_stopped
        annotation (Placement(transformation(extent={{-320,-40},{-300,-20}})));
      Modelica.StateGraph.TransitionWithSignal GF_start_request
        annotation (Placement(transformation(extent={{-280,-40},{-260,-20}})));
      inner Modelica.StateGraph.StateGraphRoot stateGraphRoot
        annotation (Placement(transformation(extent={{-340,20},{-320,40}})));
      Modelica.StateGraph.StepWithSignal GF_starting
        annotation (Placement(transformation(extent={{-240,-40},{-220,-20}})));
      Modelica.StateGraph.TransitionWithSignal GF_stop_request
        annotation (Placement(transformation(extent={{-200,-40},{-180,-20}})));
      Modelica.Blocks.Logical.Not not1
        annotation (Placement(transformation(extent={{-140,-70},{-160,-50}})));
      Modelica.Blocks.Sources.RealExpression Q_set1(y=0.01)
        annotation (Placement(transformation(extent={{-60,-98},{-40,-78}})));
    equation
      connect(realExpression.y, chi.TSet) annotation (Line(points={{-79,30},{-16,30},
              {-16,9},{-12,9}}, color={0,0,127}));
      connect(port_a1, THIn.port_a)
        annotation (Line(points={{-100,60},{-80,60}}, color={0,127,255}));
      connect(THIn.port_b, chi.port_a1) annotation (Line(points={{-60,60},{-56,60},{
              -56,6},{-10,6}}, color={0,127,255}));
      connect(port_b2, TCout.port_b)
        annotation (Line(points={{-100,-60},{-80,-60}}, color={0,127,255}));
      connect(TCIn.port_a, port_a2) annotation (Line(points={{140,-20},{140,-60},{100,
              -60}}, color={0,127,255}));
      connect(chi.port_b1, TT211.port_a)
        annotation (Line(points={{10,6},{60,6}}, color={0,127,255}));
      connect(chi.port_a2, CV121.port_b) annotation (Line(points={{10,-6},{20,-6},{20,
              -20},{30,-20}}, color={0,127,255}));
      connect(TCout.port_a, XV111.port_b) annotation (Line(points={{-60,-60},{-56,-60},
              {-56,-30},{-40,-30}}, color={0,127,255}));
      connect(XV111.port_a, chi.port_b2) annotation (Line(points={{-20,-30},{-16,-30},
              {-16,-6},{-10,-6}}, color={0,127,255}));
      connect(THIn.port_b, PT221.port) annotation (Line(points={{-60,60},{-56,60},{-56,
              6},{-32,6}}, color={0,127,255}));
      connect(chi.port_b1, PT211.port)
        annotation (Line(points={{10,6},{28,6}}, color={0,127,255}));
      connect(CV121.port_a, FT121.port_b)
        annotation (Line(points={{50,-20},{70,-20}}, color={0,127,255}));
      connect(FT121.port_a, TCIn.port_b)
        annotation (Line(points={{90,-20},{120,-20}}, color={0,127,255}));
      connect(FT121.m_flow, conPID.u_m)
        annotation (Line(points={{80,-31},{80,-70},{52,-70}}, color={0,0,127}));
      connect(Q_set.y, conPID.u_s)
        annotation (Line(points={{21,-110},{40,-110},{40,-82}}, color={0,0,127}));
      connect(conPID.y, CV121.opening)
        annotation (Line(points={{40,-59},{40,-28}}, color={0,0,127}));
      connect(PT211.p, PDT.u2) annotation (Line(points={{39,16},{40,16},{40,264},{78,
              264}}, color={0,0,127}));
      connect(PT221.p, PDT.u1) annotation (Line(points={{-21,16},{-12,16},{-12,276},
              {78,276}}, color={0,0,127}));
      connect(PDT.y, conPID1.u_m)
        annotation (Line(points={{101,270},{130,270},{130,298}}, color={0,0,127}));
      connect(PDT_set.y, conPID1.u_s)
        annotation (Line(points={{101,310},{118,310}}, color={0,0,127}));
      connect(TDT_set.y, conPID2.u_s)
        annotation (Line(points={{101,230},{118,230}}, color={0,0,127}));
      connect(TT211.T, TDT.u2)
        annotation (Line(points={{70,17},{70,184},{78,184}}, color={0,0,127}));
      connect(TDT.y, conPID2.u_m)
        annotation (Line(points={{101,190},{130,190},{130,218}}, color={0,0,127}));
      connect(TT200_in, TDT.u1) annotation (Line(points={{10,140},{10,100},{52,100},
              {52,196},{78,196}}, color={0,0,127}));
      connect(TT_set.y, conPID3.u_s)
        annotation (Line(points={{101,130},{118,130}}, color={0,0,127}));
      connect(TT211.T, conPID3.u_m) annotation (Line(points={{70,17},{70,100},{130,100},
              {130,118}}, color={0,0,127}));
      connect(conPID2.y, minMax.u[1]) annotation (Line(points={{141,230},{160,
              230},{160,234.667},{180,234.667}},
                                           color={0,0,127}));
      connect(conPID3.y, minMax.u[2]) annotation (Line(points={{141,130},{162,130},{
              162,230},{180,230}}, color={0,0,127}));
      connect(conPID1.y, minMax.u[3]) annotation (Line(points={{141,310},{160,
              310},{160,225.333},{180,225.333}},
                                           color={0,0,127}));
      connect(TT211.port_b, CV211.port_a)
        annotation (Line(points={{80,6},{100,6}}, color={0,127,255}));
      connect(CV211.port_b, port_b1) annotation (Line(points={{120,6},{140,6},{140,60},
              {100,60}}, color={0,127,255}));
      connect(minMax.yMax, CV211.opening) annotation (Line(points={{201,236},{220,236},
              {220,30},{110,30},{110,14}}, color={0,0,127}));
      connect(on, GF_start_request.condition) annotation (Line(points={{-140,-130},{
              -110,-130},{-110,-100},{-270,-100},{-270,-42}}, color={255,0,255}));
      connect(GF_stopped.outPort[1], GF_start_request.inPort)
        annotation (Line(points={{-299.5,-30},{-274,-30}}, color={0,0,0}));
      connect(GF_start_request.outPort, GF_starting.inPort[1])
        annotation (Line(points={{-268.5,-30},{-241,-30}}, color={0,0,0}));
      connect(GF_starting.active, signal.u) annotation (Line(points={{-230,-41},{-230,
              -80},{-92,-80},{-92,-130},{-82,-130}}, color={255,0,255}));
      connect(GF_starting.outPort[1], GF_stop_request.inPort)
        annotation (Line(points={{-219.5,-30},{-194,-30}}, color={0,0,0}));
      connect(GF_stop_request.outPort, GF_stopped.inPort[1]) annotation (Line(
            points={{-188.5,-30},{-170,-30},{-170,0},{-340,0},{-340,-30},{-321,-30}},
            color={0,0,0}));
      connect(not1.u, GF_start_request.condition) annotation (Line(points={{-138,-60},
              {-116,-60},{-116,-130},{-110,-130},{-110,-100},{-270,-100},{-270,-42}},
            color={255,0,255}));
      connect(not1.y, GF_stop_request.condition) annotation (Line(points={{-161,-60},
              {-190,-60},{-190,-42}}, color={255,0,255}));
      connect(Q_set1.y, XV111.opening) annotation (Line(points={{-39,-88},{-30,
              -88},{-30,-38}}, color={0,0,127}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-140,-140},
                {140,140}}), graphics={
            Rectangle(
              extent={{0,-54},{100,-66}},
              lineColor={0,0,255},
              pattern=LinePattern.None,
              fillColor={0,0,255},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-100,-66},{0,-54}},
              lineColor={0,0,127},
              pattern=LinePattern.None,
              fillColor={0,0,127},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-100,54},{0,66}},
              lineColor={0,0,255},
              pattern=LinePattern.None,
              fillColor={255,170,85},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{0,54},{100,66}},
              lineColor={0,0,255},
              pattern=LinePattern.None,
              fillColor={238,46,47},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-20,40},{20,-20}},
              lineColor={28,108,200},
              lineThickness=1,
              fillColor={28,108,200},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{-40,-20},{40,-20},{0,-54},{-40,-20}},
              lineColor={28,108,200},
              lineThickness=1,
              fillColor={28,108,200},
              fillPattern=FillPattern.Solid)}),                      Diagram(
            coordinateSystem(preserveAspectRatio=false, extent={{-140,-140},{140,140}})));
    end Chiller_carnot;

    package Tests
      extends Modelica.Icons.ExamplesPackage;
      model test_0
        Chiller chiller(redeclare package Medium1 = Media.Water, redeclare
            package Medium2 =
                      Media.Water)
          annotation (Placement(transformation(extent={{-10,0},{10,20}})));
        Modelica.Fluid.Sources.MassFlowSource_T entree_c(
          redeclare package Medium =
              Modelica.Media.Water.ConstantPropertyLiquidWater,
          m_flow=800,
          T=298.15,
          nPorts=1) annotation (Placement(transformation(extent={{-80,40},{-60,60}})));

        Modelica.Fluid.Sources.MassFlowSource_T entree_f(
          redeclare package Medium =
              Modelica.Media.Water.ConstantPropertyLiquidWater,
          m_flow=700/3.6,
          T=282.15,
          nPorts=1) annotation (Placement(transformation(extent={{80,-40},{60,-20}})));

        Modelica.Fluid.Sources.FixedBoundary sortie_f(redeclare package Medium =
              Modelica.Media.Water.ConstantPropertyLiquidWater, nPorts=1)
          annotation (Placement(transformation(extent={{-80,-40},{-60,-20}})));
        Modelica.Fluid.Sources.FixedBoundary sortie_c(redeclare package Medium =
              Modelica.Media.Water.ConstantPropertyLiquidWater, nPorts=1) annotation (
           Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=180,
              origin={70,50})));
        Modelica.Blocks.Sources.BooleanExpression booleanExpression(y=true)
          annotation (Placement(transformation(extent={{-120,20},{-100,40}})));
        Modelica.Blocks.Sources.RealExpression realExpression(y=4 + 273.15)
          annotation (Placement(transformation(extent={{-120,-10},{-100,10}})));
      equation
        connect(entree_c.ports[1], chiller.port_a1) annotation (Line(points={{-60,50},
                {-40,50},{-40,16},{-10,16}}, color={0,127,255}));
        connect(sortie_c.ports[1], chiller.port_b1) annotation (Line(points={{60,50},{
                40,50},{40,16},{10,16}}, color={0,127,255}));
        connect(chiller.port_a2, entree_f.ports[1]) annotation (Line(points={{10,4},{40,
                4},{40,-30},{60,-30}}, color={0,127,255}));
        connect(sortie_f.ports[1], chiller.port_b2) annotation (Line(points={{-60,-30},
                {-40,-30},{-40,4},{-10,4}}, color={0,127,255}));
        connect(booleanExpression.y, chiller.u) annotation (Line(points={{-99,30},
                {-56,30},{-56,13},{-12,13}},
                                        color={255,0,255}));
        connect(realExpression.y, chiller.u1) annotation (Line(points={{-99,0},{-56.5,
                0},{-56.5,7},{-12,7}}, color={0,0,127}));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
              coordinateSystem(preserveAspectRatio=false)));
      end test_0;

      model test_00
        Fluid.Chillers.ElectricReformulatedEIR electricReformulatedEIR(
          redeclare package Medium1 = Media.Water,
          redeclare package Medium2 = Media.Water,
          show_T=true,
          dp1_nominal=0.38,
          dp2_nominal=0.31,
          per=Fluid.Chillers.Data.ElectricReformulatedEIR.ReformEIRChiller_Carrier_23XL_724kW_6_04COP_Vanes())
          annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
        Modelica.Blocks.Sources.BooleanExpression booleanExpression(y=true)
          annotation (Placement(transformation(extent={{-100,20},{-80,40}})));
        Modelica.Blocks.Sources.RealExpression realExpression(y=4 + 273.15)
          annotation (Placement(transformation(extent={{-100,-40},{-80,-20}})));
        Modelica.Fluid.Sources.FixedBoundary sortie_c(redeclare package Medium =
              Modelica.Media.Water.ConstantPropertyLiquidWater, nPorts=1) annotation (
           Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=180,
              origin={90,70})));
        Modelica.Fluid.Sources.MassFlowSource_T entree_c(
          redeclare package Medium =
              Modelica.Media.Water.ConstantPropertyLiquidWater,
          m_flow=800/3.6,
          T=293.15,
          nPorts=1) annotation (Placement(transformation(extent={{-100,60},{-80,
                  80}})));
        Modelica.Fluid.Sources.FixedBoundary sortie_f(redeclare package Medium =
              Modelica.Media.Water.ConstantPropertyLiquidWater, nPorts=1)
          annotation (Placement(transformation(extent={{-100,-80},{-80,-60}})));
        Modelica.Fluid.Sources.MassFlowSource_T entree_f(
          redeclare package Medium =
              Modelica.Media.Water.ConstantPropertyLiquidWater,
          m_flow=300/3.6,
          T=282.15,
          nPorts=1) annotation (Placement(transformation(extent={{100,-80},{80,
                  -60}})));
        Modelica.Fluid.Sensors.TemperatureTwoPort temperature(redeclare package
            Medium = Modelica.Media.Water.ConstantPropertyLiquidWater)
          annotation (Placement(transformation(extent={{-20,-50},{-40,-30}})));
        Modelica.Fluid.Sensors.TemperatureTwoPort temperature1(redeclare
            package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater)
          annotation (Placement(transformation(extent={{20,60},{40,80}})));
      equation
        connect(entree_f.ports[1], electricReformulatedEIR.port_a2) annotation (
           Line(points={{80,-70},{40,-70},{40,-6},{10,-6}}, color={0,127,255}));
        connect(entree_c.ports[1], electricReformulatedEIR.port_a1) annotation (
           Line(points={{-80,70},{-40,70},{-40,6},{-10,6}}, color={0,127,255}));
        connect(realExpression.y, electricReformulatedEIR.TSet) annotation (
            Line(points={{-79,-30},{-60,-30},{-60,-3},{-12,-3}}, color={0,0,127}));
        connect(booleanExpression.y, electricReformulatedEIR.on) annotation (
            Line(points={{-79,30},{-60,30},{-60,3},{-12,3}}, color={255,0,255}));
        connect(electricReformulatedEIR.port_b2, temperature.port_a)
          annotation (Line(points={{-10,-6},{-10,-40},{-20,-40}}, color={0,127,
                255}));
        connect(temperature.port_b, sortie_f.ports[1]) annotation (Line(points=
                {{-40,-40},{-60,-40},{-60,-70},{-80,-70}}, color={0,127,255}));
        connect(electricReformulatedEIR.port_b1, temperature1.port_a)
          annotation (Line(points={{10,6},{10,70},{20,70}}, color={0,127,255}));
        connect(temperature1.port_b, sortie_c.ports[1])
          annotation (Line(points={{40,70},{80,70}}, color={0,127,255}));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
              coordinateSystem(preserveAspectRatio=false)));
      end test_00;

      model test_01
        Fluid.Chillers.ElectricReformulatedEIR electricReformulatedEIR(
          redeclare package Medium1 = Media.Water,
          redeclare package Medium2 = Media.Water,
          show_T=true,
          dp1_nominal=0.38,
          dp2_nominal=0.31,
          per=Fluid.Chillers.Data.ElectricReformulatedEIR.ReformEIRChiller_Carrier_23XL_724kW_6_04COP_Vanes())
          annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
        Modelica.Blocks.Sources.BooleanExpression booleanExpression(y=true)
          annotation (Placement(transformation(extent={{-100,20},{-80,40}})));
        Modelica.Blocks.Sources.RealExpression realExpression(y=4 + 273.15)
          annotation (Placement(transformation(extent={{-100,-40},{-80,-20}})));
        Modelica.Fluid.Sources.FixedBoundary sortie_c(redeclare package Medium =
              Modelica.Media.Water.ConstantPropertyLiquidWater, nPorts=1) annotation (
           Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=180,
              origin={90,70})));
        Modelica.Fluid.Sources.MassFlowSource_T entree_c(
          redeclare package Medium =
              Modelica.Media.Water.ConstantPropertyLiquidWater,
          m_flow=800/3.6,
          T=293.15,
          nPorts=1) annotation (Placement(transformation(extent={{-100,60},{-80,
                  80}})));
        Modelica.Fluid.Sources.FixedBoundary sortie_f(redeclare package Medium =
              Modelica.Media.Water.ConstantPropertyLiquidWater, nPorts=1)
          annotation (Placement(transformation(extent={{-100,-80},{-80,-60}})));
        Modelica.Fluid.Sources.MassFlowSource_T entree_f(
          redeclare package Medium =
              Modelica.Media.Water.ConstantPropertyLiquidWater,
          m_flow=300/3.6,
          T=282.15,
          nPorts=1) annotation (Placement(transformation(extent={{100,-80},{80,
                  -60}})));
        Modelica.Fluid.Sensors.TemperatureTwoPort temperature(redeclare package
            Medium = Modelica.Media.Water.ConstantPropertyLiquidWater)
          annotation (Placement(transformation(extent={{-20,-80},{-40,-60}})));
        Modelica.Fluid.Sensors.TemperatureTwoPort temperature1(redeclare
            package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater)
          annotation (Placement(transformation(extent={{20,60},{40,80}})));
      equation
        connect(entree_f.ports[1], electricReformulatedEIR.port_a2) annotation (
           Line(points={{80,-70},{40,-70},{40,-6},{10,-6}}, color={0,127,255}));
        connect(entree_c.ports[1], electricReformulatedEIR.port_a1) annotation (
           Line(points={{-80,70},{-40,70},{-40,6},{-10,6}}, color={0,127,255}));
        connect(realExpression.y, electricReformulatedEIR.TSet) annotation (
            Line(points={{-79,-30},{-60,-30},{-60,-3},{-12,-3}}, color={0,0,127}));
        connect(booleanExpression.y, electricReformulatedEIR.on) annotation (
            Line(points={{-79,30},{-60,30},{-60,3},{-12,3}}, color={255,0,255}));
        connect(electricReformulatedEIR.port_b2, temperature.port_a)
          annotation (Line(points={{-10,-6},{-10,-70},{-20,-70}}, color={0,127,
                255}));
        connect(temperature.port_b, sortie_f.ports[1])
          annotation (Line(points={{-40,-70},{-80,-70}}, color={0,127,255}));
        connect(electricReformulatedEIR.port_b1, temperature1.port_a)
          annotation (Line(points={{10,6},{10,70},{20,70}}, color={0,127,255}));
        connect(temperature1.port_b, sortie_c.ports[1])
          annotation (Line(points={{40,70},{80,70}}, color={0,127,255}));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
              coordinateSystem(preserveAspectRatio=false)));
      end test_01;

      model test_1
        Chiller chiller(redeclare package Medium1 = Media.Water, redeclare
            package Medium2 =
                      Media.Water)
          annotation (Placement(transformation(extent={{-10,0},{10,20}})));
        Modelica.Fluid.Sources.MassFlowSource_T entree_c(
          redeclare package Medium =
              Modelica.Media.Water.ConstantPropertyLiquidWater,
          m_flow=800,
          T=298.15,
          nPorts=1) annotation (Placement(transformation(extent={{-80,40},{-60,60}})));

        Modelica.Fluid.Sources.FixedBoundary sortie_f(redeclare package Medium =
              Modelica.Media.Water.ConstantPropertyLiquidWater, nPorts=1)
          annotation (Placement(transformation(extent={{-80,-40},{-60,-20}})));
        Modelica.Fluid.Sources.FixedBoundary sortie_c(redeclare package Medium =
              Modelica.Media.Water.ConstantPropertyLiquidWater, nPorts=1) annotation (
           Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=180,
              origin={70,50})));
        Modelica.Blocks.Sources.BooleanExpression booleanExpression(y=true)
          annotation (Placement(transformation(extent={{-120,20},{-100,40}})));
        Modelica.Blocks.Sources.RealExpression realExpression(y=4 + 273.15)
          annotation (Placement(transformation(extent={{-120,-10},{-100,10}})));
        Modelica.Fluid.Sources.Boundary_pT boundary(
          redeclare package Medium =
              Modelica.Media.Water.ConstantPropertyLiquidWater,
          use_T_in=false,
          p=100000,
          T=291.15,
          nPorts=1)
          annotation (Placement(transformation(extent={{80,-60},{60,-40}})));
        Fluid.Movers.FlowControlled_dp fan(
          redeclare package Medium = Media.Water,
          m_flow_nominal=1000,
          redeclare Fluid.Movers.Data.Generic per,
          inputType=Buildings.Fluid.Types.InputType.Constant,
          constantHead=87000)
          annotation (Placement(transformation(extent={{40,-60},{20,-40}})));
      equation
        connect(entree_c.ports[1], chiller.port_a1) annotation (Line(points={{-60,50},
                {-40,50},{-40,16},{-10,16}}, color={0,127,255}));
        connect(sortie_c.ports[1], chiller.port_b1) annotation (Line(points={{60,50},{
                40,50},{40,16},{10,16}}, color={0,127,255}));
        connect(sortie_f.ports[1], chiller.port_b2) annotation (Line(points={{-60,-30},
                {-40,-30},{-40,4},{-10,4}}, color={0,127,255}));
        connect(booleanExpression.y, chiller.u) annotation (Line(points={{-99,30},
                {-56,30},{-56,13},{-12,13}},
                                        color={255,0,255}));
        connect(realExpression.y, chiller.u1) annotation (Line(points={{-99,0},{-56.5,
                0},{-56.5,7},{-12,7}}, color={0,0,127}));
        connect(fan.port_a, boundary.ports[1]) annotation (Line(points={{40,-50},
                {52,-50},{52,-50},{60,-50}}, color={0,127,255}));
        connect(fan.port_b, chiller.port_a2) annotation (Line(points={{20,-50},
                {10,-50},{10,4}}, color={0,127,255}));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
              coordinateSystem(preserveAspectRatio=false)));
      end test_1;

      model test_carnot
        Chiller_carnot chiller_carnot(redeclare package Medium1 = Media.Water,
            redeclare package Medium2 = Media.Water)
          annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
        Modelica.Fluid.Sources.MassFlowSource_T entree_c(
          redeclare package Medium =
              Modelica.Media.Water.ConstantPropertyLiquidWater,
          m_flow=800,
          T=298.15,
          nPorts=1) annotation (Placement(transformation(extent={{-80,30},{-60,
                  50}})));
        Modelica.Fluid.Sources.FixedBoundary sortie_c(redeclare package Medium =
              Modelica.Media.Water.ConstantPropertyLiquidWater, nPorts=1) annotation (
           Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=180,
              origin={70,40})));
        Modelica.Fluid.Sources.MassFlowSource_T entree_f(
          redeclare package Medium =
              Modelica.Media.Water.ConstantPropertyLiquidWater,
          m_flow=50,
          T=282.15,
          nPorts=1) annotation (Placement(transformation(extent={{80,-50},{60,
                  -30}})));
        Modelica.Fluid.Sources.FixedBoundary sortie_f(redeclare package Medium =
              Modelica.Media.Water.ConstantPropertyLiquidWater, nPorts=1)
          annotation (Placement(transformation(extent={{-80,-50},{-60,-30}})));
      equation
        connect(entree_c.ports[1], chiller_carnot.port_a1) annotation (Line(
              points={{-60,40},{-36,40},{-36,6},{-10,6}}, color={0,127,255}));
        connect(chiller_carnot.port_b1, sortie_c.ports[1]) annotation (Line(
              points={{10,6},{36,6},{36,40},{60,40}}, color={0,127,255}));
        connect(entree_f.ports[1], chiller_carnot.port_a2) annotation (Line(
              points={{60,-40},{36,-40},{36,-6},{10,-6}}, color={0,127,255}));
        connect(chiller_carnot.port_b2, sortie_f.ports[1]) annotation (Line(
              points={{-10,-6},{-36,-6},{-36,-40},{-60,-40}}, color={0,127,255}));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
              coordinateSystem(preserveAspectRatio=false)));
      end test_carnot;

      model test_carnot_1
        Chiller_carnot chiller_carnot(redeclare package Medium1 = Media.Water,
            redeclare package Medium2 = Media.Water)
          annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
        Modelica.Fluid.Sources.MassFlowSource_T entree_c(
          redeclare package Medium =
              Modelica.Media.Water.ConstantPropertyLiquidWater,
          m_flow=800,
          T=298.15,
          nPorts=1) annotation (Placement(transformation(extent={{-100,30},{-80,
                  50}})));
        Modelica.Fluid.Sources.FixedBoundary sortie_c(redeclare package Medium =
              Modelica.Media.Water.ConstantPropertyLiquidWater, nPorts=1) annotation (
           Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=180,
              origin={70,40})));
        Modelica.Fluid.Sources.FixedBoundary sortie_f(redeclare package Medium =
              Modelica.Media.Water.ConstantPropertyLiquidWater, nPorts=1)
          annotation (Placement(transformation(extent={{-80,-50},{-60,-30}})));
        Modelica.Fluid.Sources.Boundary_pT boundary(
          redeclare package Medium =
              Modelica.Media.Water.ConstantPropertyLiquidWater,
          T=282.15,
          nPorts=1) annotation (Placement(transformation(
              extent={{10,-10},{-10,10}},
              rotation=270,
              origin={90,-70})));
        Fluid.Movers.FlowControlled_dp fan(
          redeclare package Medium = Media.Water,
          m_flow_nominal=1000,
          redeclare Fluid.Movers.Data.Generic per,
          inputType=Buildings.Fluid.Types.InputType.Constant,
          addPowerToMedium=true,
          constantHead=87000)
          annotation (Placement(transformation(extent={{60,-40},{40,-20}})));
        Modelica.Fluid.Sensors.TemperatureTwoPort temperature(redeclare package
            Medium = Modelica.Media.Water.ConstantPropertyLiquidWater)
          annotation (Placement(transformation(extent={{-70,30},{-50,50}})));
        inner Modelica.Fluid.System system
          annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
        Modelica.Blocks.Sources.BooleanExpression booleanExpression(y=true)
          annotation (Placement(transformation(extent={{-60,-80},{-40,-60}})));
      equation
        connect(chiller_carnot.port_b1, sortie_c.ports[1]) annotation (Line(
              points={{7.14286,4.28571},{36,4.28571},{36,40},{60,40}}, color={0,
                127,255}));
        connect(chiller_carnot.port_b2, sortie_f.ports[1]) annotation (Line(
              points={{-7.14286,-4.28571},{-36,-4.28571},{-36,-40},{-60,-40}},
              color={0,127,255}));
        connect(fan.port_a, boundary.ports[1]) annotation (Line(points={{60,-30},
                {90,-30},{90,-60}}, color={0,127,255}));
        connect(fan.port_b, chiller_carnot.port_a2) annotation (Line(points={{
                40,-30},{36,-30},{36,-4.28571},{7.14286,-4.28571}}, color={0,
                127,255}));
        connect(entree_c.ports[1], temperature.port_a)
          annotation (Line(points={{-80,40},{-70,40}}, color={0,127,255}));
        connect(temperature.port_b, chiller_carnot.port_a1) annotation (Line(
              points={{-50,40},{-36,40},{-36,4.28571},{-7.14286,4.28571}},
              color={0,127,255}));
        connect(temperature.T, chiller_carnot.TT200_in) annotation (Line(points=
               {{-60,51},{-60,68},{0.714286,68},{0.714286,10}}, color={0,0,127}));
        connect(booleanExpression.y, chiller_carnot.on) annotation (Line(points=
               {{-39,-70},{-26,-70},{-26,-9.28571},{-10,-9.28571}}, color={255,
                0,255}));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
              coordinateSystem(preserveAspectRatio=false)));
      end test_carnot_1;
    end Tests;
  end GF;

  package PEM
    model pem
      extends Fluid.Interfaces.EightPort_modif;
      Fluid.Movers.FlowControlled_dp fan(
        redeclare package Medium = Media.Water,
        redeclare Fluid.Movers.Data.Generic per,
        inputType=Buildings.Fluid.Types.InputType.Constant,
        constantHead=87000)
        annotation (Placement(transformation(extent={{40,-10},{60,10}})));
      Fluid.Sources.Boundary_pT bou1(
        redeclare package Medium = Media.Water,
        p=100000,
        nPorts=1) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={10,-30})));
      Modelica.Fluid.Sources.FixedBoundary boundary(nPorts=1)
        annotation (Placement(transformation(extent={{-20,-80},{-40,-60}})));
    equation
      connect(fan.port_b, port_a1) annotation (Line(points={{60,0},{80,0},{80,
              100},{60,100}}, color={0,127,255}));
      connect(port_b1, port_a2)
        annotation (Line(points={{20,100},{-40,100}}, color={0,127,255}));
      connect(port_b2, port_a3) annotation (Line(points={{-80,100},{-88,100},{
              -88,60},{-100,60}}, color={0,127,255}));
      connect(port_b3, port_a4)
        annotation (Line(points={{-100,20},{-100,-40}}, color={0,127,255}));
      connect(port_b4, boundary.ports[1]) annotation (Line(points={{-100,-80},{
              -70,-80},{-70,-70},{-40,-70}}, color={0,127,255}));
      connect(bou1.ports[1], fan.port_a)
        annotation (Line(points={{10,-20},{10,0},{40,0}}, color={0,127,255}));
      annotation (Icon(graphics={
            Rectangle(
              extent={{-100,14},{100,-18}},
              lineColor={0,0,0},
              fillColor={0,127,255},
              fillPattern=FillPattern.HorizontalCylinder),
            Ellipse(
              extent={{-58,56},{58,-60}},
              lineColor={0,0,0},
              fillPattern=FillPattern.Sphere,
              fillColor={0,100,199}),
            Polygon(
              points={{0,50},{0,-50},{-54,0},{0,50}},
              lineColor={0,0,0},
              pattern=LinePattern.None,
              fillPattern=FillPattern.HorizontalCylinder,
              fillColor={255,255,255})}));
    end pem;

    model pem_gf
      extends Fluid.Interfaces.PartialTwoPort_modif;
      Modelica.Fluid.Sources.FixedBoundary boundary(redeclare package Medium =
            Modelica.Media.Water.ConstantPropertyLiquidWater, nPorts=1)
        annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=-90,
            origin={-90,-10})));
      Fluid.Sources.Boundary_pT bou1(
        redeclare package Medium = Media.Water,
        p=100000,
        T=288.15,
        nPorts=1) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-50,-70})));
      Fluid.Movers.FlowControlled_dp fan(
        redeclare package Medium = Media.Water,
        m_flow_nominal=1000,
        redeclare Fluid.Movers.Data.Generic per,
        inputType=Buildings.Fluid.Types.InputType.Constant,
        constantHead=87000)
        annotation (Placement(transformation(extent={{-40,-30},{-20,-10}})));
      Modelica.Fluid.Sensors.TemperatureTwoPort TT200(redeclare package Medium =
            Modelica.Media.Water.ConstantPropertyLiquidWater)
        annotation (Placement(transformation(extent={{0,-30},{20,-10}})));
      Modelica.Blocks.Interfaces.RealOutput y
        annotation (Placement(transformation(extent={{100,0},{120,20}})));
      Modelica.Fluid.Sensors.Pressure PT200(redeclare package Medium =
            Modelica.Media.Water.ConstantPropertyLiquidWater)
        annotation (Placement(transformation(extent={{18,40},{38,60}})));
      Modelica.Fluid.Sensors.MassFlowRate FQT200(redeclare package Medium =
            Modelica.Media.Water.ConstantPropertyLiquidWater) annotation (
          Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={50,-10})));
    equation
      connect(boundary.ports[1], port_b) annotation (Line(points={{-90,
              -3.55271e-15},{-90,40},{-50,40},{-50,90}}, color={0,127,255}));
      connect(bou1.ports[1], fan.port_a) annotation (Line(points={{-50,-60},{
              -50,-20},{-40,-20}}, color={0,127,255}));
      connect(fan.port_b, TT200.port_a)
        annotation (Line(points={{-20,-20},{0,-20}}, color={0,127,255}));
      connect(PT200.port, port_a)
        annotation (Line(points={{28,40},{50,40},{50,90}}, color={0,127,255}));
      connect(FQT200.port_b, port_a)
        annotation (Line(points={{50,0},{50,90}}, color={0,127,255}));
      connect(TT200.port_b, FQT200.port_a) annotation (Line(points={{20,-20},{
              36,-20},{36,-20},{50,-20}}, color={0,127,255}));
      connect(TT200.T, y)
        annotation (Line(points={{10,-9},{10,10},{110,10}}, color={0,0,127}));
      annotation (Icon(graphics={
            Rectangle(
              extent={{-100,16},{100,-16}},
              lineColor={0,0,0},
              fillColor={0,127,255},
              fillPattern=FillPattern.HorizontalCylinder),
            Ellipse(
              extent={{-58,58},{58,-58}},
              lineColor={0,0,0},
              fillPattern=FillPattern.Sphere,
              fillColor={0,100,199}),
            Polygon(
              points={{0,52},{0,-48},{-54,2},{0,52}},
              lineColor={0,0,0},
              pattern=LinePattern.None,
              fillPattern=FillPattern.HorizontalCylinder,
              fillColor={255,255,255})}));
    end pem_gf;

    package Tests
      extends Modelica.Icons.ExamplesPackage;
      model test_0
        Fluid.Movers.FlowControlled_dp fan(
          redeclare package Medium = Media.Water,
          m_flow_nominal=1000,
          redeclare Fluid.Movers.Data.Generic per,
          inputType=Buildings.Fluid.Types.InputType.Constant,
          constantHead=87000)
          annotation (Placement(transformation(extent={{20,-50},{40,-30}})));
        Fluid.Sources.Boundary_pT bou(
          redeclare package Medium = Media.Water,
          p=100000,
          T=293.15,
          nPorts=1) annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={-40,-50})));
        Fluid.Sources.Boundary_pT bou1(
          redeclare package Medium = Media.Water,
          p=100000,
          T=293.15,
          nPorts=1) annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={0,-50})));
        GF.Chiller_carnot chiller_carnot
          annotation (Placement(transformation(extent={{-24,36},{4,64}})));
      equation
        connect(bou.ports[1], fan.port_b) annotation (Line(points={{-40,-40},{
                -60,-40},{-60,20},{60,20},{60,-40},{40,-40}}, color={0,127,255}));
        connect(bou1.ports[1], fan.port_a) annotation (Line(points={{
                6.66134e-16,-40},{20,-40}}, color={0,127,255}));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
              coordinateSystem(preserveAspectRatio=false)));
      end test_0;
    end Tests;

    model pem_gf_aa
      extends Fluid.Interfaces.PartialTwoPort_modif;
      Modelica.Fluid.Sources.FixedBoundary boundary(redeclare package Medium =
            Modelica.Media.Water.ConstantPropertyLiquidWater, nPorts=1)
        annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=-90,
            origin={-90,-10})));
      Fluid.Sources.Boundary_pT bou1(
        redeclare package Medium = Media.Water,
        p=100000,
        T=288.15,
        nPorts=1) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-50,-70})));
      Fluid.Movers.FlowControlled_dp fan(
        redeclare package Medium = Media.Water,
        m_flow_nominal=1000,
        redeclare Fluid.Movers.Data.Generic per,
        inputType=Buildings.Fluid.Types.InputType.Constant,
        constantHead=87000)
        annotation (Placement(transformation(extent={{-40,-30},{-20,-10}})));
    equation
      connect(boundary.ports[1], port_b) annotation (Line(points={{-90,
              -3.55271e-15},{-90,40},{-50,40},{-50,90}}, color={0,127,255}));
      connect(bou1.ports[1], fan.port_a) annotation (Line(points={{-50,-60},{
              -50,-20},{-40,-20}}, color={0,127,255}));
      connect(fan.port_b, port_a) annotation (Line(points={{-20,-20},{16,-20},{
              16,90},{50,90}}, color={0,127,255}));
      annotation (Icon(graphics={
            Rectangle(
              extent={{-100,16},{100,-16}},
              lineColor={0,0,0},
              fillColor={0,127,255},
              fillPattern=FillPattern.HorizontalCylinder),
            Ellipse(
              extent={{-58,58},{58,-58}},
              lineColor={0,0,0},
              fillPattern=FillPattern.Sphere,
              fillColor={0,100,199}),
            Polygon(
              points={{0,52},{0,-48},{-54,2},{0,52}},
              lineColor={0,0,0},
              pattern=LinePattern.None,
              fillPattern=FillPattern.HorizontalCylinder,
              fillColor={255,255,255})}));
    end pem_gf_aa;
  end PEM;

  package Controls_a
    extends Modelica.Icons.VariantsPackage;
    model Control_0
      Modelica.StateGraph.InitialStep initialStep
        annotation (Placement(transformation(extent={{-80,0},{-60,20}})));
      Modelica.Blocks.Interfaces.RealInput u
        annotation (Placement(transformation(extent={{-120,-70},{-80,-30}})));
      inner Modelica.StateGraph.StateGraphRoot stateGraphRoot
        annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
      Modelica.StateGraph.StepWithSignal GF_running
        annotation (Placement(transformation(extent={{0,0},{20,20}})));
      Modelica.Blocks.Interfaces.BooleanOutput GF1 annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=-90,
            origin={10,-110})));
      Modelica.StateGraph.Transition transition(condition=u > 300)
        annotation (Placement(transformation(extent={{-40,0},{-20,20}})));
      Modelica.StateGraph.Transition transition1(condition=u < 200)
        annotation (Placement(transformation(extent={{40,0},{60,20}})));
    equation

      connect(GF_running.active, GF1)
        annotation (Line(points={{10,-1},{10,-110}}, color={255,0,255}));
      connect(initialStep.outPort[1], transition.inPort) annotation (Line(
            points={{-59.5,10},{-46,10},{-46,10},{-34,10}}, color={0,0,0}));
      connect(transition.outPort, GF_running.inPort[1])
        annotation (Line(points={{-28.5,10},{-1,10}}, color={0,0,0}));
      connect(GF_running.outPort[1], transition1.inPort)
        annotation (Line(points={{20.5,10},{46,10}}, color={0,0,0}));
      connect(transition1.outPort, initialStep.inPort[1]) annotation (Line(
            points={{51.5,10},{70,10},{70,40},{-90,40},{-90,10},{-81,10}},
            color={0,0,0}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
              Rectangle(
              extent={{-100,100},{100,-100}},
              lineColor={28,108,200},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid)}), Diagram(coordinateSystem(
              preserveAspectRatio=false)));
    end Control_0;
  end Controls_a;

  model Plant
    PEM.pem_gf pem_gf(redeclare package Medium = Media.Water)
      annotation (Placement(transformation(extent={{0,-60},{20,-40}})));
    GF.Chiller_carnot chiller_carnot(redeclare package Medium1 = Media.Water,
        redeclare package Medium2 = Media.Water)
      annotation (Placement(transformation(extent={{-4,24},{24,-4}})));
    Modelica.Fluid.Sources.MassFlowSource_T entree_f(
      redeclare package Medium =
          Modelica.Media.Water.ConstantPropertyLiquidWater,
      use_m_flow_in=true,
      m_flow=800,
      T=282.15,
      nPorts=1) annotation (Placement(transformation(extent={{-100,20},{-80,40}})));
    Modelica.Fluid.Sources.FixedBoundary sortie_f(redeclare package Medium =
          Modelica.Media.Water.ConstantPropertyLiquidWater, nPorts=1) annotation (
       Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=180,
          origin={90,30})));
    inner Modelica.Fluid.System system
      annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
    Modelica.Fluid.Sensors.MassFlowRate massFlowRate
      annotation (Placement(transformation(extent={{-60,20},{-40,40}})));
    Modelica.Blocks.Sources.Ramp ramp(
      height=800,
      duration=10000,
      offset=10,
      startTime=10000)
      annotation (Placement(transformation(extent={{-180,18},{-160,40}})));
    Controls_a.Control_0 control_0_1
      annotation (Placement(transformation(extent={{-20,60},{0,80}})));
  equation
    connect(pem_gf.y, chiller_carnot.TT200_in) annotation (Line(points={{21,-49},
            {32,-49},{32,-14},{11,-14},{11,-4}}, color={0,0,127}));
    connect(pem_gf.port_a, chiller_carnot.port_b1) annotation (Line(points={{15,
            -41},{15,-28},{28,-28},{28,4},{20,4}}, color={0,127,255}));
    connect(chiller_carnot.port_a1, pem_gf.port_b) annotation (Line(points={{0,
            4},{-8,4},{-8,-41},{5,-41}}, color={0,127,255}));
    connect(chiller_carnot.port_a2, sortie_f.ports[1]) annotation (Line(points=
            {{20,16},{40,16},{40,30},{80,30}}, color={0,127,255}));
    connect(entree_f.ports[1], massFlowRate.port_a) annotation (Line(points={{
            -80,30},{-70,30},{-70,30},{-60,30}}, color={0,127,255}));
    connect(massFlowRate.port_b, chiller_carnot.port_b2) annotation (Line(
          points={{-40,30},{-20,30},{-20,16},{0,16}}, color={0,127,255}));
    connect(ramp.y, entree_f.m_flow_in) annotation (Line(points={{-159,29},{
            -131.5,29},{-131.5,38},{-100,38}}, color={0,0,127}));
    connect(massFlowRate.m_flow, control_0_1.u)
      annotation (Line(points={{-50,41},{-50,65},{-20,65}}, color={0,0,127}));
    connect(control_0_1.GF1, chiller_carnot.on)
      annotation (Line(points={{-9,59},{-9,23},{-4,23}}, color={255,0,255}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end Plant;
end DHC_Marseille;
