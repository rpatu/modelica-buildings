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
        Modelica.Fluid.Sensors.TemperatureTwoPort THIn(redeclare package Medium
            = Modelica.Media.Water.ConstantPropertyLiquidWater)
          annotation (Placement(transformation(extent={{-230,30},{-210,50}})));
        Modelica.Fluid.Sensors.TemperatureTwoPort TT211(redeclare package
            Medium =
              Modelica.Media.Water.ConstantPropertyLiquidWater)
          annotation (Placement(transformation(extent={{-90,-20},{-70,0}})));
        Modelica.Fluid.Sensors.TemperatureTwoPort TCout(redeclare package
            Medium =
              Modelica.Media.Water.ConstantPropertyLiquidWater)
          annotation (Placement(transformation(extent={{-220,-100},{-240,-80}})));
        Modelica.Fluid.Sensors.TemperatureTwoPort TCIn(redeclare package Medium
            = Modelica.Media.Water.ConstantPropertyLiquidWater)
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
        connect(conPID2.y,minMax. u[1]) annotation (Line(points={{1,130},{20,
                130},{20,134.667},{40,134.667}},
                                             color={0,0,127}));
        connect(conPID3.y,minMax. u[2]) annotation (Line(points={{-1,52},{20,52},
                {20,130},{40,130}},  color={0,0,127}));
        connect(conPID1.y,minMax. u[3]) annotation (Line(points={{1,210},{20,
                210},{20,125.333},{40,125.333}},
                                             color={0,0,127}));
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
    end Tests;
  end TFP;
end DHC_Marseille;
