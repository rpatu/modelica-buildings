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
      Modelica.Fluid.Sensors.TemperatureTwoPort THIn(redeclare package Medium =
            Modelica.Media.Water.ConstantPropertyLiquidWater)
        annotation (Placement(transformation(extent={{-80,50},{-60,70}})));
      Modelica.Fluid.Sensors.TemperatureTwoPort TT211(redeclare package Medium =
            Modelica.Media.Water.ConstantPropertyLiquidWater)
        annotation (Placement(transformation(extent={{60,-4},{80,16}})));
      Modelica.Fluid.Sensors.TemperatureTwoPort TCout(redeclare package Medium =
            Modelica.Media.Water.ConstantPropertyLiquidWater)
        annotation (Placement(transformation(extent={{-60,-70},{-80,-50}})));
      Modelica.Fluid.Sensors.TemperatureTwoPort TCIn(redeclare package Medium =
            Modelica.Media.Water.ConstantPropertyLiquidWater)
        annotation (Placement(transformation(extent={{140,-30},{120,-10}})));
      Modelica.Fluid.Valves.ValveLinear CV121(
        redeclare package Medium =
            Modelica.Media.Water.ConstantPropertyLiquidWater,
        dp_nominal=10000,
        m_flow_nominal=500) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={40,-20})));

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
      Modelica.Fluid.Valves.ValveDiscrete valveDiscrete(
        redeclare package Medium =
            Modelica.Media.Water.ConstantPropertyLiquidWater,
        dp_nominal=10000,
        m_flow_nominal=500,
        opening_min=0.000000000001)
        annotation (Placement(transformation(extent={{-20,-50},{-40,-70}})));
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
      connect(TCout.port_a, valveDiscrete.port_b)
        annotation (Line(points={{-60,-60},{-40,-60}}, color={0,127,255}));
      connect(valveDiscrete.port_a, chi.port_b2) annotation (Line(points={{-20,
              -60},{-14,-60},{-14,-6},{-10,-6}}, color={0,127,255}));
      connect(GF_starting.active, valveDiscrete.open) annotation (Line(points={
              {-230,-41},{-230,-80},{-30,-80},{-30,-68}}, color={255,0,255}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-360,
                -160},{240,340}}),
                             graphics={
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
            coordinateSystem(preserveAspectRatio=false, extent={{-360,-160},{
                240,340}})));
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
              points={{-60,40},{-36,40},{-36,-1.2},{-1.33333,-1.2}},
                                                          color={0,127,255}));
        connect(chiller_carnot.port_b1, sortie_c.ports[1]) annotation (Line(
              points={{5.33333,-1.2},{36,-1.2},{36,40},{60,40}},
                                                      color={0,127,255}));
        connect(entree_f.ports[1], chiller_carnot.port_a2) annotation (Line(
              points={{60,-40},{36,-40},{36,-6},{5.33333,-6}},
                                                          color={0,127,255}));
        connect(chiller_carnot.port_b2, sortie_f.ports[1]) annotation (Line(
              points={{-1.33333,-6},{-36,-6},{-36,-40},{-60,-40}},
                                                              color={0,127,255}));
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
              points={{5.33333,-1.2},{36,-1.2},{36,40},{60,40}},       color={0,
                127,255}));
        connect(chiller_carnot.port_b2, sortie_f.ports[1]) annotation (Line(
              points={{-1.33333,-6},{-36,-6},{-36,-40},{-60,-40}},
              color={0,127,255}));
        connect(fan.port_a, boundary.ports[1]) annotation (Line(points={{60,-30},
                {90,-30},{90,-60}}, color={0,127,255}));
        connect(fan.port_b, chiller_carnot.port_a2) annotation (Line(points={{40,-30},
                {36,-30},{36,-6},{5.33333,-6}},                     color={0,
                127,255}));
        connect(entree_c.ports[1], temperature.port_a)
          annotation (Line(points={{-80,40},{-70,40}}, color={0,127,255}));
        connect(temperature.port_b, chiller_carnot.port_a1) annotation (Line(
              points={{-50,40},{-36,40},{-36,-1.2},{-1.33333,-1.2}},
              color={0,127,255}));
        connect(temperature.T, chiller_carnot.TT200_in) annotation (Line(points={{-60,51},
                {-60,68},{2.33333,68},{2.33333,2}},             color={0,0,127}));
        connect(booleanExpression.y, chiller_carnot.on) annotation (Line(points={{-39,-70},
                {-26,-70},{-26,-8.8},{-2.66667,-8.8}},              color={255,
                0,255}));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
              coordinateSystem(preserveAspectRatio=false)));
      end test_carnot_1;

      model test_gf_simple
        annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
              coordinateSystem(preserveAspectRatio=false)));
      end test_gf_simple;

      model Carnot_TEva
        "Test model for chiller based on Carnot efficiency and evaporator outlet temperature control signal"
        extends Modelica.Icons.Example;
       package Medium1 = Buildings.Media.Water "Medium model";
       package Medium2 = Buildings.Media.Water "Medium model";

        parameter Modelica.SIunits.TemperatureDifference dTEva_nominal=-10
          "Temperature difference evaporator outlet-inlet";
        parameter Modelica.SIunits.TemperatureDifference dTCon_nominal=10
          "Temperature difference condenser outlet-inlet";
        parameter Real COPc_nominal = 3 "Chiller COP";
        parameter Modelica.SIunits.HeatFlowRate QEva_flow_nominal = -100E3
          "Evaporator heat flow rate";
        parameter Modelica.SIunits.MassFlowRate m2_flow_nominal=
          QEva_flow_nominal/dTEva_nominal/4200
          "Nominal mass flow rate at chilled water side";

        Buildings.Fluid.Chillers.Carnot_TEva chi(
          redeclare package Medium1 = Medium1,
          redeclare package Medium2 = Medium2,
          dTEva_nominal=dTEva_nominal,
          dTCon_nominal=dTCon_nominal,
          m2_flow_nominal=m2_flow_nominal,
          show_T=true,
          QEva_flow_nominal=QEva_flow_nominal,
          allowFlowReversal1=false,
          allowFlowReversal2=false,
          use_eta_Carnot_nominal=true,
          etaCarnot_nominal=0.3,
          dp1_nominal=6000,
          dp2_nominal=6000) "Chiller model"
          annotation (Placement(transformation(extent={{10,-10},{30,10}})));
        Buildings.Fluid.Sources.MassFlowSource_T sou1(nPorts=1,
          redeclare package Medium = Medium1,
          use_T_in=false,
          use_m_flow_in=true,
          T=298.15)
          annotation (Placement(transformation(extent={{-50,-4},{-30,16}})));
        Buildings.Fluid.Sources.MassFlowSource_T sou2(nPorts=1,
          redeclare package Medium = Medium2,
          m_flow=m2_flow_nominal,
          use_T_in=false,
          T=295.15)
          annotation (Placement(transformation(extent={{80,-16},{60,4}})));
        Buildings.Fluid.Sources.Boundary_pT sin1(
          redeclare package Medium = Medium1,
          nPorts=1)
          annotation (Placement(
              transformation(
              extent={{10,-10},{-10,10}},
              origin={70,30})));
        Buildings.Fluid.Sources.Boundary_pT sin2(nPorts=1,
          redeclare package Medium = Medium2)
          annotation (Placement(
              transformation(
              extent={{-10,-10},{10,10}},
              origin={-40,-30})));
        Modelica.Blocks.Sources.Ramp TEvaLvg(
          duration=60,
          startTime=1800,
          offset=273.15 + 6,
          height=10) "Control signal for evaporator leaving temperature"
          annotation (Placement(transformation(extent={{-60,40},{-40,60}})));
        Modelica.Blocks.Math.Gain mCon_flow(k=-1/cp1_default/dTEva_nominal)
          "Condenser mass flow rate"
          annotation (Placement(transformation(extent={{-80,4},{-60,24}})));
        Modelica.Blocks.Math.Add QCon_flow(k2=-1) "Condenser heat flow rate"
          annotation (Placement(transformation(extent={{48,-50},{68,-30}})));

        final parameter Modelica.SIunits.SpecificHeatCapacity cp1_default=
          Medium1.specificHeatCapacityCp(Medium1.setState_pTX(
            Medium1.p_default,
            Medium1.T_default,
            Medium1.X_default))
          "Specific heat capacity of medium 1 at default medium state";
      equation
        connect(sou1.ports[1], chi.port_a1)    annotation (Line(
            points={{-30,6},{10,6}},
            color={0,127,255},
            smooth=Smooth.None));
        connect(sou2.ports[1], chi.port_a2)    annotation (Line(
            points={{60,-6},{30,-6}},
            color={0,127,255},
            smooth=Smooth.None));
        connect(sin2.ports[1], chi.port_b2)    annotation (Line(
            points={{-30,-30},{0,-30},{0,-6},{10,-6}},
            color={0,127,255},
            smooth=Smooth.None));
        connect(TEvaLvg.y, chi.TSet) annotation (Line(points={{-39,50},{-10,50},{-10,
                9},{8,9}},
                        color={0,0,127}));
        connect(chi.P, QCon_flow.u1) annotation (Line(points={{31,0},{40,0},{40,-34},{
                46,-34}}, color={0,0,127}));
        connect(chi.QEva_flow, QCon_flow.u2) annotation (Line(points={{31,-9},{36,-9},
                {36,-46},{46,-46}}, color={0,0,127}));
        connect(QCon_flow.y, mCon_flow.u) annotation (Line(points={{69,-40},{80,-40},
                {80,-60},{-92,-60},{-92,14},{-82,14}},color={0,0,127}));
        connect(mCon_flow.y, sou1.m_flow_in)
          annotation (Line(points={{-59,14},{-52,14}},          color={0,0,127}));
        connect(chi.port_b1, sin1.ports[1]) annotation (Line(points={{30,6},{50,6},{
                50,30},{60,30}}, color={0,127,255}));
        annotation (experiment(Tolerance=1e-6, StopTime=3600),
      __Dymola_Commands(file="modelica://Buildings/Resources/Scripts/Dymola/Fluid/Chillers/Examples/Carnot_TEva.mos"
              "Simulate and plot"),
          Documentation(
      info="<html>
<p>
Example that simulates a chiller whose efficiency is scaled based on the
Carnot cycle.
The chiller takes as an input the evaporator leaving water temperature.
The condenser mass flow rate is computed in such a way that it has
a temperature difference equal to <code>dTEva_nominal</code>.
</p>
</html>",
      revisions="<html>
<ul>
<li>
May 15, 2019, by Jianjun Hu:<br/>
Replaced fluid source. This is for 
<a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/1072\"> #1072</a>.
</li>
<li>
November 25, 2015, by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"));
      end Carnot_TEva;

      model Carnot_TEva_modif
        "Test model for chiller based on Carnot efficiency and evaporator outlet temperature control signal"
        extends Modelica.Icons.Example;
       package Medium1 = Buildings.Media.Water "Medium model";
       package Medium2 = Buildings.Media.Water "Medium model";

        parameter Modelica.SIunits.TemperatureDifference dTEva_nominal=-10
          "Temperature difference evaporator outlet-inlet";
        parameter Modelica.SIunits.TemperatureDifference dTCon_nominal=10
          "Temperature difference condenser outlet-inlet";
        parameter Real COPc_nominal = 3 "Chiller COP";
        parameter Modelica.SIunits.HeatFlowRate QEva_flow_nominal = -100E3
          "Evaporator heat flow rate";
        parameter Modelica.SIunits.MassFlowRate m2_flow_nominal=
          QEva_flow_nominal/dTEva_nominal/4200
          "Nominal mass flow rate at chilled water side";

        Buildings.Fluid.Chillers.Carnot_TEva chi(
          redeclare package Medium1 = Medium1,
          redeclare package Medium2 = Medium2,
          dTEva_nominal=dTEva_nominal,
          dTCon_nominal=dTCon_nominal,
          m2_flow_nominal=m2_flow_nominal,
          show_T=true,
          QEva_flow_nominal=QEva_flow_nominal,
          allowFlowReversal1=false,
          allowFlowReversal2=false,
          use_eta_Carnot_nominal=true,
          etaCarnot_nominal=0.3,
          dp1_nominal=6000,
          dp2_nominal=6000) "Chiller model"
          annotation (Placement(transformation(extent={{10,-10},{30,10}})));
        Buildings.Fluid.Sources.MassFlowSource_T sou1(nPorts=1,
          redeclare package Medium = Medium1,
          use_T_in=false,
          use_m_flow_in=true,
          T=298.15)
          annotation (Placement(transformation(extent={{-50,-4},{-30,16}})));
        Buildings.Fluid.Sources.MassFlowSource_T sou2(nPorts=1,
          redeclare package Medium = Medium2,
          m_flow=m2_flow_nominal,
          use_T_in=false,
          T=295.15)
          annotation (Placement(transformation(extent={{80,-16},{60,4}})));
        Buildings.Fluid.Sources.Boundary_pT sin1(
          redeclare package Medium = Medium1,
          nPorts=1)
          annotation (Placement(
              transformation(
              extent={{10,-10},{-10,10}},
              origin={70,30})));
        Buildings.Fluid.Sources.Boundary_pT sin2(
          redeclare package Medium = Medium2, nPorts=1)
          annotation (Placement(
              transformation(
              extent={{-10,-10},{10,10}},
              origin={-130,-30})));
        Modelica.Blocks.Sources.Ramp TEvaLvg(
          duration=60,
          startTime=1800,
          offset=273.15 + 6,
          height=10) "Control signal for evaporator leaving temperature"
          annotation (Placement(transformation(extent={{-60,40},{-40,60}})));
        Modelica.Blocks.Math.Gain mCon_flow(k=-1/cp1_default/dTEva_nominal)
          "Condenser mass flow rate"
          annotation (Placement(transformation(extent={{-80,4},{-60,24}})));
        Modelica.Blocks.Math.Add QCon_flow(k2=-1) "Condenser heat flow rate"
          annotation (Placement(transformation(extent={{48,-50},{68,-30}})));

        final parameter Modelica.SIunits.SpecificHeatCapacity cp1_default=
          Medium1.specificHeatCapacityCp(Medium1.setState_pTX(
            Medium1.p_default,
            Medium1.T_default,
            Medium1.X_default))
          "Specific heat capacity of medium 1 at default medium state";
        Modelica.Fluid.Valves.ValveDiscrete valveDiscrete(
          redeclare package Medium =
              Modelica.Media.Water.ConstantPropertyLiquidWater,
          dp_nominal=10000,
          m_flow_nominal=m2_flow_nominal,
          opening_min=0.000000000000001)
          annotation (Placement(transformation(extent={{-60,-18},{-80,-38}})));
        Modelica.Blocks.Sources.BooleanPulse booleanPulse(width=50, period=1000)
          annotation (Placement(transformation(extent={{-120,-90},{-100,-70}})));
        Modelica.Fluid.Sensors.MassFlowRate FT121(redeclare package Medium =
              Modelica.Media.Water.ConstantPropertyLiquidWater) annotation (Placement(
              transformation(
              extent={{-10,-10},{10,10}},
              rotation=180,
              origin={-30,-28})));
      equation
        connect(sou1.ports[1], chi.port_a1)    annotation (Line(
            points={{-30,6},{10,6}},
            color={0,127,255},
            smooth=Smooth.None));
        connect(sou2.ports[1], chi.port_a2)    annotation (Line(
            points={{60,-6},{30,-6}},
            color={0,127,255},
            smooth=Smooth.None));
        connect(TEvaLvg.y, chi.TSet) annotation (Line(points={{-39,50},{-10,50},{-10,
                9},{8,9}},
                        color={0,0,127}));
        connect(chi.P, QCon_flow.u1) annotation (Line(points={{31,0},{40,0},{40,-34},{
                46,-34}}, color={0,0,127}));
        connect(chi.QEva_flow, QCon_flow.u2) annotation (Line(points={{31,-9},{36,-9},
                {36,-46},{46,-46}}, color={0,0,127}));
        connect(QCon_flow.y, mCon_flow.u) annotation (Line(points={{69,-40},{80,-40},
                {80,-60},{-92,-60},{-92,14},{-82,14}},color={0,0,127}));
        connect(mCon_flow.y, sou1.m_flow_in)
          annotation (Line(points={{-59,14},{-52,14}},          color={0,0,127}));
        connect(chi.port_b1, sin1.ports[1]) annotation (Line(points={{30,6},{50,6},{
                50,30},{60,30}}, color={0,127,255}));
        connect(sin2.ports[1], valveDiscrete.port_b) annotation (Line(points={{
                -120,-30},{-82,-30},{-82,-28},{-80,-28}}, color={0,127,255}));
        connect(booleanPulse.y, valveDiscrete.open) annotation (Line(points={{
                -99,-80},{-70,-80},{-70,-36}}, color={255,0,255}));
        connect(valveDiscrete.port_a, FT121.port_b)
          annotation (Line(points={{-60,-28},{-40,-28}}, color={0,127,255}));
        connect(FT121.port_a, chi.port_b2) annotation (Line(points={{-20,-28},{
                -6,-28},{-6,-6},{10,-6}}, color={0,127,255}));
        annotation (experiment(Tolerance=1e-6, StopTime=3600),
      __Dymola_Commands(file="modelica://Buildings/Resources/Scripts/Dymola/Fluid/Chillers/Examples/Carnot_TEva.mos"
              "Simulate and plot"),
          Documentation(
      info="<html>
<p>
Example that simulates a chiller whose efficiency is scaled based on the
Carnot cycle.
The chiller takes as an input the evaporator leaving water temperature.
The condenser mass flow rate is computed in such a way that it has
a temperature difference equal to <code>dTEva_nominal</code>.
</p>
</html>",
      revisions="<html>
<ul>
<li>
May 15, 2019, by Jianjun Hu:<br/>
Replaced fluid source. This is for 
<a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/1072\"> #1072</a>.
</li>
<li>
November 25, 2015, by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"));
      end Carnot_TEva_modif;
    end Tests;

    model basic_0
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
        annotation (Placement(transformation(extent={{-160,-40},{-140,-20}})));
      Modelica.Blocks.Sources.RealExpression realExpression(y=4 + 273.15)
        annotation (Placement(transformation(extent={{-250,-4},{-230,16}})));
      Modelica.Fluid.Sensors.TemperatureTwoPort THIn(redeclare package Medium =
            Modelica.Media.Water.ConstantPropertyLiquidWater)
        annotation (Placement(transformation(extent={{-230,30},{-210,50}})));
      Modelica.Fluid.Sensors.TemperatureTwoPort TT211(redeclare package Medium =
            Modelica.Media.Water.ConstantPropertyLiquidWater)
        annotation (Placement(transformation(extent={{-90,-20},{-70,0}})));
      Modelica.Fluid.Sensors.TemperatureTwoPort TCout(redeclare package Medium =
            Modelica.Media.Water.ConstantPropertyLiquidWater)
        annotation (Placement(transformation(extent={{-220,-100},{-240,-80}})));
      Modelica.Fluid.Sensors.TemperatureTwoPort TCIn(redeclare package Medium =
            Modelica.Media.Water.ConstantPropertyLiquidWater)
        annotation (Placement(transformation(extent={{-10,-60},{-30,-40}})));
      Modelica.Fluid.Valves.ValveLinear CV121(
        redeclare package Medium =
            Modelica.Media.Water.ConstantPropertyLiquidWater,
        dp_nominal=10000,
        m_flow_nominal=500) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={-110,-50})));
      Modelica.Fluid.Sensors.Pressure PT221(redeclare package Medium =
            Modelica.Media.Water.ConstantPropertyLiquidWater)
        annotation (Placement(transformation(extent={{-192,-18},{-172,2}})));
      Modelica.Fluid.Sensors.Pressure PT211(redeclare package Medium =
            Modelica.Media.Water.ConstantPropertyLiquidWater)
        annotation (Placement(transformation(extent={{-132,-18},{-112,2}})));
      Modelica.Fluid.Sensors.MassFlowRate FT121(redeclare package Medium =
            Modelica.Media.Water.ConstantPropertyLiquidWater) annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={-70,-50})));
      Controls.Continuous.LimPID conPID(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=5,
        Ti=10,
        initType=Modelica.Blocks.Types.InitPID.NoInit) annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-110,-100})));
      Modelica.Blocks.Sources.RealExpression Q_set(y=350/3.6)
        annotation (Placement(transformation(extent={{-150,-150},{-130,-130}})));
      Modelica.Blocks.Math.Add PDT(k2=-1)
        annotation (Placement(transformation(extent={{-60,160},{-40,180}})));
      Controls.Continuous.LimPID conPID1(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=3,
        Ti=15,
        initType=Modelica.Blocks.Types.InitPID.NoInit) annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={-10,210})));
      Modelica.Blocks.Sources.RealExpression PDT_set(y=0.7)
        annotation (Placement(transformation(extent={{-60,200},{-40,220}})));
      Controls.Continuous.LimPID conPID2(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=2.5,
        Ti=1.7,
        initType=Modelica.Blocks.Types.InitPID.NoInit) annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={-10,130})));
      Modelica.Blocks.Math.Add TDT(k2=-1)
        annotation (Placement(transformation(extent={{-60,80},{-40,100}})));
      Modelica.Blocks.Sources.RealExpression TDT_set(y=5 + 273.15)
        annotation (Placement(transformation(extent={{-60,120},{-40,140}})));
      Controls.Continuous.LimPID conPID3(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=3,
        Ti=1,
        initType=Modelica.Blocks.Types.InitPID.NoInit) annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={-12,52})));
      Modelica.Blocks.Sources.RealExpression TT_set(y=30 + 273.15)
        annotation (Placement(transformation(extent={{-62,42},{-42,62}})));
      Modelica.Blocks.Math.MinMax minMax(nu=3)
        annotation (Placement(transformation(extent={{40,120},{60,140}})));
      Modelica.Fluid.Valves.ValveLinear CV211(
        redeclare package Medium =
            Modelica.Media.Water.ConstantPropertyLiquidWater,
        dp_nominal=10000,
        m_flow_nominal=800) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={-40,-10})));
      Modelica.Fluid.Valves.ValveDiscrete valveDiscrete(
        redeclare package Medium =
            Modelica.Media.Water.ConstantPropertyLiquidWater,
        dp_nominal=10000,
        m_flow_nominal=500,
        opening_min=0.000000000001)
        annotation (Placement(transformation(extent={{-180,-80},{-200,-100}})));
      Fluid.Movers.FlowControlled_dp fan(
        redeclare package Medium = Media.Water,
        m_flow_nominal=1000,
        redeclare Fluid.Movers.Data.Generic per,
        inputType=Buildings.Fluid.Types.InputType.Constant,
        constantHead=87000)
        annotation (Placement(transformation(extent={{-300,40},{-280,60}})));
      Modelica.Fluid.Sources.Boundary_pT pem_in(
        redeclare package Medium =
            Modelica.Media.Water.ConstantPropertyLiquidWater,
        use_T_in=true,
        nPorts=1)
        annotation (Placement(transformation(extent={{-340,40},{-320,60}})));
      Modelica.Fluid.Sources.FixedBoundary pem_out(redeclare package Medium =
            Modelica.Media.Water.ConstantPropertyLiquidWater, nPorts=1)
        annotation (Placement(transformation(extent={{140,-20},{120,0}})));
      Modelica.Blocks.Sources.CombiTimeTable pem_data(
        tableOnFile=true,
        tableName="tab1",
        fileName=ModelicaServices.ExternalReferences.loadResource(
            "modelica://Buildings/Data/froid/pem_froid.txt"),
        columns={2,3,4},
        extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic)
        annotation (Placement(transformation(extent={{-420,40},{-400,60}})));
      Modelica.Thermal.HeatTransfer.Celsius.ToKelvin toKelvin
        annotation (Placement(transformation(extent={{-380,40},{-360,60}})));
      Modelica.Fluid.Sources.FixedBoundary GF_out(redeclare package Medium =
            Modelica.Media.Water.ConstantPropertyLiquidWater, nPorts=2)
        annotation (Placement(transformation(extent={{-360,-100},{-340,-80}})));
      Modelica.Blocks.Sources.CombiTimeTable deg_data(
        tableOnFile=true,
        tableName="tab1",
        fileName=ModelicaServices.ExternalReferences.loadResource(
            "modelica://Buildings/Data/froid/deg_froid.txt"),
        columns={2,3,4,5,6,7,8,9},
        extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic)
        annotation (Placement(transformation(extent={{380,-40},{360,-20}})));
      Modelica.Blocks.Math.Gain gain(k=1/3.6)
        annotation (Placement(transformation(extent={{220,-40},{200,-20}})));
      Modelica.Thermal.HeatTransfer.Celsius.ToKelvin T_out
        annotation (Placement(transformation(extent={{220,-100},{200,-80}})));
      Modelica.Blocks.Math.Add add
        annotation (Placement(transformation(extent={{320,-180},{300,-160}})));
      Modelica.Blocks.Sources.CombiTimeTable tfp_data(
        tableOnFile=true,
        tableName="tab1",
        fileName=ModelicaServices.ExternalReferences.loadResource(
            "modelica://Buildings/Data/froid/tfp_froid.txt"),
        columns={7},
        extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic)
        annotation (Placement(transformation(extent={{380,-160},{360,-140}})));
      Modelica.Blocks.Sources.CombiTimeTable gf_data(
        tableOnFile=true,
        tableName="tab1",
        fileName=ModelicaServices.ExternalReferences.loadResource(
            "modelica://Buildings/Data/froid/gf1_froid.txt"),
        columns={2},
        extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic)
        annotation (Placement(transformation(extent={{380,-200},{360,-180}})));
      Modelica.Thermal.HeatTransfer.Celsius.ToKelvin T_in
        annotation (Placement(transformation(extent={{220,-70},{200,-50}})));
      Modelica.Blocks.Math.Add add1(k1=-1)
        annotation (Placement(transformation(extent={{280,-140},{260,-120}})));
      Modelica.Blocks.Sources.BooleanExpression booleanExpression(y=true)
        annotation (Placement(transformation(extent={{-220,-140},{-200,-120}})));
      Modelica.Fluid.Sources.Boundary_pT boundary(
        redeclare package Medium =
            Modelica.Media.Water.ConstantPropertyLiquidWater,
        use_p_in=false,
        use_T_in=true,
        p=400000,
        nPorts=1)
        annotation (Placement(transformation(extent={{140,-80},{120,-60}})));
      Modelica.Fluid.Sources.Boundary_pT boundary1(
        redeclare package Medium =
            Modelica.Media.Water.ConstantPropertyLiquidWater,
        use_p_in=false,
        use_T_in=true,
        p=400000,
        nPorts=1)
        annotation (Placement(transformation(extent={{140,-140},{120,-120}})));
      Fluid.Movers.FlowControlled_m_flow fan1(
        redeclare package Medium = Media.Water,
        m_flow_nominal=2280,
        redeclare Fluid.Movers.Data.Generic per)
        annotation (Placement(transformation(extent={{82,-80},{62,-60}})));
      Fluid.Movers.FlowControlled_m_flow fan2(
        redeclare package Medium = Media.Water,
        m_flow_nominal=2280,
        redeclare Fluid.Movers.Data.Generic per)
        annotation (Placement(transformation(extent={{80,-140},{60,-120}})));
      Modelica.Blocks.Math.Gain gain1(k=1/3.6)
        annotation (Placement(transformation(extent={{220,-140},{200,-120}})));
      Modelica.Fluid.Valves.ValveLinear CV1(
        redeclare package Medium =
            Modelica.Media.Water.ConstantPropertyLiquidWater,
        dp_nominal=10000,
        m_flow_nominal=500) annotation (Placement(transformation(
            extent={{-10,10},{10,-10}},
            rotation=180,
            origin={-90,-170})));
      Modelica.Blocks.Math.Add add2(k2=-1) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=-90,
            origin={-72,-130})));
      Modelica.Blocks.Sources.RealExpression realExpression1(y=1) annotation (
          Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=-90,
            origin={-50,-90})));
    equation
      connect(realExpression.y,chi. TSet) annotation (Line(points={{-229,6},{
              -166,6},{-166,-21},{-162,-21}},
                                color={0,0,127}));
      connect(THIn.port_b,chi. port_a1) annotation (Line(points={{-210,40},{
              -206,40},{-206,-24},{-160,-24}},
                               color={0,127,255}));
      connect(chi.port_b1,TT211. port_a)
        annotation (Line(points={{-140,-24},{-90,-24},{-90,-10}},
                                                 color={0,127,255}));
      connect(chi.port_a2,CV121. port_b) annotation (Line(points={{-140,-36},{
              -130,-36},{-130,-50},{-120,-50}},
                              color={0,127,255}));
      connect(THIn.port_b,PT221. port) annotation (Line(points={{-210,40},{-206,
              40},{-206,-18},{-182,-18}},
                           color={0,127,255}));
      connect(chi.port_b1,PT211. port)
        annotation (Line(points={{-140,-24},{-132,-24},{-132,-18},{-122,-18}},
                                                 color={0,127,255}));
      connect(CV121.port_a,FT121. port_b)
        annotation (Line(points={{-100,-50},{-80,-50}},
                                                     color={0,127,255}));
      connect(FT121.port_a,TCIn. port_b)
        annotation (Line(points={{-60,-50},{-30,-50}},color={0,127,255}));
      connect(FT121.m_flow,conPID. u_m)
        annotation (Line(points={{-70,-61},{-70,-100},{-98,-100}},
                                                              color={0,0,127}));
      connect(Q_set.y,conPID. u_s)
        annotation (Line(points={{-129,-140},{-110,-140},{-110,-112}},
                                                                color={0,0,127}));
      connect(conPID.y,CV121. opening)
        annotation (Line(points={{-110,-89},{-110,-58}},
                                                     color={0,0,127}));
      connect(PT211.p,PDT. u2) annotation (Line(points={{-111,-8},{-100,-8},{
              -100,164},{-62,164}},
                     color={0,0,127}));
      connect(PT221.p,PDT. u1) annotation (Line(points={{-171,-8},{-152,-8},{
              -152,176},{-62,176}},
                         color={0,0,127}));
      connect(PDT.y,conPID1. u_m)
        annotation (Line(points={{-39,170},{-10,170},{-10,198}}, color={0,0,127}));
      connect(PDT_set.y,conPID1. u_s)
        annotation (Line(points={{-39,210},{-22,210}}, color={0,0,127}));
      connect(TDT_set.y,conPID2. u_s)
        annotation (Line(points={{-39,130},{-22,130}}, color={0,0,127}));
      connect(TT211.T,TDT. u2)
        annotation (Line(points={{-80,1},{-80,84},{-62,84}}, color={0,0,127}));
      connect(TDT.y,conPID2. u_m)
        annotation (Line(points={{-39,90},{-10,90},{-10,118}},   color={0,0,127}));
      connect(TT_set.y,conPID3. u_s)
        annotation (Line(points={{-41,52},{-24,52}},   color={0,0,127}));
      connect(TT211.T,conPID3. u_m) annotation (Line(points={{-80,1},{-80,20},{
              -12,20},{-12,40}},
                          color={0,0,127}));
      connect(conPID2.y,minMax. u[1]) annotation (Line(points={{1,130},{20,130},
              {20,134.667},{40,134.667}},  color={0,0,127}));
      connect(conPID3.y,minMax. u[2]) annotation (Line(points={{-1,52},{20,52},
              {20,130},{40,130}},  color={0,0,127}));
      connect(conPID1.y,minMax. u[3]) annotation (Line(points={{1,210},{20,210},
              {20,125.333},{40,125.333}},  color={0,0,127}));
      connect(TT211.port_b,CV211. port_a)
        annotation (Line(points={{-70,-10},{-50,-10}},
                                                  color={0,127,255}));
      connect(minMax.yMax,CV211. opening) annotation (Line(points={{61,136},{70,
              136},{70,14},{-40,14},{-40,-2}},
                                           color={0,0,127}));
      connect(TCout.port_a,valveDiscrete. port_b)
        annotation (Line(points={{-220,-90},{-200,-90}},
                                                       color={0,127,255}));
      connect(valveDiscrete.port_a,chi. port_b2) annotation (Line(points={{-180,
              -90},{-174,-90},{-174,-36},{-160,-36}},
                                                 color={0,127,255}));
      connect(pem_in.ports[1], fan.port_a)
        annotation (Line(points={{-320,50},{-300,50}},   color={0,127,255}));
      connect(fan.port_b, THIn.port_a) annotation (Line(points={{-280,50},{-264,
              50},{-264,40},{-230,40}},         color={0,127,255}));
      connect(CV211.port_b, pem_out.ports[1])
        annotation (Line(points={{-30,-10},{120,-10}},color={0,127,255}));
      connect(pem_data.y[1], toKelvin.Celsius)
        annotation (Line(points={{-399,50},{-382,50}},   color={0,0,127}));
      connect(toKelvin.Kelvin, pem_in.T_in) annotation (Line(points={{-359,50},
              {-351.5,50},{-351.5,54},{-342,54}},  color={0,0,127}));
      connect(TCout.port_b, GF_out.ports[1])
        annotation (Line(points={{-240,-90},{-290,-90},{-290,-88},{-340,-88}},
                                                           color={0,127,255}));
      connect(deg_data.y[6], gain.u) annotation (Line(points={{359,-30},{222,
              -30}},                     color={0,0,127}));
      connect(deg_data.y[5], T_in.Celsius) annotation (Line(points={{359,-30},{
              241.5,-30},{241.5,-60},{222,-60}}, color={0,0,127}));
      connect(tfp_data.y[1], add.u1) annotation (Line(points={{359,-150},{342,
              -150},{342,-164},{322,-164}}, color={0,0,127}));
      connect(gf_data.y[1], add.u2) annotation (Line(points={{359,-190},{340,
              -190},{340,-176},{322,-176}}, color={0,0,127}));
      connect(deg_data.y[4], T_out.Celsius) annotation (Line(points={{359,-30},
              {280,-30},{280,-90},{222,-90}}, color={0,0,127}));
      connect(deg_data.y[6], add1.u1) annotation (Line(points={{359,-30},{316,
              -30},{316,-124},{282,-124}}, color={0,0,127}));
      connect(add.y, add1.u2) annotation (Line(points={{299,-170},{292,-170},{
              292,-136},{282,-136}}, color={0,0,127}));
      connect(booleanExpression.y, valveDiscrete.open) annotation (Line(points={{-199,
              -130},{-190,-130},{-190,-98}},         color={255,0,255}));
      connect(THIn.T, TDT.u1) annotation (Line(points={{-220,51},{-220,96},{-62,
              96}}, color={0,0,127}));
      connect(boundary1.ports[1], fan2.port_a)
        annotation (Line(points={{120,-130},{80,-130}}, color={0,127,255}));
      connect(fan1.port_a, boundary.ports[1])
        annotation (Line(points={{82,-70},{120,-70}}, color={0,127,255}));
      connect(fan1.port_b, TCIn.port_a) annotation (Line(points={{62,-70},{26,
              -70},{26,-50},{-10,-50}}, color={0,127,255}));
      connect(fan2.port_b, TCIn.port_a) annotation (Line(points={{60,-130},{26,
              -130},{26,-50},{-10,-50}}, color={0,127,255}));
      connect(T_out.Kelvin, boundary1.T_in) annotation (Line(points={{199,-90},
              {174,-90},{174,-126},{142,-126}}, color={0,0,127}));
      connect(boundary.T_in, T_in.Kelvin) annotation (Line(points={{142,-66},{
              170,-66},{170,-60},{199,-60}}, color={0,0,127}));
      connect(gain.y, fan1.m_flow_in) annotation (Line(points={{199,-30},{72,
              -30},{72,-58}}, color={0,0,127}));
      connect(gain1.u, add1.y)
        annotation (Line(points={{222,-130},{259,-130}}, color={0,0,127}));
      connect(gain1.y, fan2.m_flow_in) annotation (Line(points={{199,-130},{188,
              -130},{188,-100},{70,-100},{70,-118}}, color={0,0,127}));
      connect(CV1.port_a, TCIn.port_a) annotation (Line(points={{-80,-170},{-26,
              -170},{-26,-130},{26,-130},{26,-50},{-10,-50}}, color={0,127,255}));
      connect(CV1.port_b, GF_out.ports[2]) annotation (Line(points={{-100,-170},
              {-320,-170},{-320,-92},{-340,-92}}, color={0,127,255}));
      connect(conPID.y, add2.u2) annotation (Line(points={{-110,-89},{-110,-80},
              {-78,-80},{-78,-118}}, color={0,0,127}));
      connect(add2.u1, realExpression1.y) annotation (Line(points={{-66,-118},{
              -66,-110},{-50,-110},{-50,-101}}, color={0,0,127}));
      connect(add2.y, CV1.opening) annotation (Line(points={{-72,-141},{-72,
              -148},{-90,-148},{-90,-162}}, color={0,0,127}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-440,
                -240},{440,240}})),                                  Diagram(
            coordinateSystem(preserveAspectRatio=false, extent={{-440,-240},{
                440,240}})));
    end basic_0;

    model basic_00
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
        annotation (Placement(transformation(extent={{-120,-100},{-100,-80}})));
      Modelica.Blocks.Sources.RealExpression realExpression(y=4 + 273.15)
        annotation (Placement(transformation(extent={{-210,-64},{-190,-44}})));
      Modelica.Fluid.Sensors.TemperatureTwoPort THIn(redeclare package Medium =
            Modelica.Media.Water.ConstantPropertyLiquidWater)
        annotation (Placement(transformation(extent={{-190,-30},{-170,-10}})));
      Modelica.Fluid.Sensors.TemperatureTwoPort TT211(redeclare package Medium =
            Modelica.Media.Water.ConstantPropertyLiquidWater)
        annotation (Placement(transformation(extent={{-50,-80},{-30,-60}})));
      Modelica.Fluid.Sensors.TemperatureTwoPort TCout(redeclare package Medium =
            Modelica.Media.Water.ConstantPropertyLiquidWater)
        annotation (Placement(transformation(extent={{-180,-160},{-200,-140}})));
      Modelica.Fluid.Sensors.TemperatureTwoPort TCIn(redeclare package Medium =
            Modelica.Media.Water.ConstantPropertyLiquidWater)
        annotation (Placement(transformation(extent={{30,-120},{10,-100}})));
      Modelica.Fluid.Valves.ValveLinear CV121(
        redeclare package Medium =
            Modelica.Media.Water.ConstantPropertyLiquidWater,
        dp_nominal=10000,
        m_flow_nominal=500) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={-70,-110})));
      Modelica.Fluid.Sensors.Pressure PT221(redeclare package Medium =
            Modelica.Media.Water.ConstantPropertyLiquidWater)
        annotation (Placement(transformation(extent={{-152,-78},{-132,-58}})));
      Modelica.Fluid.Sensors.Pressure PT211(redeclare package Medium =
            Modelica.Media.Water.ConstantPropertyLiquidWater)
        annotation (Placement(transformation(extent={{-92,-78},{-72,-58}})));
      Modelica.Fluid.Sensors.MassFlowRate FT121(redeclare package Medium =
            Modelica.Media.Water.ConstantPropertyLiquidWater) annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={-30,-110})));
      Modelica.Fluid.Valves.ValveLinear CV211(
        redeclare package Medium =
            Modelica.Media.Water.ConstantPropertyLiquidWater,
        dp_nominal=10000,
        m_flow_nominal=800) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={0,-70})));
      Modelica.Fluid.Valves.ValveDiscrete valveDiscrete(
        redeclare package Medium =
            Modelica.Media.Water.ConstantPropertyLiquidWater,
        dp_nominal=10000,
        m_flow_nominal=500,
        opening_min=0.000000000001)
        annotation (Placement(transformation(extent={{-140,-140},{-160,-160}})));
      Fluid.Movers.FlowControlled_dp fan(
        redeclare package Medium = Media.Water,
        m_flow_nominal=1000,
        redeclare Fluid.Movers.Data.Generic per,
        inputType=Buildings.Fluid.Types.InputType.Constant,
        constantHead=87000)
        annotation (Placement(transformation(extent={{-260,-20},{-240,0}})));
      Modelica.Fluid.Sources.Boundary_pT pem_in(
        redeclare package Medium =
            Modelica.Media.Water.ConstantPropertyLiquidWater,
        use_T_in=false,
        T=298.15,
        nPorts=1)
        annotation (Placement(transformation(extent={{-300,-20},{-280,0}})));
      Modelica.Fluid.Sources.FixedBoundary pem_out(redeclare package Medium =
            Modelica.Media.Water.ConstantPropertyLiquidWater, nPorts=1)
        annotation (Placement(transformation(extent={{200,-80},{180,-60}})));
      Modelica.Fluid.Sources.FixedBoundary GF_out(redeclare package Medium =
            Modelica.Media.Water.ConstantPropertyLiquidWater, nPorts=1)
        annotation (Placement(transformation(extent={{-320,-160},{-300,-140}})));
      Modelica.Blocks.Sources.BooleanExpression booleanExpression(y=true)
        annotation (Placement(transformation(extent={{-180,-200},{-160,-180}})));
      Modelica.Blocks.Sources.RealExpression realExpression1(y=1)
        annotation (Placement(transformation(extent={{-100,-160},{-80,-140}})));
      Modelica.Blocks.Sources.RealExpression realExpression2(y=1)
        annotation (Placement(transformation(extent={{-40,-20},{-20,0}})));
      Modelica.Fluid.Sources.Boundary_pT pem_in1(
        redeclare package Medium =
            Modelica.Media.Water.ConstantPropertyLiquidWater,
        use_T_in=false,
        T=283.15,
        nPorts=1)
        annotation (Placement(transformation(extent={{140,-122},{120,-102}})));
      Fluid.Movers.FlowControlled_dp fan1(
        redeclare package Medium = Media.Water,
        m_flow_nominal=1000,
        redeclare Fluid.Movers.Data.Generic per,
        inputType=Buildings.Fluid.Types.InputType.Constant,
        constantHead=87000)
        annotation (Placement(transformation(extent={{100,-120},{80,-100}})));
    equation
      connect(realExpression.y,chi. TSet) annotation (Line(points={{-189,-54},{
              -126,-54},{-126,-81},{-122,-81}},
                                color={0,0,127}));
      connect(THIn.port_b,chi. port_a1) annotation (Line(points={{-170,-20},{
              -166,-20},{-166,-84},{-120,-84}},
                               color={0,127,255}));
      connect(chi.port_b1,TT211. port_a)
        annotation (Line(points={{-100,-84},{-50,-84},{-50,-70}},
                                                 color={0,127,255}));
      connect(chi.port_a2,CV121. port_b) annotation (Line(points={{-100,-96},{
              -90,-96},{-90,-110},{-80,-110}},
                              color={0,127,255}));
      connect(THIn.port_b,PT221. port) annotation (Line(points={{-170,-20},{
              -166,-20},{-166,-78},{-142,-78}},
                           color={0,127,255}));
      connect(chi.port_b1,PT211. port)
        annotation (Line(points={{-100,-84},{-92,-84},{-92,-78},{-82,-78}},
                                                 color={0,127,255}));
      connect(CV121.port_a,FT121. port_b)
        annotation (Line(points={{-60,-110},{-40,-110}},
                                                     color={0,127,255}));
      connect(FT121.port_a,TCIn. port_b)
        annotation (Line(points={{-20,-110},{10,-110}},
                                                      color={0,127,255}));
      connect(TT211.port_b,CV211. port_a)
        annotation (Line(points={{-30,-70},{-10,-70}},
                                                  color={0,127,255}));
      connect(TCout.port_a,valveDiscrete. port_b)
        annotation (Line(points={{-180,-150},{-160,-150}},
                                                       color={0,127,255}));
      connect(valveDiscrete.port_a,chi. port_b2) annotation (Line(points={{-140,
              -150},{-134,-150},{-134,-96},{-120,-96}},
                                                 color={0,127,255}));
      connect(pem_in.ports[1], fan.port_a)
        annotation (Line(points={{-280,-10},{-260,-10}}, color={0,127,255}));
      connect(fan.port_b, THIn.port_a) annotation (Line(points={{-240,-10},{
              -224,-10},{-224,-20},{-190,-20}}, color={0,127,255}));
      connect(CV211.port_b, pem_out.ports[1])
        annotation (Line(points={{10,-70},{180,-70}}, color={0,127,255}));
      connect(TCout.port_b, GF_out.ports[1])
        annotation (Line(points={{-200,-150},{-300,-150}}, color={0,127,255}));
      connect(booleanExpression.y, valveDiscrete.open) annotation (Line(points=
              {{-159,-190},{-150,-190},{-150,-158}}, color={255,0,255}));
      connect(realExpression1.y, CV121.opening) annotation (Line(points={{-79,
              -150},{-70,-150},{-70,-118}}, color={0,0,127}));
      connect(realExpression2.y, CV211.opening)
        annotation (Line(points={{-19,-10},{0,-10},{0,-62}}, color={0,0,127}));
      connect(fan1.port_a, pem_in1.ports[1]) annotation (Line(points={{100,-110},
              {110,-110},{110,-112},{120,-112}}, color={0,127,255}));
      connect(fan1.port_b, TCIn.port_a) annotation (Line(points={{80,-110},{56,
              -110},{56,-110},{30,-110}}, color={0,127,255}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{
                -440,-280},{440,280}})),                             Diagram(
            coordinateSystem(preserveAspectRatio=false, extent={{-440,-280},{
                440,280}})));
    end basic_00;

    model basic_mdoe
      Fluid.Chillers.ElectricReformulatedEIR chi(
        redeclare package Medium1 = Media.Water,
        redeclare package Medium2 = Media.Water,
        m1_flow_nominal=490/3.6,
        m2_flow_nominal=810/3.6,
        per=Fluid.Chillers.Data.ElectricReformulatedEIR.Test_quantum(),
        dp1_nominal=410,
        dp2_nominal=310)
        annotation (Placement(transformation(extent={{-160,-40},{-140,-20}})));
      Modelica.Blocks.Sources.RealExpression realExpression(y=4 + 273.15)
        annotation (Placement(transformation(extent={{-250,-4},{-230,16}})));
      Modelica.Fluid.Sensors.TemperatureTwoPort THIn(redeclare package Medium =
            Modelica.Media.Water.ConstantPropertyLiquidWater)
        annotation (Placement(transformation(extent={{-230,30},{-210,50}})));
      Modelica.Fluid.Sensors.TemperatureTwoPort TT211(redeclare package Medium =
            Modelica.Media.Water.ConstantPropertyLiquidWater)
        annotation (Placement(transformation(extent={{-90,-20},{-70,0}})));
      Modelica.Fluid.Sensors.TemperatureTwoPort TCout(redeclare package Medium =
            Modelica.Media.Water.ConstantPropertyLiquidWater)
        annotation (Placement(transformation(extent={{-220,-100},{-240,-80}})));
      Modelica.Fluid.Sensors.TemperatureTwoPort TCIn(redeclare package Medium =
            Modelica.Media.Water.ConstantPropertyLiquidWater)
        annotation (Placement(transformation(extent={{-10,-60},{-30,-40}})));
      Modelica.Fluid.Valves.ValveLinear CV121(
        redeclare package Medium =
            Modelica.Media.Water.ConstantPropertyLiquidWater,
        dp_nominal=10000,
        m_flow_nominal=500) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={-110,-50})));
      Modelica.Fluid.Sensors.Pressure PT221(redeclare package Medium =
            Modelica.Media.Water.ConstantPropertyLiquidWater)
        annotation (Placement(transformation(extent={{-192,-18},{-172,2}})));
      Modelica.Fluid.Sensors.Pressure PT211(redeclare package Medium =
            Modelica.Media.Water.ConstantPropertyLiquidWater)
        annotation (Placement(transformation(extent={{-132,-18},{-112,2}})));
      Modelica.Fluid.Sensors.MassFlowRate FT121(redeclare package Medium =
            Modelica.Media.Water.ConstantPropertyLiquidWater) annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={-70,-50})));
      Controls.Continuous.LimPID conPID(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=5,
        Ti=10,
        initType=Modelica.Blocks.Types.InitPID.NoInit) annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-110,-100})));
      Modelica.Blocks.Sources.RealExpression Q_set(y=350/3.6)
        annotation (Placement(transformation(extent={{-150,-150},{-130,-130}})));
      Modelica.Blocks.Math.Add PDT(k2=-1)
        annotation (Placement(transformation(extent={{-60,160},{-40,180}})));
      Controls.Continuous.LimPID conPID1(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=3,
        Ti=15,
        initType=Modelica.Blocks.Types.InitPID.NoInit) annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={-10,210})));
      Modelica.Blocks.Sources.RealExpression PDT_set(y=0.7)
        annotation (Placement(transformation(extent={{-60,200},{-40,220}})));
      Controls.Continuous.LimPID conPID2(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=2.5,
        Ti=1.7,
        initType=Modelica.Blocks.Types.InitPID.NoInit) annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={-10,130})));
      Modelica.Blocks.Math.Add TDT(k2=-1)
        annotation (Placement(transformation(extent={{-60,80},{-40,100}})));
      Modelica.Blocks.Sources.RealExpression TDT_set(y=5 + 273.15)
        annotation (Placement(transformation(extent={{-60,120},{-40,140}})));
      Controls.Continuous.LimPID conPID3(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=3,
        Ti=1,
        initType=Modelica.Blocks.Types.InitPID.NoInit) annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={-12,52})));
      Modelica.Blocks.Sources.RealExpression TT_set(y=30 + 273.15)
        annotation (Placement(transformation(extent={{-62,42},{-42,62}})));
      Modelica.Blocks.Math.MinMax minMax(nu=3)
        annotation (Placement(transformation(extent={{40,120},{60,140}})));
      Modelica.Fluid.Valves.ValveLinear CV211(
        redeclare package Medium =
            Modelica.Media.Water.ConstantPropertyLiquidWater,
        dp_nominal=10000,
        m_flow_nominal=800) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={-40,-10})));
      Modelica.Fluid.Valves.ValveDiscrete valveDiscrete(
        redeclare package Medium =
            Modelica.Media.Water.ConstantPropertyLiquidWater,
        dp_nominal=10000,
        m_flow_nominal=500,
        opening_min=0.000000000001)
        annotation (Placement(transformation(extent={{-180,-80},{-200,-100}})));
      Fluid.Movers.FlowControlled_dp fan(
        redeclare package Medium = Media.Water,
        m_flow_nominal=1000,
        redeclare Fluid.Movers.Data.Generic per,
        inputType=Buildings.Fluid.Types.InputType.Constant,
        constantHead=87000)
        annotation (Placement(transformation(extent={{-300,40},{-280,60}})));
      Modelica.Fluid.Sources.Boundary_pT pem_in(
        redeclare package Medium =
            Modelica.Media.Water.ConstantPropertyLiquidWater,
        use_T_in=true,
        nPorts=1)
        annotation (Placement(transformation(extent={{-340,40},{-320,60}})));
      Modelica.Fluid.Sources.FixedBoundary pem_out(redeclare package Medium =
            Modelica.Media.Water.ConstantPropertyLiquidWater, nPorts=1)
        annotation (Placement(transformation(extent={{140,-20},{120,0}})));
      Modelica.Blocks.Sources.CombiTimeTable pem_data(
        tableOnFile=true,
        tableName="tab1",
        fileName=ModelicaServices.ExternalReferences.loadResource(
            "modelica://Buildings/Data/froid/pem_froid.txt"),
        columns={2,3,4},
        extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic)
        annotation (Placement(transformation(extent={{-420,40},{-400,60}})));
      Modelica.Thermal.HeatTransfer.Celsius.ToKelvin toKelvin
        annotation (Placement(transformation(extent={{-380,40},{-360,60}})));
      Modelica.Fluid.Sources.FixedBoundary GF_out(redeclare package Medium =
            Modelica.Media.Water.ConstantPropertyLiquidWater, nPorts=2)
        annotation (Placement(transformation(extent={{-360,-100},{-340,-80}})));
      Modelica.Blocks.Sources.CombiTimeTable deg_data(
        tableOnFile=true,
        tableName="tab1",
        fileName=ModelicaServices.ExternalReferences.loadResource(
            "modelica://Buildings/Data/froid/deg_froid.txt"),
        columns={2,3,4,5,6,7,8,9},
        extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic)
        annotation (Placement(transformation(extent={{380,-40},{360,-20}})));
      Modelica.Blocks.Math.Gain gain(k=1/3.6)
        annotation (Placement(transformation(extent={{220,-40},{200,-20}})));
      Modelica.Thermal.HeatTransfer.Celsius.ToKelvin T_out
        annotation (Placement(transformation(extent={{220,-100},{200,-80}})));
      Modelica.Blocks.Math.Add add
        annotation (Placement(transformation(extent={{320,-180},{300,-160}})));
      Modelica.Blocks.Sources.CombiTimeTable tfp_data(
        tableOnFile=true,
        tableName="tab1",
        fileName=ModelicaServices.ExternalReferences.loadResource(
            "modelica://Buildings/Data/froid/tfp_froid.txt"),
        columns={7},
        extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic)
        annotation (Placement(transformation(extent={{380,-160},{360,-140}})));
      Modelica.Blocks.Sources.CombiTimeTable gf_data(
        tableOnFile=true,
        tableName="tab1",
        fileName=ModelicaServices.ExternalReferences.loadResource(
            "modelica://Buildings/Data/froid/gf1_froid.txt"),
        columns={2},
        extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic)
        annotation (Placement(transformation(extent={{380,-200},{360,-180}})));
      Modelica.Thermal.HeatTransfer.Celsius.ToKelvin T_in
        annotation (Placement(transformation(extent={{220,-70},{200,-50}})));
      Modelica.Blocks.Math.Add add1(k1=-1)
        annotation (Placement(transformation(extent={{280,-140},{260,-120}})));
      Modelica.Blocks.Sources.BooleanExpression booleanExpression(y=true)
        annotation (Placement(transformation(extent={{-220,-140},{-200,-120}})));
      Modelica.Fluid.Sources.Boundary_pT boundary(
        redeclare package Medium =
            Modelica.Media.Water.ConstantPropertyLiquidWater,
        use_p_in=false,
        use_T_in=true,
        p=400000,
        nPorts=1)
        annotation (Placement(transformation(extent={{140,-80},{120,-60}})));
      Modelica.Fluid.Sources.Boundary_pT boundary1(
        redeclare package Medium =
            Modelica.Media.Water.ConstantPropertyLiquidWater,
        use_p_in=false,
        use_T_in=true,
        p=400000,
        nPorts=1)
        annotation (Placement(transformation(extent={{140,-140},{120,-120}})));
      Fluid.Movers.FlowControlled_m_flow fan1(
        redeclare package Medium = Media.Water,
        m_flow_nominal=2280,
        redeclare Fluid.Movers.Data.Generic per)
        annotation (Placement(transformation(extent={{82,-80},{62,-60}})));
      Fluid.Movers.FlowControlled_m_flow fan2(
        redeclare package Medium = Media.Water,
        m_flow_nominal=2280,
        redeclare Fluid.Movers.Data.Generic per)
        annotation (Placement(transformation(extent={{80,-140},{60,-120}})));
      Modelica.Blocks.Math.Gain gain1(k=1/3.6)
        annotation (Placement(transformation(extent={{220,-140},{200,-120}})));
      Modelica.Fluid.Valves.ValveLinear CV1(
        redeclare package Medium =
            Modelica.Media.Water.ConstantPropertyLiquidWater,
        dp_nominal=10000,
        m_flow_nominal=500) annotation (Placement(transformation(
            extent={{-10,10},{10,-10}},
            rotation=180,
            origin={-90,-170})));
      Modelica.Blocks.Math.Add add2(k2=-1) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=-90,
            origin={-72,-130})));
      Modelica.Blocks.Sources.RealExpression realExpression1(y=1) annotation (
          Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=-90,
            origin={-50,-90})));
    equation
      connect(realExpression.y,chi. TSet) annotation (Line(points={{-229,6},{-166,6},
              {-166,-33},{-162,-33}},
                                color={0,0,127}));
      connect(THIn.port_b,chi. port_a1) annotation (Line(points={{-210,40},{
              -206,40},{-206,-24},{-160,-24}},
                               color={0,127,255}));
      connect(chi.port_b1,TT211. port_a)
        annotation (Line(points={{-140,-24},{-90,-24},{-90,-10}},
                                                 color={0,127,255}));
      connect(chi.port_a2,CV121. port_b) annotation (Line(points={{-140,-36},{
              -130,-36},{-130,-50},{-120,-50}},
                              color={0,127,255}));
      connect(THIn.port_b,PT221. port) annotation (Line(points={{-210,40},{-206,
              40},{-206,-18},{-182,-18}},
                           color={0,127,255}));
      connect(chi.port_b1,PT211. port)
        annotation (Line(points={{-140,-24},{-132,-24},{-132,-18},{-122,-18}},
                                                 color={0,127,255}));
      connect(CV121.port_a,FT121. port_b)
        annotation (Line(points={{-100,-50},{-80,-50}},
                                                     color={0,127,255}));
      connect(FT121.port_a,TCIn. port_b)
        annotation (Line(points={{-60,-50},{-30,-50}},color={0,127,255}));
      connect(FT121.m_flow,conPID. u_m)
        annotation (Line(points={{-70,-61},{-70,-100},{-98,-100}},
                                                              color={0,0,127}));
      connect(Q_set.y,conPID. u_s)
        annotation (Line(points={{-129,-140},{-110,-140},{-110,-112}},
                                                                color={0,0,127}));
      connect(conPID.y,CV121. opening)
        annotation (Line(points={{-110,-89},{-110,-58}},
                                                     color={0,0,127}));
      connect(PT211.p,PDT. u2) annotation (Line(points={{-111,-8},{-100,-8},{
              -100,164},{-62,164}},
                     color={0,0,127}));
      connect(PT221.p,PDT. u1) annotation (Line(points={{-171,-8},{-152,-8},{
              -152,176},{-62,176}},
                         color={0,0,127}));
      connect(PDT.y,conPID1. u_m)
        annotation (Line(points={{-39,170},{-10,170},{-10,198}}, color={0,0,127}));
      connect(PDT_set.y,conPID1. u_s)
        annotation (Line(points={{-39,210},{-22,210}}, color={0,0,127}));
      connect(TDT_set.y,conPID2. u_s)
        annotation (Line(points={{-39,130},{-22,130}}, color={0,0,127}));
      connect(TT211.T,TDT. u2)
        annotation (Line(points={{-80,1},{-80,84},{-62,84}}, color={0,0,127}));
      connect(TDT.y,conPID2. u_m)
        annotation (Line(points={{-39,90},{-10,90},{-10,118}},   color={0,0,127}));
      connect(TT_set.y,conPID3. u_s)
        annotation (Line(points={{-41,52},{-24,52}},   color={0,0,127}));
      connect(TT211.T,conPID3. u_m) annotation (Line(points={{-80,1},{-80,20},{
              -12,20},{-12,40}},
                          color={0,0,127}));
      connect(conPID2.y,minMax. u[1]) annotation (Line(points={{1,130},{20,130},
              {20,134.667},{40,134.667}},  color={0,0,127}));
      connect(conPID3.y,minMax. u[2]) annotation (Line(points={{-1,52},{20,52},
              {20,130},{40,130}},  color={0,0,127}));
      connect(conPID1.y,minMax. u[3]) annotation (Line(points={{1,210},{20,210},
              {20,125.333},{40,125.333}},  color={0,0,127}));
      connect(TT211.port_b,CV211. port_a)
        annotation (Line(points={{-70,-10},{-50,-10}},
                                                  color={0,127,255}));
      connect(minMax.yMax,CV211. opening) annotation (Line(points={{61,136},{70,
              136},{70,14},{-40,14},{-40,-2}},
                                           color={0,0,127}));
      connect(TCout.port_a,valveDiscrete. port_b)
        annotation (Line(points={{-220,-90},{-200,-90}},
                                                       color={0,127,255}));
      connect(valveDiscrete.port_a,chi. port_b2) annotation (Line(points={{-180,
              -90},{-174,-90},{-174,-36},{-160,-36}},
                                                 color={0,127,255}));
      connect(pem_in.ports[1], fan.port_a)
        annotation (Line(points={{-320,50},{-300,50}},   color={0,127,255}));
      connect(fan.port_b, THIn.port_a) annotation (Line(points={{-280,50},{-264,
              50},{-264,40},{-230,40}},         color={0,127,255}));
      connect(CV211.port_b, pem_out.ports[1])
        annotation (Line(points={{-30,-10},{120,-10}},color={0,127,255}));
      connect(pem_data.y[1], toKelvin.Celsius)
        annotation (Line(points={{-399,50},{-382,50}},   color={0,0,127}));
      connect(toKelvin.Kelvin, pem_in.T_in) annotation (Line(points={{-359,50},
              {-351.5,50},{-351.5,54},{-342,54}},  color={0,0,127}));
      connect(TCout.port_b, GF_out.ports[1])
        annotation (Line(points={{-240,-90},{-290,-90},{-290,-88},{-340,-88}},
                                                           color={0,127,255}));
      connect(deg_data.y[6], gain.u) annotation (Line(points={{359,-30},{222,
              -30}},                     color={0,0,127}));
      connect(deg_data.y[5], T_in.Celsius) annotation (Line(points={{359,-30},{
              241.5,-30},{241.5,-60},{222,-60}}, color={0,0,127}));
      connect(tfp_data.y[1], add.u1) annotation (Line(points={{359,-150},{342,
              -150},{342,-164},{322,-164}}, color={0,0,127}));
      connect(gf_data.y[1], add.u2) annotation (Line(points={{359,-190},{340,
              -190},{340,-176},{322,-176}}, color={0,0,127}));
      connect(deg_data.y[4], T_out.Celsius) annotation (Line(points={{359,-30},
              {280,-30},{280,-90},{222,-90}}, color={0,0,127}));
      connect(deg_data.y[6], add1.u1) annotation (Line(points={{359,-30},{316,
              -30},{316,-124},{282,-124}}, color={0,0,127}));
      connect(add.y, add1.u2) annotation (Line(points={{299,-170},{292,-170},{
              292,-136},{282,-136}}, color={0,0,127}));
      connect(booleanExpression.y, valveDiscrete.open) annotation (Line(points={{-199,
              -130},{-190,-130},{-190,-98}},         color={255,0,255}));
      connect(THIn.T, TDT.u1) annotation (Line(points={{-220,51},{-220,96},{-62,
              96}}, color={0,0,127}));
      connect(boundary1.ports[1], fan2.port_a)
        annotation (Line(points={{120,-130},{80,-130}}, color={0,127,255}));
      connect(fan1.port_a, boundary.ports[1])
        annotation (Line(points={{82,-70},{120,-70}}, color={0,127,255}));
      connect(fan1.port_b, TCIn.port_a) annotation (Line(points={{62,-70},{26,
              -70},{26,-50},{-10,-50}}, color={0,127,255}));
      connect(fan2.port_b, TCIn.port_a) annotation (Line(points={{60,-130},{26,
              -130},{26,-50},{-10,-50}}, color={0,127,255}));
      connect(T_out.Kelvin, boundary1.T_in) annotation (Line(points={{199,-90},
              {174,-90},{174,-126},{142,-126}}, color={0,0,127}));
      connect(boundary.T_in, T_in.Kelvin) annotation (Line(points={{142,-66},{
              170,-66},{170,-60},{199,-60}}, color={0,0,127}));
      connect(gain.y, fan1.m_flow_in) annotation (Line(points={{199,-30},{72,
              -30},{72,-58}}, color={0,0,127}));
      connect(gain1.u, add1.y)
        annotation (Line(points={{222,-130},{259,-130}}, color={0,0,127}));
      connect(gain1.y, fan2.m_flow_in) annotation (Line(points={{199,-130},{188,
              -130},{188,-100},{70,-100},{70,-118}}, color={0,0,127}));
      connect(CV1.port_a, TCIn.port_a) annotation (Line(points={{-80,-170},{-26,
              -170},{-26,-130},{26,-130},{26,-50},{-10,-50}}, color={0,127,255}));
      connect(CV1.port_b, GF_out.ports[2]) annotation (Line(points={{-100,-170},
              {-320,-170},{-320,-92},{-340,-92}}, color={0,127,255}));
      connect(conPID.y, add2.u2) annotation (Line(points={{-110,-89},{-110,-80},
              {-78,-80},{-78,-118}}, color={0,0,127}));
      connect(add2.u1, realExpression1.y) annotation (Line(points={{-66,-118},{
              -66,-110},{-50,-110},{-50,-101}}, color={0,0,127}));
      connect(add2.y, CV1.opening) annotation (Line(points={{-72,-141},{-72,
              -148},{-90,-148},{-90,-162}}, color={0,0,127}));
      connect(booleanExpression.y, chi.on) annotation (Line(points={{-199,-130},{-170,
              -130},{-170,-27},{-162,-27}}, color={255,0,255}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-440,
                -240},{440,240}})),                                  Diagram(
            coordinateSystem(preserveAspectRatio=false, extent={{-440,-240},{
                440,240}})));
    end basic_mdoe;
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

    model pem_1groupe
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
        use_T_in=true,
        T=288.15,
        nPorts=1) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-20,-70})));
      Fluid.Movers.FlowControlled_dp fan(
        redeclare package Medium = Media.Water,
        m_flow_nominal=1000,
        redeclare Fluid.Movers.Data.Generic per,
        inputType=Buildings.Fluid.Types.InputType.Constant,
        constantHead=87000)
        annotation (Placement(transformation(extent={{-10,-30},{10,-10}})));
      Modelica.Fluid.Sensors.TemperatureTwoPort TT200(redeclare package Medium =
            Modelica.Media.Water.ConstantPropertyLiquidWater)
        annotation (Placement(transformation(extent={{30,-30},{50,-10}})));
      Modelica.Blocks.Interfaces.RealOutput y
        annotation (Placement(transformation(extent={{100,0},{120,20}})));
      Modelica.Fluid.Sensors.Pressure PT200(redeclare package Medium =
            Modelica.Media.Water.ConstantPropertyLiquidWater)
        annotation (Placement(transformation(extent={{112,80},{132,100}})));
      Modelica.Fluid.Sensors.MassFlowRate FQT200(redeclare package Medium =
            Modelica.Media.Water.ConstantPropertyLiquidWater) annotation (
          Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={70,-10})));
      Modelica.Fluid.Sensors.TemperatureTwoPort TT201(redeclare package Medium =
            Modelica.Media.Water.ConstantPropertyLiquidWater)
        annotation (Placement(transformation(extent={{-60,30},{-80,50}})));
      Modelica.Blocks.Sources.CombiTimeTable combiTimeTable(
        tableOnFile=true,
        tableName="tab1",
        fileName=ModelicaServices.ExternalReferences.loadResource(
            "modelica://Buildings/Data/pem.txt"),
        columns={2,3,4},
        extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic)
        annotation (Placement(transformation(extent={{-100,-100},{-80,-80}})));
      Modelica.Thermal.HeatTransfer.Celsius.ToKelvin toKelvin
        annotation (Placement(transformation(extent={{-60,-100},{-40,-80}})));
      Modelica.Fluid.Valves.ValveLinear valveLinear(
        redeclare package Medium = Modelica.Media.Water.IdealSteam,
        dp_nominal=10000,
        m_flow_nominal=1000)
        annotation (Placement(transformation(extent={{10,40},{-10,60}})));
      Modelica.Blocks.Sources.RealExpression realExpression(y=0.001)
        annotation (Placement(transformation(extent={{-40,60},{-20,80}})));
    equation
      connect(bou1.ports[1], fan.port_a) annotation (Line(points={{-20,-60},{
              -20,-20},{-10,-20}}, color={0,127,255}));
      connect(fan.port_b, TT200.port_a)
        annotation (Line(points={{10,-20},{30,-20}}, color={0,127,255}));
      connect(FQT200.port_b, port_a)
        annotation (Line(points={{70,0},{70,90},{50,90}},
                                                  color={0,127,255}));
      connect(TT200.port_b, FQT200.port_a) annotation (Line(points={{50,-20},{
              70,-20}},                   color={0,127,255}));
      connect(TT200.T, y)
        annotation (Line(points={{40,-9},{40,10},{110,10}}, color={0,0,127}));
      connect(boundary.ports[1], TT201.port_b) annotation (Line(points={{-90,
              -3.55271e-15},{-90,40},{-80,40}}, color={0,127,255}));
      connect(TT201.port_a, port_b) annotation (Line(points={{-60,40},{-50,40},
              {-50,90}}, color={0,127,255}));
      connect(combiTimeTable.y[1], toKelvin.Celsius)
        annotation (Line(points={{-79,-90},{-62,-90}}, color={0,0,127}));
      connect(toKelvin.Kelvin, bou1.T_in) annotation (Line(points={{-39,-90},{
              -24,-90},{-24,-82}}, color={0,0,127}));
      connect(PT200.port, port_a) annotation (Line(points={{122,80},{70,80},{70,
              90},{50,90}}, color={0,127,255}));
      connect(valveLinear.port_a, port_a) annotation (Line(points={{10,50},{70,
              50},{70,90},{50,90}}, color={0,127,255}));
      connect(valveLinear.port_b, port_b) annotation (Line(points={{-10,50},{
              -50,50},{-50,90}}, color={0,127,255}));
      connect(realExpression.y, valveLinear.opening)
        annotation (Line(points={{-19,70},{0,70},{0,58}}, color={0,0,127}));
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
    end pem_1groupe;

    package Tests
      extends Modelica.Icons.ExamplesPackage;
      model test_0
        Modelica.Fluid.Sources.FixedBoundary boundary(redeclare package Medium =
              Modelica.Media.Water.ConstantPropertyLiquidWater, nPorts=1)
          annotation (Placement(transformation(
              extent={{10,-10},{-10,10}},
              rotation=-90,
              origin={-90,-10})));
        Fluid.Sources.Boundary_pT bou1(
          redeclare package Medium = Media.Water,
          p=100000,
          use_T_in=true,
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
        Modelica.Fluid.Sensors.TemperatureTwoPort TT200(redeclare package
            Medium = Modelica.Media.Water.ConstantPropertyLiquidWater)
          annotation (Placement(transformation(extent={{0,-30},{20,-10}})));
        Modelica.Fluid.Sensors.Pressure PT200(redeclare package Medium =
              Modelica.Media.Water.ConstantPropertyLiquidWater)
          annotation (Placement(transformation(extent={{-30,40},{-10,60}})));
        Modelica.Fluid.Sensors.MassFlowRate FQT200(redeclare package Medium =
              Modelica.Media.Water.ConstantPropertyLiquidWater) annotation (
            Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={50,-10})));
        Modelica.Fluid.Sensors.TemperatureTwoPort TT201(redeclare package
            Medium = Modelica.Media.Water.ConstantPropertyLiquidWater)
          annotation (Placement(transformation(extent={{-60,30},{-80,50}})));
        Modelica.Blocks.Sources.CombiTimeTable combiTimeTable(
          tableOnFile=true,
          tableName="tab1",
          fileName=ModelicaServices.ExternalReferences.loadResource(
              "modelica://Buildings/Data/pem.txt"),
          columns={2,3,4},
          extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic)
          annotation (Placement(transformation(extent={{-140,-100},{-120,-80}})));
        inner Modelica.Fluid.System system
          annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
        Modelica.Fluid.Valves.ValveDiscrete valveDiscrete(
          redeclare package Medium =
              Modelica.Media.Water.ConstantPropertyLiquidWater,
          dp_nominal=10000,
          m_flow_nominal=100)
          annotation (Placement(transformation(extent={{40,30},{20,50}})));
        Modelica.Blocks.Sources.BooleanExpression booleanExpression(y=true)
          annotation (Placement(transformation(extent={{0,60},{20,80}})));
        Modelica.Thermal.HeatTransfer.Celsius.ToKelvin toKelvin annotation (
            Placement(transformation(extent={{-100,-100},{-80,-80}})));
      equation
        connect(bou1.ports[1],fan. port_a) annotation (Line(points={{-50,-60},{
                -50,-20},{-40,-20}}, color={0,127,255}));
        connect(fan.port_b,TT200. port_a)
          annotation (Line(points={{-20,-20},{0,-20}}, color={0,127,255}));
        connect(TT200.port_b,FQT200. port_a) annotation (Line(points={{20,-20},
                {50,-20}},                  color={0,127,255}));
        connect(boundary.ports[1], TT201.port_b) annotation (Line(points={{-90,
                0},{-90,40},{-80,40}}, color={0,127,255}));
        connect(FQT200.port_b, valveDiscrete.port_a) annotation (Line(points={{
                50,0},{50,40},{40,40}}, color={0,127,255}));
        connect(valveDiscrete.port_b, TT201.port_a)
          annotation (Line(points={{20,40},{-60,40}}, color={0,127,255}));
        connect(valveDiscrete.port_b, PT200.port)
          annotation (Line(points={{20,40},{-20,40}}, color={0,127,255}));
        connect(booleanExpression.y, valveDiscrete.open) annotation (Line(
              points={{21,70},{30,70},{30,48}}, color={255,0,255}));
        connect(combiTimeTable.y[1], toKelvin.Celsius)
          annotation (Line(points={{-119,-90},{-102,-90}}, color={0,0,127}));
        connect(toKelvin.Kelvin, bou1.T_in) annotation (Line(points={{-79,-90},
                {-54,-90},{-54,-82}}, color={0,0,127}));
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
    PEM.pem_1groupe pem_gf(redeclare package Medium = Media.Water)
      annotation (Placement(transformation(extent={{0,-60},{20,-40}})));
    GF.Chiller_carnot chiller_carnot(redeclare package Medium1 = Media.Water,
        redeclare package Medium2 = Media.Water,
      on(fixed=false))
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
            {32,-49},{32,-14},{13.2667,-14},{13.2667,7.2}},
                                                 color={0,0,127}));
    connect(pem_gf.port_a, chiller_carnot.port_b1) annotation (Line(points={{15,-41},
            {15,-28},{28,-28},{28,11.68},{17.4667,11.68}},
                                                   color={0,127,255}));
    connect(chiller_carnot.port_a1, pem_gf.port_b) annotation (Line(points={{8.13333,
            11.68},{-8,11.68},{-8,-41},{5,-41}},
                                         color={0,127,255}));
    connect(chiller_carnot.port_a2, sortie_f.ports[1]) annotation (Line(points={{17.4667,
            18.4},{40,18.4},{40,30},{80,30}},  color={0,127,255}));
    connect(entree_f.ports[1], massFlowRate.port_a) annotation (Line(points={{
            -80,30},{-70,30},{-70,30},{-60,30}}, color={0,127,255}));
    connect(massFlowRate.port_b, chiller_carnot.port_b2) annotation (Line(
          points={{-40,30},{-20,30},{-20,18.4},{8.13333,18.4}},
                                                      color={0,127,255}));
    connect(ramp.y, entree_f.m_flow_in) annotation (Line(points={{-159,29},{
            -131.5,29},{-131.5,38},{-100,38}}, color={0,0,127}));
    connect(massFlowRate.m_flow, control_0_1.u)
      annotation (Line(points={{-50,41},{-50,65},{-20,65}}, color={0,0,127}));
    connect(control_0_1.GF1, chiller_carnot.on)
      annotation (Line(points={{-9,59},{-9,22.32},{6.26667,22.32}},
                                                         color={255,0,255}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end Plant;

  package test_valves
    model test_tor
      Modelica.Fluid.Valves.ValveDiscrete valveDiscrete(
        redeclare package Medium =
            Modelica.Media.Water.ConstantPropertyLiquidWater,
        dp_nominal=10000,
        m_flow_nominal=100,
        opening_min=0.0001)
        annotation (Placement(transformation(extent={{-10,-60},{10,-40}})));
      Modelica.Fluid.Valves.ValveLinear valveLinear(
        redeclare package Medium =
            Modelica.Media.Water.ConstantPropertyLiquidWater,
        dp_nominal=10000,
        m_flow_nominal=100)
        annotation (Placement(transformation(extent={{-10,40},{10,60}})));
      Modelica.Fluid.Sources.FixedBoundary boundary2(redeclare package Medium =
            Modelica.Media.Water.ConstantPropertyLiquidWater, nPorts=2)
        annotation (Placement(transformation(extent={{100,-60},{80,-40}})));
      Modelica.Fluid.Sources.FixedBoundary boundary1(redeclare package Medium =
            Modelica.Media.Water.ConstantPropertyLiquidWater, nPorts=2)
        annotation (Placement(transformation(extent={{100,40},{80,60}})));
      Fluid.Movers.FlowControlled_dp fan2(
        redeclare package Medium = Media.Water,
        m_flow_nominal=100,
        redeclare Fluid.Movers.Data.Pumps.Wilo.Stratos25slash1to4 per,
        inputType=Buildings.Fluid.Types.InputType.Constant,
        constantHead=100)
        annotation (Placement(transformation(extent={{-80,-60},{-60,-40}})));
      Fluid.Movers.FlowControlled_dp fan1(
        redeclare package Medium = Media.Water,
        m_flow_nominal=100,
        redeclare Fluid.Movers.Data.Pumps.Wilo.Stratos25slash1to4 per,
        inputType=Buildings.Fluid.Types.InputType.Constant,
        constantHead=100)
        annotation (Placement(transformation(extent={{-80,40},{-60,60}})));
      Modelica.Blocks.Sources.BooleanPulse booleanPulse(width=50, period=1000)
        annotation (Placement(transformation(extent={{-60,-20},{-40,0}})));
      Modelica.Blocks.Sources.Pulse pulse(width=50, period=1000)
        annotation (Placement(transformation(extent={{-60,80},{-40,100}})));
    equation
      connect(valveLinear.port_b, boundary1.ports[1])
        annotation (Line(points={{10,50},{46,50},{46,52},{80,52}},
                                                   color={0,127,255}));
      connect(valveDiscrete.port_b, boundary2.ports[1])
        annotation (Line(points={{10,-50},{46,-50},{46,-48},{80,-48}},
                                                     color={0,127,255}));
      connect(fan2.port_b, valveDiscrete.port_a)
        annotation (Line(points={{-60,-50},{-10,-50}}, color={0,127,255}));
      connect(fan2.port_a, boundary2.ports[2]) annotation (Line(points={{-80,
              -50},{-90,-50},{-90,-80},{60,-80},{60,-52},{80,-52}}, color={0,
              127,255}));
      connect(fan1.port_b, valveLinear.port_a)
        annotation (Line(points={{-60,50},{-10,50}}, color={0,127,255}));
      connect(fan1.port_a, boundary1.ports[2]) annotation (Line(points={{-80,50},
              {-90,50},{-90,20},{60,20},{60,48},{80,48}}, color={0,127,255}));
      connect(booleanPulse.y, valveDiscrete.open) annotation (Line(points={{-39,
              -10},{0,-10},{0,-42}}, color={255,0,255}));
      connect(pulse.y, valveLinear.opening)
        annotation (Line(points={{-39,90},{0,90},{0,58}}, color={0,0,127}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end test_tor;

    model test_tor1
      Modelica.Fluid.Valves.ValveDiscrete valveDiscrete(
        redeclare package Medium =
            Modelica.Media.Water.ConstantPropertyLiquidWater,
        dp_nominal=10000,
        m_flow_nominal=100,
        opening_min=0.00001)
        annotation (Placement(transformation(extent={{-10,-60},{10,-40}})));
      Modelica.Fluid.Sources.FixedBoundary boundary2(redeclare package Medium =
            Modelica.Media.Water.ConstantPropertyLiquidWater, nPorts=2)
        annotation (Placement(transformation(extent={{100,-60},{80,-40}})));
      Modelica.Blocks.Sources.BooleanExpression booleanExpression(y=false)
        annotation (Placement(transformation(extent={{-40,-20},{-20,0}})));
      Fluid.Movers.FlowControlled_dp fan(
        redeclare package Medium = Media.Water,
        m_flow_nominal=100,
        redeclare Fluid.Movers.Data.Pumps.Wilo.Stratos25slash1to4 per,
        inputType=Buildings.Fluid.Types.InputType.Constant,
        constantHead=100)
        annotation (Placement(transformation(extent={{-60,-60},{-40,-40}})));
    equation
      connect(valveDiscrete.port_b, boundary2.ports[1]) annotation (Line(points=
             {{10,-50},{58,-50},{58,-48},{80,-48}}, color={0,127,255}));
      connect(booleanExpression.y, valveDiscrete.open) annotation (Line(points=
              {{-19,-10},{0,-10},{0,-42}}, color={255,0,255}));
      connect(boundary2.ports[2], fan.port_a) annotation (Line(points={{80,-52},
              {68,-52},{68,-80},{-80,-80},{-80,-50},{-60,-50}}, color={0,127,
              255}));
      connect(fan.port_b, valveDiscrete.port_a)
        annotation (Line(points={{-40,-50},{-10,-50}}, color={0,127,255}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end test_tor1;

    model test_mover
      Modelica.Fluid.Valves.ValveDiscrete valveDiscrete(
        redeclare package Medium =
            Modelica.Media.Water.ConstantPropertyLiquidWater,
        dp_nominal=10000,
        m_flow_nominal=100,
        opening_min=0.001)
        annotation (Placement(transformation(extent={{-10,-20},{10,0}})));
      Modelica.Fluid.Sources.FixedBoundary boundary2(
        redeclare package Medium =
            Modelica.Media.Water.ConstantPropertyLiquidWater,
        p=100000,
        nPorts=1)
        annotation (Placement(transformation(extent={{100,-20},{80,0}})));
      Modelica.Blocks.Sources.BooleanExpression booleanExpression(y=false)
        annotation (Placement(transformation(extent={{-40,20},{-20,40}})));
      Fluid.Sources.MassFlowSource_T           sou2(
        nPorts=1,
        redeclare package Medium = Media.Water,
        m_flow=100,
        use_T_in=false,
        T=295.15)
        annotation (Placement(transformation(extent={{-100,-20},{-80,0}})));
      inner Modelica.Fluid.System system
        annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
    equation
      connect(valveDiscrete.port_b,boundary2. ports[1]) annotation (Line(points={{10,-10},
              {58,-10},{58,-10},{80,-10}},          color={0,127,255}));
      connect(booleanExpression.y,valveDiscrete. open) annotation (Line(points={{-19,30},
              {0,30},{0,-2}},              color={255,0,255}));
      connect(sou2.ports[1], valveDiscrete.port_a)
        annotation (Line(points={{-80,-10},{-10,-10}}, color={0,127,255}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end test_mover;
  end test_valves;

  package DEC
    extends Modelica.Icons.VariantsPackage;
    package Tests
      extends Modelica.Icons.ExamplesPackage;
      model combi_0
        Modelica.Fluid.Sources.MassFlowSource_T boundary(
          redeclare package Medium =
              Modelica.Media.Water.ConstantPropertyLiquidWater,
          m_flow=50,
          T=323.15,
          nPorts=1)
          annotation (Placement(transformation(extent={{-100,20},{-80,40}})));
        Modelica.Fluid.Sources.MassFlowSource_T boundary1(
          redeclare package Medium =
              Modelica.Media.Water.ConstantPropertyLiquidWater,
          m_flow=50,
          T=303.15,
          nPorts=1)
          annotation (Placement(transformation(extent={{-100,-20},{-80,0}})));
        Modelica.Fluid.Sensors.TemperatureTwoPort temperature(redeclare package
            Medium = Modelica.Media.Water.ConstantPropertyLiquidWater)
          annotation (Placement(transformation(extent={{-28,0},{-8,20}})));
        Modelica.Fluid.Sources.FixedBoundary boundary2(redeclare package Medium =
              Modelica.Media.Water.ConstantPropertyLiquidWater, nPorts=1)
          annotation (Placement(transformation(extent={{180,0},{160,20}})));
        Modelica.Fluid.Sensors.TemperatureTwoPort temperature1(redeclare
            package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater)
          annotation (Placement(transformation(extent={{130,0},{150,20}})));
        Modelica.Fluid.Sensors.MassFlowRate massFlowRate(redeclare package
            Medium = Modelica.Media.Water.ConstantPropertyLiquidWater)
          annotation (Placement(transformation(extent={{92,-50},{112,-30}})));
        Modelica.Fluid.Sensors.MassFlowRate massFlowRate1(redeclare package
            Medium = Modelica.Media.Water.ConstantPropertyLiquidWater)
          annotation (Placement(transformation(extent={{92,0},{112,20}})));
        Modelica.Fluid.Sensors.MassFlowRate massFlowRate2(redeclare package
            Medium = Modelica.Media.Water.ConstantPropertyLiquidWater)
          annotation (Placement(transformation(extent={{4,0},{24,20}})));
        Modelica.Fluid.Valves.ValveDiscrete valveDiscrete1(
          redeclare package Medium =
              Modelica.Media.Water.ConstantPropertyLiquidWater,
          dp_nominal=20000,
          m_flow_nominal=100)
          annotation (Placement(transformation(extent={{60,-50},{80,-30}})));
        Modelica.Blocks.Sources.BooleanConstant booleanConstant
          annotation (Placement(transformation(extent={{0,-40},{20,-20}})));
        Modelica.Fluid.Valves.ValveLinear valveLinear(
          redeclare package Medium =
              Modelica.Media.Water.ConstantPropertyLiquidWater,
          dp_nominal=10000,
          m_flow_nominal=100)
          annotation (Placement(transformation(extent={{60,0},{80,20}})));
      equation
        connect(boundary1.ports[1], temperature.port_a) annotation (Line(points=
               {{-80,-10},{-52,-10},{-52,10},{-28,10}}, color={0,127,255}));
        connect(boundary.ports[1], temperature.port_a) annotation (Line(points=
                {{-80,30},{-60,30},{-60,10},{-28,10}}, color={0,127,255}));
        connect(temperature1.port_b, boundary2.ports[1])
          annotation (Line(points={{150,10},{160,10}}, color={0,127,255}));
        connect(massFlowRate.port_b, temperature1.port_a) annotation (Line(
              points={{112,-40},{122,-40},{122,10},{130,10}}, color={0,127,255}));
        connect(massFlowRate1.port_b, temperature1.port_a)
          annotation (Line(points={{112,10},{130,10}}, color={0,127,255}));
        connect(temperature.port_b, massFlowRate2.port_a)
          annotation (Line(points={{-8,10},{4,10}}, color={0,127,255}));
        connect(massFlowRate.port_a, valveDiscrete1.port_b)
          annotation (Line(points={{92,-40},{80,-40}}, color={0,127,255}));
        connect(valveDiscrete1.port_a, massFlowRate2.port_b) annotation (Line(
              points={{60,-40},{40,-40},{40,10},{24,10}}, color={0,127,255}));
        connect(booleanConstant.y, valveDiscrete1.open) annotation (Line(points=
               {{21,-30},{46,-30},{46,-32},{70,-32}}, color={255,0,255}));
        connect(massFlowRate2.port_b, valveLinear.port_a)
          annotation (Line(points={{24,10},{60,10}}, color={0,127,255}));
        connect(valveLinear.port_b, massFlowRate1.port_a)
          annotation (Line(points={{80,10},{92,10}}, color={0,127,255}));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
              coordinateSystem(preserveAspectRatio=false)));
      end combi_0;
    end Tests;
  end DEC;

  package DEG
    extends Modelica.Icons.VariantsPackage;
    package Tests
      extends Modelica.Icons.ExamplesPackage;
    end Tests;
  end DEG;

  package Miscellaneous
    extends Modelica.Icons.VariantsPackage;
    package data_table
      model table
        Modelica.Blocks.Sources.CombiTimeTable
                                          Q_TFP(
          tableOnFile=true,
          table=[0,200E3; 6,200E3; 6,50E3; 18,50E3; 18,75E3; 24,75E3],
          tableName="tab1",
          fileName=ModelicaServices.ExternalReferences.loadResource(
              "modelica://Buildings/Data/distribution/essai.txt"),
          columns={2,3,4,5,6,7,8,9,10,11},
          extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
          offset={0})
          annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
        Modelica.Blocks.Interfaces.RealOutput y
          annotation (Placement(transformation(extent={{20,20},{40,40}})));
        Modelica.Blocks.Interfaces.RealOutput y1
          annotation (Placement(transformation(extent={{20,0},{40,20}})));
      equation
        connect(Q_TFP.y[2], y) annotation (Line(points={{-59,30},{-16.5,30},{
                -16.5,30},{30,30}}, color={0,0,127}));
        connect(Q_TFP.y[3], y1) annotation (Line(points={{-59,30},{-18,30},{-18,
                10},{30,10}}, color={0,0,127}));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
              coordinateSystem(preserveAspectRatio=false)));
      end table;

      model table_b
        Modelica.Blocks.Sources.CombiTimeTable combiTimeTable(
          tableOnFile=true,
          tableName="tab1",
          fileName=ModelicaServices.ExternalReferences.loadResource(
              "modelica://Buildings/Data/pem.txt"),
          columns={2,3,4},
          extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic)
          annotation (Placement(transformation(extent={{-20,-20},{0,0}})));
        Modelica.Thermal.HeatTransfer.Celsius.ToKelvin toKelvin
          annotation (Placement(transformation(extent={{20,-20},{40,0}})));
      equation
        connect(combiTimeTable.y[1], toKelvin.Celsius)
          annotation (Line(points={{1,-10},{18,-10}}, color={0,0,127}));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
              coordinateSystem(preserveAspectRatio=false)));
      end table_b;

      model table_c
        Fluid.Sources.Boundary_pT bou1(
          redeclare package Medium = Media.Water,
          p=100000,
          use_T_in=true,
          T=288.15,
          nPorts=1) annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={0,30})));
        Modelica.Blocks.Sources.CombiTimeTable combiTimeTable(
          tableOnFile=true,
          tableName="tab1",
          fileName=ModelicaServices.ExternalReferences.loadResource(
              "modelica://Buildings/Data/pem.txt"),
          columns={2,3,4},
          extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic)
          annotation (Placement(transformation(extent={{-80,0},{-60,20}})));
        Modelica.Thermal.HeatTransfer.Celsius.ToKelvin toKelvin
          annotation (Placement(transformation(extent={{-40,0},{-20,20}})));
      equation
        connect(combiTimeTable.y[1],toKelvin. Celsius)
          annotation (Line(points={{-59,10},{-42,10}},   color={0,0,127}));
        connect(toKelvin.Kelvin,bou1. T_in) annotation (Line(points={{-19,10},{
                -4,10},{-4,18}},     color={0,0,127}));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
              coordinateSystem(preserveAspectRatio=false)));
      end table_c;

      model mass_flow_table
        Modelica.Fluid.Sources.FixedBoundary sortie_f(redeclare package Medium =
              Modelica.Media.Water.ConstantPropertyLiquidWater, nPorts=1) annotation (
           Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=180,
              origin={90,10})));
        Modelica.Fluid.Sensors.MassFlowRate massFlowRate(redeclare package
            Medium =
              Modelica.Media.Water.ConstantPropertyLiquidWater)
          annotation (Placement(transformation(extent={{20,0},{40,20}})));
        Fluid.Movers.FlowControlled_dp fan(
          redeclare package Medium = Media.Water,
          m_flow_nominal=800,
          redeclare Fluid.Movers.Data.Pumps.Wilo.Stratos25slash1to4 per,
          inputType=Buildings.Fluid.Types.InputType.Constant,
          constantHead=870)
          annotation (Placement(transformation(extent={{-40,0},{-20,20}})));
        Fluid.Sources.Boundary_pT bou1(
          redeclare package Medium = Media.Water,
          p=100000,
          use_T_in=true,
          T=288.15,
          nPorts=1) annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={-70,-10})));
        Modelica.Blocks.Sources.CombiTimeTable combiTimeTable(
          tableOnFile=true,
          tableName="tab1",
          fileName=ModelicaServices.ExternalReferences.loadResource(
              "modelica://Buildings/Data/pem.txt"),
          columns={2,3,4},
          extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic)
          annotation (Placement(transformation(extent={{-150,-40},{-130,-20}})));
        Modelica.Thermal.HeatTransfer.Celsius.ToKelvin toKelvin
          annotation (Placement(transformation(extent={{-110,-40},{-90,-20}})));
      equation
        connect(massFlowRate.port_b, sortie_f.ports[1])
          annotation (Line(points={{40,10},{80,10}}, color={0,127,255}));
        connect(fan.port_b, massFlowRate.port_a)
          annotation (Line(points={{-20,10},{20,10}}, color={0,127,255}));
        connect(combiTimeTable.y[1],toKelvin. Celsius)
          annotation (Line(points={{-129,-30},{-112,-30}},
                                                         color={0,0,127}));
        connect(toKelvin.Kelvin,bou1. T_in) annotation (Line(points={{-89,-30},
                {-74,-30},{-74,-22}},color={0,0,127}));
        connect(bou1.ports[1], fan.port_a) annotation (Line(points={{-70,0},{
                -56,0},{-56,10},{-40,10}}, color={0,127,255}));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
              coordinateSystem(preserveAspectRatio=false)));
      end mass_flow_table;

      model data_gf
        Modelica.Blocks.Sources.CombiTimeTable pem_data(
          tableOnFile=true,
          tableName="tab1",
          fileName=ModelicaServices.ExternalReferences.loadResource(
              "modelica://Buildings/Data/froid/pem_froid.txt"),
          columns={2,3,4},
          extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic)
          annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
        Modelica.Thermal.HeatTransfer.Celsius.ToKelvin toKelvin
          annotation (Placement(transformation(extent={{-60,80},{-40,100}})));
        Modelica.Blocks.Sources.CombiTimeTable deg_data(
          tableOnFile=true,
          tableName="tab1",
          fileName=ModelicaServices.ExternalReferences.loadResource(
              "modelica://Buildings/Data/froid/deg_froid.txt"),
          columns={2,3,4,5,6,7,8,9},
          extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic)
          annotation (Placement(transformation(extent={{100,60},{80,80}})));
        Modelica.Blocks.Math.Gain gain(k=1/3.6)
          annotation (Placement(transformation(extent={{-60,60},{-80,80}})));
        Modelica.Thermal.HeatTransfer.Celsius.ToKelvin toKelvin1
          annotation (Placement(transformation(extent={{-60,0},{-80,20}})));
        Modelica.Blocks.Math.Add add
          annotation (Placement(transformation(extent={{40,-80},{20,-60}})));
        Modelica.Blocks.Sources.CombiTimeTable tfp_data(
          tableOnFile=true,
          tableName="tab1",
          fileName=ModelicaServices.ExternalReferences.loadResource(
              "modelica://Buildings/Data/froid/tfp_froid.txt"),
          columns={7},
          extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic)
          annotation (Placement(transformation(extent={{100,-60},{80,-40}})));
        Modelica.Blocks.Sources.CombiTimeTable gf_data(
          tableOnFile=true,
          tableName="tab1",
          fileName=ModelicaServices.ExternalReferences.loadResource(
              "modelica://Buildings/Data/froid/gf1_froid.txt"),
          columns={2},
          extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic)
          annotation (Placement(transformation(extent={{100,-100},{80,-80}})));
        Modelica.Thermal.HeatTransfer.Celsius.ToKelvin toKelvin2
          annotation (Placement(transformation(extent={{-60,30},{-80,50}})));
        Modelica.Blocks.Math.Add add1(k1=-1)
          annotation (Placement(transformation(extent={{0,-40},{-20,-20}})));
      equation
        connect(pem_data.y[1],toKelvin. Celsius)
          annotation (Line(points={{-79,90},{-62,90}},     color={0,0,127}));
        connect(deg_data.y[6],gain. u) annotation (Line(points={{79,70},{-58,70}},
                                           color={0,0,127}));
        connect(deg_data.y[5],toKelvin2. Celsius) annotation (Line(points={{79,70},
                {-38.5,70},{-38.5,40},{-58,40}},           color={0,0,127}));
        connect(tfp_data.y[1],add. u1) annotation (Line(points={{79,-50},{62,
                -50},{62,-64},{42,-64}},      color={0,0,127}));
        connect(gf_data.y[1],add. u2) annotation (Line(points={{79,-90},{60,-90},
                {60,-76},{42,-76}},           color={0,0,127}));
        connect(deg_data.y[4],toKelvin1. Celsius) annotation (Line(points={{79,70},
                {0,70},{0,10},{-58,10}},               color={0,0,127}));
        connect(deg_data.y[6],add1. u1) annotation (Line(points={{79,70},{36,70},
                {36,-24},{2,-24}},           color={0,0,127}));
        connect(add.y,add1. u2) annotation (Line(points={{19,-70},{12,-70},{12,
                -36},{2,-36}},         color={0,0,127}));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
              coordinateSystem(preserveAspectRatio=false)));
      end data_gf;
    end data_table;

    model mass_flow
      Modelica.Fluid.Sources.FixedBoundary sortie_f(redeclare package Medium =
            Modelica.Media.Water.ConstantPropertyLiquidWater, nPorts=1) annotation (
         Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={90,10})));
      Modelica.Fluid.Sensors.MassFlowRate massFlowRate(redeclare package Medium =
            Modelica.Media.Water.ConstantPropertyLiquidWater)
        annotation (Placement(transformation(extent={{20,0},{40,20}})));
      Fluid.Movers.FlowControlled_dp fan(
        redeclare package Medium = Media.Water,
        m_flow_nominal=800,
        redeclare Fluid.Movers.Data.Pumps.Wilo.Stratos25slash1to4 per,
        inputType=Buildings.Fluid.Types.InputType.Constant,
        constantHead=870)
        annotation (Placement(transformation(extent={{-40,0},{-20,20}})));
      Modelica.Fluid.Sources.FixedBoundary entree_f(
        redeclare package Medium =
            Modelica.Media.Water.ConstantPropertyLiquidWater,
        p=100000,
        nPorts=1) annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=180,
            origin={-90,10})));
    equation
      connect(massFlowRate.port_b, sortie_f.ports[1])
        annotation (Line(points={{40,10},{80,10}}, color={0,127,255}));
      connect(fan.port_b, massFlowRate.port_a)
        annotation (Line(points={{-20,10},{20,10}}, color={0,127,255}));
      connect(entree_f.ports[1], fan.port_a)
        annotation (Line(points={{-80,10},{-40,10}}, color={0,127,255}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end mass_flow;

    model IntegratedPrimaryLoadSideEconomizer
      "Example that demonstrates a chiller plant with integrated primary load side economizer"
      extends Modelica.Icons.Example;
      extends
        Buildings.Applications.DataCenters.ChillerCooled.Examples.BaseClasses.PostProcess(
        freCooSig(
          y=if cooModCon.y == Integer(Buildings.Applications.DataCenters.Types.CoolingModes.FreeCooling)
          then 1 else 0),
        parMecCooSig(
          y=if cooModCon.y == Integer(Buildings.Applications.DataCenters.Types.CoolingModes.PartialMechanical)
          then 1 else 0),
        fulMecCooSig(
          y=if cooModCon.y == Integer(Buildings.Applications.DataCenters.Types.CoolingModes.FullMechanical)
          then 1 else 0),
        PHVAC(y=cooTow[1].PFan + cooTow[2].PFan + pumCW[1].P + pumCW[2].P + sum(
              chiWSE.powChi + chiWSE.powPum) + ahu.PFan + ahu.PHea),
        PIT(y=roo.QSou.Q_flow));
      extends
        Buildings.Applications.DataCenters.ChillerCooled.Examples.BaseClasses.PartialDataCenter(
        redeclare Buildings.Applications.DataCenters.ChillerCooled.Equipment.IntegratedPrimaryLoadSide chiWSE(
          addPowerToMedium=false,
          perPum=perPumPri),
        weaData(filNam=Modelica.Utilities.Files.loadResource("modelica://Buildings/Resources/weatherdata/DRYCOLD.mos")),
        expVesChi(redeclare package Medium = Media.Water));

      parameter Buildings.Fluid.Movers.Data.Generic[numChi] perPumPri(
        each pressure=Buildings.Fluid.Movers.BaseClasses.Characteristics.flowParameters(
              V_flow=m2_flow_chi_nominal/1000*{0.2,0.6,1.0,1.2},
              dp=(dp2_chi_nominal+dp2_wse_nominal+18000)*{1.5,1.3,1.0,0.6}))
        "Performance data for primary pumps";

      Buildings.Applications.DataCenters.ChillerCooled.Controls.CoolingMode
        cooModCon(
        tWai=tWai,
        deaBan1=1.1,
        deaBan2=0.5,
        deaBan3=1.1,
        deaBan4=0.5)
        "Cooling mode controller"
        annotation (Placement(transformation(extent={{-214,100},{-194,120}})));
      Modelica.Blocks.Sources.RealExpression towTApp(y=cooTow[1].TApp_nominal)
        "Cooling tower approach temperature"
        annotation (Placement(transformation(extent={{-320,100},{-300,120}})));
      Modelica.Blocks.Sources.RealExpression yVal5(
        y=if cooModCon.y == Integer(
        Buildings.Applications.DataCenters.Types.CoolingModes.FullMechanical)
        then 1 else 0)
        "On/off signal for valve 5"
        annotation (Placement(transformation(extent={{-160,30},{-140,50}})));
      Modelica.Blocks.Sources.RealExpression yVal6(
        y=if cooModCon.y == Integer(
        Buildings.Applications.DataCenters.Types.CoolingModes.FreeCooling)
        then 1 else 0)
        "On/off signal for valve 6"
        annotation (Placement(transformation(extent={{-160,14},{-140,34}})));

      Modelica.Blocks.Sources.RealExpression cooLoaChi(
        y=-chiWSE.port_a2.m_flow*4180*(chiWSE.TCHWSupWSE - TCHWSupSet.y))
        "Cooling load in chillers"
        annotation (Placement(transformation(extent={{-320,130},{-300,150}})));
    equation

      connect(pumSpeSig.y, chiWSE.yPum)
        annotation (Line(
          points={{-99,-10},{-60,-10},{-60,25.6},{-1.6,25.6}},
          color={0,0,127}));
      connect(TCHWSup.port_b, ahu.port_a1)
        annotation (Line(
          points={{-36,0},{-40,0},{-40,0},{-40,-114},{0,-114}},
          color={0,127,255},
          thickness=0.5));
      connect(chiWSE.TCHWSupWSE, cooModCon.TCHWSupWSE)
        annotation (Line(
          points={{21,34},{148,34},{148,200},{-226,200},{-226,106},{-216,106}},
          color={0,0,127}));
      connect(cooLoaChi.y, chiStaCon.QTot)
        annotation (Line(
          points={{-299,140},{-172,140}},
          color={0,0,127}));
       for i in 1:numChi loop
        connect(pumCW[i].port_a, TCWSup.port_b)
          annotation (Line(
            points={{-50,110},{-50,140},{-42,140}},
            color={0,127,255},
            thickness=0.5));
       end for;
      connect(TCHWSupSet.y, cooModCon.TCHWSupSet)
        annotation (Line(
          points={{-239,160},{-222,160},{-222,118},{-216,118}},
          color={0,0,127}));
      connect(towTApp.y, cooModCon.TApp)
        annotation (Line(
          points={{-299,110},{-216,110}},
          color={0,0,127}));
      connect(weaBus.TWetBul.TWetBul, cooModCon.TWetBul)
        annotation (Line(
          points={{-328,-20},{-340,-20},{-340,200},{-224,200},{-224,114},{-216,114}},
          color={255,204,51},thickness=0.5));
      connect(TCHWRet.port_b, chiWSE.port_a2)
        annotation (Line(
          points={{80,0},{40,0},{40,24},{20,24}},
          color={0,127,255},
          thickness=0.5));
      connect(cooModCon.TCHWRetWSE, TCHWRet.T)
        annotation (Line(
          points={{-216,102},{-228,102},{-228,206},{152,206},{152,20},{90,20},{90,
              11}},
        color={0,0,127}));

      connect(cooModCon.y, chiStaCon.cooMod)
        annotation (Line(
          points={{-193,110},{-190,110},{-190,146},{-172,146}},
          color={255,127,0}));
      connect(cooModCon.y,intToBoo.u)
        annotation (Line(
          points={{-193,110},{-172,110}},
          color={255,127,0}));
      connect(TCHWSup.T, chiStaCon.TCHWSup)
        annotation (Line(
          points={{-26,11},{-26,18},{-182,18},{-182,134},{-172,134}},
          color={0,0,127}));
      connect(cooModCon.y, sigCha.u)
        annotation (Line(
          points={{-193,110},{-190,110},{-190,212},{156,212},{156,160},{178,160}},
          color={255,127,0}));
      connect(yVal5.y, chiWSE.yVal5) annotation (Line(points={{-139,40},{-84,40},{
              -84,33},{-1.6,33}}, color={0,0,127}));
      connect(yVal6.y, chiWSE.yVal6) annotation (Line(points={{-139,24},{-84,24},{
              -84,29.8},{-1.6,29.8}}, color={0,0,127}));
      connect(cooModCon.y, cooTowSpeCon.cooMod) annotation (Line(points={{-193,
              110},{-190,110},{-190,182.444},{-172,182.444}},
                                                         color={255,127,0}));
      connect(cooModCon.y, CWPumCon.cooMod) annotation (Line(points={{-193,110},{
              -190,110},{-190,75},{-174,75}}, color={255,127,0}));
      annotation (Diagram(coordinateSystem(preserveAspectRatio=false,
        extent={{-360,-200},{300,220}})),
      __Dymola_Commands(file=
      "modelica://Buildings/Resources/Scripts/Dymola/Applications/DataCenters/ChillerCooled/Examples/IntegratedPrimaryLoadSideEconomizer.mos"
      "Simulate and plot"),
       Documentation(info="<html>
<h4>System Configuration</h4>
<p>This example demonstrates the implementation of a chiller plant
with water-side economizer (WSE) to cool a data center.
The system is a primary-only chiller plant with two chillers and
an integrated WSE located on the load side.
The system schematics is as shown below.
</p>
<p align=\"center\">
<img alt=\"image\"
src=\"modelica://Buildings/Resources/Images/Applications/DataCenters/ChillerCooled/Examples/IntegratedPrimaryLoadSideEconomizerSystem.png\"/>
</p>
<h4>Control Logic</h4>
<p>This section describes the detailed control logic used in this chilled water plant system.
</p>
<h5>Cooling Mode Control</h5>
<p>
The chilled water system with integrated waterside economizer can run in three modes:
free cooling (FC) mode, partially mechanical cooling (PMC) mode and fully mechanical cooling (FMC) mode.
The detailed control logics about how to switch among these three cooling modes are described in
<a href=\"modelica://Buildings.Applications.DataCenters.ChillerCooled.Controls.CoolingMode\">
Buildings.Applications.DataCenters.ChillerCooled.Controls.CoolingMode</a>. Details on how the valves are operated
under different cooling modes are presented in
<a href=\"modelica://Buildings.Applications.DataCenters.ChillerCooled.Equipment.IntegratedPrimaryLoadSide\">
Buildings.Applications.DataCenters.ChillerCooled.Equipment.IntegratedPrimaryLoadSide</a>.
</p>
<h5>Chiller Staging Control </h5>
<p>
The staging sequence of multiple chillers are descibed as below:
</p>
<ul>
<li>
The chillers are all off when cooling mode is FC.
</li>
<li>
One chiller is commanded on when cooling mode is not FC.
</li>
<li>
Two chillers are commanded on when cooling mode is not FC and the cooling load served
by the chillers is larger than
a critical value.
</li>
</ul>
<p>
The detailed implementation is shown in
<a href=\"modelica://Buildings.Applications.DataCenters.ChillerCooled.Controls.ChillerStage\">
Buildings.Applications.DataCenters.ChillerCooled.Controls.ChillerStage</a>.
</p>
<h5>Pump Staging Control </h5>
<p>
For constant speed pumps, the number of running pumps equals to the number of running chillers.
</p>
<p>
For variable speed pumps, the number of running pumps is controlled by the speed signal and the mass flow rate.
Details are shown in
<a href=\"modelica://Buildings.Applications.DataCenters.ChillerCooled.Controls.VariableSpeedPumpStage\">
Buildings.Applications.DataCenters.ChillerCooled.Controls.VariableSpeedPumpStage</a>. The speed is
controlled by maintaining a fixed differential pressure between the outlet and inlet on the waterside
of the Computer Room Air Handler (CRAH).
</p>
<h5>Cooling Tower Speed Control</h5>
<p>
The control logic for cooling tower fan speed is described as:
</p>
<ul>
<li>
When in FMC mode, the cooling tower speed is controlled to maintain
the condenser water supply temperature (CWST) at its setpoint.
</li>
<li>
When in PMC mode, the fan is set to run at 100% speed to make the condenser water as cold as possible
and maximize the WSE output.
</li>
<li>
When in FC mode, the fan speed is modulated to maintain chilled water supply temperature at its setpoint.
</li>
</ul>
<p>
Detailed implementation of cooling tower speed control can be found in
<a href=\"modelica://Buildings.Applications.DataCenters.ChillerCooled.Controls.CoolingTowerSpeed\">
Buildings.Applications.DataCenters.ChillerCooled.Controls.CoolingTowerSpeed</a>.
</p>
<h5>Room temperature control</h5>
<p>
The room temperature is controlled by adjusting the fan speed of the AHU using a PI controller.
</p>
<p>
Note that for simplicity, the temperature and differential pressure reset control
are not implemented in this example.
</p>
</html>",     revisions="<html>
<ul>
<li>
December 1, 2017, by Yangyang Fu:<br/>
Removed redundant connection <code>connect(dpSet.y, pumSpe.u_s)</code>
</li>
<li>
July 30, 2017, by Yangyang Fu:<br/>
First implementation.
</li>
</ul>
</html>"),
    experiment(
          StartTime=0,
          StopTime=86400,
          Tolerance=1e-06));
    end IntegratedPrimaryLoadSideEconomizer;
  end Miscellaneous;

  package TFP
    extends Modelica.Icons.VariantsPackage;
    package Tests
      extends Modelica.Icons.ExamplesPackage;
      model basic_0
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
          annotation (Placement(transformation(extent={{-160,-40},{-140,-20}})));
        Modelica.Blocks.Sources.RealExpression realExpression(y=4 + 273.15)
          annotation (Placement(transformation(extent={{-250,-4},{-230,16}})));
        Modelica.Fluid.Sensors.TemperatureTwoPort THIn(redeclare package Medium =
              Modelica.Media.Water.ConstantPropertyLiquidWater)
          annotation (Placement(transformation(extent={{-230,30},{-210,50}})));
        Modelica.Fluid.Sensors.TemperatureTwoPort TT211(redeclare package
            Medium =
              Modelica.Media.Water.ConstantPropertyLiquidWater)
          annotation (Placement(transformation(extent={{-90,-20},{-70,0}})));
        Modelica.Fluid.Sensors.TemperatureTwoPort TCout(redeclare package
            Medium =
              Modelica.Media.Water.ConstantPropertyLiquidWater)
          annotation (Placement(transformation(extent={{-220,-100},{-240,-80}})));
        Modelica.Fluid.Sensors.TemperatureTwoPort TCIn(redeclare package Medium =
              Modelica.Media.Water.ConstantPropertyLiquidWater)
          annotation (Placement(transformation(extent={{-10,-60},{-30,-40}})));
        Modelica.Fluid.Valves.ValveLinear CV121(
          redeclare package Medium =
              Modelica.Media.Water.ConstantPropertyLiquidWater,
          dp_nominal=10000,
          m_flow_nominal=500) annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=180,
              origin={-110,-50})));
        Modelica.Fluid.Sensors.Pressure PT221(redeclare package Medium =
              Modelica.Media.Water.ConstantPropertyLiquidWater)
          annotation (Placement(transformation(extent={{-192,-18},{-172,2}})));
        Modelica.Fluid.Sensors.Pressure PT211(redeclare package Medium =
              Modelica.Media.Water.ConstantPropertyLiquidWater)
          annotation (Placement(transformation(extent={{-132,-18},{-112,2}})));
        Modelica.Fluid.Sensors.MassFlowRate FT121(redeclare package Medium =
              Modelica.Media.Water.ConstantPropertyLiquidWater) annotation (Placement(
              transformation(
              extent={{-10,-10},{10,10}},
              rotation=180,
              origin={-70,-50})));
        Controls.Continuous.LimPID conPID(
          controllerType=Modelica.Blocks.Types.SimpleController.PI,
          k=5,
          Ti=10,
          initType=Modelica.Blocks.Types.InitPID.NoInit) annotation (Placement(
              transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={-110,-100})));
        Modelica.Blocks.Sources.RealExpression Q_set(y=350/3.6)
          annotation (Placement(transformation(extent={{-150,-150},{-130,-130}})));
        Modelica.Blocks.Math.Add PDT(k2=-1)
          annotation (Placement(transformation(extent={{-60,160},{-40,180}})));
        Controls.Continuous.LimPID conPID1(
          controllerType=Modelica.Blocks.Types.SimpleController.PI,
          k=3,
          Ti=15,
          initType=Modelica.Blocks.Types.InitPID.NoInit) annotation (Placement(
              transformation(
              extent={{-10,-10},{10,10}},
              rotation=0,
              origin={-10,210})));
        Modelica.Blocks.Sources.RealExpression PDT_set(y=0.7)
          annotation (Placement(transformation(extent={{-60,200},{-40,220}})));
        Controls.Continuous.LimPID conPID2(
          controllerType=Modelica.Blocks.Types.SimpleController.PI,
          k=2.5,
          Ti=1.7,
          initType=Modelica.Blocks.Types.InitPID.NoInit) annotation (Placement(
              transformation(
              extent={{-10,-10},{10,10}},
              rotation=0,
              origin={-10,130})));
        Modelica.Blocks.Math.Add TDT(k2=-1)
          annotation (Placement(transformation(extent={{-60,80},{-40,100}})));
        Modelica.Blocks.Sources.RealExpression TDT_set(y=5 + 273.15)
          annotation (Placement(transformation(extent={{-60,120},{-40,140}})));
        Controls.Continuous.LimPID conPID3(
          controllerType=Modelica.Blocks.Types.SimpleController.PI,
          k=3,
          Ti=1,
          initType=Modelica.Blocks.Types.InitPID.NoInit) annotation (Placement(
              transformation(
              extent={{-10,-10},{10,10}},
              rotation=0,
              origin={-12,52})));
        Modelica.Blocks.Sources.RealExpression TT_set(y=30 + 273.15)
          annotation (Placement(transformation(extent={{-62,42},{-42,62}})));
        Modelica.Blocks.Math.MinMax minMax(nu=3)
          annotation (Placement(transformation(extent={{40,120},{60,140}})));
        Modelica.Fluid.Valves.ValveLinear CV211(
          redeclare package Medium =
              Modelica.Media.Water.ConstantPropertyLiquidWater,
          dp_nominal=10000,
          m_flow_nominal=800) annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=0,
              origin={-40,-10})));
        Modelica.Fluid.Valves.ValveDiscrete valveDiscrete(
          redeclare package Medium =
              Modelica.Media.Water.ConstantPropertyLiquidWater,
          dp_nominal=10000,
          m_flow_nominal=500,
          opening_min=0.000000000001)
          annotation (Placement(transformation(extent={{-180,-80},{-200,-100}})));
        Fluid.Movers.FlowControlled_dp fan(
          redeclare package Medium = Media.Water,
          m_flow_nominal=1000,
          redeclare Fluid.Movers.Data.Generic per,
          inputType=Buildings.Fluid.Types.InputType.Constant,
          constantHead=87000)
          annotation (Placement(transformation(extent={{-300,40},{-280,60}})));
        Modelica.Fluid.Sources.Boundary_pT pem_in(
          redeclare package Medium =
              Modelica.Media.Water.ConstantPropertyLiquidWater,
          use_T_in=true,
          nPorts=1)
          annotation (Placement(transformation(extent={{-340,40},{-320,60}})));
        Modelica.Blocks.Sources.CombiTimeTable pem_data(
          tableOnFile=true,
          tableName="tab1",
          fileName=ModelicaServices.ExternalReferences.loadResource(
              "modelica://Buildings/Data/froid/pem_froid.txt"),
          columns={2,3,4},
          extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic)
          annotation (Placement(transformation(extent={{-420,40},{-400,60}})));
        Modelica.Thermal.HeatTransfer.Celsius.ToKelvin toKelvin
          annotation (Placement(transformation(extent={{-380,40},{-360,60}})));
        Modelica.Fluid.Sources.FixedBoundary GF_out(redeclare package Medium =
              Modelica.Media.Water.ConstantPropertyLiquidWater, nPorts=1)
          annotation (Placement(transformation(extent={{-360,-100},{-340,-80}})));
        Modelica.Blocks.Sources.BooleanExpression booleanExpression(y=true)
          annotation (Placement(transformation(extent={{-220,-140},{-200,-120}})));
        Modelica.Blocks.Math.Add add2(k2=-1) annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=-90,
              origin={-72,-130})));
        Modelica.Blocks.Sources.RealExpression realExpression1(y=1) annotation (
            Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=-90,
              origin={-50,-90})));
      equation
        connect(realExpression.y,chi. TSet) annotation (Line(points={{-229,6},{
                -166,6},{-166,-21},{-162,-21}},
                                  color={0,0,127}));
        connect(THIn.port_b,chi. port_a1) annotation (Line(points={{-210,40},{
                -206,40},{-206,-24},{-160,-24}},
                                 color={0,127,255}));
        connect(chi.port_b1,TT211. port_a)
          annotation (Line(points={{-140,-24},{-90,-24},{-90,-10}},
                                                   color={0,127,255}));
        connect(chi.port_a2,CV121. port_b) annotation (Line(points={{-140,-36},{
                -130,-36},{-130,-50},{-120,-50}},
                                color={0,127,255}));
        connect(THIn.port_b,PT221. port) annotation (Line(points={{-210,40},{-206,
                40},{-206,-18},{-182,-18}},
                             color={0,127,255}));
        connect(chi.port_b1,PT211. port)
          annotation (Line(points={{-140,-24},{-132,-24},{-132,-18},{-122,-18}},
                                                   color={0,127,255}));
        connect(CV121.port_a,FT121. port_b)
          annotation (Line(points={{-100,-50},{-80,-50}},
                                                       color={0,127,255}));
        connect(FT121.port_a,TCIn. port_b)
          annotation (Line(points={{-60,-50},{-30,-50}},color={0,127,255}));
        connect(FT121.m_flow,conPID. u_m)
          annotation (Line(points={{-70,-61},{-70,-100},{-98,-100}},
                                                                color={0,0,127}));
        connect(Q_set.y,conPID. u_s)
          annotation (Line(points={{-129,-140},{-110,-140},{-110,-112}},
                                                                  color={0,0,127}));
        connect(conPID.y,CV121. opening)
          annotation (Line(points={{-110,-89},{-110,-58}},
                                                       color={0,0,127}));
        connect(PT211.p,PDT. u2) annotation (Line(points={{-111,-8},{-100,-8},{
                -100,164},{-62,164}},
                       color={0,0,127}));
        connect(PT221.p,PDT. u1) annotation (Line(points={{-171,-8},{-152,-8},{
                -152,176},{-62,176}},
                           color={0,0,127}));
        connect(PDT.y,conPID1. u_m)
          annotation (Line(points={{-39,170},{-10,170},{-10,198}}, color={0,0,127}));
        connect(PDT_set.y,conPID1. u_s)
          annotation (Line(points={{-39,210},{-22,210}}, color={0,0,127}));
        connect(TDT_set.y,conPID2. u_s)
          annotation (Line(points={{-39,130},{-22,130}}, color={0,0,127}));
        connect(TT211.T,TDT. u2)
          annotation (Line(points={{-80,1},{-80,84},{-62,84}}, color={0,0,127}));
        connect(TDT.y,conPID2. u_m)
          annotation (Line(points={{-39,90},{-10,90},{-10,118}},   color={0,0,127}));
        connect(TT_set.y,conPID3. u_s)
          annotation (Line(points={{-41,52},{-24,52}},   color={0,0,127}));
        connect(TT211.T,conPID3. u_m) annotation (Line(points={{-80,1},{-80,20},{
                -12,20},{-12,40}},
                            color={0,0,127}));
        connect(conPID2.y,minMax. u[1]) annotation (Line(points={{1,130},{20,130},
                {20,134.667},{40,134.667}},  color={0,0,127}));
        connect(conPID3.y,minMax. u[2]) annotation (Line(points={{-1,52},{20,52},
                {20,130},{40,130}},  color={0,0,127}));
        connect(conPID1.y,minMax. u[3]) annotation (Line(points={{1,210},{20,210},
                {20,125.333},{40,125.333}},  color={0,0,127}));
        connect(TT211.port_b,CV211. port_a)
          annotation (Line(points={{-70,-10},{-50,-10}},
                                                    color={0,127,255}));
        connect(minMax.yMax,CV211. opening) annotation (Line(points={{61,136},{70,
                136},{70,14},{-40,14},{-40,-2}},
                                             color={0,0,127}));
        connect(TCout.port_a,valveDiscrete. port_b)
          annotation (Line(points={{-220,-90},{-200,-90}},
                                                         color={0,127,255}));
        connect(valveDiscrete.port_a,chi. port_b2) annotation (Line(points={{-180,
                -90},{-174,-90},{-174,-36},{-160,-36}},
                                                   color={0,127,255}));
        connect(pem_in.ports[1], fan.port_a)
          annotation (Line(points={{-320,50},{-300,50}},   color={0,127,255}));
        connect(fan.port_b, THIn.port_a) annotation (Line(points={{-280,50},{-264,
                50},{-264,40},{-230,40}},         color={0,127,255}));
        connect(pem_data.y[1], toKelvin.Celsius)
          annotation (Line(points={{-399,50},{-382,50}},   color={0,0,127}));
        connect(toKelvin.Kelvin, pem_in.T_in) annotation (Line(points={{-359,50},
                {-351.5,50},{-351.5,54},{-342,54}},  color={0,0,127}));
        connect(TCout.port_b, GF_out.ports[1])
          annotation (Line(points={{-240,-90},{-290,-90},{-290,-90},{-340,-90}},
                                                             color={0,127,255}));
        connect(booleanExpression.y, valveDiscrete.open) annotation (Line(points={{-199,
                -130},{-190,-130},{-190,-98}},         color={255,0,255}));
        connect(THIn.T, TDT.u1) annotation (Line(points={{-220,51},{-220,96},{-62,
                96}}, color={0,0,127}));
        connect(conPID.y, add2.u2) annotation (Line(points={{-110,-89},{-110,-80},
                {-78,-80},{-78,-118}}, color={0,0,127}));
        connect(add2.u1, realExpression1.y) annotation (Line(points={{-66,-118},{
                -66,-110},{-50,-110},{-50,-101}}, color={0,0,127}));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-440,
                  -240},{440,240}})),                                  Diagram(
              coordinateSystem(preserveAspectRatio=false, extent={{-440,-240},{
                  440,240}})));
      end basic_0;

      model basic_1
        Fluid.Chillers.ElectricReformulatedEIR electricReformulatedEIR
          annotation (Placement(transformation(extent={{40,-20},{60,0}})));
        Modelica.Fluid.Sensors.TemperatureTwoPort PEM_TT_200(redeclare package
            Medium = Modelica.Media.Water.ConstantPropertyLiquidWater)
          annotation (Placement(transformation(extent={{-140,80},{-120,100}})));
        Fluid.Movers.FlowControlled_dp fan(
          redeclare package Medium = Media.Water,
          m_flow_nominal=1000,
          redeclare Fluid.Movers.Data.Generic per,
          inputType=Buildings.Fluid.Types.InputType.Constant,
          constantHead=87000)
          annotation (Placement(transformation(extent={{-198,80},{-178,100}})));
        Modelica.Fluid.Sources.Boundary_pT pem_in(
          redeclare package Medium =
              Modelica.Media.Water.ConstantPropertyLiquidWater,
          use_T_in=true,
          nPorts=1)
          annotation (Placement(transformation(extent={{-238,80},{-218,100}})));
        Modelica.Blocks.Sources.CombiTimeTable pem_data(
          tableOnFile=true,
          tableName="tab1",
          fileName=ModelicaServices.ExternalReferences.loadResource("modelica://Buildings/Data/froid/pem_froid.txt"),
          columns={2,3,4},
          extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic)
          annotation (Placement(transformation(extent={{-318,80},{-298,100}})));

        Modelica.Thermal.HeatTransfer.Celsius.ToKelvin toKelvin
          annotation (Placement(transformation(extent={{-278,80},{-258,100}})));
        Fluid.Sensors.TemperatureTwoPort senTem
          annotation (Placement(transformation(extent={{-276,-24},{-256,-4}})));
        Fluid.HeatExchangers.PlateHeatExchangerEffectivenessNTU hex(redeclare
            package Medium1 = Media.Water)
          annotation (Placement(transformation(extent={{-116,-10},{-96,10}})));
      equation
        connect(pem_in.ports[1],fan. port_a)
          annotation (Line(points={{-218,90},{-198,90}},   color={0,127,255}));
        connect(fan.port_b, PEM_TT_200.port_a)
          annotation (Line(points={{-178,90},{-140,90}}, color={0,127,255}));
        connect(pem_data.y[1],toKelvin. Celsius)
          annotation (Line(points={{-297,90},{-280,90}},   color={0,0,127}));
        connect(toKelvin.Kelvin,pem_in. T_in) annotation (Line(points={{-257,90},
                {-249.5,90},{-249.5,94},{-240,94}},  color={0,0,127}));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-200,
                  -200},{200,200}})), Diagram(coordinateSystem(
                preserveAspectRatio=false, extent={{-200,-200},{200,200}})));
      end basic_1;
    end Tests;
  end TFP;

  package heat_exchanger
    extends Modelica.Icons.VariantsPackage;

    package Tests
    extends Modelica.Icons.ExamplesPackage;
      model sea_water

      package Med_mode = Modelica.Media.Water.ConstantPropertyLiquidWater;
      replaceable package Med_buil = Buildings.Media.Water;
      replaceable package espoir =
            Buildings.Applications.DHC_Marseille.Media.Sea_Water;


        Fluid.HeatExchangers.PlateHeatExchangerEffectivenessNTU hex(
          redeclare replaceable package Medium1 = Med_mode,
          redeclare package Medium2 = espoir,
          m1_flow_nominal=50,
          m2_flow_nominal=50,
          dp1_nominal=10,
          dp2_nominal=12,
          configuration=Buildings.Fluid.Types.HeatExchangerConfiguration.CounterFlow,
          Q_flow_nominal=50,
          T_a1_nominal=303.15,
          T_a2_nominal=323.15)
          annotation (Placement(transformation(extent={{-20,0},{0,20}})));

        Fluid.Sources.MassFlowSource_T boundary(
          redeclare package Medium = Buildings.Media.Water,
          m_flow=60,
          nPorts=1)
          annotation (Placement(transformation(extent={{-100,40},{-80,60}})));
        Fluid.Sources.Boundary_pT bou(redeclare package Medium =
              Buildings.Media.Water,                                          nPorts=1)
          annotation (Placement(transformation(extent={{60,40},{40,60}})));
        Fluid.Sources.MassFlowSource_T boundary1(
          redeclare package Medium = Buildings.Media.Water,
          m_flow=50,
          nPorts=1) annotation (Placement(transformation(extent={{60,-20},{40,0}})));
        Fluid.Sources.Boundary_pT bou1(redeclare package Medium =
              Buildings.Media.Water,                                         nPorts=
             1) annotation (Placement(transformation(extent={{-100,-20},{-80,0}})));
      equation
        connect(boundary.ports[1], hex.port_a1) annotation (Line(points={{-80,50},{-50,
                50},{-50,16},{-20,16}}, color={0,127,255}));
        connect(hex.port_b1, bou.ports[1]) annotation (Line(points={{0,16},{20,16},{20,
                50},{40,50}}, color={0,127,255}));
        connect(bou1.ports[1], hex.port_b2) annotation (Line(points={{-80,-10},{-50,-10},
                {-50,4},{-20,4}}, color={0,127,255}));
        connect(hex.port_a2, boundary1.ports[1]) annotation (Line(points={{0,4},{22,4},
                {22,-10},{40,-10}}, color={0,127,255}));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
              coordinateSystem(preserveAspectRatio=false)));
      end sea_water;

      model sea_water_bis

      package Med_mode = Modelica.Media.Water.ConstantPropertyLiquidWater;
      replaceable package Med_buil = Buildings.Media.Water;


        Fluid.HeatExchangers.PlateHeatExchangerEffectivenessNTU hex(
          redeclare replaceable package Medium1 = Med_mode,
          redeclare package Medium2 =
              Buildings.Applications.DHC_Marseille.Media.Sea_Water,
          m1_flow_nominal=50,
          m2_flow_nominal=50,
          dp1_nominal=10,
          dp2_nominal=12,
          configuration=Buildings.Fluid.Types.HeatExchangerConfiguration.CounterFlow,
          Q_flow_nominal=50,
          T_a1_nominal=303.15,
          T_a2_nominal=323.15)
          annotation (Placement(transformation(extent={{-20,0},{0,20}})));

        Fluid.Sources.MassFlowSource_T boundary(
          redeclare package Medium = Buildings.Media.Water,
          m_flow=60,
          nPorts=1)
          annotation (Placement(transformation(extent={{-100,40},{-80,60}})));
        Fluid.Sources.Boundary_pT bou(redeclare package Medium =
              Buildings.Media.Water,                                          nPorts=1)
          annotation (Placement(transformation(extent={{60,40},{40,60}})));
        Fluid.Sources.MassFlowSource_T boundary1(
          redeclare package Medium = Buildings.Media.Water,
          m_flow=50,
          nPorts=1) annotation (Placement(transformation(extent={{60,-20},{40,0}})));
        Fluid.Sources.Boundary_pT bou1(redeclare package Medium =
              Buildings.Media.Water,                                         nPorts=
             1) annotation (Placement(transformation(extent={{-100,-20},{-80,0}})));
      equation
        connect(boundary.ports[1], hex.port_a1) annotation (Line(points={{-80,50},{-50,
                50},{-50,16},{-20,16}}, color={0,127,255}));
        connect(hex.port_b1, bou.ports[1]) annotation (Line(points={{0,16},{20,16},{20,
                50},{40,50}}, color={0,127,255}));
        connect(bou1.ports[1], hex.port_b2) annotation (Line(points={{-80,-10},{-50,-10},
                {-50,4},{-20,4}}, color={0,127,255}));
        connect(hex.port_a2, boundary1.ports[1]) annotation (Line(points={{0,4},{22,4},
                {22,-10},{40,-10}}, color={0,127,255}));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
              coordinateSystem(preserveAspectRatio=false)));
      end sea_water_bis;
    end Tests;
  end heat_exchanger;

  package Media "Package with medium models"
  extends Modelica.Icons.Package;
    package Sea_Water
      "Package with model for sea water with constant density"
       extends Modelica.Media.Water.ConstantPropertyLiquidWater(
       cp_const=3994,
       d_const= 1024.8,
         final cv_const=cp_const,
         p_default=300000,
         reference_p=300000,
         reference_T=273.15,
         reference_X={1},
         AbsolutePressure(start=p_default),
         Temperature(start=T_default),
         Density(start=d_const));
      // cp_const and cv_const have been made final because the model sets u=h.
      extends Modelica.Icons.Package;

      redeclare model BaseProperties "Base properties"
        Temperature T(stateSelect=
          if preferredMediumStates then StateSelect.prefer else StateSelect.default)
          "Temperature of medium";
        InputAbsolutePressure p "Absolute pressure of medium";
        InputMassFraction[nXi] Xi=fill(0, 0)
          "Structurally independent mass fractions";
        InputSpecificEnthalpy h "Specific enthalpy of medium";
        Modelica.SIunits.SpecificInternalEnergy u
          "Specific internal energy of medium";
        Modelica.SIunits.Density d=d_const "Density of medium";
        Modelica.SIunits.MassFraction[nX] X={1}
          "Mass fractions (= (component mass)/total mass  m_i/m)";
        final Modelica.SIunits.SpecificHeatCapacity R=0
          "Gas constant (of mixture if applicable)";
        final Modelica.SIunits.MolarMass MM=MM_const
          "Molar mass (of mixture or single fluid)";
        ThermodynamicState state
          "Thermodynamic state record for optional functions";
        parameter Boolean preferredMediumStates=false
          "= true if StateSelect.prefer shall be used for the independent property variables of the medium"
          annotation(Evaluate=true, Dialog(tab="Advanced"));
        final parameter Boolean standardOrderComponents=true
          "If true, and reducedX = true, the last element of X will be computed from the other ones";
        Modelica.SIunits.Conversions.NonSIunits.Temperature_degC T_degC=
            Modelica.SIunits.Conversions.to_degC(T)
          "Temperature of medium in [degC]";
        Modelica.SIunits.Conversions.NonSIunits.Pressure_bar p_bar=
            Modelica.SIunits.Conversions.to_bar(p)
          "Absolute pressure of medium in [bar]";

        // Local connector definition, used for equation balancing check
        connector InputAbsolutePressure = input
            Modelica.SIunits.AbsolutePressure
          "Pressure as input signal connector";
        connector InputSpecificEnthalpy = input
            Modelica.SIunits.SpecificEnthalpy
          "Specific enthalpy as input signal connector";
        connector InputMassFraction = input Modelica.SIunits.MassFraction
          "Mass fraction as input signal connector";

      equation
        assert(T >= T_min,
                       "
  In "     + getInstanceName() + ": Temperature T = " + String(T) + " K exceeded its minimum allowed value of " +
      String(T_min-273.15) + " degC (" + String(T_min) + " Kelvin)
as required from medium model \""     + mediumName + "\".");
        assert(T <= T_max,
                       "
  In "     + getInstanceName() + ": Temperature T = " + String(T) + " K exceeded its maximum allowed value of " +
      String(T_max-273.15) + " degC (" + String(T_max) + " Kelvin)
as required from medium model \""     + mediumName + "\".");

        h = cp_const*(T-reference_T);
        u = h;
        state.T = T;
        state.p = p;
        annotation(Documentation(info="<html>
    <p>
    This base properties model is identical to
    <a href=\"modelica://Modelica.Media.Water.ConstantPropertyLiquidWater\">
    Modelica.Media.Water.ConstantPropertyLiquidWater</a>,
    except that the equation
    <code>u = cv_const*(T - reference_T)</code>
    has been replaced by <code>u=h</code> because
    <code>cp_const=cv_const</code>.
    </p>
</html>"));
      end BaseProperties;

    function enthalpyOfLiquid "Return the specific enthalpy of liquid"
      extends Modelica.Icons.Function;
      input Modelica.SIunits.Temperature T "Temperature";
      output Modelica.SIunits.SpecificEnthalpy h "Specific enthalpy";
    algorithm
      h := cp_const*(T-reference_T);
    annotation (
      smoothOrder=5,
      Inline=true,
    Documentation(info="<html>
<p>
Enthalpy of the water.
</p>
</html>",     revisions="<html>
<ul>
<li>
October 16, 2014 by Michael Wetter:<br/>
First implementation.
This function is used by
<a href=\"modelica://Buildings.Fluid.MixingVolumes.MixingVolumeMoistAir\">
Buildings.Fluid.MixingVolumes.MixingVolumeMoistAir</a>.
</li>
</ul>
</html>"));
    end enthalpyOfLiquid;
      annotation(preferredView="info", Documentation(info="<html>
<p>
This medium package models liquid water.
</p>
<p>
The mass density is computed using a constant value of <i>995.586</i> kg/s.
For a medium model in which the density is a function of temperature, use
<a href=\"modelica://Buildings.Media.Specialized.Water.TemperatureDependentDensity\">
Buildings.Media.Specialized.Water.TemperatureDependentDensity</a> which may have considerably higher computing time.
</p>
<p>
For the specific heat capacities at constant pressure and at constant volume,
a constant value of <i>4184</i> J/(kg K), which corresponds to <i>20</i>&deg;C
is used.
The figure below shows the relative error of the specific heat capacity that
is introduced by this simplification.
</p>
<p align=\"center\">
<img src=\"modelica://Buildings/Resources/Images/Media/Water/plotCp.png\" border=\"1\"
alt=\"Relative variation of specific heat capacity with temperature\"/>
</p>
<p>
The enthalpy is computed using the convention that <i>h=0</i>
if <i>T=0</i> &deg;C.
</p>
<h4>Limitations</h4>
<p>
Density, specific heat capacity, thermal conductivity and viscosity are constant.
Water is modeled as an incompressible liquid.
There are no phase changes.
</p>
</html>",     revisions="<html>
<ul>
<li>
October 26, 2018, by Filip Jorissen and Michael Wetter:<br/>
Now printing different messages if temperature is above or below its limit,
and adding instance name as JModelica does not print the full instance name in the assertion.
This is for
<a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/1045\">#1045</a>.
</li>
<li>
June 6, 2015, by Michael Wetter:<br/>
Set <code>AbsolutePressure(start=p_default)</code> to avoid
a translation error if
<a href=\"modelica://Buildings.Fluid.Sources.Examples.TraceSubstancesFlowSource\">
Buildings.Fluid.Sources.Examples.TraceSubstancesFlowSource</a>
(if used with water instead of air)
is translated in pedantic mode in Dymola 2016.
The reason is that pressures use <code>Medium.p_default</code> as start values,
but
<a href=\"modelica://Modelica.Media.Interfaces.Types\">
Modelica.Media.Interfaces.Types</a>
sets a default value of <i>1E-5</i>.
A similar change has been done for pressure and density.
This fixes
<a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/266\">#266</a>.
</li>
<li>
June 6, 2015, by Michael Wetter:<br/>
Changed type of <code>BaseProperties.T</code> from
<code>Modelica.SIunits.Temperature</code> to <code>Temperature</code>.
Otherwise, it has a different start value than <code>Medium.T</code>, which
causes an error if
<a href=\"Buildings.Media.Examples.WaterProperties\">
Buildings.Media.Examples.WaterProperties</a>
is translated in pedantic mode.
This fixes
<a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/266\">#266</a>.
</li>
<li>
June 5, 2015, by Michael Wetter:<br/>
Added <code>stateSelect</code> attribute in <code>BaseProperties.T</code>
to allow correct use of <code>preferredMediumState</code> as
described in
<a href=\"modelica://Modelica.Media.Interfaces.PartialMedium\">
Modelica.Media.Interfaces.PartialMedium</a>,
and set <code>preferredMediumState=false</code>
to keep the same states as were used before.
This is for
<a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/260\">#260</a>.
</li>
<li>
June 5, 2015, by Michael Wetter:<br/>
Removed <code>ThermodynamicState</code> declaration as this lead to
the error
\"Attempting to redeclare record ThermodynamicState when the original was not replaceable.\"
in Dymola 2016 using the pedantic model check.
</li>
<li>
May 1, 2015, by Michael Wetter:<br/>
Added <code>Inline=true</code> for
<a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/227\">
issue 227</a>.
</li>
<li>
February 25, 2015, by Michael Wetter:<br/>
Removed <code>stateSelect</code> attribute on pressure as this caused
<a href=\"modelica://Buildings.Examples.Tutorial.SpaceCooling.System3\">
Buildings.Examples.Tutorial.SpaceCooling.System3</a>
to fail with the error message
\"differentiated if-then-else was not continuous\".
</li>
<li>
October 15, 2014, by Michael Wetter:<br/>
Reimplemented media based on
<a href=\"https://github.com/ibpsa/modelica-ibpsa/blob/446aa83720884052476ad6d6d4f90a6a29bb8ec9/Buildings/Media/Water.mo\">446aa83</a>.
</li>
<li>
November 15, 2013, by Michael Wetter:<br/>
Complete new reimplementation because the previous version
had the option to add a compressibility to the medium, which
has never been used.
</li>
</ul>
</html>"),
        Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
            graphics={
            Polygon(
              points={{16,-28},{32,-42},{26,-48},{10,-36},{16,-28}},
              lineColor={95,95,95},
              fillPattern=FillPattern.Sphere,
              fillColor={95,95,95}),
            Polygon(
              points={{10,34},{26,44},{30,36},{14,26},{10,34}},
              lineColor={95,95,95},
              fillPattern=FillPattern.Sphere,
              fillColor={95,95,95}),
            Ellipse(
              extent={{-82,52},{24,-54}},
              lineColor={95,95,95},
              fillPattern=FillPattern.Sphere,
              fillColor={0,0,0}),
            Ellipse(
              extent={{22,82},{80,24}},
              lineColor={0,0,0},
              fillPattern=FillPattern.Sphere,
              fillColor={95,95,95}),
            Ellipse(
              extent={{20,-30},{78,-88}},
              lineColor={0,0,0},
              fillPattern=FillPattern.Sphere,
              fillColor={95,95,95})}));
    end Sea_Water;

    package Water_b "Package with model for liquid water with constant density"
       extends Modelica.Media.Water.ConstantPropertyLiquidWater(
         final cv_const=cp_const,
         p_default=300000,
         reference_p=300000,
         reference_T=273.15,
         reference_X={1},
         AbsolutePressure(start=p_default),
         Temperature(start=T_default),
         Density(start=d_const));
      // cp_const and cv_const have been made final because the model sets u=h.
      extends Modelica.Icons.Package;

      redeclare model BaseProperties "Base properties"
        Temperature T(stateSelect=
          if preferredMediumStates then StateSelect.prefer else StateSelect.default)
          "Temperature of medium";
        InputAbsolutePressure p "Absolute pressure of medium";
        InputMassFraction[nXi] Xi=fill(0, 0)
          "Structurally independent mass fractions";
        InputSpecificEnthalpy h "Specific enthalpy of medium";
        Modelica.SIunits.SpecificInternalEnergy u
          "Specific internal energy of medium";
        Modelica.SIunits.Density d=d_const "Density of medium";
        Modelica.SIunits.MassFraction[nX] X={1}
          "Mass fractions (= (component mass)/total mass  m_i/m)";
        final Modelica.SIunits.SpecificHeatCapacity R=0
          "Gas constant (of mixture if applicable)";
        final Modelica.SIunits.MolarMass MM=MM_const
          "Molar mass (of mixture or single fluid)";
        ThermodynamicState state
          "Thermodynamic state record for optional functions";
        parameter Boolean preferredMediumStates=false
          "= true if StateSelect.prefer shall be used for the independent property variables of the medium"
          annotation(Evaluate=true, Dialog(tab="Advanced"));
        final parameter Boolean standardOrderComponents=true
          "If true, and reducedX = true, the last element of X will be computed from the other ones";
        Modelica.SIunits.Conversions.NonSIunits.Temperature_degC T_degC=
            Modelica.SIunits.Conversions.to_degC(T)
          "Temperature of medium in [degC]";
        Modelica.SIunits.Conversions.NonSIunits.Pressure_bar p_bar=
            Modelica.SIunits.Conversions.to_bar(p)
          "Absolute pressure of medium in [bar]";

        // Local connector definition, used for equation balancing check
        connector InputAbsolutePressure = input
            Modelica.SIunits.AbsolutePressure
          "Pressure as input signal connector";
        connector InputSpecificEnthalpy = input
            Modelica.SIunits.SpecificEnthalpy
          "Specific enthalpy as input signal connector";
        connector InputMassFraction = input Modelica.SIunits.MassFraction
          "Mass fraction as input signal connector";

      equation
        assert(T >= T_min,
                       "
  In "     + getInstanceName() + ": Temperature T = " + String(T) + " K exceeded its minimum allowed value of " +
      String(T_min-273.15) + " degC (" + String(T_min) + " Kelvin)
as required from medium model \""     + mediumName + "\".");
        assert(T <= T_max,
                       "
  In "     + getInstanceName() + ": Temperature T = " + String(T) + " K exceeded its maximum allowed value of " +
      String(T_max-273.15) + " degC (" + String(T_max) + " Kelvin)
as required from medium model \""     + mediumName + "\".");

        h = cp_const*(T-reference_T);
        u = h;
        state.T = T;
        state.p = p;
        annotation(Documentation(info="<html>
    <p>
    This base properties model is identical to
    <a href=\"modelica://Modelica.Media.Water.ConstantPropertyLiquidWater\">
    Modelica.Media.Water.ConstantPropertyLiquidWater</a>,
    except that the equation
    <code>u = cv_const*(T - reference_T)</code>
    has been replaced by <code>u=h</code> because
    <code>cp_const=cv_const</code>.
    </p>
</html>"));
      end BaseProperties;

    function enthalpyOfLiquid "Return the specific enthalpy of liquid"
      extends Modelica.Icons.Function;
      input Modelica.SIunits.Temperature T "Temperature";
      output Modelica.SIunits.SpecificEnthalpy h "Specific enthalpy";
    algorithm
      h := cp_const*(T-reference_T);
    annotation (
      smoothOrder=5,
      Inline=true,
    Documentation(info="<html>
<p>
Enthalpy of the water.
</p>
</html>",     revisions="<html>
<ul>
<li>
October 16, 2014 by Michael Wetter:<br/>
First implementation.
This function is used by
<a href=\"modelica://Buildings.Fluid.MixingVolumes.MixingVolumeMoistAir\">
Buildings.Fluid.MixingVolumes.MixingVolumeMoistAir</a>.
</li>
</ul>
</html>"));
    end enthalpyOfLiquid;
      annotation(preferredView="info", Documentation(info="<html>
<p>
This medium package models liquid water.
</p>
<p>
The mass density is computed using a constant value of <i>995.586</i> kg/s.
For a medium model in which the density is a function of temperature, use
<a href=\"modelica://Buildings.Media.Specialized.Water.TemperatureDependentDensity\">
Buildings.Media.Specialized.Water.TemperatureDependentDensity</a> which may have considerably higher computing time.
</p>
<p>
For the specific heat capacities at constant pressure and at constant volume,
a constant value of <i>4184</i> J/(kg K), which corresponds to <i>20</i>&deg;C
is used.
The figure below shows the relative error of the specific heat capacity that
is introduced by this simplification.
</p>
<p align=\"center\">
<img src=\"modelica://Buildings/Resources/Images/Media/Water/plotCp.png\" border=\"1\"
alt=\"Relative variation of specific heat capacity with temperature\"/>
</p>
<p>
The enthalpy is computed using the convention that <i>h=0</i>
if <i>T=0</i> &deg;C.
</p>
<h4>Limitations</h4>
<p>
Density, specific heat capacity, thermal conductivity and viscosity are constant.
Water is modeled as an incompressible liquid.
There are no phase changes.
</p>
</html>",     revisions="<html>
<ul>
<li>
October 26, 2018, by Filip Jorissen and Michael Wetter:<br/>
Now printing different messages if temperature is above or below its limit,
and adding instance name as JModelica does not print the full instance name in the assertion.
This is for
<a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/1045\">#1045</a>.
</li>
<li>
June 6, 2015, by Michael Wetter:<br/>
Set <code>AbsolutePressure(start=p_default)</code> to avoid
a translation error if
<a href=\"modelica://Buildings.Fluid.Sources.Examples.TraceSubstancesFlowSource\">
Buildings.Fluid.Sources.Examples.TraceSubstancesFlowSource</a>
(if used with water instead of air)
is translated in pedantic mode in Dymola 2016.
The reason is that pressures use <code>Medium.p_default</code> as start values,
but
<a href=\"modelica://Modelica.Media.Interfaces.Types\">
Modelica.Media.Interfaces.Types</a>
sets a default value of <i>1E-5</i>.
A similar change has been done for pressure and density.
This fixes
<a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/266\">#266</a>.
</li>
<li>
June 6, 2015, by Michael Wetter:<br/>
Changed type of <code>BaseProperties.T</code> from
<code>Modelica.SIunits.Temperature</code> to <code>Temperature</code>.
Otherwise, it has a different start value than <code>Medium.T</code>, which
causes an error if
<a href=\"Buildings.Media.Examples.WaterProperties\">
Buildings.Media.Examples.WaterProperties</a>
is translated in pedantic mode.
This fixes
<a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/266\">#266</a>.
</li>
<li>
June 5, 2015, by Michael Wetter:<br/>
Added <code>stateSelect</code> attribute in <code>BaseProperties.T</code>
to allow correct use of <code>preferredMediumState</code> as
described in
<a href=\"modelica://Modelica.Media.Interfaces.PartialMedium\">
Modelica.Media.Interfaces.PartialMedium</a>,
and set <code>preferredMediumState=false</code>
to keep the same states as were used before.
This is for
<a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/260\">#260</a>.
</li>
<li>
June 5, 2015, by Michael Wetter:<br/>
Removed <code>ThermodynamicState</code> declaration as this lead to
the error
\"Attempting to redeclare record ThermodynamicState when the original was not replaceable.\"
in Dymola 2016 using the pedantic model check.
</li>
<li>
May 1, 2015, by Michael Wetter:<br/>
Added <code>Inline=true</code> for
<a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/227\">
issue 227</a>.
</li>
<li>
February 25, 2015, by Michael Wetter:<br/>
Removed <code>stateSelect</code> attribute on pressure as this caused
<a href=\"modelica://Buildings.Examples.Tutorial.SpaceCooling.System3\">
Buildings.Examples.Tutorial.SpaceCooling.System3</a>
to fail with the error message
\"differentiated if-then-else was not continuous\".
</li>
<li>
October 15, 2014, by Michael Wetter:<br/>
Reimplemented media based on
<a href=\"https://github.com/ibpsa/modelica-ibpsa/blob/446aa83720884052476ad6d6d4f90a6a29bb8ec9/Buildings/Media/Water.mo\">446aa83</a>.
</li>
<li>
November 15, 2013, by Michael Wetter:<br/>
Complete new reimplementation because the previous version
had the option to add a compressibility to the medium, which
has never been used.
</li>
</ul>
</html>"),
        Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
            graphics={
            Polygon(
              points={{16,-28},{32,-42},{26,-48},{10,-36},{16,-28}},
              lineColor={95,95,95},
              fillPattern=FillPattern.Sphere,
              fillColor={95,95,95}),
            Polygon(
              points={{10,34},{26,44},{30,36},{14,26},{10,34}},
              lineColor={95,95,95},
              fillPattern=FillPattern.Sphere,
              fillColor={95,95,95}),
            Ellipse(
              extent={{-82,52},{24,-54}},
              lineColor={95,95,95},
              fillPattern=FillPattern.Sphere,
              fillColor={0,0,0}),
            Ellipse(
              extent={{22,82},{80,24}},
              lineColor={0,0,0},
              fillPattern=FillPattern.Sphere,
              fillColor={95,95,95}),
            Ellipse(
              extent={{20,-30},{78,-88}},
              lineColor={0,0,0},
              fillPattern=FillPattern.Sphere,
              fillColor={95,95,95})}));
    end Water_b;


  end Media;
end DHC_Marseille;
