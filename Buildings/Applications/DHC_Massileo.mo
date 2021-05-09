within Buildings.Applications;
package DHC_Massileo
  extends Modelica.Icons.VariantsPackage;
  package Controls
    extends Modelica.Icons.VariantsPackage;
    package TFP
      extends Modelica.Icons.VariantsPackage;
      model PID_Valve_cond

        Real T_cons_hot_min;
        Real T_cons_hot_max;
        Modelica.Blocks.Math.Min min
          annotation (Placement(transformation(extent={{-20,-10},{0,10}})));
        Modelica.Blocks.Sources.RealExpression limit_hot_max(y=T_cons_hot_max)
          annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
        Buildings.Controls.Continuous.LimPID PID_Tmax(
          controllerType=Modelica.Blocks.Types.SimpleController.PI,
          k=0.1,
          Ti=120,
          initType=Modelica.Blocks.Types.InitPID.NoInit,
          reverseActing=false) annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=0,
              origin={-60,90})));
        Modelica.Blocks.Sources.RealExpression limit_hot_min(y=T_cons_hot_min)
          annotation (Placement(transformation(extent={{-100,-60},{-80,-40}})));
        Buildings.Controls.Continuous.LimPID PID_Tmin(
          controllerType=Modelica.Blocks.Types.SimpleController.PI,
          k=0.1,
          Ti=120,
          initType=Modelica.Blocks.Types.InitPID.NoInit,
          reverseActing=false) annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=0,
              origin={-60,-50})));
        DHC_Thassalia.Controls_a.opposite opposite1
          annotation (Placement(transformation(extent={{70,-60},{90,-40}})));
        Modelica.Blocks.Interfaces.RealInput TFP_TT511
          annotation (Placement(transformation(extent={{-140,40},{-100,80}})));
        Modelica.Blocks.Interfaces.RealInput TFP_TT521
          annotation (Placement(transformation(extent={{-140,-100},{-100,-60}})));
        Modelica.Blocks.Interfaces.RealOutput CV522
          annotation (Placement(transformation(extent={{100,40},{120,60}})));
        Modelica.Blocks.Interfaces.RealOutput CV521
          annotation (Placement(transformation(extent={{100,-60},{120,-40}})));
        Modelica.Blocks.Interfaces.IntegerInput mode
          annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
      equation
          if mode <=1 then
          T_cons_hot_min = 30+273.15;
        elseif mode == 2 then
          T_cons_hot_min = 41+273.15;
        else
          T_cons_hot_min = 55+273.15;
        end if;

        if mode <=1 then
          T_cons_hot_max = 37+273.15;
        elseif mode == 2 then
          T_cons_hot_max = 48+273.15;
        else
          T_cons_hot_max = 62+273.15;
        end if;

        connect(limit_hot_min.y, PID_Tmin.u_s)
          annotation (Line(points={{-79,-50},{-72,-50}}, color={0,0,127}));
        connect(TFP_TT521, PID_Tmin.u_m) annotation (Line(points={{-120,-80},{
                -60,-80},{-60,-62}},
                                 color={0,0,127}));
        connect(CV521, opposite1.y)
          annotation (Line(points={{110,-50},{91,-50}}, color={0,0,127}));
        connect(limit_hot_max.y, PID_Tmax.u_s)
          annotation (Line(points={{-79,90},{-72,90}}, color={0,0,127}));
        connect(TFP_TT511, PID_Tmax.u_m) annotation (Line(points={{-120,60},{
                -60,60},{-60,78}},
                               color={0,0,127}));
        connect(PID_Tmax.y, min.u1) annotation (Line(points={{-49,90},{-40,90},
                {-40,6},{-22,6}},
                            color={0,0,127}));
        connect(PID_Tmin.y, min.u2) annotation (Line(points={{-49,-50},{-40,-50},
                {-40,-6},{-22,-6}},
                                 color={0,0,127}));
        connect(min.y, opposite1.u) annotation (Line(points={{1,0},{34,0},{34,-50},{68,
                -50}}, color={0,0,127}));
        connect(min.y, CV522)
          annotation (Line(points={{1,0},{34,0},{34,50},{110,50}}, color={0,0,127}));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
                                      Rectangle(
              extent={{-100,-100},{100,100}},
              lineColor={0,0,127},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
              Rectangle(
                extent={{-6,-20},{66,-66}},
                lineColor={255,255,255},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid),
              Text(
                visible=(controllerType == Modelica.Blocks.Types.SimpleController.PI),
                extent={{-28,-22},{72,-62}},
                lineColor={0,0,0},
                textString="PI",
                fillPattern=FillPattern.Solid,
                fillColor={175,175,175}),
              Polygon(
                points={{-80,90},{-88,68},{-72,68},{-80,90}},
                lineColor={192,192,192},
                fillColor={192,192,192},
                fillPattern=FillPattern.Solid),
              Line(points={{-80,78},{-80,-90}}, color={192,192,192}),
              Line(points={{-80,-80},{-80,-20},{30,60},{80,60}}, color={0,0,127}),
              Line(points={{-90,-80},{82,-80}}, color={192,192,192}),
              Polygon(
                points={{90,-80},{68,-72},{68,-88},{90,-80}},
                lineColor={192,192,192},
                fillColor={192,192,192},
                fillPattern=FillPattern.Solid),
              Line(
                visible=strict,
                points={{30,60},{81,60}},
                color={255,0,0},
                smooth=Smooth.None)}),                                 Diagram(
              coordinateSystem(preserveAspectRatio=false)),
          experiment(__Dymola_Algorithm="Dassl"));
      end PID_Valve_cond;

      model PID_Valve_evap

        parameter Real T_cons_cold = 14+273.15;
        Real T_cons_hot;
        Modelica.Blocks.Math.Max max
          annotation (Placement(transformation(extent={{-80,60},{-60,80}})));
        Modelica.Blocks.Math.Min min
          annotation (Placement(transformation(extent={{-40,40},{-20,60}})));
        Modelica.Blocks.Sources.RealExpression limit_cold(y=T_cons_cold)
          annotation (Placement(transformation(extent={{-80,30},{-60,50}})));
        Buildings.Controls.Continuous.LimPID PID_Tevap(
          controllerType=Modelica.Blocks.Types.SimpleController.PI,
          k=0.1,
          Ti=15,
          initType=Modelica.Blocks.Types.InitPID.NoInit,
          reverseActing=true) annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=0,
              origin={0,50})));
        Buildings.Controls.Continuous.LimPID PID_Tcond(
          controllerType=Modelica.Blocks.Types.SimpleController.PI,
          k=0.1,
          Ti=15,
          initType=Modelica.Blocks.Types.InitPID.NoInit,
          reverseActing=true) annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=0,
              origin={0,-40})));
        DHC_Thassalia.Controls_a.opposite opposite1
          annotation (Placement(transformation(extent={{70,-60},{90,-40}})));
        Modelica.Blocks.Interfaces.RealInput PEM_TT200
          annotation (Placement(transformation(extent={{-140,60},{-100,100}})));
        Modelica.Blocks.Interfaces.RealInput DEG_TT121
          annotation (Placement(transformation(extent={{-140,20},{-100,60}})));
        Modelica.Blocks.Interfaces.RealInput TFP_TT121
          annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
        Modelica.Blocks.Interfaces.RealInput TFP_TT511
          annotation (Placement(transformation(extent={{-140,-100},{-100,-60}})));
        Modelica.Blocks.Math.Min min1
          annotation (Placement(transformation(extent={{30,-10},{50,10}})));
        Modelica.Blocks.Interfaces.RealOutput CV122
          annotation (Placement(transformation(extent={{100,40},{120,60}})));
        Modelica.Blocks.Interfaces.RealOutput CV121
          annotation (Placement(transformation(extent={{100,-60},{120,-40}})));
        Modelica.Blocks.Interfaces.IntegerInput mode
          annotation (Placement(transformation(extent={{-140,-60},{-100,-20}})));
        Modelica.Blocks.Sources.RealExpression realExpression(y=T_cons_hot)
          annotation (Placement(transformation(extent={{-60,-50},{-40,-30}})));
      equation
        if mode <=1 then
          T_cons_hot = 35+273.15;
        elseif mode == 2 then
          T_cons_hot = 46+273.15;
        else
          T_cons_hot = 60+273.15;
        end if;

        connect(PEM_TT200, max.u1) annotation (Line(points={{-120,80},{-90,80},{-90,
                76},{-82,76}},
                           color={0,0,127}));
        connect(max.u2,DEG_TT121)  annotation (Line(points={{-82,64},{-90,64},{-90,40},
                {-120,40}}, color={0,0,127}));
        connect(limit_cold.y, min.u2) annotation (Line(points={{-59,40},{-50,40},{-50,
                44},{-42,44}}, color={0,0,127}));
        connect(max.y, min.u1) annotation (Line(points={{-59,70},{-50,70},{-50,56},{
                -42,56}},
                      color={0,0,127}));
        connect(TFP_TT121, PID_Tevap.u_m) annotation (Line(points={{-120,0},{0,0},{0,38}},
                                                color={0,0,127}));
        connect(min.y, PID_Tevap.u_s)
          annotation (Line(points={{-19,50},{-12,50}}, color={0,0,127}));
        connect(TFP_TT511, PID_Tcond.u_m) annotation (Line(points={{-120,-80},{0,-80},
                {0,-52}},        color={0,0,127}));
        connect(PID_Tcond.y, min1.u2) annotation (Line(points={{11,-40},{20,-40},{20,-6},
                {28,-6}},         color={0,0,127}));
        connect(PID_Tevap.y, min1.u1) annotation (Line(points={{11,50},{20,50},
                {20,6},{28,6}}, color={0,0,127}));
        connect(min1.y, CV122) annotation (Line(points={{51,0},{60,0},{60,50},{
                110,50}}, color={0,0,127}));
        connect(min1.y, opposite1.u) annotation (Line(points={{51,0},{60,0},{60,-50},
                {68,-50}}, color={0,0,127}));
        connect(CV121, opposite1.y)
          annotation (Line(points={{110,-50},{91,-50}}, color={0,0,127}));
        connect(realExpression.y, PID_Tcond.u_s)
          annotation (Line(points={{-39,-40},{-12,-40}}, color={0,0,127}));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
                                      Rectangle(
              extent={{-100,-100},{100,100}},
              lineColor={0,0,127},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
              Rectangle(
                extent={{-6,-20},{66,-66}},
                lineColor={255,255,255},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid),
              Text(
                visible=(controllerType == Modelica.Blocks.Types.SimpleController.PI),
                extent={{-28,-22},{72,-62}},
                lineColor={0,0,0},
                textString="PI",
                fillPattern=FillPattern.Solid,
                fillColor={175,175,175}),
              Polygon(
                points={{-80,90},{-88,68},{-72,68},{-80,90}},
                lineColor={192,192,192},
                fillColor={192,192,192},
                fillPattern=FillPattern.Solid),
              Line(points={{-80,78},{-80,-90}}, color={192,192,192}),
              Line(points={{-80,-80},{-80,-20},{30,60},{80,60}}, color={0,0,127}),
              Line(points={{-90,-80},{82,-80}}, color={192,192,192}),
              Polygon(
                points={{90,-80},{68,-72},{68,-88},{90,-80}},
                lineColor={192,192,192},
                fillColor={192,192,192},
                fillPattern=FillPattern.Solid),
              Line(
                visible=strict,
                points={{30,60},{81,60}},
                color={255,0,0},
                smooth=Smooth.None)}),                                 Diagram(
              coordinateSystem(preserveAspectRatio=false)));
      end PID_Valve_evap;

      package Tests
        extends Modelica.Icons.ExamplesPackage;

        model select
          Modelica.Blocks.Interfaces.RealInput u
            annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
          Modelica.Blocks.Interfaces.RealOutput y
            annotation (Placement(transformation(extent={{100,-10},{120,10}})));
        equation
          y = u+6;
          annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
                coordinateSystem(preserveAspectRatio=false)));
        end select;

        model select_0
          Real bb;
          Modelica.Blocks.Sources.RealExpression aa(y=bb)
            annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
          Modelica.Blocks.Interfaces.IntegerInput u
            annotation (Placement(transformation(extent={{-120,50},{-80,90}})));
        equation
            if u <=1 then
            bb = 35;
            elseif u == 2 then
            bb = 46;
            elseif u == 3 then
              bb = 60;
          end if;

          annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
                coordinateSystem(preserveAspectRatio=false)));
        end select_0;

        model select_1
          select_0 select_0_1
            annotation (Placement(transformation(extent={{-40,20},{-20,40}})));
          Modelica.Blocks.Sources.IntegerExpression integerExpression(y=1)
            annotation (Placement(transformation(extent={{-100,20},{-80,40}})));
        equation
          connect(integerExpression.y, select_0_1.u) annotation (Line(points={{
                  -79,30},{-60,30},{-60,37},{-40,37}}, color={255,127,0}));
          annotation (Icon(coordinateSystem(preserveAspectRatio=false)),
              Diagram(coordinateSystem(preserveAspectRatio=false)));
        end select_1;
      end Tests;

    end TFP;

    package Mode "Modelica.Icons.VariantsPackage"
    extends Modelica.Icons.VariantsPackage;

      model switch_tfp
        Modelica.StateGraph.InitialStep initialStep(nIn=3, nOut=3)
          annotation (Placement(transformation(extent={{-60,60},{-40,80}})));
        Modelica.StateGraph.StepWithSignal cooling_mode(nOut=3)
          annotation (Placement(transformation(extent={{0,60},{20,80}})));
        Modelica.StateGraph.StepWithSignal sh_mode(nIn=2, nOut=2)
          annotation (Placement(transformation(extent={{80,-60},{100,-40}})));
        Modelica.StateGraph.StepWithSignal ecs_mode(nIn=3)
          annotation (Placement(transformation(extent={{160,-170},{180,-150}})));
        Modelica.StateGraph.TransitionWithSignal cooling
          annotation (Placement(transformation(extent={{-30,60},{-10,80}})));
        Modelica.StateGraph.TransitionWithSignal sh
          annotation (Placement(transformation(extent={{-30,-60},{-10,-40}})));
        Modelica.StateGraph.TransitionWithSignal heating
          annotation (Placement(transformation(extent={{-30,-170},{-10,-150}})));
        Modelica.StateGraph.TransitionWithSignal stop
          annotation (Placement(transformation(extent={{40,140},{60,160}})));
        Modelica.StateGraph.TransitionWithSignal sh1
          annotation (Placement(transformation(extent={{40,100},{60,120}})));
        Modelica.StateGraph.TransitionWithSignal heating1
          annotation (Placement(transformation(extent={{40,60},{60,80}})));
        Modelica.StateGraph.TransitionWithSignal stop1
          annotation (Placement(transformation(extent={{120,20},{140,40}})));
        Modelica.StateGraph.TransitionWithSignal heating2
          annotation (Placement(transformation(extent={{120,-60},{140,-40}})));
        Modelica.StateGraph.TransitionWithSignal stop2
          annotation (Placement(transformation(extent={{200,-170},{220,-150}})));
        Modelica.Blocks.Interfaces.RealInput cooling_in annotation (Placement(
              transformation(extent={{-180,50},{-140,90}}), iconTransformation(extent=
                 {{-140,50},{-100,90}})));
        Modelica.Blocks.Logical.GreaterThreshold greaterThreshold(threshold=
              0.001)
          annotation (Placement(transformation(extent={{-80,30},{-60,50}})));
        Modelica.Blocks.Interfaces.RealInput sh_in annotation (Placement(
              transformation(extent={{-180,-20},{-140,20}}), iconTransformation(
                extent={{-140,-20},{-100,20}})));
        Modelica.Blocks.Logical.GreaterThreshold greaterThreshold1(threshold=
              0.001)
          annotation (Placement(transformation(extent={{-80,-50},{-60,-30}})));
        Modelica.Blocks.Interfaces.RealInput ecs_in annotation (Placement(
              transformation(extent={{-180,-90},{-140,-50}}), iconTransformation(extent={{-140,-90},{-100,-50}})));
        Modelica.Blocks.Logical.GreaterThreshold greaterThreshold2(threshold=
              0.001)
          annotation (Placement(transformation(extent={{-80,-160},{-60,-140}})));
        Modelica.Blocks.Logical.Not not1
          annotation (Placement(transformation(extent={{-20,-210},{0,-190}})));
        Modelica.Blocks.Logical.Not not2
          annotation (Placement(transformation(extent={{-20,-100},{0,-80}})));
        Modelica.Blocks.Logical.Not not3
          annotation (Placement(transformation(extent={{-20,0},{0,20}})));
        Modelica.Blocks.MathInteger.MultiSwitch HPSHC_exit(
          expr={1,2,3},
          use_pre_as_default=false,
          nu=3) annotation (Placement(transformation(extent={{260,200},{300,220}})));
        Modelica.Blocks.Interfaces.IntegerOutput HPSHC annotation (Placement(
              transformation(extent={{260,-20},{300,20}}),  iconTransformation(
                extent={{100,60},{140,100}})));
        inner Modelica.StateGraph.StateGraphRoot stateGraphRoot
          annotation (Placement(transformation(extent={{-260,200},{-240,220}})));
      equation
        connect(initialStep.outPort[1], cooling.inPort) annotation (Line(points={{-39.5,
                70.3333},{-32,70.3333},{-32,70},{-24,70}}, color={0,0,0}));
        connect(initialStep.outPort[2], sh.inPort) annotation (Line(points={{-39.5,70},
                {-32,70},{-32,-50},{-24,-50}}, color={0,0,0}));
        connect(initialStep.outPort[3], heating.inPort) annotation (Line(points={{-39.5,
                69.6667},{-32,69.6667},{-32,-160},{-24,-160}}, color={0,0,0}));
        connect(cooling.outPort, cooling_mode.inPort[1])
          annotation (Line(points={{-18.5,70},{-1,70}}, color={0,0,0}));
        connect(sh.outPort, sh_mode.inPort[1]) annotation (Line(points={{-18.5,-50},{30,
                -50},{30,-49.5},{79,-49.5}}, color={0,0,0}));
        connect(heating.outPort, ecs_mode.inPort[1]) annotation (Line(points={{-18.5,
                -160},{70,-160},{70,-159.333},{159,-159.333}},
                                                         color={0,0,0}));
        connect(cooling_mode.outPort[1], stop.inPort) annotation (Line(points={{20.5,
                70.3333},{34,70.3333},{34,150},{46,150}},
                                                 color={0,0,0}));
        connect(cooling_mode.outPort[2], sh1.inPort) annotation (Line(points={{20.5,70},
                {34,70},{34,110},{46,110}}, color={0,0,0}));
        connect(cooling_mode.outPort[3], heating1.inPort) annotation (Line(points={{20.5,
                69.6667},{34,69.6667},{34,70},{46,70}}, color={0,0,0}));
        connect(sh1.outPort, sh_mode.inPort[2]) annotation (Line(points={{51.5,110},{68,
                110},{68,-50.5},{79,-50.5}}, color={0,0,0}));
        connect(sh_mode.outPort[1], stop1.inPort) annotation (Line(points={{100.5,-49.75},
                {114,-49.75},{114,30},{126,30}}, color={0,0,0}));
        connect(sh_mode.outPort[2], heating2.inPort) annotation (Line(points={{100.5,-50.25},
                {112,-50.25},{112,-50},{126,-50}}, color={0,0,0}));
        connect(stop.outPort, initialStep.inPort[1]) annotation (Line(points={{51.5,
                150},{80,150},{80,180},{-80,180},{-80,70.6667},{-61,70.6667}},
                                                                          color={0,0,0}));
        connect(stop1.outPort, initialStep.inPort[2]) annotation (Line(points={{131.5,
                30},{160,30},{160,180},{-80,180},{-80,70},{-61,70}}, color={0,0,0}));
        connect(heating1.outPort, ecs_mode.inPort[2]) annotation (Line(points={{51.5,70},
                {60,70},{60,-160},{159,-160}}, color={0,0,0}));
        connect(heating2.outPort, ecs_mode.inPort[3]) annotation (Line(points={{131.5,
                -50},{144,-50},{144,-160.667},{159,-160.667}}, color={0,0,0}));
        connect(ecs_mode.outPort[1], stop2.inPort)
          annotation (Line(points={{180.5,-160},{206,-160}}, color={0,0,0}));
        connect(stop2.outPort, initialStep.inPort[3]) annotation (Line(points={{211.5,
                -160},{230,-160},{230,180},{-80,180},{-80,69.3333},{-61,69.3333}},
              color={0,0,0}));
        connect(cooling_in, greaterThreshold.u) annotation (Line(points={{-160,70},{
                -100,70},{-100,40},{-82,40}},
                                        color={0,0,127}));
        connect(greaterThreshold.y, cooling.condition)
          annotation (Line(points={{-59,40},{-20,40},{-20,58}}, color={255,0,255}));
        connect(sh_in, greaterThreshold1.u) annotation (Line(points={{-160,0},{-100,
                0},{-100,-40},{-82,-40}},
                                       color={0,0,127}));
        connect(ecs_in, greaterThreshold2.u) annotation (Line(points={{-160,-70},{-100,
                -70},{-100,-150},{-82,-150}}, color={0,0,127}));
        connect(greaterThreshold1.y, sh.condition) annotation (Line(points={{-59,-40},
                {-50,-40},{-50,-72},{-20,-72},{-20,-62}}, color={255,0,255}));
        connect(greaterThreshold1.y, sh1.condition) annotation (Line(points={{-59,-40},
                {42,-40},{42,90},{50,90},{50,98}}, color={255,0,255}));
        connect(greaterThreshold2.y, heating.condition) annotation (Line(points={{-59,
                -150},{-40,-150},{-40,-180},{-20,-180},{-20,-172}}, color={255,0,255}));
        connect(greaterThreshold2.y, heating1.condition) annotation (Line(points={{-59,
                -150},{-40,-150},{-40,-128},{50,-128},{50,58}}, color={255,0,255}));
        connect(greaterThreshold2.y, heating2.condition) annotation (Line(points={{-59,
                -150},{-40,-150},{-40,-128},{130,-128},{130,-62}}, color={255,0,255}));
        connect(greaterThreshold2.y, not1.u) annotation (Line(points={{-59,-150},{-40,
                -150},{-40,-200},{-22,-200}}, color={255,0,255}));
        connect(not1.y, stop2.condition) annotation (Line(points={{1,-200},{210,-200},
                {210,-172}}, color={255,0,255}));
        connect(greaterThreshold1.y, not2.u) annotation (Line(points={{-59,-40},{-50,-40},
                {-50,-90},{-22,-90}}, color={255,0,255}));
        connect(not2.y, stop1.condition) annotation (Line(points={{1,-90},{120,-90},{120,
                -32},{130,-32},{130,18}}, color={255,0,255}));
        connect(greaterThreshold.y, not3.u) annotation (Line(points={{-59,40},{-42,40},
                {-42,10},{-22,10}}, color={255,0,255}));
        connect(not3.y, stop.condition) annotation (Line(points={{1,10},{38,10},{38,130},
                {50,130},{50,138}}, color={255,0,255}));
        connect(cooling_mode.active, HPSHC_exit.u[1]) annotation (Line(points={{10,59},
                {10,46},{108,46},{108,212},{260,212}}, color={255,0,255}));
        connect(sh_mode.active, HPSHC_exit.u[2]) annotation (Line(points={{90,-61},{
                90,-72},{190,-72},{190,210},{260,210}}, color={255,0,255}));
        connect(ecs_mode.active, HPSHC_exit.u[3]) annotation (Line(points={{170,-171},
                {170,-180},{198,-180},{198,208},{260,208}}, color={255,0,255}));
        connect(HPSHC_exit.y, HPSHC) annotation (Line(points={{301,210},{320,210},{320,
                60},{240,60},{240,0},{280,0}}, color={255,127,0}));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
                                         Rectangle(
                extent={{-100,100},{100,-100}},
                lineColor={0,0,0},
                fillColor={210,210,210},
                fillPattern=FillPattern.Solid,
                borderPattern=BorderPattern.Raised), Text(
                extent={{-80,80},{80,-80}},
                lineColor={28,108,200},
                textString="I/O
Cooling
SH
HW")}),                                                Diagram(coordinateSystem(
                preserveAspectRatio=false, extent={{-260,-220},{260,220}})));
      end switch_tfp;

    package Tests
      extends Modelica.Icons.ExamplesPackage;
      model test_switch
          switch_tfp switch_tfp1
            annotation (Placement(transformation(extent={{0,60},{20,80}})));
          Modelica.Blocks.Sources.Step step(startTime=2)
            annotation (Placement(transformation(extent={{-60,0},{-40,20}})));
          Modelica.Blocks.Sources.Constant const(k=0.5)
            annotation (Placement(transformation(extent={{-80,80},{-60,100}})));
          Modelica.Blocks.Sources.Constant const1(k=0)
            annotation (Placement(transformation(extent={{-80,50},{-60,70}})));
      equation
          connect(step.y, switch_tfp1.ecs_in) annotation (Line(points={{-39,10},
                  {-20,10},{-20,63},{-2,63}}, color={0,0,127}));
          connect(const1.y, switch_tfp1.sh_in) annotation (Line(points={{-59,60},
                  {-32,60},{-32,70},{-2,70}}, color={0,0,127}));
          connect(const.y, switch_tfp1.cooling_in) annotation (Line(points={{
                  -59,90},{-28,90},{-28,76},{-2,76},{-2,77}}, color={0,0,127}));
          annotation (Icon(coordinateSystem(preserveAspectRatio=false)),
              Diagram(coordinateSystem(preserveAspectRatio=false)));
      end test_switch;
    end Tests;
    end Mode;
  end Controls;

package ECS
  extends Modelica.Icons.VariantsPackage;
  package Tests
    extends Modelica.Icons.ExamplesPackage;
    model ballon
      Fluid.Storage.StratifiedEnhanced tan1(
        redeclare package Medium = Media.Water,
        m_flow_nominal=25,
        VTan=5,
        hTan=5,
        dIns=0.05)
        annotation (Placement(transformation(extent={{0,20},{20,40}})));
      Fluid.Sources.Boundary_pT bou(
        redeclare package Medium = Media.Water,
        use_T_in=true,
        T=333.15,
        nPorts=2)
        annotation (Placement(transformation(extent={{-100,-40},{-80,-20}})));
      Fluid.Sensors.TemperatureTwoPort senTem(redeclare package Medium =
            Media.Water, m_flow_nominal=25)
        annotation (Placement(transformation(extent={{-70,20},{-50,40}})));
      Fluid.Sensors.TemperatureTwoPort senTem1(redeclare package Medium =
            Media.Water, m_flow_nominal=25)
        annotation (Placement(transformation(extent={{40,20},{60,40}})));
      Fluid.HeatExchangers.ConstantEffectiveness hex(
        redeclare package Medium1 = Media.Water,
        redeclare package Medium2 = Media.Water,
        m1_flow_nominal=25,
        m2_flow_nominal=20,
        dp1_nominal=1000,
        dp2_nominal=1000)
        annotation (Placement(transformation(extent={{80,0},{100,20}})));
      Fluid.Sources.MassFlowSource_T boundary1(
        redeclare package Medium = Media.Water,
        m_flow=25,
        T=288.15,
        nPorts=1)
        annotation (Placement(transformation(extent={{160,-20},{140,0}})));
      Fluid.Sensors.TemperatureTwoPort senTem2(redeclare package Medium =
            Media.Water, m_flow_nominal=25)
        annotation (Placement(transformation(extent={{120,40},{140,60}})));
      Fluid.Sources.Boundary_pT bou1(
        redeclare package Medium = Media.Water,
        T=293.15,
        nPorts=1)
        annotation (Placement(transformation(extent={{180,40},{160,60}})));
      Fluid.Sensors.TemperatureTwoPort senTem3(redeclare package Medium =
            Media.Water, m_flow_nominal=25)
        annotation (Placement(transformation(extent={{-20,-40},{-40,-20}})));
      Fluid.Movers.FlowControlled_dp fan(
        redeclare package Medium = Media.Water,
        m_flow_nominal=25,
        redeclare Fluid.Movers.Data.Pumps.Wilo.Stratos30slash1to4 per,
        inputType=Buildings.Fluid.Types.InputType.Constant,
        addPowerToMedium=false,
        dp_nominal=1000,
        constantHead=1000)
        annotation (Placement(transformation(extent={{-120,20},{-100,40}})));
      Modelica.Blocks.Sources.Step step(
        height=-20,
        offset=60 + 273.15,
        startTime=200000) annotation (Placement(transformation(extent={{-140,
                -40},{-120,-20}})));
    equation
      connect(senTem.port_b, tan1.port_a)
        annotation (Line(points={{-50,30},{0,30}}, color={0,127,255}));
      connect(senTem1.port_a, tan1.port_b)
        annotation (Line(points={{40,30},{20,30}}, color={0,127,255}));
      connect(senTem1.port_b, hex.port_a1) annotation (Line(points={{60,30},{
              70,30},{70,16},{80,16}}, color={0,127,255}));
      connect(hex.port_b1, senTem2.port_a) annotation (Line(points={{100,16},
              {110,16},{110,50},{120,50}}, color={0,127,255}));
      connect(hex.port_a2, boundary1.ports[1]) annotation (Line(points={{100,
              4},{120,4},{120,-10},{140,-10}}, color={0,127,255}));
      connect(senTem2.port_b, bou1.ports[1]) annotation (Line(points={{140,50},
              {150,50},{150,50},{160,50}}, color={0,127,255}));
      connect(hex.port_b2, senTem3.port_a) annotation (Line(points={{80,4},{0,
              4},{0,-30},{-20,-30}}, color={0,127,255}));
      connect(senTem3.port_b, bou.ports[1]) annotation (Line(points={{-40,-30},
              {-60,-30},{-60,-28},{-80,-28}}, color={0,127,255}));
      connect(fan.port_b, senTem.port_a)
        annotation (Line(points={{-100,30},{-70,30}}, color={0,127,255}));
      connect(step.y, bou.T_in) annotation (Line(points={{-119,-30},{-112,-30},
              {-112,-26},{-102,-26}}, color={0,0,127}));
      connect(bou.ports[2], fan.port_a) annotation (Line(points={{-80,-32},{
              -80,0},{-180,0},{-180,30},{-120,30}}, color={0,127,255}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end ballon;

    model ballon_b
      Fluid.Storage.StratifiedEnhanced tan1(
        redeclare package Medium = Media.Water,
        m_flow_nominal=25,
        VTan=20,
        hTan=5,
        dIns=0.05)
        annotation (Placement(transformation(extent={{0,20},{20,40}})));
      Fluid.Sources.Boundary_pT bou(
        redeclare package Medium = Media.Water,
        use_T_in=true,
        T=333.15,
        nPorts=2)
        annotation (Placement(transformation(extent={{-100,-40},{-80,-20}})));
      Fluid.Sensors.TemperatureTwoPort senTem(redeclare package Medium =
            Media.Water, m_flow_nominal=25)
        annotation (Placement(transformation(extent={{-70,20},{-50,40}})));
      Fluid.Sensors.TemperatureTwoPort senTem1(redeclare package Medium =
            Media.Water, m_flow_nominal=25)
        annotation (Placement(transformation(extent={{40,20},{60,40}})));
      Fluid.Movers.FlowControlled_dp fan(
        redeclare package Medium = Media.Water,
        m_flow_nominal=25,
        redeclare Fluid.Movers.Data.Pumps.Wilo.Stratos30slash1to4 per,
        inputType=Buildings.Fluid.Types.InputType.Constant,
        addPowerToMedium=false,
        dp_nominal=1000,
        constantHead=1000)
        annotation (Placement(transformation(extent={{-120,20},{-100,40}})));
      Modelica.Blocks.Sources.Step step(
        height=-20,
        offset=60 + 273.15,
        startTime=200000) annotation (Placement(transformation(extent={{-140,
                -40},{-120,-20}})));
      Fluid.Actuators.Valves.TwoWayLinear val(
        redeclare package Medium = Media.Water,
        m_flow_nominal=25,
        dpValve_nominal=100)
        annotation (Placement(transformation(extent={{20,-42},{0,-22}})));
      Modelica.Blocks.Sources.RealExpression realExpression(y=1)
        annotation (Placement(transformation(extent={{-20,-10},{0,10}})));
    equation
      connect(senTem.port_b, tan1.port_a)
        annotation (Line(points={{-50,30},{0,30}}, color={0,127,255}));
      connect(senTem1.port_a, tan1.port_b)
        annotation (Line(points={{40,30},{20,30}}, color={0,127,255}));
      connect(fan.port_b, senTem.port_a)
        annotation (Line(points={{-100,30},{-70,30}}, color={0,127,255}));
      connect(step.y, bou.T_in) annotation (Line(points={{-119,-30},{-112,-30},
              {-112,-26},{-102,-26}}, color={0,0,127}));
      connect(bou.ports[1], fan.port_a) annotation (Line(points={{-80,-28},{
              -70,-28},{-70,0},{-180,0},{-180,30},{-120,30}}, color={0,127,
              255}));
      connect(bou.ports[2], val.port_b)
        annotation (Line(points={{-80,-32},{0,-32}}, color={0,127,255}));
      connect(val.port_a, senTem1.port_b) annotation (Line(points={{20,-32},{
              84,-32},{84,30},{60,30}}, color={0,127,255}));
      connect(realExpression.y, val.y)
        annotation (Line(points={{1,0},{10,0},{10,-20}}, color={0,0,127}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end ballon_b;

    model ballon_c
      Fluid.Storage.StratifiedEnhanced tan1(
        redeclare package Medium = Media.Water,
        m_flow_nominal=25,
        VTan=5,
        hTan=5,
        dIns=0.05)
        annotation (Placement(transformation(extent={{-30,20},{-10,40}})));
      Fluid.Sources.Boundary_pT bou(
        redeclare package Medium = Media.Water,
        use_T_in=true,
        T=333.15,
        nPorts=3)
        annotation (Placement(transformation(extent={{-100,-40},{-80,-20}})));
      Fluid.Sensors.TemperatureTwoPort senTem(redeclare package Medium =
            Media.Water, m_flow_nominal=25)
        annotation (Placement(transformation(extent={{-70,20},{-50,40}})));
      Fluid.Sensors.TemperatureTwoPort senTem1(redeclare package Medium =
            Media.Water, m_flow_nominal=25)
        annotation (Placement(transformation(extent={{40,20},{60,40}})));
      Fluid.HeatExchangers.ConstantEffectiveness hex(
        redeclare package Medium1 = Media.Water,
        redeclare package Medium2 = Media.Water,
        m1_flow_nominal=25,
        m2_flow_nominal=20,
        dp1_nominal=1000,
        dp2_nominal=1000)
        annotation (Placement(transformation(extent={{80,0},{100,20}})));
      Fluid.Sources.MassFlowSource_T boundary1(
        redeclare package Medium = Media.Water,
        m_flow=25,
        T=288.15,
        nPorts=1)
        annotation (Placement(transformation(extent={{160,-20},{140,0}})));
      Fluid.Sensors.TemperatureTwoPort senTem2(redeclare package Medium =
            Media.Water, m_flow_nominal=25)
        annotation (Placement(transformation(extent={{120,40},{140,60}})));
      Fluid.Sources.Boundary_pT bou1(
        redeclare package Medium = Media.Water,
        T=293.15,
        nPorts=1)
        annotation (Placement(transformation(extent={{180,40},{160,60}})));
      Fluid.Sensors.TemperatureTwoPort senTem3(redeclare package Medium =
            Media.Water, m_flow_nominal=25)
        annotation (Placement(transformation(extent={{-40,-40},{-60,-20}})));
      Fluid.Movers.FlowControlled_dp fan(
        redeclare package Medium = Media.Water,
        m_flow_nominal=25,
        redeclare Fluid.Movers.Data.Pumps.Wilo.Stratos30slash1to4 per,
        inputType=Buildings.Fluid.Types.InputType.Constant,
        addPowerToMedium=false,
        dp_nominal=1000,
        constantHead=1000)
        annotation (Placement(transformation(extent={{-120,20},{-100,40}})));
      Modelica.Blocks.Sources.Step step(
        height=-20,
        offset=60 + 273.15,
        startTime=200000) annotation (Placement(transformation(extent={{-140,
                -40},{-120,-20}})));
      Fluid.Movers.FlowControlled_dp fan1(
        redeclare package Medium = Media.Water,
        m_flow_nominal=25,
        redeclare Fluid.Movers.Data.Pumps.Wilo.Stratos30slash1to4 per,
        inputType=Buildings.Fluid.Types.InputType.Constant,
        addPowerToMedium=false,
        dp_nominal=1000,
        constantHead=1000)
        annotation (Placement(transformation(extent={{12,20},{32,40}})));
      Fluid.Actuators.Valves.TwoWayLinear val(
        redeclare package Medium = Media.Water,
        m_flow_nominal=25,
        dpValve_nominal=100)
        annotation (Placement(transformation(extent={{20,-80},{0,-60}})));
      Fluid.Actuators.Valves.TwoWayLinear val1(
        redeclare package Medium = Media.Water,
        m_flow_nominal=25,
        dpValve_nominal=100)
        annotation (Placement(transformation(extent={{-10,-40},{-30,-20}})));
      Modelica.Blocks.Sources.Step step1(
        height=-1,
        offset=1,
        startTime=200000)
        annotation (Placement(transformation(extent={{-46,-10},{-26,10}})));
      Modelica.Blocks.Sources.Step step2(
        height=1,
        offset=0,
        startTime=200000)
        annotation (Placement(transformation(extent={{-46,-94},{-26,-74}})));
    equation
      connect(senTem.port_b, tan1.port_a)
        annotation (Line(points={{-50,30},{-30,30}}, color={0,127,255}));
      connect(senTem1.port_b, hex.port_a1) annotation (Line(points={{60,30},{
              70,30},{70,16},{80,16}}, color={0,127,255}));
      connect(hex.port_b1, senTem2.port_a) annotation (Line(points={{100,16},
              {110,16},{110,50},{120,50}}, color={0,127,255}));
      connect(hex.port_a2, boundary1.ports[1]) annotation (Line(points={{100,
              4},{120,4},{120,-10},{140,-10}}, color={0,127,255}));
      connect(senTem2.port_b, bou1.ports[1]) annotation (Line(points={{140,50},
              {150,50},{150,50},{160,50}}, color={0,127,255}));
      connect(senTem3.port_b, bou.ports[1]) annotation (Line(points={{-60,-30},{-74,
              -30},{-74,-27.3333},{-80,-27.3333}},      color={0,127,255}));
      connect(fan.port_b, senTem.port_a)
        annotation (Line(points={{-100,30},{-70,30}}, color={0,127,255}));
      connect(step.y, bou.T_in) annotation (Line(points={{-119,-30},{-112,-30},
              {-112,-26},{-102,-26}}, color={0,0,127}));
      connect(bou.ports[2], fan.port_a) annotation (Line(points={{-80,-30},{
              -80,0},{-180,0},{-180,30},{-120,30}}, color={0,127,255}));
      connect(tan1.port_b, fan1.port_a)
        annotation (Line(points={{-10,30},{12,30}}, color={0,127,255}));
      connect(fan1.port_b, senTem1.port_a)
        annotation (Line(points={{32,30},{40,30}}, color={0,127,255}));
      connect(hex.port_b2, val.port_a) annotation (Line(points={{80,4},{72,4},
              {72,2},{46,2},{46,-70},{20,-70}}, color={0,127,255}));
      connect(val.port_b, bou.ports[3]) annotation (Line(points={{0,-70},{-80,-70},
              {-80,-32.6667}},      color={0,127,255}));
      connect(tan1.port_b, val1.port_a) annotation (Line(points={{-10,30},{2,
              30},{2,-30},{-10,-30}}, color={0,127,255}));
      connect(val1.port_b, senTem3.port_a)
        annotation (Line(points={{-30,-30},{-40,-30}}, color={0,127,255}));
      connect(step1.y, val1.y) annotation (Line(points={{-25,0},{-20,0},{-20,
              -18}}, color={0,0,127}));
      connect(step2.y, val.y) annotation (Line(points={{-25,-84},{-12,-84},{
              -12,-46},{10,-46},{10,-58}}, color={0,0,127}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end ballon_c;

    model ballon_d
      Fluid.Sources.Boundary_pT bou(
        redeclare package Medium = Media.Water,
        use_T_in=false,
        T=333.15,
        nPorts=2)
        annotation (Placement(transformation(extent={{-100,-40},{-80,-20}})));
      Fluid.Sensors.TemperatureTwoPort senTem(redeclare package Medium =
            Media.Water, m_flow_nominal=25)
        annotation (Placement(transformation(extent={{-60,20},{-40,40}})));
      Fluid.Sensors.TemperatureTwoPort senTem1(redeclare package Medium =
            Media.Water, m_flow_nominal=25)
        annotation (Placement(transformation(extent={{42,42},{62,62}})));
      Fluid.HeatExchangers.ConstantEffectiveness hex(
        redeclare package Medium1 = Media.Water,
        redeclare package Medium2 = Media.Water,
        m1_flow_nominal=25,
        m2_flow_nominal=20,
        dp1_nominal=1000,
        dp2_nominal=1000)
        annotation (Placement(transformation(extent={{80,0},{100,20}})));
      Fluid.Sources.MassFlowSource_T boundary1(
        redeclare package Medium = Media.Water,
        m_flow=2,
        T=288.15,
        nPorts=1) annotation (Placement(transformation(extent={{160,-20},{140,0}})));
      Fluid.Sensors.TemperatureTwoPort senTem2(redeclare package Medium =
            Media.Water, m_flow_nominal=25)
        annotation (Placement(transformation(extent={{60,-40},{40,-20}})));
      Fluid.Sources.Boundary_pT bou1(
        redeclare package Medium = Media.Water,
        T=293.15,
        nPorts=1) annotation (Placement(transformation(extent={{10,-40},{30,
                -20}})));
      Fluid.Sensors.TemperatureTwoPort senTem3(redeclare package Medium =
            Media.Water, m_flow_nominal=25)
        annotation (Placement(transformation(extent={{-40,-40},{-60,-20}})));
      Fluid.Storage.StratifiedEnhancedInternalHex tan1(
        redeclare package Medium = Media.Water,
        m_flow_nominal=25,
        VTan=5,
        hTan=2,
        dIns=0.1,
        nSeg=12,
        hHex_a=1,
        hHex_b=0.1,
        Q_flow_nominal=500000,
        TTan_nominal=332.15,
        THex_nominal=333.15,
        mHex_flow_nominal=25,
        redeclare package MediumHex =Media.Water)
        annotation (Placement(transformation(extent={{-20,20},{0,40}})));
      Fluid.Sensors.TemperatureTwoPort senTem4(redeclare package Medium =
            Media.Water, m_flow_nominal=25)
        annotation (Placement(transformation(extent={{70,90},{50,110}})));
      Fluid.Movers.FlowControlled_m_flow fan(
        redeclare package Medium = Media.Water,
        m_flow_nominal=50,
        redeclare Fluid.Movers.Data.Pumps.Wilo.Stratos25slash1to4 per,
        inputType=Buildings.Fluid.Types.InputType.Continuous,
        addPowerToMedium=false,
        dp_nominal=50000,
        constantMassFlowRate=25)
        annotation (Placement(transformation(extent={{-100,20},{-80,40}})));
      Modelica.Blocks.Sources.Step step(
        height=-25,
        offset=25,
        startTime=200000)
        annotation (Placement(transformation(extent={{-160,80},{-140,100}})));
      Fluid.Sources.Boundary_pT bou2(
        redeclare package Medium = Media.Water,
        use_T_in=true,
        T=293.15,
        nPorts=2) annotation (Placement(transformation(extent={{-10,-10},{10,
                10}},
            rotation=270,
            origin={12,118})));
      Fluid.Movers.FlowControlled_m_flow fan1(
        redeclare package Medium = Media.Water,
        m_flow_nominal=50,
        redeclare Fluid.Movers.Data.Pumps.Wilo.Stratos25slash1to4 per,
        inputType=Buildings.Fluid.Types.InputType.Continuous,
        addPowerToMedium=false,
        dp_nominal=50000,
        constantMassFlowRate=10)
        annotation (Placement(transformation(extent={{30,20},{10,40}})));
      Modelica.Blocks.Sources.Step step1(
        height=1,
        offset=0,
        startTime=150000)
        annotation (Placement(transformation(extent={{-16,60},{4,80}})));
      Modelica.Blocks.Sources.Step step2(
        height=25,
        offset=0,
        startTime=205000)
        annotation (Placement(transformation(extent={{-160,40},{-140,60}})));
      Modelica.Blocks.Math.MultiSum multiSum(nu=2)
        annotation (Placement(transformation(extent={{-112,64},{-100,76}})));
    equation
      connect(senTem1.port_b, hex.port_a1) annotation (Line(points={{62,52},{
              76,52},{76,16},{80,16}},
                                color={0,127,255}));
      connect(hex.port_a2, boundary1.ports[1]) annotation (Line(points={{100,4},{120,
              4},{120,-10},{140,-10}}, color={0,127,255}));
      connect(senTem3.port_b, bou.ports[1]) annotation (Line(points={{-60,-30},
              {-70,-30},{-70,-28},{-80,-28}},
                                         color={0,127,255}));
      connect(senTem.port_b, tan1.portHex_a) annotation (Line(points={{-40,30},{-30,
              30},{-30,26.2},{-20,26.2}}, color={0,127,255}));
      connect(senTem3.port_a, tan1.portHex_b) annotation (Line(points={{-40,-30},{-20,
              -30},{-20,22}}, color={0,127,255}));
      connect(bou.ports[2], fan.port_a) annotation (Line(points={{-80,-32},{
              -80,10},{-116,10},{-116,30},{-100,30}}, color={0,127,255}));
      connect(fan.port_b, senTem.port_a)
        annotation (Line(points={{-80,30},{-60,30}}, color={0,127,255}));
      connect(senTem2.port_a, hex.port_b2) annotation (Line(points={{60,-30},
              {70,-30},{70,4},{80,4}}, color={0,127,255}));
      connect(bou1.ports[1], senTem2.port_b)
        annotation (Line(points={{30,-30},{40,-30}}, color={0,127,255}));
      connect(hex.port_b1, senTem4.port_a) annotation (Line(points={{100,16},
              {108,16},{108,100},{70,100}}, color={0,127,255}));
      connect(senTem4.port_b, bou2.ports[1]) annotation (Line(points={{50,100},
              {14,100},{14,108}}, color={0,127,255}));
      connect(senTem4.T, bou2.T_in) annotation (Line(points={{60,111},{60,140},
              {16,140},{16,130}}, color={0,0,127}));
      connect(step1.y, fan1.m_flow_in)
        annotation (Line(points={{5,70},{20,70},{20,42}}, color={0,0,127}));
      connect(fan1.port_b, tan1.port_b)
        annotation (Line(points={{10,30},{0,30}}, color={0,127,255}));
      connect(bou2.ports[2], fan1.port_a) annotation (Line(points={{10,108},{
              10,108},{10,80},{34,80},{34,30},{30,30}}, color={0,127,255}));
      connect(tan1.port_a, senTem1.port_a) annotation (Line(points={{-20,30},
              {-26,30},{-26,52},{42,52}}, color={0,127,255}));
      connect(step2.y, multiSum.u[1]) annotation (Line(points={{-139,50},{
              -126,50},{-126,72.1},{-112,72.1}}, color={0,0,127}));
      connect(step.y, multiSum.u[2]) annotation (Line(points={{-139,90},{-126,
              90},{-126,67.9},{-112,67.9}}, color={0,0,127}));
      connect(multiSum.y, fan.m_flow_in) annotation (Line(points={{-98.98,70},
              {-90,70},{-90,42}}, color={0,0,127}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)),
        experiment(
          StopTime=400000,
          Interval=200,
          __Dymola_Algorithm="Dassl"));
    end ballon_d;

    model ballon_f
      Fluid.Sources.Boundary_pT bou(
        redeclare package Medium = Media.Water,
        use_T_in=false,
        T=333.15,
        nPorts=2)
        annotation (Placement(transformation(extent={{-100,-40},{-80,-20}})));
      Fluid.Sensors.TemperatureTwoPort senTem(redeclare package Medium =
            Media.Water, m_flow_nominal=25)
        annotation (Placement(transformation(extent={{-60,20},{-40,40}})));
      Fluid.Sensors.TemperatureTwoPort senTem1(redeclare package Medium =
            Media.Water, m_flow_nominal=25)
        annotation (Placement(transformation(extent={{42,42},{62,62}})));
      Fluid.HeatExchangers.ConstantEffectiveness hex(
        redeclare package Medium1 = Media.Water,
        redeclare package Medium2 = Media.Water,
        m1_flow_nominal=25,
        m2_flow_nominal=20,
        dp1_nominal=1000,
        dp2_nominal=1000)
        annotation (Placement(transformation(extent={{80,0},{100,20}})));
      Fluid.Sources.MassFlowSource_T boundary1(
        redeclare package Medium = Media.Water,
        m_flow=2,
        T=288.15,
        nPorts=1) annotation (Placement(transformation(extent={{160,-20},{140,0}})));
      Fluid.Sensors.TemperatureTwoPort senTem2(redeclare package Medium =
            Media.Water, m_flow_nominal=25)
        annotation (Placement(transformation(extent={{60,-40},{40,-20}})));
      Fluid.Sources.Boundary_pT bou1(
        redeclare package Medium = Media.Water,
        T=293.15,
        nPorts=1) annotation (Placement(transformation(extent={{10,-40},{30,
                -20}})));
      Fluid.Sensors.TemperatureTwoPort senTem3(redeclare package Medium =
            Media.Water, m_flow_nominal=25)
        annotation (Placement(transformation(extent={{-40,-40},{-60,-20}})));
      Fluid.Storage.StratifiedEnhancedInternalHex tan1(
        redeclare package Medium = Media.Water,
        m_flow_nominal=25,
        VTan=5,
        hTan=2,
        dIns=0.1,
        nSeg=10,
        hHex_a=1,
        hHex_b=0.1,
        Q_flow_nominal=500000,
        TTan_nominal=332.15,
        THex_nominal=333.15,
        mHex_flow_nominal=25,
        redeclare package MediumHex =Media.Water)
        annotation (Placement(transformation(extent={{-8,20},{-28,40}})));
      Fluid.Sensors.TemperatureTwoPort senTem4(redeclare package Medium =
            Media.Water, m_flow_nominal=25)
        annotation (Placement(transformation(extent={{70,90},{50,110}})));
      Fluid.Movers.FlowControlled_m_flow fan(
        redeclare package Medium = Media.Water,
        m_flow_nominal=50,
        redeclare Fluid.Movers.Data.Pumps.Wilo.Stratos25slash1to4 per,
        inputType=Buildings.Fluid.Types.InputType.Continuous,
        addPowerToMedium=false,
        dp_nominal=50000,
        constantMassFlowRate=25)
        annotation (Placement(transformation(extent={{-100,20},{-80,40}})));
      Modelica.Blocks.Sources.Step step(
        height=-50,
        offset=50,
        startTime=201600)
        annotation (Placement(transformation(extent={{-120,62},{-100,82}})));
      Fluid.Sources.Boundary_pT bou2(
        redeclare package Medium = Media.Water,
        use_T_in=true,
        T=293.15,
        nPorts=2) annotation (Placement(transformation(extent={{-10,-10},{10,
                10}},
            rotation=270,
            origin={12,118})));
      Fluid.Movers.FlowControlled_m_flow fan1(
        redeclare package Medium = Media.Water,
        m_flow_nominal=50,
        redeclare Fluid.Movers.Data.Pumps.Wilo.Stratos25slash1to4 per,
        inputType=Buildings.Fluid.Types.InputType.Continuous,
        addPowerToMedium=false,
        dp_nominal=50000,
        constantMassFlowRate=10)
        annotation (Placement(transformation(extent={{32,0},{12,20}})));
      Modelica.Blocks.Sources.Step step1(
        height=0.5,
        offset=0,
        startTime=150000)
        annotation (Placement(transformation(extent={{-20,60},{0,80}})));
    equation
      connect(hex.port_a2, boundary1.ports[1]) annotation (Line(points={{100,4},{120,
              4},{120,-10},{140,-10}}, color={0,127,255}));
      connect(senTem3.port_b, bou.ports[1]) annotation (Line(points={{-60,-30},
              {-70,-30},{-70,-28},{-80,-28}},
                                         color={0,127,255}));
      connect(bou.ports[2], fan.port_a) annotation (Line(points={{-80,-32},{
              -80,10},{-116,10},{-116,30},{-100,30}}, color={0,127,255}));
      connect(fan.port_b, senTem.port_a)
        annotation (Line(points={{-80,30},{-60,30}}, color={0,127,255}));
      connect(step.y, fan.m_flow_in) annotation (Line(points={{-99,72},{-90,
              72},{-90,42}}, color={0,0,127}));
      connect(senTem2.port_a, hex.port_b2) annotation (Line(points={{60,-30},
              {70,-30},{70,4},{80,4}}, color={0,127,255}));
      connect(bou1.ports[1], senTem2.port_b)
        annotation (Line(points={{30,-30},{40,-30}}, color={0,127,255}));
      connect(hex.port_b1, senTem4.port_a) annotation (Line(points={{100,16},
              {108,16},{108,100},{70,100}}, color={0,127,255}));
      connect(senTem4.port_b, bou2.ports[1]) annotation (Line(points={{50,100},
              {14,100},{14,108}}, color={0,127,255}));
      connect(senTem4.T, bou2.T_in) annotation (Line(points={{60,111},{60,140},
              {16,140},{16,130}}, color={0,0,127}));
      connect(senTem.port_b, tan1.port_a) annotation (Line(points={{-40,30},{
              -34,30},{-34,46},{-2,46},{-2,30},{-8,30}}, color={0,127,255}));
      connect(tan1.port_b, senTem3.port_a) annotation (Line(points={{-28,30},
              {-28,-30},{-40,-30}}, color={0,127,255}));
      connect(fan1.port_b, tan1.portHex_b) annotation (Line(points={{12,10},{
              8,10},{8,12},{-8,12},{-8,22}}, color={0,127,255}));
      connect(tan1.portHex_a, senTem1.port_a) annotation (Line(points={{-8,
              26.2},{0,26.2},{0,26},{10,26},{10,52},{42,52}}, color={0,127,
              255}));
      connect(senTem1.port_b, hex.port_a1) annotation (Line(points={{62,52},{
              64,52},{64,16},{80,16}}, color={0,127,255}));
      connect(bou2.ports[2], fan1.port_a) annotation (Line(points={{10,108},{
              10,62},{36,62},{36,10},{32,10}}, color={0,127,255}));
      connect(step1.y, fan1.m_flow_in) annotation (Line(points={{1,70},{6,70},
              {6,42},{22,42},{22,22}}, color={0,0,127}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end ballon_f;

    model sst_ecs
      Fluid.Sources.Boundary_pT bou(
        redeclare package Medium = Media.Water,
        use_T_in=false,
        T=333.15,
        nPorts=1)
        annotation (Placement(transformation(extent={{-220,-40},{-200,-20}})));
      Fluid.Sensors.TemperatureTwoPort senTem(redeclare package Medium =
            Media.Water, m_flow_nominal=5)
        annotation (Placement(transformation(extent={{-60,0},{-40,20}})));
      Fluid.Sensors.TemperatureTwoPort senTem1(redeclare package Medium =
            Media.Water, m_flow_nominal=5)
        annotation (Placement(transformation(extent={{60,-40},{80,-20}})));
      Fluid.HeatExchangers.ConstantEffectiveness hex(
        redeclare package Medium1 = Media.Water,
        redeclare package Medium2 = Media.Water,
        m1_flow_nominal=25,
        m2_flow_nominal=20,
        dp1_nominal=1000,
        dp2_nominal=1000,
        eps=(55 - 15)/(56 - 15))
        annotation (Placement(transformation(extent={{100,-60},{120,-40}})));
      Fluid.Sources.MassFlowSource_T boundary1(
        redeclare package Medium = Media.Water,
        use_m_flow_in=true,
        m_flow=2,
        T=288.15,
        nPorts=1) annotation (Placement(transformation(extent={{260,-100},{
                240,-80}})));
      Fluid.Sensors.TemperatureTwoPort senTem2(redeclare package Medium =
            Media.Water, m_flow_nominal=25)
        annotation (Placement(transformation(extent={{80,-100},{60,-80}})));
      Fluid.Sources.Boundary_pT bou1(
        redeclare package Medium = Media.Water,
        T=293.15,
        nPorts=1) annotation (Placement(transformation(extent={{20,-100},{40,
                -80}})));
      Fluid.Sensors.TemperatureTwoPort senTem3(redeclare package Medium =
            Media.Water, m_flow_nominal=5)
        annotation (Placement(transformation(extent={{-60,-40},{-80,-20}})));
      Fluid.Storage.StratifiedEnhancedInternalHex tan1(
        redeclare package Medium = Media.Water,
        m_flow_nominal=25,
        VTan=15,
        hTan=2,
        dIns=0.1,
        nSeg=12,
        hHex_a=1,
        hHex_b=0.1,
        Q_flow_nominal=500000,
        TTan_nominal=332.15,
        THex_nominal=333.15,
        mHex_flow_nominal=25,
        redeclare package MediumHex =Media.Water)
        annotation (Placement(transformation(extent={{-20,20},{0,40}})));
      Fluid.Sensors.TemperatureTwoPort senTem4(redeclare package Medium =
            Media.Water, m_flow_nominal=5)
        annotation (Placement(transformation(extent={{70,90},{50,110}})));
      Fluid.Sources.Boundary_pT bou2(
        redeclare package Medium = Media.Water,
        T=293.15,
        nPorts=1) annotation (Placement(transformation(extent={{-10,-10},{10,
                10}},
            rotation=0,
            origin={30,-30})));
      Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor temperatureSensor
        annotation (Placement(transformation(extent={{-260,60},{-240,80}})));
      Modelica.Blocks.Logical.Hysteresis hysteresis(uLow=56 + 273.15, uHigh=
            59 + 273.15)
        annotation (Placement(transformation(extent={{-220,60},{-200,80}})));
      Buildings.Controls.OBC.CDL.Conversions.BooleanToReal booToRea(realTrue=
            0, realFalse=1)
        annotation (Placement(transformation(extent={{-180,60},{-160,80}})));
      Modelica.Blocks.Sources.CombiTimeTable combiTimeTable1(
        tableOnFile=true,
        tableName="tab1",
        fileName=ModelicaServices.ExternalReferences.loadResource(
            "modelica://Buildings/Data/sst/test_nexi.txt"),
        columns={2,3})
        annotation (Placement(transformation(extent={{342,-100},{322,-80}})));
      Modelica.Blocks.Math.Gain gain2(k=1/(4185*(55 - 15))) annotation (
          Placement(transformation(extent={{300,-100},{280,-80}})));
      Fluid.Sources.MassFlowSource_T boundary2(
        redeclare package Medium = Media.Water,
        use_m_flow_in=true,
        m_flow=2,
        use_T_in=true,
        T=288.15,
        nPorts=1) annotation (Placement(transformation(extent={{40,20},{20,40}})));
      Modelica.Blocks.Math.Gain gain1(k=(55 - 15)/(56 - 36))
                                                            annotation (
          Placement(transformation(extent={{100,20},{80,40}})));
      Fluid.HeatExchangers.ConstantEffectiveness hex1(
        redeclare package Medium1 = Media.Water,
        redeclare package Medium2 = Media.Water,
        m1_flow_nominal=25,
        m2_flow_nominal=20,
        dp1_nominal=1000,
        dp2_nominal=1000,
        eps=0.95)
        annotation (Placement(transformation(extent={{180,-60},{200,-40}})));
      Fluid.Sources.Boundary_pT bou3(
        redeclare package Medium = Media.Water,
        use_T_in=false,
        T=333.15,
        nPorts=1)
        annotation (Placement(transformation(extent={{-10,-10},{10,10}},
            rotation=270,
            origin={230,10})));
      Fluid.Sources.MassFlowSource_T boundary3(
        redeclare package Medium = Media.Water,
        use_m_flow_in=true,
        m_flow=2,
        T=333.15,
        nPorts=1) annotation (Placement(transformation(extent={{-100,0},{-80,
                20}})));
      Modelica.Blocks.Math.Gain gain3(k=30/3.6)             annotation (
          Placement(transformation(extent={{10,-10},{-10,10}},
            rotation=180,
            origin={-130,70})));
      DHC_Thassalia.Controls_a.opposite opposite
        annotation (Placement(transformation(extent={{140,120},{160,140}})));
      Modelica.Blocks.Math.Gain gain4(k=15/3.6)             annotation (
          Placement(transformation(extent={{10,-10},{-10,10}},
            rotation=90,
            origin={170,50})));
      Fluid.Sources.MassFlowSource_T boundary4(
        redeclare package Medium = Media.Water,
        use_m_flow_in=true,
        m_flow=2,
        T=319.15,
        nPorts=1) annotation (Placement(transformation(extent={{-10,-10},{10,
                10}},
            rotation=270,
            origin={162,10})));
      Fluid.Sensors.TemperatureTwoPort senTem5(redeclare package Medium =
            Media.Water, m_flow_nominal=25)
        annotation (Placement(transformation(extent={{156,-66},{136,-46}})));
      Fluid.Sensors.TemperatureTwoPort senTem6(redeclare package Medium =
            Media.Water, m_flow_nominal=25)
        annotation (Placement(transformation(extent={{206,-54},{226,-34}})));
    equation
      connect(senTem3.port_b, bou.ports[1]) annotation (Line(points={{-80,-30},
              {-100,-30},{-100,-30},{-200,-30}},
                                         color={0,127,255}));
      connect(senTem.port_b, tan1.portHex_a) annotation (Line(points={{-40,10},
              {-30,10},{-30,26.2},{-20,26.2}},
                                          color={0,127,255}));
      connect(senTem3.port_a, tan1.portHex_b) annotation (Line(points={{-60,-30},
              {-20,-30},{-20,22}},
                              color={0,127,255}));
      connect(senTem2.port_a, hex.port_b2) annotation (Line(points={{80,-90},
              {90,-90},{90,-56},{100,-56}},
                                       color={0,127,255}));
      connect(bou1.ports[1], senTem2.port_b)
        annotation (Line(points={{40,-90},{60,-90}}, color={0,127,255}));
      connect(hex.port_b1, senTem4.port_a) annotation (Line(points={{120,-44},
              {128,-44},{128,100},{70,100}},color={0,127,255}));
      connect(tan1.heaPorVol[2], temperatureSensor.port) annotation (Line(
            points={{-10,29.55},{-10,40},{-280,40},{-280,70},{-260,70}},
            color={191,0,0}));
      connect(temperatureSensor.T, hysteresis.u)
        annotation (Line(points={{-240,70},{-222,70}}, color={0,0,127}));
      connect(hysteresis.y, booToRea.u)
        annotation (Line(points={{-199,70},{-182,70}}, color={255,0,255}));
      connect(boundary1.m_flow_in, gain2.y) annotation (Line(points={{262,-82},
              {270,-82},{270,-90},{279,-90}}, color={0,0,127}));
      connect(combiTimeTable1.y[1], gain2.u)
        annotation (Line(points={{321,-90},{302,-90}}, color={0,0,127}));
      connect(bou2.ports[1], senTem1.port_a) annotation (Line(points={{40,-30},
              {50,-30},{50,-30},{60,-30}}, color={0,127,255}));
      connect(senTem1.port_b, hex.port_a1) annotation (Line(points={{80,-30},
              {90,-30},{90,-44},{100,-44}}, color={0,127,255}));
      connect(senTem1.T, boundary2.T_in) annotation (Line(points={{70,-19},{
              70,0},{50,0},{50,34},{42,34}}, color={0,0,127}));
      connect(boundary2.ports[1], tan1.port_b)
        annotation (Line(points={{20,30},{0,30}}, color={0,127,255}));
      connect(tan1.port_a, senTem4.port_b) annotation (Line(points={{-20,30},
              {-30,30},{-30,100},{50,100}}, color={0,127,255}));
      connect(boundary2.m_flow_in, gain1.y) annotation (Line(points={{42,38},
              {60,38},{60,30},{79,30}}, color={0,0,127}));
      connect(gain1.u, gain2.y) annotation (Line(points={{102,30},{274,30},{
              274,-90},{279,-90}}, color={0,0,127}));
      connect(hex1.port_a2, boundary1.ports[1]) annotation (Line(points={{200,
              -56},{212,-56},{212,-90},{240,-90}}, color={0,127,255}));
      connect(boundary3.ports[1], senTem.port_a)
        annotation (Line(points={{-80,10},{-60,10}}, color={0,127,255}));
      connect(booToRea.y, gain3.u)
        annotation (Line(points={{-158,70},{-142,70}}, color={0,0,127}));
      connect(gain3.y, boundary3.m_flow_in) annotation (Line(points={{-119,70},
              {-110,70},{-110,18},{-102,18}}, color={0,0,127}));
      connect(booToRea.y, opposite.u) annotation (Line(points={{-158,70},{
              -152,70},{-152,130},{138,130}}, color={0,0,127}));
      connect(opposite.y, gain4.u) annotation (Line(points={{161,130},{170,
              130},{170,62}}, color={0,0,127}));
      connect(gain4.y, boundary4.m_flow_in)
        annotation (Line(points={{170,39},{170,22}}, color={0,0,127}));
      connect(boundary4.ports[1], hex1.port_a1) annotation (Line(points={{162,
              -3.55271e-15},{162,-44},{180,-44}}, color={0,127,255}));
      connect(hex.port_a2, senTem5.port_b)
        annotation (Line(points={{120,-56},{136,-56}}, color={0,127,255}));
      connect(senTem5.port_a, hex1.port_b2)
        annotation (Line(points={{156,-56},{180,-56}}, color={0,127,255}));
      connect(hex1.port_b1, senTem6.port_a)
        annotation (Line(points={{200,-44},{206,-44}}, color={0,127,255}));
      connect(senTem6.port_b, bou3.ports[1]) annotation (Line(points={{226,
              -44},{230,-44},{230,-3.55271e-15}}, color={0,127,255}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)),
        experiment(
          StopTime=400000,
          Interval=200,
          __Dymola_Algorithm="Dassl"));
    end sst_ecs;

    model timetable
      Modelica.Blocks.Sources.CombiTimeTable combiTimeTable(
        tableOnFile=true,
        tableName="tab1",
        fileName=ModelicaServices.ExternalReferences.loadResource(
            "modelica://Buildings/Data/sst/jan_20/test_cast.txt"),
        columns={2,3})
        annotation (Placement(transformation(extent={{-40,0},{-20,20}})));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end timetable;

    model stratified
      Fluid.Sources.MassFlowSource_T boundary3(
          redeclare package Medium = Media.Water,
          use_m_flow_in=true,
          m_flow=5,
          T=333.15,
          nPorts=1)
                  annotation (Placement(transformation(extent={{-100,40},{-80,
                  60}})));
      Fluid.Sensors.TemperatureTwoPort senTem(redeclare package Medium =
              Media.Water, m_flow_nominal=5)
        annotation (Placement(transformation(extent={{-60,40},{-40,60}})));
      Fluid.Sensors.TemperatureTwoPort senTem3(redeclare package Medium =
              Media.Water, m_flow_nominal=5)
        annotation (Placement(transformation(extent={{-20,-40},{-40,-20}})));
      Fluid.Sources.Boundary_pT bou(
          redeclare package Medium = Media.Water,
          use_T_in=false,
          T=333.15,
          nPorts=1)
        annotation (Placement(transformation(extent={{-100,-40},{-80,-20}})));
        Fluid.Storage.StratifiedEnhanced tan1(
          redeclare package Medium = Media.Water,
          m_flow_nominal=20,
          VTan=10,
          hTan=10,
          dIns=0.05,
          nSeg=10)
          annotation (Placement(transformation(extent={{20,0},{40,20}})));
        Fluid.FixedResistances.Junction jun(
          redeclare package Medium = Media.Water,
          m_flow_nominal={5,-5,-5},
          dp_nominal={0,0,0})
          annotation (Placement(transformation(extent={{0,40},{20,60}})));
        Fluid.FixedResistances.Junction jun1(
          redeclare package Medium = Media.Water,
          m_flow_nominal={5,5,-5},
          dp_nominal={0,0,0}) annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=180,
              origin={50,-30})));
      Fluid.Sensors.TemperatureTwoPort senTem1(redeclare package Medium =
              Media.Water, m_flow_nominal=5)
        annotation (Placement(transformation(extent={{90,40},{110,60}})));
      Fluid.Sensors.TemperatureTwoPort senTem2(redeclare package Medium =
              Media.Water, m_flow_nominal=5)
        annotation (Placement(transformation(extent={{100,-40},{80,-20}})));
        Fluid.Sources.PropertySource_T proSou(use_T_in=true, redeclare package
            Medium = Media.Water) annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=270,
              origin={150,10})));
        Modelica.Blocks.Math.Add add
          annotation (Placement(transformation(extent={{200,60},{220,80}})));
        Modelica.Blocks.Sources.RealExpression realExpression(y=-10)
          annotation (Placement(transformation(extent={{160,50},{180,70}})));
        Fluid.Movers.FlowControlled_m_flow fan(
          redeclare package Medium = Media.Water,
          m_flow_nominal=2,
          redeclare Fluid.Movers.Data.Pumps.Wilo.Stratos25slash1to8 per,
          inputType=Buildings.Fluid.Types.InputType.Constant,
          dp_nominal=1000,
          constantMassFlowRate=2)
          annotation (Placement(transformation(extent={{50,40},{70,60}})));
        Modelica.Blocks.Sources.Step step(
          height=-5,
          offset=5,
          startTime=10000)
          annotation (Placement(transformation(extent={{-160,40},{-140,60}})));
    equation
        connect(boundary3.ports[1], senTem.port_a) annotation (Line(points={{
                -80,50},{-71,50},{-71,50},{-60,50}}, color={0,127,255}));
        connect(senTem.port_b, jun.port_1)
          annotation (Line(points={{-40,50},{0,50}}, color={0,127,255}));
        connect(jun.port_3, tan1.port_a) annotation (Line(points={{10,40},{10,
                10},{20,10}}, color={0,127,255}));
        connect(tan1.port_b, jun1.port_3) annotation (Line(points={{40,10},{50,
                10},{50,-20}}, color={0,127,255}));
        connect(bou.ports[1], senTem3.port_b)
          annotation (Line(points={{-80,-30},{-40,-30}}, color={0,127,255}));
        connect(senTem3.port_a, jun1.port_2)
          annotation (Line(points={{-20,-30},{40,-30}}, color={0,127,255}));
        connect(jun1.port_1, senTem2.port_b)
          annotation (Line(points={{60,-30},{80,-30}}, color={0,127,255}));
        connect(senTem1.port_b, proSou.port_a) annotation (Line(points={{110,50},
                {150,50},{150,20}}, color={0,127,255}));
        connect(proSou.port_b, senTem2.port_a) annotation (Line(points={{150,
                -3.55271e-15},{150,-30},{100,-30}}, color={0,127,255}));
        connect(realExpression.y, add.u2) annotation (Line(points={{181,60},{
                188,60},{188,64},{198,64}}, color={0,0,127}));
        connect(senTem1.T, add.u1) annotation (Line(points={{100,61},{100,76},{
                198,76}}, color={0,0,127}));
        connect(add.y, proSou.T_in) annotation (Line(points={{221,70},{236,70},
                {236,14},{162,14}}, color={0,0,127}));
        connect(jun.port_2, fan.port_a)
          annotation (Line(points={{20,50},{50,50}}, color={0,127,255}));
        connect(fan.port_b, senTem1.port_a)
          annotation (Line(points={{70,50},{90,50}}, color={0,127,255}));
        connect(step.y, boundary3.m_flow_in) annotation (Line(points={{-139,50},
                {-120,50},{-120,58},{-102,58}}, color={0,0,127}));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
              coordinateSystem(preserveAspectRatio=false)));
    end stratified;

    model stratified_0
      Fluid.Sources.MassFlowSource_T boundary3(
          redeclare package Medium = Media.Water,
          m_flow=5,
          T=333.15,
          nPorts=1)
                  annotation (Placement(transformation(extent={{-100,40},{-80,
                  60}})));
      Fluid.Sources.Boundary_pT bou(
          redeclare package Medium = Media.Water,
          use_T_in=false,
          T=333.15,
          nPorts=1)
        annotation (Placement(transformation(extent={{-100,-40},{-80,-20}})));
      Fluid.Sensors.TemperatureTwoPort senTem1(redeclare package Medium =
              Media.Water, m_flow_nominal=5)
        annotation (Placement(transformation(extent={{80,40},{100,60}})));
      Fluid.Sensors.TemperatureTwoPort senTem2(redeclare package Medium =
              Media.Water, m_flow_nominal=5)
        annotation (Placement(transformation(extent={{100,-40},{80,-20}})));
        Fluid.Sources.PropertySource_T proSou(use_T_in=true, redeclare package
            Medium = Media.Water) annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=270,
              origin={150,10})));
        Modelica.Blocks.Math.Add add
          annotation (Placement(transformation(extent={{200,60},{220,80}})));
        Modelica.Blocks.Sources.RealExpression realExpression(y=-10)
          annotation (Placement(transformation(extent={{160,50},{180,70}})));
    equation
        connect(senTem1.port_b, proSou.port_a) annotation (Line(points={{100,50},
                {150,50},{150,20}}, color={0,127,255}));
        connect(proSou.port_b, senTem2.port_a) annotation (Line(points={{150,
                -3.55271e-15},{150,-30},{100,-30}}, color={0,127,255}));
        connect(realExpression.y, add.u2) annotation (Line(points={{181,60},{
                188,60},{188,64},{198,64}}, color={0,0,127}));
        connect(senTem1.T, add.u1) annotation (Line(points={{90,61},{90,76},{
                198,76},{198,76}}, color={0,0,127}));
        connect(add.y, proSou.T_in) annotation (Line(points={{221,70},{236,70},
                {236,14},{162,14}}, color={0,0,127}));
        connect(boundary3.ports[1], senTem1.port_a) annotation (Line(points={{
                -80,50},{0,50},{0,50},{80,50}}, color={0,127,255}));
        connect(senTem2.port_b, bou.ports[1]) annotation (Line(points={{80,-30},
                {0,-30},{0,-30},{-80,-30}}, color={0,127,255}));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
              coordinateSystem(preserveAspectRatio=false)));
    end stratified_0;

    model stratified_1
      Fluid.Sources.MassFlowSource_T boundary3(
          redeclare package Medium = Media.Water,
          use_m_flow_in=true,
          m_flow=5,
          T=333.15,
          nPorts=1)
                  annotation (Placement(transformation(extent={{-100,40},{-80,
                  60}})));
      Fluid.Sensors.TemperatureTwoPort senTem(redeclare package Medium =
              Media.Water, m_flow_nominal=5)
        annotation (Placement(transformation(extent={{-60,40},{-40,60}})));
      Fluid.Sensors.TemperatureTwoPort senTem3(redeclare package Medium =
              Media.Water, m_flow_nominal=5)
        annotation (Placement(transformation(extent={{-20,-40},{-40,-20}})));
      Fluid.Sources.Boundary_pT bou(
          redeclare package Medium = Media.Water,
          use_T_in=false,
          T=333.15,
          nPorts=1)
        annotation (Placement(transformation(extent={{-100,-40},{-80,-20}})));
        Fluid.Storage.StratifiedEnhanced tan1(
          redeclare package Medium = Media.Water,
          m_flow_nominal=20,
          VTan=10,
          hTan=10,
          dIns=0.05,
          nSeg=10)
          annotation (Placement(transformation(extent={{20,0},{40,20}})));
      Fluid.Sensors.TemperatureTwoPort senTem1(redeclare package Medium =
              Media.Water, m_flow_nominal=5)
        annotation (Placement(transformation(extent={{90,40},{110,60}})));
      Fluid.Sensors.TemperatureTwoPort senTem2(redeclare package Medium =
              Media.Water, m_flow_nominal=5)
        annotation (Placement(transformation(extent={{100,-40},{80,-20}})));
        Fluid.Sources.PropertySource_T proSou(use_T_in=true, redeclare package
            Medium = Media.Water) annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=270,
              origin={150,10})));
        Modelica.Blocks.Math.Add add
          annotation (Placement(transformation(extent={{180,60},{200,80}})));
        Modelica.Blocks.Sources.RealExpression realExpression(y=-10)
          annotation (Placement(transformation(extent={{140,50},{160,70}})));
        Fluid.Movers.FlowControlled_m_flow fan(
          redeclare package Medium = Media.Water,
          m_flow_nominal=2,
          redeclare Fluid.Movers.Data.Pumps.Wilo.Stratos25slash1to8 per,
          inputType=Buildings.Fluid.Types.InputType.Constant,
          dp_nominal=1000,
          constantMassFlowRate=2)
          annotation (Placement(transformation(extent={{50,40},{70,60}})));
        Modelica.Blocks.Sources.Step step(
          height=-5,
          offset=5,
          startTime=10000)
          annotation (Placement(transformation(extent={{-160,40},{-140,60}})));
    equation
        connect(boundary3.ports[1], senTem.port_a) annotation (Line(points={{
                -80,50},{-71,50},{-71,50},{-60,50}}, color={0,127,255}));
        connect(bou.ports[1], senTem3.port_b)
          annotation (Line(points={{-80,-30},{-40,-30}}, color={0,127,255}));
        connect(senTem1.port_b, proSou.port_a) annotation (Line(points={{110,50},
                {150,50},{150,20}}, color={0,127,255}));
        connect(proSou.port_b, senTem2.port_a) annotation (Line(points={{150,
                -3.55271e-15},{150,-30},{100,-30}}, color={0,127,255}));
        connect(realExpression.y, add.u2) annotation (Line(points={{161,60},{
                168,60},{168,64},{178,64}}, color={0,0,127}));
        connect(senTem1.T, add.u1) annotation (Line(points={{100,61},{100,76},{
                178,76}}, color={0,0,127}));
        connect(add.y, proSou.T_in) annotation (Line(points={{201,70},{220,70},
                {220,14},{162,14}}, color={0,0,127}));
        connect(fan.port_b, senTem1.port_a)
          annotation (Line(points={{70,50},{90,50}}, color={0,127,255}));
        connect(step.y, boundary3.m_flow_in) annotation (Line(points={{-139,50},
                {-120,50},{-120,58},{-102,58}}, color={0,0,127}));
        connect(senTem.port_b, tan1.port_a) annotation (Line(points={{-40,50},{
                10,50},{10,10},{20,10}}, color={0,127,255}));
        connect(tan1.port_a, fan.port_a) annotation (Line(points={{20,10},{10,
                10},{10,50},{50,50}}, color={0,127,255}));
        connect(tan1.port_b, senTem3.port_a) annotation (Line(points={{40,10},{
                52,10},{52,-30},{-20,-30}}, color={0,127,255}));
        connect(tan1.port_b, senTem2.port_b) annotation (Line(points={{40,10},{
                52,10},{52,-30},{80,-30}}, color={0,127,255}));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
              coordinateSystem(preserveAspectRatio=false)));
    end stratified_1;
  end Tests;
end ECS;


    package SST_Main
    extends Modelica.Icons.VariantsPackage;
      model SST_basic
      extends Fluid.Interfaces.PartialTwoPortInterface;
      DHC_Thassalia.RJC.Heat_exchanger_basic heat_exchanger_basic
        annotation (Placement(transformation(extent={{-50,-80},{-30,-60}})));
      DHC_Thassalia.RJF.Cold_exchanger cold_exchanger
        annotation (Placement(transformation(extent={{40,-80},{60,-60}})));
      Fluid.FixedResistances.Junction jun
        annotation (Placement(transformation(extent={{-80,-40},{-60,-20}})));
      Fluid.FixedResistances.Junction jun1
        annotation (Placement(transformation(extent={{-20,-40},{0,-20}})));
      Fluid.FixedResistances.Junction jun2
        annotation (Placement(transformation(extent={{10,-40},{30,-20}})));
      Fluid.FixedResistances.Junction jun3
        annotation (Placement(transformation(extent={{70,-40},{90,-20}})));
      Fluid.Chillers.Carnot_TEva chi
        annotation (Placement(transformation(extent={{-12,-160},{8,-140}})));
      equation
      connect(port_a, jun.port_1) annotation (Line(points={{-100,0},{-90,0},{
              -90,-30},{-80,-30}}, color={0,127,255}));
      connect(jun.port_3, heat_exchanger_basic.port_a1) annotation (Line(points=
             {{-70,-40},{-70,-64},{-50,-64}}, color={0,127,255}));
      connect(jun.port_2, jun1.port_1)
        annotation (Line(points={{-60,-30},{-20,-30}}, color={0,127,255}));
      connect(heat_exchanger_basic.port_b1, jun1.port_3) annotation (Line(
            points={{-30,-64},{-10,-64},{-10,-40}}, color={0,127,255}));
      connect(jun1.port_2, jun2.port_1)
        annotation (Line(points={{0,-30},{10,-30}}, color={0,127,255}));
      connect(jun2.port_2, jun3.port_1)
        annotation (Line(points={{30,-30},{70,-30}}, color={0,127,255}));
      connect(jun3.port_2, port_b) annotation (Line(points={{90,-30},{96,-30},{
              96,0},{100,0}}, color={0,127,255}));
      connect(jun2.port_3, cold_exchanger.port_a1) annotation (Line(points={{20,
              -40},{20,-64},{40,-64}}, color={0,127,255}));
      connect(cold_exchanger.port_b1, jun3.port_3) annotation (Line(points={{60,
              -64},{80,-64},{80,-40}}, color={0,127,255}));
      annotation (Diagram(coordinateSystem(extent={{-220,-240},{220,20}})));
      end SST_basic;

    package Tests
    extends Modelica.Icons.ExamplesPackage;
    end Tests;
    end SST_Main;

  package SST
    extends Modelica.Icons.VariantsPackage;

    model SST_ECS_HE
      extends Fluid.Interfaces.PartialTwoPortInterface;

      parameter String fileName=
          ModelicaServices.ExternalReferences.loadResource(
          "modelica://Buildings/Data/tfp_he.txt") "File where matrix is stored"
    annotation (Dialog(
          loadSelector(filter="Text files (*.txt);;MATLAB MAT-files (*.mat)",
              caption="Open file in which table is present")));

      Fluid.Storage.StratifiedEnhancedInternalHex tan1(
        redeclare package Medium = Media.Water,
        m_flow_nominal=25,
        VTan=5,
        hTan=2,
        dIns=0.1,
        nSeg=12,
        hHex_a=1,
        hHex_b=0.1,
        Q_flow_nominal=500000,
        TTan_nominal=332.15,
        THex_nominal=333.15,
        mHex_flow_nominal=25,
        redeclare package MediumHex = Media.Water)
        annotation (Placement(transformation(extent={{60,20},{80,40}})));
      Fluid.Sources.Boundary_pT bou(redeclare package Medium = Media.Water,
          nPorts=1)
        annotation (Placement(transformation(extent={{180,74},{160,94}})));
      Fluid.HeatExchangers.ConstantEffectiveness hex1(
        redeclare package Medium1 = Media.Water,
        redeclare package Medium2 = Media.Water,
        m1_flow_nominal=50,
        m2_flow_nominal=50,
        dp1_nominal=10000,
        dp2_nominal=10000,
        eps=0.9)
        annotation (Placement(transformation(extent={{-20,80},{-40,100}})));
      Fluid.Actuators.Valves.TwoWayLinear val_storage(
        redeclare package Medium = Media.Water,
        m_flow_nominal=70/3.6,
        dpValve_nominal=5000,
        use_inputFilter=false)
        annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
      Fluid.Actuators.Valves.TwoWayLinear val_preheat(
        redeclare package Medium = Media.Water,
        m_flow_nominal=10,
        dpValve_nominal=5000,
        use_inputFilter=false)
        annotation (Placement(transformation(extent={{-80,50},{-60,70}})));
      Fluid.HeatExchangers.ConstantEffectiveness hex2(
        redeclare package Medium1 = Media.Water,
        redeclare package Medium2 = Media.Water,
        m1_flow_nominal=50,
        m2_flow_nominal=50,
        dp1_nominal=10000,
        dp2_nominal=10000,
        eps=0.9)
        annotation (Placement(transformation(extent={{80,80},{60,100}})));
      Fluid.Sources.MassFlowSource_T boundary(
        redeclare package Medium = Media.Water,
        use_m_flow_in=true,
        m_flow=0.5,
        T=288.15,
        nPorts=1)
        annotation (Placement(transformation(extent={{-100,160},{-80,180}})));
      Fluid.Sources.Boundary_pT bou1(redeclare package Medium = Media.Water,
          nPorts=1)
        annotation (Placement(transformation(extent={{140,130},{120,150}})));
      Fluid.Sensors.TemperatureTwoPort T_sec_intermediate(redeclare package
          Medium =
            Media.Water, m_flow_nominal=50)
        annotation (Placement(transformation(extent={{10,110},{30,130}})));
      Fluid.Sensors.TemperatureTwoPort T_sec_out(redeclare package Medium =
            Media.Water, m_flow_nominal=50)
        annotation (Placement(transformation(extent={{80,130},{100,150}})));
      Fluid.Sensors.TemperatureTwoPort T_prim_in(redeclare package Medium =
            Media.Water, m_flow_nominal=50)
        annotation (Placement(transformation(extent={{20,74},{40,94}})));
      Fluid.Sensors.TemperatureTwoPort T_prim_out(redeclare package Medium =
            Media.Water, m_flow_nominal=50)
        annotation (Placement(transformation(extent={{110,74},{130,94}})));
      Modelica.Blocks.Sources.CombiTimeTable combiTimeTable(
        tableOnFile=true,
        tableName="tab1",
        fileName=fileName,
        columns={2,3})
        annotation (Placement(transformation(extent={{-200,160},{-180,180}})));

      Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor temperatureSensor
        annotation (Placement(transformation(extent={{80,-62},{100,-42}})));
      Modelica.Blocks.Logical.Hysteresis hysteresis(uLow=56 + 273.15, uHigh=60
             + 273.15)
        annotation (Placement(transformation(extent={{120,-62},{140,-42}})));
      Buildings.Controls.OBC.CDL.Conversions.BooleanToReal booToRea(realTrue=0,
          realFalse=1)
        annotation (Placement(transformation(extent={{160,-62},{180,-42}})));
      Modelica.Blocks.Interfaces.RealOutput y_storage annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={0,210}), iconTransformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={0,110})));
      Buildings.Controls.Continuous.LimPID pid_storage(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=0.05,
        Ti=15,
        yMax=1)
        annotation (Placement(transformation(extent={{260,-60},{280,-40}})));
      Buildings.Controls.Continuous.LimPID pid_preheat(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=0.05,
        Ti=15,
        yMax=1)
        annotation (Placement(transformation(extent={{300,-160},{320,-140}})));
      Fluid.Sensors.MassFlowRate senMasFlo(redeclare package Medium =
            Media.Water)
        annotation (Placement(transformation(extent={{40,-40},{60,-20}})));
      Fluid.Sensors.MassFlowRate senMasFlo1(redeclare package Medium =
            Media.Water)
        annotation (Placement(transformation(extent={{20,-10},{40,10}})));
      Modelica.Blocks.Math.Product product1
        annotation (Placement(transformation(extent={{200,-90},{220,-70}})));
      Modelica.Blocks.Sources.RealExpression realExpression1(y=66/3.6)
        annotation (Placement(transformation(extent={{140,-100},{160,-80}})));
      Modelica.Blocks.Math.Product product2
        annotation (Placement(transformation(extent={{240,-160},{260,-140}})));
      DHC_Thassalia.Controls_a.opposite opposite
        annotation (Placement(transformation(extent={{200,-154},{220,-134}})));
      Modelica.Blocks.Sources.RealExpression realExpression2(y=66/3.6)
        annotation (Placement(transformation(extent={{200,-178},{220,-158}})));
      Modelica.Blocks.Math.Gain gain1(k=(55 - 15)/(56 - 36))
                                                            annotation (
          Placement(transformation(extent={{160,20},{140,40}})));
      Fluid.Sources.MassFlowSource_T boundary1(
        redeclare package Medium = Media.Water,
        use_m_flow_in=true,
        m_flow=0.5,
        use_T_in=true,
        T=288.15,
        nPorts=1)
        annotation (Placement(transformation(extent={{120,20},{100,40}})));
      Modelica.Blocks.Math.Gain gain2(k=1/(4185*(55 - 15))) annotation (
          Placement(transformation(extent={{-160,160},{-140,180}})));
    equation
      connect(port_a, val_storage.port_a)
        annotation (Line(points={{-100,0},{-60,0}}, color={0,127,255}));
      connect(val_storage.port_b, tan1.portHex_a) annotation (Line(points={{-40,0},{
              0,0},{0,26.2},{60,26.2}}, color={0,127,255}));
      connect(port_a, val_preheat.port_a)
        annotation (Line(points={{-100,0},{-100,60},{-80,60}}, color={0,127,255}));
      connect(val_preheat.port_b, hex1.port_a2) annotation (Line(points={{-60,60},{-54,
              60},{-54,84},{-40,84}}, color={0,127,255}));
      connect(boundary.ports[1], hex1.port_a1) annotation (Line(points={{-80,170},{-10,
              170},{-10,96},{-20,96}},      color={0,127,255}));
      connect(hex1.port_b1, T_sec_intermediate.port_a) annotation (Line(points={{-40,
              96},{-50,96},{-50,120},{10,120}}, color={0,127,255}));
      connect(T_sec_intermediate.port_b, hex2.port_a1) annotation (Line(points={{30,
              120},{90,120},{90,96},{80,96}}, color={0,127,255}));
      connect(hex2.port_b1, T_sec_out.port_a) annotation (Line(points={{60,96},{50,96},
              {50,140},{80,140}}, color={0,127,255}));
      connect(T_sec_out.port_b, bou1.ports[1])
        annotation (Line(points={{100,140},{120,140}}, color={0,127,255}));
      connect(tan1.port_a, T_prim_in.port_a) annotation (Line(points={{60,30},{10,30},
              {10,84},{20,84}}, color={0,127,255}));
      connect(T_prim_in.port_b, hex2.port_a2)
        annotation (Line(points={{40,84},{60,84}}, color={0,127,255}));
      connect(hex2.port_b2, T_prim_out.port_a)
        annotation (Line(points={{80,84},{110,84}}, color={0,127,255}));
      connect(T_prim_out.port_b, bou.ports[1])
        annotation (Line(points={{130,84},{160,84}},          color={0,127,255}));
      connect(tan1.heaPorVol[2], temperatureSensor.port)
        annotation (Line(points={{70,29.55},{70,-52},{80,-52}}, color={191,0,0}));
      connect(temperatureSensor.T, hysteresis.u)
        annotation (Line(points={{100,-52},{118,-52}}, color={0,0,127}));
      connect(hysteresis.y, booToRea.u)
        annotation (Line(points={{141,-52},{158,-52}}, color={255,0,255}));
      connect(hex1.port_b2, senMasFlo.port_a) annotation (Line(points={{-20,84},{-10,
              84},{-10,-30},{40,-30}}, color={0,127,255}));
      connect(senMasFlo.port_b, port_b)
        annotation (Line(points={{60,-30},{100,-30},{100,0}}, color={0,127,255}));
      connect(tan1.portHex_b, senMasFlo1.port_a) annotation (Line(points={{60,22},{10,
              22},{10,0},{20,0}}, color={0,127,255}));
      connect(senMasFlo1.port_b, port_b)
        annotation (Line(points={{40,0},{100,0}}, color={0,127,255}));
      connect(booToRea.y, product1.u1) annotation (Line(points={{182,-52},{190,-52},
              {190,-74},{198,-74}}, color={0,0,127}));
      connect(realExpression1.y, product1.u2) annotation (Line(points={{161,-90},{180,
              -90},{180,-86},{198,-86}}, color={0,0,127}));
      connect(product1.y, pid_storage.u_s) annotation (Line(points={{221,-80},{240,-80},
              {240,-50},{258,-50}}, color={0,0,127}));
      connect(senMasFlo1.m_flow, pid_storage.u_m) annotation (Line(points={{30,11},{
              30,14},{14,14},{14,-110},{270,-110},{270,-62}}, color={0,0,127}));
      connect(pid_storage.y, val_storage.y) annotation (Line(points={{281,-50},{300,
              -50},{300,-120},{-28,-120},{-28,20},{-50,20},{-50,12}}, color={0,0,127}));
      connect(opposite.y, product2.u1)
        annotation (Line(points={{221,-144},{238,-144}}, color={0,0,127}));
      connect(booToRea.y, opposite.u) annotation (Line(points={{182,-52},{190,-52},{
              190,-144},{198,-144}}, color={0,0,127}));
      connect(senMasFlo.m_flow, pid_preheat.u_m) annotation (Line(points={{50,-19},{
              50,-16},{30,-16},{30,-180},{310,-180},{310,-162}}, color={0,0,127}));
      connect(product2.y, pid_preheat.u_s)
        annotation (Line(points={{261,-150},{298,-150}}, color={0,0,127}));
      connect(realExpression2.y, product2.u2) annotation (Line(points={{221,-168},{228.5,
              -168},{228.5,-156},{238,-156}}, color={0,0,127}));
      connect(pid_preheat.y, val_preheat.y) annotation (Line(points={{321,-150},{342,
              -150},{342,-200},{-90,-200},{-90,80},{-70,80},{-70,72}}, color={0,0,127}));
      connect(val_storage.y_actual, y_storage) annotation (Line(points={{-45,7},{-20,
              7},{-20,50},{0,50},{0,210}}, color={0,0,127}));
      connect(gain1.y, boundary1.m_flow_in) annotation (Line(points={{139,30},{
              132,30},{132,38},{122,38}}, color={0,0,127}));
      connect(T_prim_out.T, boundary1.T_in) annotation (Line(points={{120,95},{
              120,100},{136,100},{136,34},{122,34}}, color={0,0,127}));
      connect(boundary1.ports[1], tan1.port_b)
        annotation (Line(points={{100,30},{80,30}}, color={0,127,255}));
      connect(gain2.y, boundary.m_flow_in) annotation (Line(points={{-139,170},
              {-120,170},{-120,178},{-102,178}}, color={0,0,127}));
      connect(gain2.y, gain1.u) annotation (Line(points={{-139,170},{-130,170},
              {-130,240},{200,240},{200,30},{162,30}}, color={0,0,127}));
      connect(combiTimeTable.y[2], gain2.u)
        annotation (Line(points={{-179,170},{-162,170}}, color={0,0,127}));
      annotation (Diagram(coordinateSystem(extent={{-180,-20},{180,200}})), Icon(
            graphics={Rectangle(
              extent={{-40,60},{40,0}},
              lineColor={238,46,47},
              fillColor={238,46,47},
              fillPattern=FillPattern.Solid), Rectangle(
              extent={{-40,0},{40,-60}},
              lineColor={244,125,35},
              fillColor={244,125,35},
              fillPattern=FillPattern.Solid)}));
    end SST_ECS_HE;

    model SST_ECS_stratified
      extends Fluid.Interfaces.PartialTwoPortInterface;

      parameter String fileName=
          ModelicaServices.ExternalReferences.loadResource(
          "modelica://Buildings/Data/tfp_he.txt") "File where matrix is stored"
    annotation (Dialog(
          loadSelector(filter="Text files (*.txt);;MATLAB MAT-files (*.mat)",
              caption="Open file in which table is present")));

      Fluid.HeatExchangers.ConstantEffectiveness hex1(
        redeclare package Medium1 = Media.Water,
        redeclare package Medium2 = Media.Water,
        m1_flow_nominal=50,
        m2_flow_nominal=50,
        dp1_nominal=10000,
        dp2_nominal=10000,
        eps=0.9)
        annotation (Placement(transformation(extent={{-20,110},{-40,130}})));
      Fluid.Actuators.Valves.TwoWayLinear val_storage(
        redeclare package Medium = Media.Water,
        m_flow_nominal=70/3.6,
        dpValve_nominal=5000,
        use_inputFilter=false)
        annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
      Fluid.Actuators.Valves.TwoWayLinear val_preheat(
        redeclare package Medium = Media.Water,
        m_flow_nominal=10,
        dpValve_nominal=5000,
        use_inputFilter=false)
        annotation (Placement(transformation(extent={{-80,80},{-60,100}})));
      Fluid.HeatExchangers.ConstantEffectiveness hex2(
        redeclare package Medium1 = Media.Water,
        redeclare package Medium2 = Media.Water,
        m1_flow_nominal=50,
        m2_flow_nominal=50,
        dp1_nominal=10000,
        dp2_nominal=10000,
        eps=0.9)
        annotation (Placement(transformation(extent={{140,106},{120,126}})));
      Fluid.Sources.MassFlowSource_T boundary(
        redeclare package Medium = Media.Water,
        use_m_flow_in=true,
        m_flow=0.5,
        T=288.15,
        nPorts=1)
        annotation (Placement(transformation(extent={{-100,160},{-80,180}})));
      Fluid.Sources.Boundary_pT bou1(redeclare package Medium = Media.Water,
          nPorts=1)
        annotation (Placement(transformation(extent={{200,160},{180,180}})));
      Fluid.Sensors.TemperatureTwoPort T_sec_intermediate(redeclare package
          Medium =
            Media.Water, m_flow_nominal=50)
        annotation (Placement(transformation(extent={{10,140},{30,160}})));
      Fluid.Sensors.TemperatureTwoPort T_sec_out(redeclare package Medium =
            Media.Water, m_flow_nominal=50)
        annotation (Placement(transformation(extent={{120,160},{140,180}})));
      Fluid.Sensors.TemperatureTwoPort T_prim_in(redeclare package Medium =
            Media.Water, m_flow_nominal=50)
        annotation (Placement(transformation(extent={{80,100},{100,120}})));
      Fluid.Sensors.TemperatureTwoPort T_prim_out(redeclare package Medium =
            Media.Water, m_flow_nominal=50)
        annotation (Placement(transformation(extent={{170,100},{190,120}})));
      Modelica.Blocks.Sources.CombiTimeTable combiTimeTable(
        tableOnFile=true,
        tableName="tab1",
        fileName=fileName,
        columns={2,3})
        annotation (Placement(transformation(extent={{-200,160},{-180,180}})));

      Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor temperatureSensor
        annotation (Placement(transformation(extent={{80,-62},{100,-42}})));
      Modelica.Blocks.Logical.Hysteresis hysteresis(uLow=56 + 273.15, uHigh=60
             + 273.15)
        annotation (Placement(transformation(extent={{120,-62},{140,-42}})));
      Buildings.Controls.OBC.CDL.Conversions.BooleanToReal booToRea(realTrue=0,
          realFalse=1)
        annotation (Placement(transformation(extent={{160,-62},{180,-42}})));
      Modelica.Blocks.Interfaces.RealOutput y_storage annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={0,210}), iconTransformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={0,110})));
      Buildings.Controls.Continuous.LimPID pid_storage(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=0.05,
        Ti=15,
        yMax=1)
        annotation (Placement(transformation(extent={{260,-60},{280,-40}})));
      Buildings.Controls.Continuous.LimPID pid_preheat(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=0.05,
        Ti=15,
        yMax=1)
        annotation (Placement(transformation(extent={{300,-160},{320,-140}})));
      Fluid.Sensors.MassFlowRate senMasFlo(redeclare package Medium =
            Media.Water)
        annotation (Placement(transformation(extent={{40,-40},{60,-20}})));
      Fluid.Sensors.MassFlowRate senMasFlo1(redeclare package Medium =
            Media.Water)
        annotation (Placement(transformation(extent={{-10,-10},{10,10}},
            rotation=270,
            origin={170,20})));
      Modelica.Blocks.Math.Product product1
        annotation (Placement(transformation(extent={{200,-90},{220,-70}})));
      Modelica.Blocks.Sources.RealExpression realExpression1(y=66/3.6)
        annotation (Placement(transformation(extent={{140,-100},{160,-80}})));
      Modelica.Blocks.Math.Product product2
        annotation (Placement(transformation(extent={{240,-160},{260,-140}})));
      DHC_Thassalia.Controls_a.opposite opposite
        annotation (Placement(transformation(extent={{200,-154},{220,-134}})));
      Modelica.Blocks.Sources.RealExpression realExpression2(y=66/3.6)
        annotation (Placement(transformation(extent={{200,-178},{220,-158}})));
      Modelica.Blocks.Math.Gain gain2(k=1/(4185*(55 - 15))) annotation (
          Placement(transformation(extent={{-160,160},{-140,180}})));
      Fluid.Storage.StratifiedEnhanced tan1(
        redeclare package Medium = Media.Water,
        m_flow_nominal=20,
        VTan=10,
        hTan=10,
        dIns=0.05,
        nSeg=10)
        annotation (Placement(transformation(extent={{100,40},{120,60}})));
      Fluid.FixedResistances.Junction jun(
        redeclare package Medium = Media.Water,
        m_flow_nominal={5,-5,-5},
        dp_nominal={0,0,0}) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={30,50})));
      Fluid.Movers.FlowControlled_m_flow fan(
        redeclare package Medium = Media.Water,
        m_flow_nominal=2,
        redeclare Fluid.Movers.Data.Pumps.Wilo.Stratos25slash1to8 per,
        inputType=Buildings.Fluid.Types.InputType.Constant,
        dp_nominal=1000,
        constantMassFlowRate=2)
        annotation (Placement(transformation(extent={{40,100},{60,120}})));
      Fluid.FixedResistances.Junction jun1(
        redeclare package Medium = Media.Water,
        m_flow_nominal={5,5,-5},
        dp_nominal={0,0,0}) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={170,50})));
    equation
      connect(port_a, val_storage.port_a)
        annotation (Line(points={{-100,0},{-60,0}}, color={0,127,255}));
      connect(port_a, val_preheat.port_a)
        annotation (Line(points={{-100,0},{-100,90},{-80,90}}, color={0,127,255}));
      connect(val_preheat.port_b, hex1.port_a2) annotation (Line(points={{-60,90},
              {-54,90},{-54,114},{-40,114}},
                                      color={0,127,255}));
      connect(boundary.ports[1], hex1.port_a1) annotation (Line(points={{-80,170},
              {-10,170},{-10,126},{-20,126}},
                                            color={0,127,255}));
      connect(hex1.port_b1, T_sec_intermediate.port_a) annotation (Line(points={{-40,126},
              {-50,126},{-50,150},{10,150}},    color={0,127,255}));
      connect(T_sec_intermediate.port_b, hex2.port_a1) annotation (Line(points={{30,150},
              {150,150},{150,122},{140,122}}, color={0,127,255}));
      connect(hex2.port_b1, T_sec_out.port_a) annotation (Line(points={{120,122},
              {110,122},{110,170},{120,170}},
                                  color={0,127,255}));
      connect(T_sec_out.port_b, bou1.ports[1])
        annotation (Line(points={{140,170},{180,170}}, color={0,127,255}));
      connect(T_prim_in.port_b, hex2.port_a2)
        annotation (Line(points={{100,110},{120,110}},
                                                   color={0,127,255}));
      connect(hex2.port_b2, T_prim_out.port_a)
        annotation (Line(points={{140,110},{170,110}},
                                                    color={0,127,255}));
      connect(temperatureSensor.T, hysteresis.u)
        annotation (Line(points={{100,-52},{118,-52}}, color={0,0,127}));
      connect(hysteresis.y, booToRea.u)
        annotation (Line(points={{141,-52},{158,-52}}, color={255,0,255}));
      connect(hex1.port_b2, senMasFlo.port_a) annotation (Line(points={{-20,114},
              {-10,114},{-10,-30},{40,-30}},
                                       color={0,127,255}));
      connect(senMasFlo.port_b, port_b)
        annotation (Line(points={{60,-30},{100,-30},{100,0}}, color={0,127,255}));
      connect(senMasFlo1.port_b, port_b)
        annotation (Line(points={{170,10},{170,0},{100,0}},
                                                  color={0,127,255}));
      connect(booToRea.y, product1.u1) annotation (Line(points={{182,-52},{190,-52},
              {190,-74},{198,-74}}, color={0,0,127}));
      connect(realExpression1.y, product1.u2) annotation (Line(points={{161,-90},{180,
              -90},{180,-86},{198,-86}}, color={0,0,127}));
      connect(product1.y, pid_storage.u_s) annotation (Line(points={{221,-80},{240,-80},
              {240,-50},{258,-50}}, color={0,0,127}));
      connect(senMasFlo1.m_flow, pid_storage.u_m) annotation (Line(points={{181,20},
              {320,20},{320,-110},{270,-110},{270,-62}},      color={0,0,127}));
      connect(pid_storage.y, val_storage.y) annotation (Line(points={{281,-50},
              {300,-50},{300,-100},{-30,-100},{-30,20},{-50,20},{-50,12}},
                                                                      color={0,0,127}));
      connect(opposite.y, product2.u1)
        annotation (Line(points={{221,-144},{238,-144}}, color={0,0,127}));
      connect(booToRea.y, opposite.u) annotation (Line(points={{182,-52},{190,-52},{
              190,-144},{198,-144}}, color={0,0,127}));
      connect(senMasFlo.m_flow, pid_preheat.u_m) annotation (Line(points={{50,-19},
              {50,-16},{30,-16},{30,-190},{310,-190},{310,-162}},color={0,0,127}));
      connect(product2.y, pid_preheat.u_s)
        annotation (Line(points={{261,-150},{298,-150}}, color={0,0,127}));
      connect(realExpression2.y, product2.u2) annotation (Line(points={{221,-168},{228.5,
              -168},{228.5,-156},{238,-156}}, color={0,0,127}));
      connect(pid_preheat.y, val_preheat.y) annotation (Line(points={{321,-150},
              {340,-150},{340,-180},{-90,-180},{-90,110},{-70,110},{-70,102}},
                                                                       color={0,0,127}));
      connect(val_storage.y_actual, y_storage) annotation (Line(points={{-45,7},
              {-20,7},{-20,80},{0,80},{0,210}},
                                           color={0,0,127}));
      connect(gain2.y, boundary.m_flow_in) annotation (Line(points={{-139,170},
              {-120,170},{-120,178},{-102,178}}, color={0,0,127}));
      connect(combiTimeTable.y[2], gain2.u)
        annotation (Line(points={{-179,170},{-162,170}}, color={0,0,127}));
      connect(tan1.port_b, jun1.port_3)
        annotation (Line(points={{120,50},{160,50}}, color={0,127,255}));
      connect(T_prim_out.port_b, jun1.port_1) annotation (Line(points={{190,110},
              {200,110},{200,70},{170,70},{170,60}}, color={0,127,255}));
      connect(jun.port_3, tan1.port_a)
        annotation (Line(points={{40,50},{100,50}}, color={0,127,255}));
      connect(jun1.port_2, senMasFlo1.port_a)
        annotation (Line(points={{170,40},{170,30}}, color={0,127,255}));
      connect(val_storage.port_b, jun.port_1)
        annotation (Line(points={{-40,0},{30,0},{30,40}}, color={0,127,255}));
      connect(jun.port_2, fan.port_a) annotation (Line(points={{30,60},{30,110},
              {40,110}}, color={0,127,255}));
      connect(fan.port_b, T_prim_in.port_a)
        annotation (Line(points={{60,110},{80,110}}, color={0,127,255}));
      connect(tan1.heaPorVol[2], temperatureSensor.port) annotation (Line(
            points={{110,49.58},{110,20},{70,20},{70,-52},{80,-52}}, color={191,
              0,0}));
      annotation (Diagram(coordinateSystem(extent={{-200,-200},{200,200}})),Icon(
            coordinateSystem(extent={{-200,-200},{200,200}}),
            graphics={Rectangle(
              extent={{-40,60},{40,0}},
              lineColor={238,46,47},
              fillColor={238,46,47},
              fillPattern=FillPattern.Solid), Rectangle(
              extent={{-40,0},{40,-60}},
              lineColor={244,125,35},
              fillColor={244,125,35},
              fillPattern=FillPattern.Solid)}));
    end SST_ECS_stratified;

    model SST_SH
      extends Fluid.Interfaces.PartialTwoPortInterface;
      parameter Real eps=0.7;
      parameter Real m_prim = 25;
      parameter Real m_sec = 3;
      parameter String fileName=
          ModelicaServices.ExternalReferences.loadResource(
          "modelica://Buildings/Data/tfp_he.txt") "File where matrix is stored"
    annotation (Dialog(
          loadSelector(filter="Text files (*.txt);;MATLAB MAT-files (*.mat)",
              caption="Open file in which table is present")));

      Fluid.HeatExchangers.PlateHeatExchangerEffectivenessNTU hex(
        redeclare package Medium1 = Media.Water,
        redeclare package Medium2 = Media.Water,
        m1_flow_nominal=m_prim,
        m2_flow_nominal=m_sec,
        dp1_nominal=1000,
        dp2_nominal=1000,
        configuration=Buildings.Fluid.Types.HeatExchangerConfiguration.CounterFlow,
        use_Q_flow_nominal=false,
        eps_nominal=eps)
        annotation (Placement(transformation(extent={{-10,-16},{10,4}})));
      Fluid.Sources.MassFlowSource_T boundary(
        redeclare package Medium = Media.Water,
        use_m_flow_in=true,
        m_flow=0.5,
        T=313.15,
        nPorts=1)
        annotation (Placement(transformation(extent={{60,-60},{40,-40}})));
      Modelica.Blocks.Math.Gain gain2(k=1/(4185*(55 - 15))) annotation (
          Placement(transformation(extent={{100,-60},{80,-40}})));
      Modelica.Blocks.Sources.CombiTimeTable combiTimeTable(
        tableOnFile=true,
        tableName="tab1",
        fileName=fileName,
        columns={2,3})
        annotation (Placement(transformation(extent={{140,-60},{120,-40}})));
      Fluid.Sensors.TemperatureTwoPort T_sec_out(redeclare package Medium =
            Media.Water, m_flow_nominal=50)
        annotation (Placement(transformation(extent={{-40,-80},{-60,-60}})));
      Fluid.Sources.Boundary_pT bou(redeclare package Medium = Media.Water,
          nPorts=1)
        annotation (Placement(transformation(extent={{-100,-80},{-80,-60}})));
      Fluid.Actuators.Valves.TwoWayLinear val_sh(
        redeclare package Medium = Media.Water,
        m_flow_nominal=m_prim,
        dpValve_nominal=5000,
        use_inputFilter=false)
        annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
      Buildings.Controls.Continuous.LimPID pid_heating(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=0.05,
        Ti=15,
        yMax=1)
        annotation (Placement(transformation(extent={{-80,40},{-60,60}})));
      Modelica.Blocks.Sources.RealExpression realExpression1(y=45 + 273.15)
        annotation (Placement(transformation(extent={{-120,40},{-100,60}})));
      Modelica.Blocks.Interfaces.RealOutput y_heating annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={0,110}), iconTransformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={0,110})));
      Fluid.Sensors.TemperatureTwoPort T_prim_out(redeclare package Medium =
            Media.Water, m_flow_nominal=50)
        annotation (Placement(transformation(extent={{40,-10},{60,10}})));
    equation
      connect(gain2.y, boundary.m_flow_in) annotation (Line(points={{79,-50},{
              72,-50},{72,-42},{62,-42}}, color={0,0,127}));
      connect(boundary.ports[1], hex.port_a2) annotation (Line(points={{40,-50},
              {26,-50},{26,-12},{10,-12}}, color={0,127,255}));
      connect(hex.port_b2,T_sec_out. port_a) annotation (Line(points={{-10,-12},
              {-26,-12},{-26,-70},{-40,-70}}, color={0,127,255}));
      connect(bou.ports[1],T_sec_out. port_b)
        annotation (Line(points={{-80,-70},{-60,-70}}, color={0,127,255}));
      connect(port_a, val_sh.port_a) annotation (Line(points={{-100,0},{-80,0},{-80,
              0},{-60,0}}, color={0,127,255}));
      connect(val_sh.port_b, hex.port_a1)
        annotation (Line(points={{-40,0},{-10,0}}, color={0,127,255}));
      connect(pid_heating.y, val_sh.y)
        annotation (Line(points={{-59,50},{-50,50},{-50,12}}, color={0,0,127}));
      connect(T_sec_out.T, pid_heating.u_m) annotation (Line(points={{-50,-59},
              {-50,-30},{-70,-30},{-70,38}}, color={0,0,127}));
      connect(realExpression1.y, pid_heating.u_s)
        annotation (Line(points={{-99,50},{-82,50}}, color={0,0,127}));
      connect(val_sh.y_actual, y_heating) annotation (Line(points={{-45,7},{-30,7},{
              -30,80},{0,80},{0,110}}, color={0,0,127}));
      connect(hex.port_b1, T_prim_out.port_a)
        annotation (Line(points={{10,0},{40,0}}, color={0,127,255}));
      connect(T_prim_out.port_b, port_b)
        annotation (Line(points={{60,0},{100,0}}, color={0,127,255}));
      connect(combiTimeTable.y[1], gain2.u)
        annotation (Line(points={{119,-50},{102,-50}}, color={0,0,127}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
              Rectangle(
              extent={{-60,40},{60,-40}},
              lineColor={28,108,200},
              fillColor={238,46,47},
              fillPattern=FillPattern.Solid)}),                      Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end SST_SH;

    model SST_cold
      extends Fluid.Interfaces.PartialTwoPortInterface;
        parameter Real eps=0.7;
      parameter Real m_prim = 25;
      parameter Real m_sec = 3;
      parameter String fileName=
          ModelicaServices.ExternalReferences.loadResource(
          "modelica://Buildings/Data/tfp_he.txt") "File where matrix is stored"
    annotation (Dialog(
          loadSelector(filter="Text files (*.txt);;MATLAB MAT-files (*.mat)",
              caption="Open file in which table is present")));

      Fluid.HeatExchangers.PlateHeatExchangerEffectivenessNTU hex(
        redeclare package Medium1 = Media.Water,
        redeclare package Medium2 = Media.Water,
        m1_flow_nominal=m_prim,
        m2_flow_nominal=m_sec,
        dp1_nominal=1000,
        dp2_nominal=1000,
        configuration=Buildings.Fluid.Types.HeatExchangerConfiguration.CounterFlow,
        use_Q_flow_nominal=false,
        eps_nominal=eps)
        annotation (Placement(transformation(extent={{-10,-16},{10,4}})));
      Fluid.Sources.MassFlowSource_T boundary(
        redeclare package Medium = Media.Water,
        use_m_flow_in=true,
        m_flow=0.5,
        T=285.15,
        nPorts=1)
        annotation (Placement(transformation(extent={{60,-60},{40,-40}})));
      Modelica.Blocks.Math.Gain gain2(k=1/(4185*(12 - 7)))  annotation (
          Placement(transformation(extent={{100,-60},{80,-40}})));
      Modelica.Blocks.Sources.CombiTimeTable combiTimeTable(
        tableOnFile=true,
        tableName="tab1",
        fileName=fileName,
        columns={2})
        annotation (Placement(transformation(extent={{140,-60},{120,-40}})));
      Fluid.Sensors.TemperatureTwoPort T_sec_out(redeclare package Medium =
            Media.Water, m_flow_nominal=50)
        annotation (Placement(transformation(extent={{-40,-80},{-60,-60}})));
      Fluid.Sources.Boundary_pT bou(redeclare package Medium = Media.Water,
          nPorts=1)
        annotation (Placement(transformation(extent={{-100,-80},{-80,-60}})));
      Fluid.Actuators.Valves.TwoWayLinear val_cooling(
        redeclare package Medium = Media.Water,
        m_flow_nominal=m_prim,
        dpValve_nominal=5000,
        use_inputFilter=false)
        annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
      Buildings.Controls.Continuous.LimPID pid_cooling(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=0.05,
        Ti=15,
        yMax=1,
        reverseActing=false)
        annotation (Placement(transformation(extent={{-80,40},{-60,60}})));
      Modelica.Blocks.Sources.RealExpression realExpression1(y=12 + 273.15)
        annotation (Placement(transformation(extent={{-120,40},{-100,60}})));
      Modelica.Blocks.Interfaces.RealOutput y_cooling annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={0,110}), iconTransformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={0,110})));
      Fluid.Sensors.TemperatureTwoPort T_prim_out(redeclare package Medium =
            Media.Water, m_flow_nominal=50)
        annotation (Placement(transformation(extent={{40,-10},{60,10}})));
    equation
      connect(gain2.y, boundary.m_flow_in) annotation (Line(points={{79,-50},{
              72,-50},{72,-42},{62,-42}}, color={0,0,127}));
      connect(boundary.ports[1], hex.port_a2) annotation (Line(points={{40,-50},
              {26,-50},{26,-12},{10,-12}}, color={0,127,255}));
      connect(hex.port_b2,T_sec_out. port_a) annotation (Line(points={{-10,-12},
              {-26,-12},{-26,-70},{-40,-70}}, color={0,127,255}));
      connect(bou.ports[1],T_sec_out. port_b)
        annotation (Line(points={{-80,-70},{-60,-70}}, color={0,127,255}));
      connect(port_a,val_cooling. port_a) annotation (Line(points={{-100,0},{
              -80,0},{-80,0},{-60,0}}, color={0,127,255}));
      connect(val_cooling.port_b, hex.port_a1)
        annotation (Line(points={{-40,0},{-10,0}}, color={0,127,255}));
      connect(pid_cooling.y,val_cooling. y) annotation (Line(points={{-59,50},{
              -50,50},{-50,12}}, color={0,0,127}));
      connect(T_sec_out.T, pid_cooling.u_m) annotation (Line(points={{-50,-59},
              {-50,-30},{-70,-30},{-70,38}}, color={0,0,127}));
      connect(realExpression1.y, pid_cooling.u_s)
        annotation (Line(points={{-99,50},{-82,50}}, color={0,0,127}));
      connect(val_cooling.y_actual, y_cooling) annotation (Line(points={{-45,7},
              {-30,7},{-30,80},{0,80},{0,110}}, color={0,0,127}));
      connect(combiTimeTable.y[1], gain2.u)
        annotation (Line(points={{119,-50},{102,-50}}, color={0,0,127}));
      connect(hex.port_b1, T_prim_out.port_a)
        annotation (Line(points={{10,0},{40,0}}, color={0,127,255}));
      connect(T_prim_out.port_b, port_b)
        annotation (Line(points={{60,0},{100,0}}, color={0,127,255}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
              Rectangle(
              extent={{-60,40},{60,-40}},
              lineColor={28,108,200},
              fillColor={28,108,200},
              fillPattern=FillPattern.Solid)}),                      Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end SST_cold;

  package Tests
    extends Modelica.Icons.ExamplesPackage;

    model test_sst_sh
      SST.SST_SH sST_SH(
        redeclare package Medium = Media.Water,
        m_flow_nominal=10,
        fileName=ModelicaServices.ExternalReferences.loadResource("modelica://Buildings/Data/sst/jan_20/test_cast.txt"),
        hex(eps_nominal=0.7))
        annotation (Placement(transformation(extent={{20,20},{40,40}})));

      Fluid.Sources.Boundary_pT bou(
        redeclare package Medium = Media.Water,
        use_T_in=false,
        T=319.15,
        nPorts=2)                                            annotation (
          Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={-90,30})));
      Fluid.Sensors.TemperatureTwoPort senTem(redeclare package Medium =
            Media.Water, m_flow_nominal=10)
        annotation (Placement(transformation(extent={{-20,-20},{-40,0}})));
      Fluid.Movers.FlowControlled_dp fan(
        redeclare package Medium = Media.Water,
        m_flow_nominal=10,
        redeclare Fluid.Movers.Data.Pumps.Wilo.Stratos25slash1to6 per,
        inputType=Buildings.Fluid.Types.InputType.Constant,
        addPowerToMedium=false,
        dp_nominal=2000,
        constantHead=2000)
        annotation (Placement(transformation(extent={{-40,20},{-20,40}})));
    equation
      connect(bou.ports[1], fan.port_a) annotation (Line(points={{-80,32},{
              -60,32},{-60,30},{-40,30}}, color={0,127,255}));
      connect(fan.port_b, sST_SH.port_a) annotation (Line(points={{-20,30},{0,
              30},{0,30},{20,30}}, color={0,127,255}));
      connect(sST_SH.port_b, senTem.port_a) annotation (Line(points={{40,30},
              {50,30},{50,-10},{-20,-10}}, color={0,127,255}));
      connect(senTem.port_b, bou.ports[2]) annotation (Line(points={{-40,-10},
              {-62,-10},{-62,28},{-80,28}}, color={0,127,255}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end test_sst_sh;

    model test_sst_cold
      Fluid.Sources.Boundary_pT bou(
        redeclare package Medium = Media.Water,
        use_T_in=false,
        T=278.15,
        nPorts=2)                                            annotation (
          Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={-90,30})));
      Fluid.Sensors.TemperatureTwoPort senTem(redeclare package Medium =
            Media.Water, m_flow_nominal=10)
        annotation (Placement(transformation(extent={{-20,-20},{-40,0}})));
      Fluid.Movers.FlowControlled_dp fan(
        redeclare package Medium = Media.Water,
        m_flow_nominal=10,
        redeclare Fluid.Movers.Data.Pumps.Wilo.Stratos25slash1to6 per,
        inputType=Buildings.Fluid.Types.InputType.Constant,
        addPowerToMedium=false,
        dp_nominal=2000,
        constantHead=2000)
        annotation (Placement(transformation(extent={{-40,20},{-20,40}})));
      SST.SST_cold sST_cold(
        redeclare package Medium = Media.Water,
        m_flow_nominal=10,
        fileName=ModelicaServices.ExternalReferences.loadResource("modelica://Buildings/Data/sst/jan_20/test_cast_froid.txt"),
        hex(eps_nominal=0.95))
        annotation (Placement(transformation(extent={{0,20},{20,40}})));

    equation
      connect(bou.ports[1], fan.port_a) annotation (Line(points={{-80,32},{
              -60,32},{-60,30},{-40,30}}, color={0,127,255}));
      connect(senTem.port_b, bou.ports[2]) annotation (Line(points={{-40,-10},
              {-62,-10},{-62,28},{-80,28}}, color={0,127,255}));
      connect(fan.port_b, sST_cold.port_a) annotation (Line(points={{-20,30},
              {-10,30},{-10,30},{0,30}}, color={0,127,255}));
      connect(sST_cold.port_b, senTem.port_a) annotation (Line(points={{20,30},
              {30,30},{30,-10},{-20,-10}}, color={0,127,255}));
      annotation (
        Icon(coordinateSystem(preserveAspectRatio=false)),
        Diagram(coordinateSystem(preserveAspectRatio=false)),
        experiment(
          StartTime=11221200,
          StopTime=11394000,
          Interval=3600,
          __Dymola_Algorithm="Dassl"));
    end test_sst_cold;

    model nveau_pb
      Fluid.Sources.MassFlowSource_T boundary(
        redeclare package Medium = Media.Water,
        use_m_flow_in=true,
        m_flow=0.5,
        T=288.15,
        nPorts=1)
        annotation (Placement(transformation(extent={{0,20},{20,40}})));
      Modelica.Blocks.Sources.CombiTimeTable combiTimeTable(
        tableOnFile=true,
        tableName="tab1",
        fileName=fileName,
        columns={2})
        annotation (Placement(transformation(extent={{-100,20},{-80,40}})));
      Modelica.Blocks.Math.Gain gain2(k=1/(4185*(55 - 15))) annotation (
          Placement(transformation(extent={{-60,20},{-40,40}})));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end nveau_pb;
  end Tests;
  end SST;

package TFP
  extends Modelica.Icons.VariantsPackage;
  model TFP_carnot_massileo

    extends Fluid.Interfaces.PartialEightPortInterface;

    parameter Modelica.SIunits.MassFlowRate m_flow_hot= 211*1000/3600;
    parameter Modelica.SIunits.MassFlowRate m_flow_cold= 332*1000/3600;
    parameter Real T_set_hot = 61+273.15;
    parameter Real T_set_hot_max = 63+273.15;
    parameter Real T_set_hot_min = 41+273.15;
    parameter Real T_set_cold_max = 14+273.15;
    parameter Real T_set_cold = 4+273.15;

    Fluid.FixedResistances.Junction jun(
      redeclare package Medium = Buildings.Media.Water,
      m_flow_nominal={m_flow_hot,-m_flow_hot,-m_flow_hot},
      dp_nominal={0,0,0})
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-30,110})));
    Fluid.FixedResistances.Junction jun5(
      redeclare package Medium = Buildings.Media.Water,
      m_flow_nominal={m_flow_cold,-m_flow_cold,-m_flow_cold},
      dp_nominal={0,0,0})
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},
          rotation=90,
          origin={50,-150})));
    Fluid.Sensors.TemperatureTwoPort TT111(redeclare package Medium =
          Buildings.Media.Water, m_flow_nominal=m_flow_cold)
      annotation (Placement(transformation(extent={{-60,-90},{-80,-70}})));
    Fluid.Sensors.TemperatureTwoPort TT511(redeclare package Medium =
          Buildings.Media.Water, m_flow_nominal=100)
      annotation (Placement(transformation(extent={{40,70},{60,90}})));
    Fluid.Sensors.TemperatureTwoPort TT521(redeclare package Medium =
          Buildings.Media.Water, m_flow_nominal=100) annotation (Placement(
          transformation(
          extent={{-10,10},{10,-10}},
          rotation=-90,
          origin={-30,30})));
    Modelica.Blocks.Interfaces.IntegerInput mode
      annotation (Placement(transformation(extent={{-220,70},{-180,110}}),
          iconTransformation(extent={{-20,-20},{20,20}},
          rotation=90,
          origin={-80,-120})));
    Modelica.Blocks.Sources.RealExpression cons_cold(y=T_set_cold)
      annotation (Placement(transformation(extent={{-200,20},{-180,40}})));
    Modelica.Blocks.Interfaces.RealInput DEG_TT121
      annotation (Placement(transformation(extent={{-220,-120},{-180,-80}}),
          iconTransformation(extent={{-20,-20},{20,20}},
          rotation=90,
          origin={80,-120})));
    Modelica.Blocks.Interfaces.RealInput PEM_TT200
      annotation (Placement(transformation(extent={{-220,-180},{-180,-140}}),
          iconTransformation(extent={{-20,-20},{20,20}},
          rotation=90,
          origin={0,-120})));
    Fluid.Sensors.TemperatureTwoPort TT121(redeclare package Medium =
          Buildings.Media.Water, m_flow_nominal=322/3.6)
                                                     annotation (Placement(
          transformation(
          extent={{10,10},{-10,-10}},
          rotation=270,
          origin={50,-70})));
    DHC_Massileo.Controls.TFP.PID_Valve_evap pID_Valve_evap
        annotation (Placement(transformation(extent={{-80,-140},{-60,-120}})));
    Buildings.Applications.DHC_Massileo.Controls.TFP.PID_Valve_cond pID_Valve_cond
        annotation (Placement(transformation(extent={{-200,160},{-180,180}})));
    Modelica.Blocks.Interfaces.RealOutput CV522_pid
      annotation (Placement(transformation(extent={{120,50},{140,70}})));
    Modelica.Blocks.Interfaces.RealOutput CV122_pid
      annotation (Placement(transformation(extent={{120,-70},{140,-50}})));
    Fluid.Actuators.Valves.ThreeWayLinear val(
      redeclare package Medium = Buildings.Media.Water,
      use_inputFilter=false,
      m_flow_nominal=m_flow_cold,
      dpValve_nominal=5000) annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=270,
          origin={50,-110})));
    Fluid.Actuators.Valves.ThreeWayLinear CV521_522(
      redeclare package Medium = Buildings.Media.Water,
      use_inputFilter=false,
      m_flow_nominal=m_flow_hot,
      dpValve_nominal=5000) annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=90,
          origin={-30,60})));
    Modelica.Blocks.Sources.IntegerExpression integerExpression(y=mode)
      annotation (Placement(transformation(extent={{-240,160},{-220,180}})));
    Fluid.Chillers.Carnot_TEva TFPA(
      redeclare package Medium1 = Buildings.Media.Water,
      redeclare package Medium2 = Buildings.Media.Water,
      m1_flow_nominal=m_flow_hot,
      m2_flow_nominal=m_flow_cold/2,
      QEva_flow_nominal=-166/3.6*4185*(7),
      dTEva_nominal=-7,
      dTCon_nominal=15,
      use_eta_Carnot_nominal=true,
      etaCarnot_nominal=0.95,
      COP_nominal=6.5,
      TCon_nominal=313.15,
      dp1_nominal=40000,
      dp2_nominal=40000,
      QEva_flow_min(displayUnit="kW") = -1800000)
      annotation (Placement(transformation(extent={{-10,-20},{10,0}})));
    Modelica.Blocks.Sources.IntegerExpression integerExpression1(y=mode)
      annotation (Placement(transformation(extent={{-200,-140},{-180,-120}})));
  equation

    connect(port_a1, jun.port_1) annotation (Line(points={{-100,80},{-100,140},
              {-30,140},{-30,120}},  color={238,46,47},
        thickness=0.5));

    connect(jun5.port_3, port_b3) annotation (Line(points={{60,-150},{112,-150},
              {112,-30},{100,-30}},     color={0,127,255},
        thickness=0.5));
    connect(TT111.port_b, port_b4) annotation (Line(points={{-80,-80},{-100,-80}},
                               color={0,127,255},
        thickness=0.5));
    connect(jun5.port_1, port_a4) annotation (Line(points={{50,-160},{50,-180},
              {100,-180},{100,-80}},
                                   color={0,127,255},
        thickness=0.5));
    connect(DEG_TT121, pID_Valve_evap.DEG_TT121) annotation (Line(points={{-200,
              -100},{-170,-100},{-170,-126},{-82,-126}},     color={0,0,127}));
    connect(PEM_TT200, pID_Valve_evap.PEM_TT200) annotation (Line(points={{-200,
              -160},{-160,-160},{-160,-122},{-82,-122}},     color={0,0,127}));
    connect(pID_Valve_evap.TFP_TT121, TT121.T) annotation (Line(points={{-82,
              -130},{-100,-130},{-100,-156},{26,-156},{26,-70},{39,-70}},
                                                                        color=
           {0,0,127}));
    connect(TT511.T, pID_Valve_evap.TFP_TT511) annotation (Line(points={{50,91},
              {50,200},{-250,200},{-250,-180},{-140,-180},{-140,-138},{-82,-138}},
                         color={0,0,127}));
    connect(TT511.T, pID_Valve_cond.TFP_TT511) annotation (Line(points={{50,91},
              {50,200},{-250,200},{-250,176},{-202,176}},    color={0,0,127}));
    connect(TT521.T, pID_Valve_cond.TFP_TT521) annotation (Line(points={{-41,30},
              {-60,30},{-60,20},{-220,20},{-220,162},{-202,162}},
                                                    color={0,0,127}));
    connect(pID_Valve_cond.CV522, CV522_pid) annotation (Line(points={{-179,175},
              {80,175},{80,60},{130,60}},    color={0,0,127}));
    connect(pID_Valve_evap.CV122, CV122_pid) annotation (Line(points={{-59,-125},
              {-8,-125},{-8,-126},{90,-126},{90,-60},{130,-60}},     color={0,
            0,127}));
    connect(val.port_1, jun5.port_2) annotation (Line(
        points={{50,-120},{50,-140}},
        color={0,127,255},
        thickness=0.5));
    connect(port_a3, val.port_3) annotation (Line(
        points={{-100,-32},{-120,-32},{-120,-110},{40,-110}},
        color={0,127,255},
        thickness=0.5));
    connect(pID_Valve_evap.CV121, val.y) annotation (Line(points={{-59,-135},{
              80,-135},{80,-110},{62,-110}},color={0,0,127}));
    connect(pID_Valve_cond.CV521, CV521_522.y) annotation (Line(points={{-179,
              165},{-120,165},{-120,166},{-60,166},{-60,60},{-42,60}},
                                               color={0,0,127}));
    connect(CV521_522.port_2, TT521.port_a) annotation (Line(
        points={{-30,50},{-30,40}},
        color={238,46,47},
        thickness=0.5));
    connect(CV521_522.port_1, jun.port_2) annotation (Line(
        points={{-30,70},{-30,100}},
        color={238,46,47},
        thickness=0.5));
    connect(CV521_522.port_3, port_a2) annotation (Line(
        points={{-20,60},{60,60},{60,30},{100,30}},
        color={238,46,47},
        thickness=0.5));
      connect(integerExpression.y, pID_Valve_cond.mode) annotation (Line(points=
             {{-219,170},{-212,170},{-212,170},{-202,170}}, color={255,127,0}));
    connect(cons_cold.y, TFPA.TSet) annotation (Line(points={{-179,30},{-136,30},
              {-136,-1},{-12,-1}},
                                color={0,0,127}));
      connect(TT121.port_a, val.port_2) annotation (Line(
          points={{50,-80},{50,-100}},
          color={0,127,255},
          thickness=0.5));
      connect(TT121.port_b, TFPA.port_a2) annotation (Line(
          points={{50,-60},{50,-16},{10,-16}},
          color={0,127,255},
          thickness=0.5));
      connect(port_b2, jun.port_3) annotation (Line(
          points={{-100,30},{-80,30},{-80,110},{-40,110}},
          color={238,46,47},
          thickness=0.5));
      connect(TFPA.port_b1, TT511.port_a) annotation (Line(
          points={{10,-4},{30,-4},{30,80},{40,80}},
          color={238,46,47},
          thickness=0.5));
      connect(TT511.port_b, port_b1) annotation (Line(
          points={{60,80},{100,80}},
          color={238,46,47},
          thickness=0.5));
      connect(TT521.port_b, TFPA.port_a1) annotation (Line(
          points={{-30,20},{-30,-4},{-10,-4}},
          color={238,46,47},
          thickness=0.5));
      connect(TFPA.port_b2, TT111.port_a) annotation (Line(
          points={{-10,-16},{-40,-16},{-40,-80},{-60,-80}},
          color={0,127,255},
          thickness=0.5));
      connect(integerExpression1.y, pID_Valve_evap.mode) annotation (Line(
            points={{-179,-130},{-132,-130},{-132,-134},{-82,-134}}, color={255,
              127,0}));
    annotation (Diagram(coordinateSystem(extent={{-100,-100},{100,100}})), Icon(
          coordinateSystem(extent={{-100,-100},{100,100}}), graphics={Rectangle(
            extent={{0,80},{60,20}},
            lineColor={238,46,47},
            fillColor={238,46,47},
            fillPattern=FillPattern.Solid),                           Rectangle(
            extent={{0,-20},{60,-80}},
            lineColor={28,108,200},
            fillColor={28,108,200},
            fillPattern=FillPattern.Solid),                           Rectangle(
            extent={{-60,80},{0,20}},
            lineColor={238,46,47},
            fillColor={244,125,35},
            fillPattern=FillPattern.Solid),                           Rectangle(
            extent={{-60,-20},{0,-80}},
            lineColor={28,108,200},
            fillColor={0,0,127},
            fillPattern=FillPattern.Solid)}),
      Documentation(info="<html>
<h4><span style=\"color: #000000\">HPSHC modes</span></h4>
<p>For the HPSHC, 4 possible modes :</p>
<p>0 - Off</p>
<p>1 - Cold mode</p>
<p>2 - HPSHC full</p>
<p>3 - HPSHC 1/2</p>
</html>"),
      experiment(StopTime=1, __Dymola_Algorithm="Dassl"));
  end TFP_carnot_massileo;
end TFP;

  package Plant
    extends Modelica.Icons.VariantsPackage;
    package Tests
    extends Modelica.Icons.ExamplesPackage;
      model cast
        TFP.TFP_carnot_massileo tFP_carnot_massileo(
          redeclare package Medium1 = Media.Water,
          redeclare package Medium2 = Media.Water,
          redeclare package Medium3 = Media.Water,
          redeclare package Medium4 = Media.Water,
          m1_flow_nominal=20,
          m2_flow_nominal=20,
          m3_flow_nominal=20,
          m4_flow_nominal=20,
          pID_Valve_cond(PID_Tmax(k=0.05, Ti=15), PID_Tmin(k=0.05, Ti=15)))
          annotation (Placement(transformation(extent={{-60,-20},{-40,0}})));
        DHC_Thassalia.DEC_DEG.DEC_simpler dEC_simpler(redeclare package Medium1 =
              Media.Water, redeclare package Medium2 = Media.Water)
          annotation (Placement(transformation(extent={{200,40},{220,60}})));
        DHC_Thassalia.DEC_DEG.DEG_simpler dEG_simpler(redeclare package Medium1 =
              Media.Water, redeclare package Medium2 = Media.Water)
          annotation (Placement(transformation(extent={{200,-40},{220,-20}})));
        DHC_Thassalia.RJC.Heat_exchanger_basic heat_exchanger_basic(redeclare
            package Medium1 = Media.Water, redeclare package Medium2 =
              Media.Water)
          annotation (Placement(transformation(extent={{-100,40},{-80,60}})));
        DHC_Thassalia.RJF.Cold_exchanger cold_exchanger(redeclare package
            Medium1 = Media.Water, redeclare package Medium2 = Media.Water)
          annotation (Placement(transformation(extent={{-20,40},{0,60}})));
        Fluid.Movers.FlowControlled_m_flow fan(
          redeclare package Medium = Media.Water,
          m_flow_nominal=150/3.6,
          redeclare
            Fluid.Movers.Data.Pumps.Wilo.CronolineIL80slash220dash4slash4 per,
          dp_nominal=10000)
          annotation (Placement(transformation(extent={{140,50},{160,70}})));
        Fluid.Sources.Boundary_pT bou(
          redeclare package Medium = Media.Water,
                                      use_T_in=true, nPorts=2) annotation (
            Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=270,
              origin={110,70})));
        Fluid.Sensors.TemperatureTwoPort senTem(redeclare package Medium =
              Media.Water, m_flow_nominal=10)
          annotation (Placement(transformation(extent={{60,20},{80,40}})));
        Fluid.Sensors.TemperatureTwoPort senTem1(redeclare package Medium =
              Media.Water, m_flow_nominal=10)
          annotation (Placement(transformation(extent={{60,-60},{80,-40}})));
        Fluid.Sources.Boundary_pT bou1(
          redeclare package Medium = Media.Water,
                                       use_T_in=true, nPorts=2) annotation (
            Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={110,-70})));
        Fluid.Movers.FlowControlled_m_flow fan1(
          redeclare package Medium = Media.Water,
          m_flow_nominal=120/3.6,
          redeclare
            Fluid.Movers.Data.Pumps.Wilo.CronolineIL80slash220dash4slash4 per,
          dp_nominal=10000)
          annotation (Placement(transformation(extent={{140,-40},{160,-20}})));
        Fluid.Sources.Boundary_pT bou2(
          redeclare package Medium = Media.Water,
          use_T_in=true,
          nPorts=3) annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=0,
              origin={-210,110})));
        Fluid.Movers.FlowControlled_dp fan2(
          redeclare package Medium = Media.Water,
          m_flow_nominal=50,
          redeclare Fluid.Movers.Data.Pumps.KSB.KSB_edm per,
          inputType=Buildings.Fluid.Types.InputType.Constant,
          dp_nominal=100000,
          constantHead=1000) annotation (Placement(transformation(extent={{-140,
                  100},{-120,120}})));
        SST.SST_ECS_HE sST_ECS(
          redeclare package Medium = Media.Water,
          m_flow_nominal=10,
          fileName=ModelicaServices.ExternalReferences.loadResource(
              "modelica://Buildings/Data/sst/jan_20/test_cast.txt"),
          tan1(VTan=15))
          annotation (Placement(transformation(extent={{280,80},{300,100}})));
        SST.SST_SH sST_SH(
          redeclare package Medium = Media.Water,
          m_flow_nominal=20,
          fileName=ModelicaServices.ExternalReferences.loadResource(
              "modelica://Buildings/Data/sst/jan_20/test_cast.txt"),
          T_sec_out(T_start=318.15))
          annotation (Placement(transformation(extent={{280,122},{300,142}})));
        Controls.Mode.switch_tfp switch_tfp(greaterThreshold1(threshold=0.001))
          annotation (Placement(transformation(extent={{340,160},{360,180}})));
        SST.SST_cold sST_cold(
          redeclare package Medium = Media.Water,
          m_flow_nominal=10,
          eps=0.9,
          fileName=ModelicaServices.ExternalReferences.loadResource(
              "modelica://Buildings/Data/sst/jan_20/test_cast_froid.txt"))
          annotation (Placement(transformation(extent={{280,-30},{300,-10}})));
        Modelica.Blocks.Sources.RealExpression realExpression1(y=150/3.6/3)
                                                              annotation (
            Placement(transformation(extent={{120,100},{140,120}})));
        Modelica.Blocks.Sources.RealExpression realExpression2(y=120/3.6/3)
                                                              annotation (
            Placement(transformation(extent={{120,10},{140,30}})));
        Modelica.Blocks.Sources.CombiTimeTable combiTimeTable(
          tableOnFile=true,
          tableName="tab1",
          fileName=ModelicaServices.ExternalReferences.loadResource(
              "modelica://Buildings/Data/sst/jan_20/pem_2020.txt"),
          columns={2})
          annotation (Placement(transformation(extent={{-280,60},{-260,80}})));
        Fluid.Sensors.TemperatureTwoPort senTem2(redeclare package Medium =
              Media.Water, m_flow_nominal=10)
          annotation (Placement(transformation(extent={{-70,46},{-50,66}})));
        Fluid.Sensors.TemperatureTwoPort senTem3(redeclare package Medium =
              Media.Water, m_flow_nominal=10)
          annotation (Placement(transformation(extent={{10,46},{30,66}})));
        Fluid.Sensors.TemperatureTwoPort senTem4(redeclare package Medium =
              Media.Water, m_flow_nominal=10)
          annotation (Placement(transformation(extent={{-180,100},{-160,120}})));
      equation
        connect(tFP_carnot_massileo.port_a3, cold_exchanger.port_b2)
          annotation (Line(
            points={{-60,-13.2},{-64,-13.2},{-64,-12},{-80,-12},{-80,26},{-30,
                26},{-30,44},{-20,44}},
            color={28,108,200},
            thickness=0.5));
        connect(tFP_carnot_massileo.port_b3, cold_exchanger.port_a2)
          annotation (Line(
            points={{-40,-13.1},{-38,-13.1},{-38,-12},{10,-12},{10,44},{0,44}},
            color={28,108,200},
            thickness=0.5));

        connect(heat_exchanger_basic.port_b2, tFP_carnot_massileo.port_a2)
          annotation (Line(
            points={{-100,44},{-120,44},{-120,20},{-20,20},{-20,-7},{-40,-7}},
            color={238,46,47},
            thickness=0.5));
        connect(tFP_carnot_massileo.port_b2, heat_exchanger_basic.port_a2)
          annotation (Line(
            points={{-60,-7},{-66,-7},{-66,-6},{-68,-6},{-68,44},{-80,44}},
            color={238,46,47},
            thickness=0.5));
        connect(tFP_carnot_massileo.port_b1, senTem.port_a) annotation (Line(
            points={{-40,-2},{60,-2},{60,30}},
            color={238,46,47},
            thickness=0.5));
        connect(senTem.port_b, bou.ports[1]) annotation (Line(
            points={{80,30},{112,30},{112,60}},
            color={238,46,47},
            thickness=0.5));
        connect(senTem.T, bou.T_in) annotation (Line(points={{70,41},{70,90},{
                114,90},{114,82}}, color={0,0,127}));
        connect(bou.ports[2], fan.port_a) annotation (Line(
            points={{108,60},{140,60}},
            color={238,46,47},
            thickness=0.5));
        connect(fan.port_b, dEC_simpler.port_a1) annotation (Line(points={{160,
                60},{180,60},{180,56},{200,56}}, color={238,46,47},
            thickness=0.5));
        connect(dEC_simpler.port_b2, tFP_carnot_massileo.port_a1) annotation (
            Line(
            points={{200,44},{182,44},{182,6},{-74,6},{-74,-2},{-60,-2}},
            color={238,46,47},
            thickness=0.5));
        connect(senTem1.port_b, bou1.ports[1]) annotation (Line(
            points={{80,-50},{108,-50},{108,-60}},
            color={0,127,255},
            thickness=0.5));
        connect(bou1.ports[2], fan1.port_a) annotation (Line(
            points={{112,-60},{112,-30},{140,-30}},
            color={0,127,255},
            thickness=0.5));
        connect(fan1.port_b, dEG_simpler.port_a1) annotation (Line(
            points={{160,-30},{180,-30},{180,-24},{200,-24}},
            color={0,127,255},
            thickness=0.5));
        connect(tFP_carnot_massileo.port_b4, senTem1.port_a) annotation (Line(
            points={{-60,-18.5},{-62,-18.5},{-62,-18},{-72,-18},{-72,-50},{60,
                -50}},
            color={0,127,255},
            thickness=0.5));
        connect(dEG_simpler.port_b2, tFP_carnot_massileo.port_a4) annotation (
            Line(
            points={{200,-36},{184,-36},{184,-8},{66,-8},{66,-18},{-40,-18}},
            color={0,127,255},
            thickness=0.5));
        connect(senTem1.T, bou1.T_in) annotation (Line(points={{70,-39},{70,-30},
                {50,-30},{50,-94},{106,-94},{106,-82}}, color={0,0,127}));
        connect(fan2.port_b, heat_exchanger_basic.port_a1) annotation (Line(
            points={{-120,110},{-110,110},{-110,56},{-100,56}},
            color={0,140,72},
            thickness=0.5));
        connect(fan2.port_b, cold_exchanger.port_a1) annotation (Line(
            points={{-120,110},{-30,110},{-30,56},{-20,56}},
            color={0,140,72},
            thickness=0.5));
        connect(dEG_simpler.TT121_DEG, tFP_carnot_massileo.DEG_TT121)
          annotation (Line(points={{210,-41},{210,-106},{-42,-106},{-42,-22}},
              color={0,0,127}));
        connect(dEC_simpler.port_b1, sST_ECS.port_a) annotation (Line(points={{
                220,56},{240,56},{240,90},{280,90}}, color={238,46,47},
            thickness=0.5));
        connect(dEC_simpler.port_b1, sST_SH.port_a) annotation (Line(points={{
                220,56},{240,56},{240,132},{280,132}}, color={238,46,47},
            thickness=0.5));
        connect(sST_SH.port_b, dEC_simpler.port_a2) annotation (Line(points={{
                300,132},{320,132},{320,44},{220,44}}, color={238,46,47},
            thickness=0.5));
        connect(sST_ECS.port_b, dEC_simpler.port_a2) annotation (Line(points={{
                300,90},{320,90},{320,44},{220,44}}, color={238,46,47},
            thickness=0.5));
        connect(dEG_simpler.port_b1, sST_cold.port_a) annotation (Line(points={
                {220,-24},{250,-24},{250,-20},{280,-20}}, color={0,127,255},
            thickness=0.5));
        connect(sST_cold.port_b, dEG_simpler.port_a2) annotation (Line(points={
                {300,-20},{320,-20},{320,-40},{240,-40},{240,-36},{220,-36}},
              color={0,127,255},
            thickness=0.5));
        connect(sST_SH.y_heating, switch_tfp.sh_in) annotation (Line(points={{
                290,143},{290,170},{338,170}}, color={0,0,127}));
        connect(sST_ECS.y_storage, switch_tfp.ecs_in) annotation (Line(points={
                {290,101},{290,112},{328,112},{328,163},{338,163}}, color={0,0,
                127}));
        connect(sST_cold.y_cooling, switch_tfp.cooling_in) annotation (Line(
              points={{290,-9},{290,14},{332,14},{332,177},{338,177}}, color={0,
                0,127}));
        connect(switch_tfp.HPSHC, tFP_carnot_massileo.mode) annotation (Line(
              points={{362,178},{400,178},{400,-100},{-58,-100},{-58,-22}},
              color={255,127,0}));
        connect(realExpression1.y, fan.m_flow_in) annotation (Line(points={{141,
                110},{150,110},{150,72}}, color={0,0,127}));
        connect(realExpression2.y, fan1.m_flow_in) annotation (Line(points={{
                141,20},{150,20},{150,-18}}, color={0,0,127}));
        connect(tFP_carnot_massileo.CV522_pid, heat_exchanger_basic.TFP_CV522)
          annotation (Line(points={{-37,-4},{-28,-4},{-28,14},{-138,14},{-138,
                54},{-102,54}},color={0,0,127}));
        connect(tFP_carnot_massileo.CV122_pid, cold_exchanger.TFP_CV122)
          annotation (Line(points={{-37,-16},{-28,-16},{-28,54},{-22,54}},
              color={0,0,127}));
        connect(combiTimeTable.y[1], bou2.T_in) annotation (Line(points={{-259,
                70},{-240,70},{-240,114},{-222,114}}, color={0,0,127}));
        connect(combiTimeTable.y[1], heat_exchanger_basic.PEM_TT200)
          annotation (Line(points={{-259,70},{-172,70},{-172,46},{-102,46}},
              color={0,0,127}));
        connect(combiTimeTable.y[1], cold_exchanger.PEM_TT200) annotation (Line(
              points={{-259,70},{-172,70},{-172,36},{-36,36},{-36,46},{-22,46}},
              color={0,0,127}));
        connect(combiTimeTable.y[1], tFP_carnot_massileo.PEM_TT200) annotation (
           Line(points={{-259,70},{-210,70},{-210,-38},{-50,-38},{-50,-22}},
              color={0,0,127}));
        connect(heat_exchanger_basic.port_b1, senTem2.port_a) annotation (Line(
            points={{-80,56},{-70,56}},
            color={0,140,72},
            thickness=0.5));
        connect(senTem2.port_b, bou2.ports[1]) annotation (Line(
            points={{-50,56},{-40,56},{-40,140},{-200,140},{-200,112.667}},
            color={0,140,72},
            thickness=0.5));
        connect(cold_exchanger.port_b1, senTem3.port_a) annotation (Line(
            points={{0,56},{10,56}},
            color={0,140,72},
            thickness=0.5));
        connect(senTem3.port_b, bou2.ports[2]) annotation (Line(
            points={{30,56},{40,56},{40,140},{-200,140},{-200,110}},
            color={0,140,72},
            thickness=0.5));
        connect(bou2.ports[3], senTem4.port_a) annotation (Line(
            points={{-200,107.333},{-196,107.333},{-196,108},{-192,108},{-192,110},
                {-180,110}},
            color={0,140,72},
            thickness=0.5));
        connect(senTem4.port_b, fan2.port_a) annotation (Line(
            points={{-160,110},{-140,110}},
            color={0,140,72},
            thickness=0.5));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{
                  -420,-200},{420,200}})),                             Diagram(
              coordinateSystem(preserveAspectRatio=false, extent={{-420,-200},{
                  420,200}})),
          experiment(
            StartTime=13125600,
            StopTime=13298400,
            Interval=3600,
            __Dymola_Algorithm="Dassl"));
      end cast;

      model cast_bis
        TFP.TFP_carnot_massileo tFP_carnot_massileo(
          redeclare package Medium1 = Media.Water,
          redeclare package Medium2 = Media.Water,
          redeclare package Medium3 = Media.Water,
          redeclare package Medium4 = Media.Water,
          m1_flow_nominal=20,
          m2_flow_nominal=20,
          m3_flow_nominal=20,
          m4_flow_nominal=20)
          annotation (Placement(transformation(extent={{-60,-20},{-40,0}})));
        DHC_Thassalia.RJC.Heat_exchanger_basic heat_exchanger_basic(redeclare
            package Medium1 = Media.Water, redeclare package Medium2 =
              Media.Water)
          annotation (Placement(transformation(extent={{-80,40},{-60,60}})));
        DHC_Thassalia.RJF.Cold_exchanger cold_exchanger(redeclare package
            Medium1 = Media.Water, redeclare package Medium2 = Media.Water)
          annotation (Placement(transformation(extent={{-20,40},{0,60}})));
        Fluid.Movers.FlowControlled_m_flow fan(
          redeclare package Medium = Media.Water,
          m_flow_nominal=150/3.6,
          redeclare
            Fluid.Movers.Data.Pumps.Wilo.CronolineIL80slash220dash4slash4 per,
          dp_nominal=10000)
          annotation (Placement(transformation(extent={{60,30},{40,50}})));
        Fluid.Sources.Boundary_pT bou(
          redeclare package Medium = Media.Water,
                                      use_T_in=true, nPorts=4) annotation (
            Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=270,
              origin={110,70})));
        Fluid.Sensors.TemperatureTwoPort senTem(redeclare package Medium =
              Media.Water, m_flow_nominal=10)
          annotation (Placement(transformation(extent={{60,0},{80,20}})));
        Fluid.Sensors.TemperatureTwoPort senTem1(redeclare package Medium =
              Media.Water, m_flow_nominal=10)
          annotation (Placement(transformation(extent={{60,-40},{80,-20}})));
        Fluid.Sources.Boundary_pT bou1(
          redeclare package Medium = Media.Water,
                                       use_T_in=true, nPorts=4) annotation (
            Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={110,-80})));
        Fluid.Movers.FlowControlled_m_flow fan1(
          redeclare package Medium = Media.Water,
          m_flow_nominal=120/3.6,
          redeclare
            Fluid.Movers.Data.Pumps.Wilo.CronolineIL80slash220dash4slash4 per,
          dp_nominal=10000)
          annotation (Placement(transformation(extent={{40,-70},{20,-50}})));
        Fluid.Sources.Boundary_pT bou2(
          redeclare package Medium = Media.Water,
          use_T_in=true,
          nPorts=3) annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=0,
              origin={-210,110})));
        Fluid.Movers.FlowControlled_dp fan2(
          redeclare package Medium = Media.Water,
          m_flow_nominal=50,
          redeclare Fluid.Movers.Data.Pumps.KSB.KSB_edm per,
          inputType=Buildings.Fluid.Types.InputType.Constant,
          dp_nominal=100000,
          constantHead=1000) annotation (Placement(transformation(extent={{-160,
                  100},{-140,120}})));
        SST.SST_ECS_HE sST_ECS(
          redeclare package Medium = Media.Water,
          m_flow_nominal=10,
          fileName=ModelicaServices.ExternalReferences.loadResource(
              "modelica://Buildings/Data/sst/jan_20/test_cast.txt"),
          tan1(VTan=15))
          annotation (Placement(transformation(extent={{280,80},{300,100}})));
        SST.SST_SH sST_SH(
          redeclare package Medium = Media.Water,
          m_flow_nominal=20,
          fileName=ModelicaServices.ExternalReferences.loadResource(
              "modelica://Buildings/Data/sst/jan_20/test_cast.txt"))
          annotation (Placement(transformation(extent={{280,122},{300,142}})));
        Controls.Mode.switch_tfp switch_tfp
          annotation (Placement(transformation(extent={{340,160},{360,180}})));
        SST.SST_cold sST_cold(
          redeclare package Medium = Media.Water,
          m_flow_nominal=10,
          eps=0.9,
          fileName=ModelicaServices.ExternalReferences.loadResource(
              "modelica://Buildings/Data/sst/jan_20/test_cast_froid.txt"))
          annotation (Placement(transformation(extent={{280,-30},{300,-10}})));
        Modelica.Blocks.Sources.RealExpression realExpression1(y=150/3.6/3)
                                                              annotation (
            Placement(transformation(extent={{20,150},{40,170}})));
        Modelica.Blocks.Sources.RealExpression realExpression2(y=120/3.6/3)
                                                              annotation (
            Placement(transformation(extent={{-20,-90},{0,-70}})));
        Modelica.Blocks.Sources.CombiTimeTable combiTimeTable(
          tableOnFile=true,
          tableName="tab1",
          fileName=ModelicaServices.ExternalReferences.loadResource(
              "modelica://Buildings/Data/sst/jan_20/pem_2020.txt"),
          columns={2})
          annotation (Placement(transformation(extent={{-280,60},{-260,80}})));
        Fluid.Movers.FlowControlled_dp fan3(
          redeclare package Medium = Media.Water,
          m_flow_nominal=10,
          redeclare Fluid.Movers.Data.Pumps.Wilo.Stratos25slash1to6 per,
          inputType=Buildings.Fluid.Types.InputType.Constant,
          dp_nominal=5000,
          constantHead=5000)
          annotation (Placement(transformation(extent={{180,60},{200,80}})));
        Fluid.Sensors.TemperatureTwoPort senTem2(redeclare package Medium =
              Media.Water, m_flow_nominal=10)
          annotation (Placement(transformation(extent={{220,20},{200,40}})));
        Fluid.Sensors.MassFlowRate senMasFlo1(redeclare package Medium =
              Media.Water)
          annotation (Placement(transformation(extent={{148,60},{168,80}})));
        Fluid.Sensors.MassFlowRate senMasFlo2(redeclare package Medium =
              Media.Water)
          annotation (Placement(transformation(extent={{100,30},{80,50}})));
        mult_t mult_t1
          annotation (Placement(transformation(extent={{100,140},{120,160}})));
        mult_t mult_t2 annotation (Placement(transformation(extent={{140,-140},
                  {160,-120}})));
        Fluid.Sensors.MassFlowRate senMasFlo3(redeclare package Medium =
              Media.Water)
          annotation (Placement(transformation(extent={{140,-40},{160,-20}})));
        Fluid.Movers.FlowControlled_dp fan4(
          redeclare package Medium = Media.Water,
          m_flow_nominal=10,
          redeclare Fluid.Movers.Data.Pumps.Wilo.Stratos25slash1to6 per,
          inputType=Buildings.Fluid.Types.InputType.Constant,
          dp_nominal=5000,
          constantHead=5000)
          annotation (Placement(transformation(extent={{180,-40},{200,-20}})));
        Fluid.Sensors.TemperatureTwoPort senTem3(redeclare package Medium =
              Media.Water, m_flow_nominal=10)
          annotation (Placement(transformation(extent={{230,-80},{210,-60}})));
        Fluid.Sensors.MassFlowRate senMasFlo4(redeclare package Medium =
              Media.Water)
          annotation (Placement(transformation(extent={{82,-70},{62,-50}})));
      equation
        connect(tFP_carnot_massileo.port_a3, cold_exchanger.port_b2)
          annotation (Line(
            points={{-60,-13.2},{-64,-13.2},{-64,-12},{-80,-12},{-80,26},{-30,
                26},{-30,44},{-20,44}},
            color={28,108,200},
            thickness=0.5));
        connect(tFP_carnot_massileo.port_b3, cold_exchanger.port_a2)
          annotation (Line(
            points={{-40,-13.1},{-38,-13.1},{-38,-12},{10,-12},{10,44},{0,44}},
            color={28,108,200},
            thickness=0.5));

        connect(heat_exchanger_basic.port_b2, tFP_carnot_massileo.port_a2)
          annotation (Line(
            points={{-80,44},{-88,44},{-88,20},{-20,20},{-20,-7},{-40,-7}},
            color={238,46,47},
            thickness=0.5));
        connect(tFP_carnot_massileo.port_b2, heat_exchanger_basic.port_a2)
          annotation (Line(
            points={{-60,-7},{-66,-7},{-66,-6},{-68,-6},{-68,34},{-54,34},{-54,
                44},{-60,44}},
            color={238,46,47},
            thickness=0.5));
        connect(senTem.port_b, bou.ports[1]) annotation (Line(
            points={{80,10},{113,10},{113,60}},
            color={238,46,47},
            thickness=0.5));
        connect(senTem1.port_b, bou1.ports[1]) annotation (Line(
            points={{80,-30},{107,-30},{107,-70}},
            color={0,127,255},
            thickness=0.5));
        connect(bou2.ports[1], fan2.port_a) annotation (Line(
            points={{-200,112.667},{-180,112.667},{-180,110},{-160,110}},
            color={0,140,72},
            thickness=0.5));
        connect(fan2.port_b, heat_exchanger_basic.port_a1) annotation (Line(
            points={{-140,110},{-110,110},{-110,56},{-80,56}},
            color={0,140,72},
            thickness=0.5));
        connect(fan2.port_b, cold_exchanger.port_a1) annotation (Line(
            points={{-140,110},{-30,110},{-30,56},{-20,56}},
            color={0,140,72},
            thickness=0.5));
        connect(heat_exchanger_basic.port_b1, bou2.ports[2]) annotation (Line(
            points={{-60,56},{-40,56},{-40,140},{-200,140},{-200,110}},
            color={0,140,72},
            thickness=0.5));
        connect(cold_exchanger.port_b1, bou2.ports[3]) annotation (Line(
            points={{0,56},{20,56},{20,140},{-200,140},{-200,107.333}},
            color={0,140,72},
            thickness=0.5));
        connect(sST_SH.y_heating, switch_tfp.sh_in) annotation (Line(points={{
                290,143},{290,170},{338,170}}, color={0,0,127}));
        connect(sST_ECS.y_storage, switch_tfp.ecs_in) annotation (Line(points={
                {290,101},{290,112},{328,112},{328,163},{338,163}}, color={0,0,
                127}));
        connect(sST_cold.y_cooling, switch_tfp.cooling_in) annotation (Line(
              points={{290,-9},{290,14},{332,14},{332,177},{338,177}}, color={0,
                0,127}));
        connect(switch_tfp.HPSHC, tFP_carnot_massileo.mode) annotation (Line(
              points={{362,178},{400,178},{400,-100},{-58,-100},{-58,-22}},
              color={255,127,0}));
        connect(realExpression1.y, fan.m_flow_in) annotation (Line(points={{41,160},
                {50,160},{50,52}},        color={0,0,127}));
        connect(realExpression2.y, fan1.m_flow_in) annotation (Line(points={{1,-80},
                {10,-80},{10,-40},{30,-40},{30,-48}},
                                             color={0,0,127}));
        connect(tFP_carnot_massileo.CV522_pid, heat_exchanger_basic.TFP_CV522)
          annotation (Line(points={{-37,-4},{-28,-4},{-28,16},{-102,16},{-102,
                54},{-82,54}}, color={0,0,127}));
        connect(tFP_carnot_massileo.CV122_pid, cold_exchanger.TFP_CV122)
          annotation (Line(points={{-37,-16},{-28,-16},{-28,54},{-22,54}},
              color={0,0,127}));
        connect(combiTimeTable.y[1], bou2.T_in) annotation (Line(points={{-259,
                70},{-240,70},{-240,114},{-222,114}}, color={0,0,127}));
        connect(combiTimeTable.y[1], heat_exchanger_basic.PEM_TT200)
          annotation (Line(points={{-259,70},{-172,70},{-172,46},{-82,46}},
              color={0,0,127}));
        connect(combiTimeTable.y[1], cold_exchanger.PEM_TT200) annotation (Line(
              points={{-259,70},{-172,70},{-172,36},{-36,36},{-36,46},{-22,46}},
              color={0,0,127}));
        connect(combiTimeTable.y[1], tFP_carnot_massileo.PEM_TT200) annotation (
           Line(points={{-259,70},{-210,70},{-210,-38},{-50,-38},{-50,-22}},
              color={0,0,127}));
        connect(fan1.port_b, tFP_carnot_massileo.port_a4) annotation (Line(
            points={{20,-60},{-20,-60},{-20,-18},{-40,-18}},
            color={0,127,255},
            thickness=0.5));
        connect(tFP_carnot_massileo.port_b4, senTem1.port_a) annotation (Line(
            points={{-60,-18.5},{-64,-18.5},{-64,-18},{-68,-18},{-68,-30},{60,
                -30}},
            color={0,127,255},
            thickness=0.5));
        connect(fan.port_b, tFP_carnot_massileo.port_a1) annotation (Line(
            points={{40,40},{30,40},{30,14},{-60,14},{-60,-2}},
            color={238,46,47},
            thickness=0.5));
        connect(tFP_carnot_massileo.port_b1, senTem.port_a) annotation (Line(
            points={{-40,-2},{40,-2},{40,10},{60,10}},
            color={238,46,47},
            thickness=0.5));
        connect(fan3.port_b, sST_SH.port_a) annotation (Line(
            points={{200,70},{240,70},{240,132},{280,132}},
            color={238,46,47},
            thickness=0.5));
        connect(fan3.port_b, sST_ECS.port_a) annotation (Line(
            points={{200,70},{240,70},{240,90},{280,90}},
            color={238,46,47},
            thickness=0.5));
        connect(senTem2.port_a, sST_ECS.port_b) annotation (Line(
            points={{220,30},{314,30},{314,90},{300,90}},
            color={238,46,47},
            thickness=0.5));
        connect(senTem2.port_a, sST_SH.port_b) annotation (Line(
            points={{220,30},{314,30},{314,132},{300,132}},
            color={238,46,47},
            thickness=0.5));
        connect(senTem2.port_b, bou.ports[2]) annotation (Line(
            points={{200,30},{111,30},{111,60}},
            color={238,46,47},
            thickness=0.5));
        connect(bou.ports[3], senMasFlo1.port_a) annotation (Line(points={{109,
                60},{106,60},{106,50},{134,50},{134,70},{148,70}}, color={0,127,
                255}));
        connect(senMasFlo1.port_b, fan3.port_a)
          annotation (Line(points={{168,70},{180,70}}, color={0,127,255}));
        connect(senMasFlo2.m_flow, mult_t1.m1) annotation (Line(points={{90,51},
                {90,158},{98,158}}, color={0,0,127}));
        connect(senTem.T, mult_t1.T1) annotation (Line(points={{70,21},{70,153},
                {98,153}}, color={0,0,127}));
        connect(senMasFlo1.m_flow, mult_t1.m2) annotation (Line(points={{158,81},
                {158,128},{82,128},{82,147},{98,147}}, color={0,0,127}));
        connect(senTem2.T, mult_t1.T2) annotation (Line(points={{210,41},{210,
                114},{98,114},{98,142}}, color={0,0,127}));
        connect(mult_t1.y, bou.T_in) annotation (Line(points={{121,150},{134,
                150},{134,94},{114,94},{114,82}}, color={0,0,127}));
        connect(sST_cold.port_b, senTem3.port_a) annotation (Line(points={{300,
                -20},{320,-20},{320,-70},{230,-70}}, color={0,127,255}));
        connect(senMasFlo3.port_b, fan4.port_a)
          annotation (Line(points={{160,-30},{180,-30}}, color={0,127,255}));
        connect(fan4.port_b, sST_cold.port_a) annotation (Line(points={{200,-30},
                {240,-30},{240,-20},{280,-20}}, color={0,127,255}));
        connect(senMasFlo3.port_a, bou1.ports[2]) annotation (Line(points={{140,
                -30},{109,-30},{109,-70}}, color={0,127,255}));
        connect(senTem3.port_b, bou1.ports[3])
          annotation (Line(points={{210,-70},{111,-70}}, color={0,127,255}));
        connect(bou1.ports[4], senMasFlo4.port_a) annotation (Line(points={{113,
                -70},{113,-60},{82,-60}}, color={0,127,255}));
        connect(senMasFlo4.port_b, fan1.port_a)
          annotation (Line(points={{62,-60},{40,-60}}, color={0,127,255}));
        connect(senMasFlo4.m_flow, mult_t2.m1) annotation (Line(points={{72,-49},
                {76,-49},{76,-50},{88,-50},{88,-122},{138,-122}}, color={0,0,
                127}));
        connect(senTem1.T, mult_t2.T1) annotation (Line(points={{70,-19},{70,
                -14},{52,-14},{52,-127},{138,-127}}, color={0,0,127}));
        connect(senMasFlo3.m_flow, mult_t2.m2) annotation (Line(points={{150,
                -19},{150,-8},{128,-8},{128,-133},{138,-133}}, color={0,0,127}));
        connect(senTem3.T, mult_t2.T2) annotation (Line(points={{220,-59},{220,
                -48},{240,-48},{240,-150},{132,-150},{132,-138},{138,-138}},
              color={0,0,127}));
        connect(mult_t2.y, bou1.T_in) annotation (Line(points={{161,-130},{170,
                -130},{170,-108},{106,-108},{106,-92}}, color={0,0,127}));
        connect(mult_t2.y, tFP_carnot_massileo.DEG_TT121) annotation (Line(
              points={{161,-130},{170,-130},{170,-160},{-42,-160},{-42,-22}},
              color={0,0,127}));
        connect(fan.port_a, senMasFlo2.port_b)
          annotation (Line(points={{60,40},{80,40}}, color={0,127,255}));
        connect(senMasFlo2.port_a, bou.ports[4]) annotation (Line(points={{100,
                40},{107,40},{107,60}}, color={0,127,255}));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
              coordinateSystem(preserveAspectRatio=false)),
          experiment(
            StopTime=172800,
            Interval=3600,
            __Dymola_Algorithm="Dassl"));
      end cast_bis;

      model mult_t
        Modelica.Blocks.Interfaces.RealInput m1
          annotation (Placement(transformation(extent={{-140,60},{-100,100}})));
        Modelica.Blocks.Interfaces.RealInput T1
          annotation (Placement(transformation(extent={{-140,10},{-100,50}})));
        Modelica.Blocks.Interfaces.RealInput m2
          annotation (Placement(transformation(extent={{-140,-50},{-100,-10}})));
        Modelica.Blocks.Interfaces.RealInput T2
          annotation (Placement(transformation(extent={{-140,-100},{-100,-60}})));
        Modelica.Blocks.Interfaces.RealOutput y
          annotation (Placement(transformation(extent={{100,-10},{120,10}})));
      equation
        y = (m1*T1+m2*T2) / (m1+m2);
        annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
              coordinateSystem(preserveAspectRatio=false)));
      end mult_t;

      model cast_ter
        DHC_Thassalia.DEC_DEG.DEC_simpler dEC_simpler(redeclare package Medium1 =
              Media.Water, redeclare package Medium2 = Media.Water)
          annotation (Placement(transformation(extent={{200,40},{220,60}})));
        Fluid.Movers.FlowControlled_m_flow fan(
          redeclare package Medium = Media.Water,
          m_flow_nominal=150/3.6,
          redeclare
            Fluid.Movers.Data.Pumps.Wilo.CronolineIL80slash220dash4slash4 per,
          dp_nominal=10000)
          annotation (Placement(transformation(extent={{140,50},{160,70}})));
        Fluid.Sources.Boundary_pT bou(
          redeclare package Medium = Media.Water,
          use_T_in=false,
          T=333.15,                                  nPorts=2) annotation (
            Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=270,
              origin={110,70})));
        SST.SST_ECS_HE sST_ECS(
          redeclare package Medium = Media.Water,
          m_flow_nominal=10,
          fileName=ModelicaServices.ExternalReferences.loadResource(
              "modelica://Buildings/Data/sst/jan_20/test_cast.txt"),
          tan1(VTan=15))
          annotation (Placement(transformation(extent={{280,80},{300,100}})));
        SST.SST_SH sST_SH(
          redeclare package Medium = Media.Water,
          m_flow_nominal=20,
          fileName=ModelicaServices.ExternalReferences.loadResource(
              "modelica://Buildings/Data/sst/jan_20/test_cast.txt"),
          T_sec_out(T_start=318.15))
          annotation (Placement(transformation(extent={{280,122},{300,142}})));
        Modelica.Blocks.Sources.RealExpression realExpression1(y=150/3.6/3)
                                                              annotation (
            Placement(transformation(extent={{120,100},{140,120}})));
        Modelica.Blocks.Sources.RealExpression realExpression2(y=120/3.6/3)
                                                              annotation (
            Placement(transformation(extent={{120,10},{140,30}})));
        Fluid.FixedResistances.Junction jun(
          redeclare package Medium = Media.Water,
          m_flow_nominal={20,-20,-20},
          dp_nominal={0,0,0}) annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={230,90})));
      equation

        connect(bou.ports[1], fan.port_a) annotation (Line(
            points={{112,60},{140,60}},
            color={238,46,47},
            thickness=0.5));
        connect(fan.port_b, dEC_simpler.port_a1) annotation (Line(points={{160,
                60},{180,60},{180,56},{200,56}}, color={238,46,47},
            thickness=0.5));
        connect(sST_SH.port_b, dEC_simpler.port_a2) annotation (Line(points={{
                300,132},{320,132},{320,44},{220,44}}, color={238,46,47},
            thickness=0.5));
        connect(sST_ECS.port_b, dEC_simpler.port_a2) annotation (Line(points={{
                300,90},{320,90},{320,44},{220,44}}, color={238,46,47},
            thickness=0.5));
        connect(realExpression1.y, fan.m_flow_in) annotation (Line(points={{141,
                110},{150,110},{150,72}}, color={0,0,127}));
        connect(dEC_simpler.port_b2, bou.ports[2]) annotation (Line(points={{
                200,44},{102,44},{102,60},{108,60}}, color={0,127,255}));
        connect(dEC_simpler.port_b1, jun.port_1) annotation (Line(points={{220,
                56},{228,56},{228,80},{230,80},{230,80}}, color={0,127,255}));
        connect(jun.port_3, sST_ECS.port_a)
          annotation (Line(points={{240,90},{280,90}}, color={0,127,255}));
        connect(jun.port_2, sST_SH.port_a) annotation (Line(points={{230,100},{
                230,132},{280,132}}, color={0,127,255}));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{
                  -420,-200},{420,200}})),                             Diagram(
              coordinateSystem(preserveAspectRatio=false, extent={{-420,-200},{
                  420,200}})),
          experiment(
            StartTime=13125600,
            StopTime=13298400,
            Interval=3600,
            __Dymola_Algorithm="Dassl"));
      end cast_ter;
    end Tests;
  end Plant;
end DHC_Massileo;
