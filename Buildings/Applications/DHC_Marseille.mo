within Buildings.Applications;
package DHC_Marseille
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

    model opposite
      Modelica.Blocks.Interfaces.RealInput u
        annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
      Modelica.Blocks.Interfaces.RealOutput y
        annotation (Placement(transformation(extent={{100,-10},{120,10}})));
    equation
      y = 1-u;
      annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
            Rectangle(
              extent={{-100,40},{100,-40}},
              lineColor={28,108,200},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{-100,40},{100,-40}},
              lineColor={28,108,200},
              fillColor={255,255,255},
              fillPattern=FillPattern.None,
              textString="1-u"),
            Text(
              extent={{-100,100},{100,60}},
              lineColor={28,108,200},
              fillColor={255,255,255},
              fillPattern=FillPattern.None,
              textString="%name")}),                                 Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end opposite;

    model dp_law_hot

      parameter Modelica.SIunits.Pressure W1(displayUnit="bar") = 30000;
      parameter Modelica.SIunits.Pressure W2(displayUnit="bar") = 1100000;
      parameter Modelica.SIunits.Conversions.NonSIunits.Temperature_degC T_min = -4;
      parameter Modelica.SIunits.Conversions.NonSIunits.Temperature_degC T_max = 18;

      Modelica.Blocks.Interfaces.RealInput T_ext
        annotation (Placement(transformation(extent={{-140,60},{-100,100}})));
      Modelica.Blocks.Interfaces.RealOutput y
        annotation (Placement(transformation(extent={{100,-10},{120,10}})));

    equation

        if T_ext< T_min then
        y = W2;
        elseif T_ext>= T_min and T_ext <= T_max then
        y = (sqrt(W2) - (sqrt(W2)-sqrt(W1))/(T_max-T_min)*(T_ext-T_min))^2;
        else
        y = W1;
        end if;

      annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={Text(
              extent={{-100,140},{100,100}},
              lineColor={28,108,200},
              textString="%name"),           Rectangle(
              extent={{-100,100},{100,-100}},
              fillColor={210,210,210},
              fillPattern=FillPattern.Solid,
              borderPattern=BorderPattern.Raised),
            Line(points={{-60,60},{-60,-60},{-60,-60},{60,-60}}, color={28,108,200}),
            Polygon(
              points={{-54,60},{-66,60},{-60,80},{-54,60}},
              lineColor={28,108,200},
              fillColor={28,108,200},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{6,-10},{-6,-10},{0,10},{6,-10}},
              lineColor={28,108,200},
              origin={70,-60},
              rotation=270,
              fillColor={28,108,200},
              fillPattern=FillPattern.Solid),
            Line(points={{-70,20},{-40,20},{20,-40},{50,-40}}, color={255,255,0},
              thickness=1)}),                                        Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end dp_law_hot;

    model dp_law_cold

      parameter Modelica.SIunits.Pressure W1(displayUnit="bar") = 30000;
      parameter Modelica.SIunits.Pressure W2(displayUnit="bar") = 1100000;
      parameter Modelica.SIunits.Conversions.NonSIunits.Temperature_degC T_min = 18;
      parameter Modelica.SIunits.Conversions.NonSIunits.Temperature_degC T_max = 34;


      Modelica.Blocks.Interfaces.RealInput T_ext
        annotation (Placement(transformation(extent={{-140,60},{-100,100}})));
      Modelica.Blocks.Interfaces.RealOutput y
        annotation (Placement(transformation(extent={{100,-10},{120,10}})));

    equation

        if T_ext< T_min then
        y = W1;
        elseif T_ext>= T_min and T_ext <= T_max then
        y = (sqrt(W2) - (sqrt(W2)-sqrt(W1))/(T_max-T_min)*(T_max-T_ext))^2;
        else
        y = W2;
        end if;

      annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={Text(
              extent={{-100,140},{100,100}},
              lineColor={28,108,200},
              textString="%name"),           Rectangle(
              extent={{-100,100},{100,-100}},
              fillColor={210,210,210},
              fillPattern=FillPattern.Solid,
              borderPattern=BorderPattern.Raised),
            Line(points={{-60,60},{-60,-60},{-60,-60},{60,-60}}, color={28,108,200}),
            Polygon(
              points={{-54,60},{-66,60},{-60,80},{-54,60}},
              lineColor={28,108,200},
              fillColor={28,108,200},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{6,-10},{-6,-10},{0,10},{6,-10}},
              lineColor={28,108,200},
              origin={70,-60},
              rotation=270,
              fillColor={28,108,200},
              fillPattern=FillPattern.Solid),
            Line(points={{-70,20},{-40,20},{20,-40},{50,-40}}, color={255,255,0},
              thickness=1)}),                                        Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end dp_law_cold;

    model DEC_controls
      Modelica.Blocks.Interfaces.RealInput dp_DEC
        annotation (Placement(transformation(extent={{-360,280},{-320,320}})));
      Modelica.Blocks.Interfaces.RealInput FT_DEC
        annotation (Placement(transformation(extent={{-360,200},{-320,240}})));
      Modelica.Blocks.Interfaces.RealInput FT_TFP
        annotation (Placement(transformation(extent={{-360,160},{-320,200}})));
      Modelica.Blocks.Interfaces.RealInput FT_CHA
        annotation (Placement(transformation(extent={{-360,120},{-320,160}})));
      inner Modelica.StateGraph.StateGraphRoot stateGraphRoot
        annotation (Placement(transformation(extent={{300,300},{320,320}})));
      Modelica.StateGraph.TransitionWithSignal transitionWithSignal
        annotation (Placement(transformation(extent={{-180,-80},{-160,-60}})));
      Modelica.Blocks.Interfaces.RealInput TT_DEC
        annotation (Placement(transformation(extent={{-360,240},{-320,280}})));
      Modelica.StateGraph.StepWithSignal HPSHC1_start(nIn=3, nOut=1)
        annotation (Placement(transformation(extent={{-140,-80},{-120,-60}})));
      Modelica.StateGraph.Transition HPSHC_start_buffer(enableTimer=true,
          waitTime=2)
        annotation (Placement(transformation(extent={{-100,-80},{-80,-60}})));
      Modelica.StateGraph.StepWithSignal HPSHC1_on(nIn=2, nOut=3)
        annotation (Placement(transformation(extent={{-60,-80},{-40,-60}})));
      Modelica.StateGraph.TransitionWithSignal Temp_solo
        annotation (Placement(transformation(extent={{-20,-20},{0,0}})));
      Modelica.StateGraph.TransitionWithSignal HPSHC_turnoff
        annotation (Placement(transformation(extent={{-20,-80},{0,-60}})));
      Modelica.StateGraph.TransitionWithSignal CHA_need
        annotation (Placement(transformation(extent={{-20,-220},{0,-200}})));
      WaitBefore waitBefore(
        threshold=0,
        t_threshold=2,
        superior=false)
        annotation (Placement(transformation(extent={{-238,290},{-218,310}})));
      WaitBefore waitBefore1(
        threshold=53.5,
        t_threshold=2,
        superior=true)
        annotation (Placement(transformation(extent={{-120,-40},{-100,-20}})));
      Modelica.StateGraph.StepWithSignal HPSHC_solo_switch
        annotation (Placement(transformation(extent={{20,-20},{40,0}})));
      Modelica.StateGraph.Transition HPSHC_solo_buffer(enableTimer=true,
          waitTime=2)
        annotation (Placement(transformation(extent={{60,-20},{80,0}})));
      Modelica.StateGraph.StepWithSignal HPSHC_solo(nOut=2)
        annotation (Placement(transformation(extent={{100,-20},{120,0}})));
      Modelica.StateGraph.TransitionWithSignal temp_duo
        annotation (Placement(transformation(extent={{140,20},{160,40}})));
      Modelica.StateGraph.TransitionWithSignal HPSHC_solo_off
        annotation (Placement(transformation(extent={{140,-40},{160,-20}})));
      WaitBefore waitBefore2(
        threshold=53.5,
        t_threshold=2,
        superior=false)
        annotation (Placement(transformation(extent={{40,20},{60,40}})));
      Modelica.Blocks.Math.Add add(k1=-1, k2=+1)
        annotation (Placement(transformation(extent={{-240,200},{-220,220}})));
      Modelica.Blocks.Logical.GreaterEqualThreshold greaterEqualThreshold(threshold=
           10)
        annotation (Placement(transformation(extent={{-200,200},{-180,220}})));
      Modelica.StateGraph.InitialStepWithSignal initialStepWithSignal
        annotation (Placement(transformation(extent={{-220,-80},{-200,-60}})));
      Modelica.StateGraph.StepWithSignal HPSHC_off(nIn=2, nOut=1)
        annotation (Placement(transformation(extent={{180,-80},{200,-60}})));
      Modelica.StateGraph.Transition HPSHC_off_buffer(enableTimer=true,
          waitTime=2)
        annotation (Placement(transformation(extent={{220,-80},{240,-60}})));
      Modelica.StateGraph.StepWithSignal HPSHC_cooling(nIn=1, nOut=2)
        annotation (Placement(transformation(extent={{20,-100},{40,-80}})));
      Modelica.StateGraph.Transition HPSC_turnoff_buffer(enableTimer=true,
          waitTime=2)
        annotation (Placement(transformation(extent={{140,-100},{160,-80}})));
      Modelica.StateGraph.TransitionWithSignal transitionWithSignal7
        annotation (Placement(transformation(extent={{140,-160},{160,-140}})));
      Modelica.StateGraph.StepWithSignal CHA_start(nIn=1, nOut=1)
        annotation (Placement(transformation(extent={{20,-220},{40,-200}})));
      Modelica.StateGraph.Transition CHA_start_buffer(enableTimer=true,
          waitTime=2)
        annotation (Placement(transformation(extent={{60,-220},{80,-200}})));
      Modelica.StateGraph.StepWithSignal CHA_on(nOut=3)
        annotation (Placement(transformation(extent={{100,-220},{120,-200}})));
      Modelica.Blocks.Math.Add add1(k1=+1, k2=+1)
        annotation (Placement(transformation(extent={{-270,140},{-250,160}})));
      Modelica.Blocks.Math.Add add2(k1=-1, k2=+1)
        annotation (Placement(transformation(extent={{-220,150},{-200,170}})));
      Modelica.Blocks.Logical.GreaterEqualThreshold greaterEqualThreshold1(
          threshold=10)
        annotation (Placement(transformation(extent={{-180,150},{-160,170}})));
      Modelica.StateGraph.TransitionWithSignal CHA_turnoff
        annotation (Placement(transformation(extent={{140,-220},{160,-200}})));
      Modelica.StateGraph.StepWithSignal CHA_off(nIn=1, nOut=1)
        annotation (Placement(transformation(extent={{180,-220},{200,-200}})));
      Modelica.StateGraph.Transition CHA_off_buffer(enableTimer=true, waitTime=
            2)
        annotation (Placement(transformation(extent={{220,-220},{240,-200}})));
      Modelica.Blocks.Math.BooleanToInteger booleanToInteger2(integerTrue=0)
        annotation (Placement(transformation(extent={{-60,-140},{-40,-120}})));
      Modelica.Blocks.Math.BooleanToInteger booleanToInteger3(integerTrue=0)
        annotation (Placement(transformation(extent={{40,-140},{60,-120}})));
      Modelica.Blocks.Math.BooleanToInteger booleanToInteger4(integerTrue=0)
        annotation (Placement(transformation(extent={{40,-60},{60,-40}})));
      Modelica.Blocks.Math.BooleanToInteger booleanToInteger5(integerTrue=0)
        annotation (Placement(transformation(extent={{100,-60},{120,-40}})));
      Modelica.Blocks.Math.BooleanToInteger booleanToInteger6(integerTrue=0)
        annotation (Placement(transformation(extent={{200,-120},{220,-100}})));
      Modelica.Blocks.Math.BooleanToInteger booleanToInteger7(integerTrue=0)
        annotation (Placement(transformation(extent={{40,-250},{60,-230}})));
      Modelica.Blocks.Math.BooleanToInteger booleanToInteger8(integerTrue=0)
        annotation (Placement(transformation(extent={{120,-250},{140,-230}})));
      Modelica.Blocks.Math.BooleanToInteger booleanToInteger9(integerTrue=0)
        annotation (Placement(transformation(extent={{200,-260},{220,-240}})));
    equation
      connect(transitionWithSignal.outPort, HPSHC1_start.inPort[1]) annotation (
          Line(points={{-168.5,-70},{-154,-70},{-154,-69.3333},{-141,-69.3333}},
            color={0,0,0}));
      connect(HPSHC1_start.outPort[1], HPSHC_start_buffer.inPort)
        annotation (Line(points={{-119.5,-70},{-94,-70}}, color={0,0,0}));
      connect(HPSHC_start_buffer.outPort, HPSHC1_on.inPort[1]) annotation (Line(
            points={{-88.5,-70},{-74,-70},{-74,-69.5},{-61,-69.5}}, color={0,0,
              0}));
      connect(HPSHC1_on.outPort[1], Temp_solo.inPort) annotation (Line(points={
              {-39.5,-69.6667},{-30,-69.6667},{-30,-10},{-14,-10}}, color={0,0,
              0}));
      connect(HPSHC1_on.outPort[2], HPSHC_turnoff.inPort)
        annotation (Line(points={{-39.5,-70},{-14,-70}}, color={0,0,0}));
      connect(HPSHC1_on.outPort[3], CHA_need.inPort) annotation (Line(points={{
              -39.5,-70.3333},{-30,-70.3333},{-30,-210},{-14,-210}}, color={0,0,
              0}));
      connect(dp_DEC, waitBefore.u)
        annotation (Line(points={{-340,300},{-240,300}}, color={0,0,127}));
      connect(waitBefore.y, transitionWithSignal.condition) annotation (Line(points={{-217,
              300},{-180,300},{-180,240},{-280,240},{-280,-100},{-170,-100},{
              -170,-82}},
                      color={255,0,255}));
      connect(TT_DEC, waitBefore1.u) annotation (Line(points={{-340,260},{-140,
              260},{-140,-30},{-122,-30}},
                                     color={0,0,127}));
      connect(waitBefore1.y, Temp_solo.condition) annotation (Line(points={{-99,
              -30},{-10,-30},{-10,-22}}, color={255,0,255}));
      connect(Temp_solo.outPort, HPSHC_solo_switch.inPort[1])
        annotation (Line(points={{-8.5,-10},{19,-10}}, color={0,0,0}));
      connect(HPSHC_solo_switch.outPort[1], HPSHC_solo_buffer.inPort)
        annotation (Line(points={{40.5,-10},{66,-10}}, color={0,0,0}));
      connect(HPSHC_solo_buffer.outPort, HPSHC_solo.inPort[1])
        annotation (Line(points={{71.5,-10},{99,-10}}, color={0,0,0}));
      connect(HPSHC_solo.outPort[1], temp_duo.inPort) annotation (Line(points={
              {120.5,-9.75},{132,-9.75},{132,30},{146,30}}, color={0,0,0}));
      connect(HPSHC_solo.outPort[2], HPSHC_solo_off.inPort) annotation (Line(
            points={{120.5,-10.25},{132,-10.25},{132,-30},{146,-30}}, color={0,
              0,0}));
      connect(TT_DEC, waitBefore2.u) annotation (Line(points={{-340,260},{-102,
              260},{-102,30},{38,30}},
                                  color={0,0,127}));
      connect(waitBefore2.y, temp_duo.condition) annotation (Line(points={{61,
              30},{120,30},{120,10},{150,10},{150,18}}, color={255,0,255}));
      connect(temp_duo.outPort, HPSHC1_start.inPort[2]) annotation (Line(points=
             {{151.5,30},{180,30},{180,60},{-152,60},{-152,-70},{-141,-70}},
            color={0,0,0}));
      connect(FT_DEC, add.u1) annotation (Line(points={{-340,220},{-260,220},{-260,216},
              {-242,216}}, color={0,0,127}));
      connect(FT_TFP, add.u2) annotation (Line(points={{-340,180},{-260,180},{-260,204},
              {-242,204}}, color={0,0,127}));
      connect(add.y, greaterEqualThreshold.u)
        annotation (Line(points={{-219,210},{-202,210}}, color={0,0,127}));
      connect(greaterEqualThreshold.y, HPSHC_solo_off.condition) annotation (
          Line(points={{-179,210},{128,210},{128,-60},{150,-60},{150,-42}},
            color={255,0,255}));
      connect(greaterEqualThreshold.y, HPSHC_turnoff.condition) annotation (
          Line(points={{-179,210},{-20,210},{-20,-100},{-10,-100},{-10,-82}},
            color={255,0,255}));
      connect(initialStepWithSignal.outPort[1], transitionWithSignal.inPort)
        annotation (Line(points={{-199.5,-70},{-174,-70}}, color={0,0,0}));
      connect(HPSHC_solo_off.outPort, HPSHC_off.inPort[2]) annotation (Line(
            points={{151.5,-30},{166,-30},{166,-70.5},{179,-70.5}}, color={0,0,
              0}));
      connect(HPSHC_off.outPort[1], HPSHC_off_buffer.inPort)
        annotation (Line(points={{200.5,-70},{226,-70}}, color={0,0,0}));
      connect(HPSHC_off_buffer.outPort, initialStepWithSignal.inPort[1])
        annotation (Line(points={{231.5,-70},{260,-70},{260,80},{-240,80},{-240,
              -70},{-221,-70}}, color={0,0,0}));
      connect(waitBefore.y, CHA_need.condition) annotation (Line(points={{-217,
              300},{-180,300},{-180,240},{-280,240},{-280,-240},{-10,-240},{-10,
              -222}}, color={255,0,255}));
      connect(HPSHC_turnoff.outPort, HPSHC_cooling.inPort[1]) annotation (Line(
            points={{-8.5,-70},{4,-70},{4,-90},{19,-90}}, color={0,0,0}));
      connect(HPSHC_cooling.outPort[1], HPSC_turnoff_buffer.inPort) annotation (
         Line(points={{40.5,-89.75},{94,-89.75},{94,-90},{146,-90}}, color={0,0,
              0}));
      connect(HPSC_turnoff_buffer.outPort, HPSHC_off.inPort[1]) annotation (
          Line(points={{151.5,-90},{166,-90},{166,-69.5},{179,-69.5}}, color={0,
              0,0}));
      connect(waitBefore.y, transitionWithSignal7.condition) annotation (Line(
            points={{-217,300},{-180,300},{-180,240},{-280,240},{-280,-180},{
              150,-180},{150,-162}},
                           color={255,0,255}));
      connect(HPSHC_cooling.outPort[2], transitionWithSignal7.inPort) annotation (
          Line(points={{40.5,-90.25},{94,-90.25},{94,-150},{146,-150}},   color={0,0,
              0}));
      connect(transitionWithSignal7.outPort, HPSHC1_start.inPort[3]) annotation (
          Line(points={{151.5,-150},{300,-150},{300,74},{-148,74},{-148,-70},{
              -146,-70},{-146,-70.6667},{-141,-70.6667}},
                                color={0,0,0}));
      connect(CHA_start.outPort[1], CHA_start_buffer.inPort)
        annotation (Line(points={{40.5,-210},{66,-210}}, color={0,0,0}));
      connect(CHA_need.outPort, CHA_start.inPort[1])
        annotation (Line(points={{-8.5,-210},{19,-210}}, color={0,0,0}));
      connect(CHA_start_buffer.outPort, CHA_on.inPort[1])
        annotation (Line(points={{71.5,-210},{99,-210}}, color={0,0,0}));
      connect(FT_TFP, add1.u1) annotation (Line(points={{-340,180},{-308,180},{-308,
              156},{-272,156}}, color={0,0,127}));
      connect(FT_CHA, add1.u2) annotation (Line(points={{-340,140},{-308,140},{-308,
              144},{-272,144}}, color={0,0,127}));
      connect(FT_DEC, add2.u1) annotation (Line(points={{-340,220},{-272,220},{-272,
              174},{-248,174},{-248,166},{-222,166}}, color={0,0,127}));
      connect(add1.y, add2.u2) annotation (Line(points={{-249,150},{-237.5,150},{-237.5,
              154},{-222,154}}, color={0,0,127}));
      connect(add2.y, greaterEqualThreshold1.u) annotation (Line(points={{-199,160},
              {-191.5,160},{-191.5,160},{-182,160}}, color={0,0,127}));
      connect(CHA_on.outPort[1], CHA_turnoff.inPort) annotation (Line(points={{
              120.5,-209.667},{134,-209.667},{134,-210},{146,-210}}, color={0,0,
              0}));
      connect(CHA_turnoff.outPort, CHA_off.inPort[1])
        annotation (Line(points={{151.5,-210},{179,-210}}, color={0,0,0}));
      connect(CHA_off.outPort[1], CHA_off_buffer.inPort)
        annotation (Line(points={{200.5,-210},{226,-210}}, color={0,0,0}));
      connect(CHA_off_buffer.outPort, HPSHC1_on.inPort[2]) annotation (Line(
            points={{231.5,-210},{280,-210},{280,70},{-70,70},{-70,-70.5},{-61,
              -70.5}}, color={0,0,0}));
      connect(greaterEqualThreshold1.y, CHA_turnoff.condition) annotation (Line(
            points={{-159,160},{-148,160},{-148,120},{-300,120},{-300,-260},{
              150,-260},{150,-222}}, color={255,0,255}));
      connect(HPSHC_solo_switch.active, booleanToInteger4.u) annotation (Line(
            points={{30,-21},{30,-50},{38,-50}}, color={255,0,255}));
      connect(HPSHC_solo.active, booleanToInteger5.u) annotation (Line(points={
              {110,-21},{110,-28},{86,-28},{86,-50},{98,-50}}, color={255,0,255}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-320,-320},
                {320,320}})),            Diagram(coordinateSystem(
              preserveAspectRatio=false, extent={{-320,-320},{320,320}})));
    end DEC_controls;

      package Tests
      extends Modelica.Icons.ExamplesPackage;
        model switch
          Modelica.Blocks.Sources.RealExpression realExpression(y= if aa.y == 1 or aa.y == 15 then 10 else if aa.y == 2 then 15 else 0)
            annotation (Placement(transformation(extent={{-40,80},{-20,100}})));
          Modelica.Blocks.Math.RealToInteger aa
            annotation (Placement(transformation(extent={{-60,40},{-40,60}})));
          Modelica.Blocks.Sources.Ramp ramp(height=20,  duration=400)
            annotation (Placement(transformation(extent={{-100,40},{-80,60}})));
        equation
          connect(ramp.y, aa.u)
            annotation (Line(points={{-79,50},{-62,50}}, color={0,0,127}));
          annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
                coordinateSystem(preserveAspectRatio=false)));
        end switch;

        model loi_eau
        Modelica.Blocks.Sources.Ramp ramp(
          height=50,
          duration=100,
          offset=-10)
          annotation (Placement(transformation(extent={{-60,0},{-40,20}})));
        dp_law_hot dp_law_hot1(T_min(displayUnit="degC"))
          annotation (Placement(transformation(extent={{0,0},{20,20}})));
        dp_law_cold dp_law_cold1
          annotation (Placement(transformation(extent={{0,-40},{20,-20}})));
        equation
        connect(ramp.y, dp_law_hot1.T_ext) annotation (Line(points={{-39,10},{
                -19.5,10},{-19.5,18},{-2,18}}, color={0,0,127}));
        connect(ramp.y, dp_law_cold1.T_ext) annotation (Line(points={{-39,10},{
                -20,10},{-20,-22},{-2,-22}}, color={0,0,127}));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
              coordinateSystem(preserveAspectRatio=false)));
        end loi_eau;

        model temps_0
        Modelica.Blocks.Sources.Sine sine(freqHz(displayUnit="Hz") = 0.1)
          annotation (Placement(transformation(extent={{-100,0},{-80,20}})));
        Modelica.Blocks.Logical.Timer timer
          annotation (Placement(transformation(extent={{-20,0},{0,20}})));
        Modelica.Blocks.Logical.GreaterEqualThreshold greaterEqualThreshold
          annotation (Placement(transformation(extent={{20,0},{40,20}})));
        Modelica.Blocks.Logical.LessEqualThreshold lessEqualThreshold
          annotation (Placement(transformation(extent={{-60,0},{-40,20}})));
        equation
        connect(sine.y, lessEqualThreshold.u)
          annotation (Line(points={{-79,10},{-62,10}}, color={0,0,127}));
        connect(lessEqualThreshold.y, timer.u)
          annotation (Line(points={{-39,10},{-22,10}}, color={255,0,255}));
        connect(timer.y, greaterEqualThreshold.u)
          annotation (Line(points={{1,10},{18,10}}, color={0,0,127}));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
              coordinateSystem(preserveAspectRatio=false)));
        end temps_0;

        model root_0
          inner Modelica.StateGraph.StateGraphRoot stateGraphRoot
            annotation (Placement(transformation(extent={{80,78},{100,98}})));
          Modelica.StateGraph.InitialStep initialStep
            annotation (Placement(transformation(extent={{-80,-20},{-60,0}})));
          Modelica.StateGraph.TransitionWithSignal transitionWithSignal
            annotation (Placement(transformation(extent={{-40,-20},{-20,0}})));
        Modelica.Blocks.Logical.Timer timer
          annotation (Placement(transformation(extent={{-20,60},{0,80}})));
        Modelica.Blocks.Logical.LessEqualThreshold lessEqualThreshold
          annotation (Placement(transformation(extent={{-60,60},{-40,80}})));
        Modelica.Blocks.Logical.GreaterEqualThreshold greaterEqualThreshold(
            threshold=300)
          annotation (Placement(transformation(extent={{20,60},{40,80}})));
        Modelica.Blocks.Sources.Step step(
          height=-1,
          offset=1,
          startTime=100)
          annotation (Placement(transformation(extent={{-100,60},{-80,80}})));
        Modelica.StateGraph.Transition transition1(enableTimer=true, waitTime=
              100)
          annotation (Placement(transformation(extent={{40,-20},{60,0}})));
        Modelica.StateGraph.Step step1
          annotation (Placement(transformation(extent={{0,-20},{20,0}})));
        equation
          connect(initialStep.outPort[1],transitionWithSignal. inPort)
            annotation (Line(points={{-59.5,-10},{-34,-10}},   color={0,0,0}));
        connect(lessEqualThreshold.y, timer.u)
          annotation (Line(points={{-39,70},{-22,70}}, color={255,0,255}));
        connect(timer.y, greaterEqualThreshold.u)
          annotation (Line(points={{1,70},{18,70}}, color={0,0,127}));
        connect(step.y, lessEqualThreshold.u) annotation (Line(points={{-79,70},
                {-62,70},{-62,70}}, color={0,0,127}));
        connect(transitionWithSignal.outPort, step1.inPort[1])
          annotation (Line(points={{-28.5,-10},{-1,-10}}, color={0,0,0}));
        connect(step1.outPort[1], transition1.inPort)
          annotation (Line(points={{20.5,-10},{46,-10}}, color={0,0,0}));
        connect(transition1.outPort, initialStep.inPort[1]) annotation (Line(
              points={{51.5,-10},{72,-10},{72,20},{-90,20},{-90,-10},{-81,-10}},
              color={0,0,0}));
        connect(greaterEqualThreshold.y, transitionWithSignal.condition)
          annotation (Line(points={{41,70},{52,70},{52,40},{-100,40},{-100,-34},
                {-30,-34},{-30,-22}}, color={255,0,255}));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
              coordinateSystem(preserveAspectRatio=false)));
        end root_0;

        model root_1
          inner Modelica.StateGraph.StateGraphRoot stateGraphRoot
            annotation (Placement(transformation(extent={{80,78},{100,98}})));
          Modelica.StateGraph.InitialStep initialStep(nIn=1)
            annotation (Placement(transformation(extent={{-80,-20},{-60,0}})));
          Modelica.StateGraph.Transition transitionWithSignal(enableTimer=true, waitTime=
             2)
            annotation (Placement(transformation(extent={{-40,-20},{-20,0}})));
          Modelica.StateGraph.Transition transition1(enableTimer=true, waitTime=
             5)
            annotation (Placement(transformation(extent={{40,-20},{60,0}})));
          Modelica.StateGraph.Step step1(nIn=2,
                                         nOut=2)
            annotation (Placement(transformation(extent={{0,-20},{20,0}})));
          Modelica.StateGraph.Transition transition2(enableTimer=true, waitTime=
             2)
            annotation (Placement(transformation(extent={{40,-60},{60,-40}})));
          Modelica.StateGraph.Step step
            annotation (Placement(transformation(extent={{80,-60},{100,-40}})));
          Modelica.StateGraph.Transition transition3(enableTimer=true, waitTime=
             1)
            annotation (Placement(transformation(extent={{120,-60},{140,-40}})));
        equation
          connect(initialStep.outPort[1],transitionWithSignal. inPort)
            annotation (Line(points={{-59.5,-10},{-34,-10}},   color={0,0,0}));
          connect(step1.outPort[1], transition1.inPort)
            annotation (Line(points={{20.5,-9.75},{34,-9.75},{34,-10},{46,-10}},
                                                           color={0,0,0}));
          connect(transition1.outPort, initialStep.inPort[1]) annotation (Line(points={{51.5,
                -10},{72,-10},{72,20},{-90,20},{-90,-10},{-81,-10}},        color={0,0,0}));
          connect(step1.outPort[2], transition2.inPort) annotation (Line(points={{20.5,
                -10.25},{34,-10.25},{34,-50},{46,-50}},
                                                 color={0,0,0}));
          connect(transition2.outPort, step.inPort[1])
            annotation (Line(points={{51.5,-50},{79,-50}}, color={0,0,0}));
          connect(step.outPort[1], transition3.inPort)
            annotation (Line(points={{100.5,-50},{126,-50}}, color={0,0,0}));
        connect(transition3.outPort, step1.inPort[2]) annotation (Line(points={
                {131.5,-50},{160,-50},{160,-80},{-14,-80},{-14,-10.5},{-1,-10.5}},
              color={0,0,0}));
        connect(transitionWithSignal.outPort, step1.inPort[1]) annotation (Line(
              points={{-28.5,-10},{-14,-10},{-14,-9.5},{-1,-9.5}}, color={0,0,0}));
          annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
                coordinateSystem(preserveAspectRatio=false)));
        end root_1;

        model temps_1
        Modelica.Blocks.Sources.Sine sine(freqHz(displayUnit="Hz") = 0.1)
          annotation (Placement(transformation(extent={{-100,0},{-80,20}})));
        WaitBefore waitBefore_comp(
          threshold=0,
          t_threshold=1,
          superior=true)
          annotation (Placement(transformation(extent={{-40,0},{-20,20}})));
        equation
        connect(sine.y, waitBefore_comp.u)
          annotation (Line(points={{-79,10},{-42,10}}, color={0,0,127}));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
              coordinateSystem(preserveAspectRatio=false)),
          experiment(
            StopTime=500,
            Interval=0.1,
            __Dymola_Algorithm="Dassl"));
        end temps_1;

        model dec_controls
          extends Modelica.Icons.Example;
        DEC_controls_parallel dEC_controls
          annotation (Placement(transformation(extent={{-42,-2},{22,62}})));
        Modelica.Blocks.Sources.RealExpression realExpression
          annotation (Placement(transformation(extent={{-120,40},{-100,60}})));
        equation
        connect(realExpression.y, dEC_controls.dp_DEC) annotation (Line(points=
                {{-99,50},{-72,50},{-72,60},{-44,60}}, color={0,0,127}));
        connect(realExpression.y, dEC_controls.TT_DEC) annotation (Line(points=
                {{-99,50},{-72,50},{-72,56},{-44,56}}, color={0,0,127}));
        connect(realExpression.y, dEC_controls.FT_DEC) annotation (Line(points=
                {{-99,50},{-72,50},{-72,52},{-44,52}}, color={0,0,127}));
        connect(realExpression.y, dEC_controls.FT_TFP) annotation (Line(points=
                {{-99,50},{-72,50},{-72,48},{-44,48}}, color={0,0,127}));
        connect(realExpression.y, dEC_controls.FT_CHA) annotation (Line(points=
                {{-99,50},{-72,50},{-72,44},{-44,44}}, color={0,0,127}));
        end dec_controls;

        model ExecutionPaths
        "Example to demonstrate parallel and alternative execution paths"

          extends Modelica.Icons.Example;

          Modelica.StateGraph.InitialStep step0
            annotation (Placement(transformation(extent={{-140,-100},{-120,-80}})));
          Modelica.StateGraph.Transition transition1(enableTimer=true, waitTime=1)
            annotation (Placement(transformation(extent={{-100,-100},{-80,-80}})));
          Modelica.StateGraph.Step step1
            annotation (Placement(transformation(extent={{-10,-40},{10,-20}})));
          Modelica.StateGraph.Transition transition2(enableTimer=true, waitTime=1)
            annotation (Placement(transformation(extent={{90,-100},{110,-80}})));
          Modelica.StateGraph.Step step6
            annotation (Placement(transformation(extent={{120,-100},{140,-80}})));
          Modelica.StateGraph.Step step2
            annotation (Placement(transformation(extent={{-98,40},{-78,60}})));
          Modelica.StateGraph.Transition transition3(enableTimer=true, waitTime=1.1)
            annotation (Placement(transformation(extent={{-42,80},{-22,100}})));
          Modelica.StateGraph.Transition transition4(enableTimer=true, waitTime=1)
            annotation (Placement(transformation(extent={{-42,40},{-22,60}})));
          Modelica.StateGraph.Step step3
            annotation (Placement(transformation(extent={{-8,80},{12,100}})));
          Modelica.StateGraph.Step step4
            annotation (Placement(transformation(extent={{-8,40},{12,60}})));
          Modelica.StateGraph.Transition transition5(enableTimer=true, waitTime=1)
            annotation (Placement(transformation(extent={{26,80},{46,100}})));
          Modelica.StateGraph.Transition transition6(enableTimer=true, waitTime=1)
            annotation (Placement(transformation(extent={{26,40},{46,60}})));
          Modelica.StateGraph.Step step5
            annotation (Placement(transformation(extent={{80,40},{100,60}})));
          Modelica.Blocks.Sources.RealExpression setReal(y=time)
                                  annotation (Placement(transformation(extent={{21,
                      -160},{41,-140}})));
          Modelica.StateGraph.TransitionWithSignal transition7
            annotation (Placement(transformation(extent={{9,-134},{-11,-114}})));
          Modelica.Blocks.Sources.BooleanExpression setCondition(y=time >= 7)
            annotation (Placement(transformation(extent={{-77,-160},{-19,-140}})));
          Modelica.StateGraph.Transition transition4a(enableTimer=true, waitTime=1)
            annotation (Placement(transformation(extent={{-42,0},{-22,20}})));
          Modelica.StateGraph.Step step4a
            annotation (Placement(transformation(extent={{-8,0},{12,20}})));
          Modelica.StateGraph.Transition transition6a(enableTimer=true, waitTime=2)
            annotation (Placement(transformation(extent={{26,0},{46,20}})));
          Modelica.StateGraph.Temporary.NumericValue NumericValue1
            annotation (Placement(transformation(extent={{61,-160},{81,-140}})));
          Modelica.StateGraph.Alternative alternative(nBranches=3)
            annotation (Placement(transformation(extent={{-70,-10},{72,110}})));
          Modelica.StateGraph.Parallel Parallel1
            annotation (Placement(transformation(extent={{-154,-50},{152,120}})));
            inner Modelica.StateGraph.StateGraphRoot stateGraphRoot
            annotation (Placement(transformation(extent={{-160,120},{-140,140}})));
        equation
          connect(transition3.outPort, step3.inPort[1])
            annotation (Line(points={{-30.5,90},{-9,90}}));
          connect(step3.outPort[1], transition5.inPort)
            annotation (Line(points={{12.5,90},{32,90}}));
          connect(transition4.outPort, step4.inPort[1])
            annotation (Line(points={{-30.5,50},{-9,50}}));
          connect(step4.outPort[1], transition6.inPort)
            annotation (Line(points={{12.5,50},{32,50}}));
          connect(transition7.outPort, step0.inPort[1]) annotation (Line(points={{
                    -2.5,-124},{-149,-124},{-149,-90},{-141,-90}}));
          connect(step6.outPort[1], transition7.inPort) annotation (Line(points={{
                    140.5,-90},{150,-90},{150,-124},{3,-124}}));
          connect(transition4a.outPort, step4a.inPort[1])
            annotation (Line(points={{-30.5,10},{-9,10}}));
          connect(step4a.outPort[1], transition6a.inPort)
            annotation (Line(points={{12.5,10},{32,10}}));
          connect(setCondition.y, transition7.condition) annotation (Line(points={{
                    -16.1,-150},{-1,-150},{-1,-136}}, color={255,0,255}));
          connect(setReal.y, NumericValue1.Value) annotation (Line(
                points={{42,-150},{59,-150}}, color={0,0,255}));
          connect(transition3.inPort, alternative.split[1]) annotation (Line(points={{-36,90},
                    {-55.09,90}}));
          connect(transition4.inPort, alternative.split[2]) annotation (Line(points={{-36,50},
                    {-55.09,50}}));
          connect(transition4a.inPort, alternative.split[3]) annotation (Line(points={{-36,10},
                    {-45.0125,10},{-45.0125,10},{-55.09,10}}));
          connect(transition5.outPort, alternative.join[1]) annotation (Line(points={{37.5,90},
                    {57.09,90}}));
          connect(transition6.outPort, alternative.join[2]) annotation (Line(points={{37.5,50},
                    {57.09,50}}));
          connect(transition6a.outPort, alternative.join[3]) annotation (Line(points={{37.5,10},
                    {46.7625,10},{46.7625,10},{57.09,10}}));
          connect(step2.outPort[1], alternative.inPort) annotation (Line(points={{
                    -77.5,50},{-72.13,50}}));
          connect(alternative.outPort, step5.inPort[1])
            annotation (Line(points={{73.42,50},{79,50}}));
          connect(step2.inPort[1], Parallel1.split[1]) annotation (Line(points={{-99,50},
                  {-118,50},{-118,78},{-119.575,78},{-119.575,35}}));
          connect(step1.outPort[1], Parallel1.join[2]) annotation (Line(points={{10.5,
                  -30},{118,-30},{118,35},{117.575,35}}));
          connect(step0.outPort[1], transition1.inPort) annotation (Line(points={{
                    -119.5,-90},{-94,-90}}));
          connect(transition2.outPort, step6.inPort[1]) annotation (Line(points={{
                    101.5,-90},{119,-90}}));
          connect(transition1.outPort, Parallel1.inPort) annotation (Line(points={{
                    -88.5,-90},{-70,-90},{-70,-64},{-174,-64},{-174,35},{-158.59,35}}));
          connect(Parallel1.outPort, transition2.inPort) annotation (Line(points={{
                    155.06,35},{168,35},{168,-60},{80,-60},{80,-90},{96,-90}}));
          connect(step5.outPort[1], Parallel1.join[1]) annotation (Line(points={{100.5,
                  50},{116,50},{116,35},{117.575,35}}));
          connect(Parallel1.split[2], step1.inPort[1]) annotation (Line(points={{
                  -119.575,35},{-119.575,-8},{-119.575,-30},{-11,-30}}));
          annotation (
            Documentation(info="<html>
<p>
This is an example to demonstrate in which way <strong>parallel</strong> activities
can be modelled by a StateGraph. When transition1 fires
(after 1 second), two branches are executed in parallel.
After 6 seconds the two branches are synchronized in order to arrive
at step6.
</p>
<p>
Before simulating the model, try to figure out whether which branch
of the alternative sequence is executed. Note, that alternatives
have priorities according to the port index (alternative.split[1]
has a higher priority to fire as alternative.split[2]).
</p>
</html>"),            experiment(StopTime=15),
              Diagram(coordinateSystem(extent={{-200,-200},{200,200}})));
        end ExecutionPaths;

        model inttoboo
        Modelica.Blocks.Math.BooleanToInteger booleanToInteger(integerTrue=10)
          annotation (Placement(transformation(extent={{20,0},{40,20}})));
        Modelica.Blocks.Sources.BooleanPulse booleanPulse(period=100)
          annotation (Placement(transformation(extent={{-100,40},{-80,60}})));
        Modelica.Blocks.Logical.Or or1
          annotation (Placement(transformation(extent={{-60,0},{-40,20}})));
        Modelica.Blocks.Sources.BooleanPulse booleanPulse1(period=120)
          annotation (Placement(transformation(extent={{-100,0},{-80,20}})));
        equation
        connect(booleanPulse.y, or1.u1) annotation (Line(points={{-79,50},{-79,
                30},{-62,30},{-62,10}}, color={255,0,255}));
        connect(booleanPulse1.y, or1.u2) annotation (Line(points={{-79,10},{-72,
                10},{-72,2},{-62,2}}, color={255,0,255}));
        connect(or1.y, booleanToInteger.u)
          annotation (Line(points={{-39,10},{18,10}}, color={255,0,255}));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
              coordinateSystem(preserveAspectRatio=false)));
        end inttoboo;

        model or_test
          Modelica.Blocks.Interfaces.BooleanInput u[2]
            annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));

          Modelica.Blocks.Interfaces.BooleanOutput y
            annotation (Placement(transformation(extent={{100,-10},{120,10}})));
        equation
            y = u[1] + u[2]
          annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
                coordinateSystem(preserveAspectRatio=false)));

        end or_test;

        model test_or
        Modelica.Blocks.MathInteger.MultiSwitch HPSHC_exit(
          expr={1,10},
          use_pre_as_default=false,
          nu=2) annotation (Placement(transformation(extent={{20,20},{60,40}})));
        Modelica.Blocks.Sources.BooleanPulse booleanPulse(period=100)
          annotation (Placement(transformation(extent={{-100,40},{-80,60}})));
        Modelica.Blocks.Sources.BooleanPulse booleanPulse1(period=120)
          annotation (Placement(transformation(extent={{-100,0},{-80,20}})));
        equation
        connect(booleanPulse.y, HPSHC_exit.u[1]) annotation (Line(points={{-79,
                50},{-30,50},{-30,31.5},{20,31.5}}, color={255,0,255}));
        connect(booleanPulse1.y, HPSHC_exit.u[2]) annotation (Line(points={{-79,
                10},{-30,10},{-30,28.5},{20,28.5}}, color={255,0,255}));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
              coordinateSystem(preserveAspectRatio=false)));
        end test_or;

        model DEC_test
        DEC_controls_parallel dEC_controls_parallel
          annotation (Placement(transformation(extent={{-20,-20},{44,44}})));
        Modelica.Blocks.Sources.RealExpression realExpression
          annotation (Placement(transformation(extent={{-80,80},{-60,100}})));
        Modelica.Blocks.Sources.RealExpression realExpression1
          annotation (Placement(transformation(extent={{-80,50},{-60,70}})));
        Modelica.Blocks.Sources.RealExpression realExpression2
          annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
        Modelica.Blocks.Sources.RealExpression realExpression3
          annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
        Modelica.Blocks.Sources.RealExpression realExpression4
          annotation (Placement(transformation(extent={{-80,-40},{-60,-20}})));
        equation
        connect(realExpression4.y, dEC_controls_parallel.FT_CHA) annotation (
            Line(points={{-59,-30},{-40,-30},{-40,26},{-22,26}}, color={0,0,127}));
        connect(realExpression3.y, dEC_controls_parallel.FT_TFP) annotation (
            Line(points={{-59,0},{-42,0},{-42,30},{-22,30}}, color={0,0,127}));
        connect(realExpression2.y, dEC_controls_parallel.FT_DEC) annotation (
            Line(points={{-59,30},{-40,30},{-40,34},{-22,34}}, color={0,0,127}));
        connect(realExpression1.y, dEC_controls_parallel.TT_DEC) annotation (
            Line(points={{-59,60},{-42,60},{-42,38},{-22,38}}, color={0,0,127}));
        connect(realExpression.y, dEC_controls_parallel.dp_DEC) annotation (
            Line(points={{-59,90},{-42,90},{-42,42},{-22,42}}, color={0,0,127}));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
              coordinateSystem(preserveAspectRatio=false)));
        end DEC_test;

        model test_greater
        Modelica.Blocks.Interfaces.RealInput u
          annotation (Placement(transformation(extent={{-120,-20},{-80,20}})));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
              coordinateSystem(preserveAspectRatio=false)));
        end test_greater;
      end Tests;

    model WaitBefore_backup
      parameter Real threshold "time threshold";
      Modelica.Blocks.Logical.Timer timer annotation (Placement(transformation(
                extent={{-10,-10},{10,10}})));
      Modelica.Blocks.Interfaces.BooleanInput
                                     u "Connector of Boolean input signal"
        annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
      Modelica.Blocks.Interfaces.BooleanOutput y
        "Connector of Boolean output signal"
        annotation (Placement(transformation(extent={{100,-10},{120,10}})));
    equation
      y = timer.y >= threshold;
      connect(u, timer.u);
      annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
                                             Rectangle(
              extent={{-100,100},{100,-100}},
              fillColor={210,210,210},
              fillPattern=FillPattern.Solid,
              borderPattern=BorderPattern.Raised),
          Line(points={{-80,-20},{-62,-20},{40,70},{40,-20},{68,-20}},
            color={0,0,127}),
          Line(points={{-80,-80},{20,-80},{20,-36},{40,-36},{40,-80},{66,-80}},
            color={255,0,255},
              thickness=0.5),
          Line(points={{-80,60},{-80,-80}},
            color={192,192,192}),
          Line(points={{-80,-80},{60,-80}},
            color={192,192,192}),
          Polygon(lineColor={192,192,192},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid,
            points={{-80,80},{-88,60},{-72,60},{-80,80}}),
          Polygon(lineColor={192,192,192},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid,
            points={{80,-80},{60,-72},{60,-88},{80,-80}}),
            Line(
              points={{20,80},{20,-88}},
              color={0,0,0},
              pattern=LinePattern.Dash),
            Text(
              lineColor={0,0,255},
              extent={{-150,110},{150,150}},
              textString="%name")}),                                 Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end WaitBefore_backup;

    model WaitBefore
      parameter Real threshold "Value threshold";
      parameter Real t_threshold "time threshold";
      parameter Boolean superior=true "true when superior to threshold";
      Modelica.Blocks.Logical.Timer timer annotation (Placement(transformation(
                extent={{-10,-10},{10,10}})));
      Modelica.Blocks.Interfaces.BooleanOutput y
        "Connector of Boolean output signal"
        annotation (Placement(transformation(extent={{100,-10},{120,10}})));
      Modelica.Blocks.Interfaces.RealInput u
        annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
    equation
      if superior==true then
      timer.u = u >= threshold;
      else
      timer.u = u <= threshold;
      end if;
      y = timer.y >= t_threshold;

      annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
                                             Rectangle(
              extent={{-100,100},{100,-100}},
              fillColor={210,210,210},
              fillPattern=FillPattern.Solid,
              borderPattern=BorderPattern.Raised),
          Line(points={{-80,-20},{-62,-20},{40,70},{40,-20},{68,-20}},
            color={0,0,127}),
          Line(points={{-80,-80},{20,-80},{20,-36},{40,-36},{40,-80},{66,-80}},
            color={255,0,255},
              thickness=0.5),
          Line(points={{-80,60},{-80,-80}},
            color={192,192,192}),
          Line(points={{-80,-80},{60,-80}},
            color={192,192,192}),
          Polygon(lineColor={192,192,192},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid,
            points={{-80,80},{-88,60},{-72,60},{-80,80}}),
          Polygon(lineColor={192,192,192},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid,
            points={{80,-80},{60,-72},{60,-88},{80,-80}}),
            Line(
              points={{20,80},{20,-88}},
              color={0,0,0},
              pattern=LinePattern.Dash),
            Text(
              lineColor={0,0,255},
              extent={{-150,110},{150,150}},
              textString="%name"),
            Line(
              points={{-52,92},{-6,72},{-52,52}},
              thickness=0.5),
            Line(points={{-52,46},{-6,46}},   thickness=0.5),
            Line(
              points={{-10,-22},{-56,-42},{-10,-62}},
              thickness=0.5),
            Line(points={{-56,-68},{-10,-68}},thickness=0.5)}),      Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end WaitBefore;

    model DEC_controls_parallel
      Modelica.Blocks.Interfaces.RealInput dp_DEC
        annotation (Placement(transformation(extent={{-360,280},{-320,320}})));
      Modelica.Blocks.Interfaces.RealInput FT_DEC
        annotation (Placement(transformation(extent={{-360,200},{-320,240}})));
      Modelica.Blocks.Interfaces.RealInput FT_TFP
        annotation (Placement(transformation(extent={{-360,160},{-320,200}})));
      Modelica.Blocks.Interfaces.RealInput FT_CHA
        annotation (Placement(transformation(extent={{-360,120},{-320,160}})));
      inner Modelica.StateGraph.StateGraphRoot stateGraphRoot
        annotation (Placement(transformation(extent={{300,300},{320,320}})));
      Modelica.StateGraph.TransitionWithSignal transitionWithSignal
        annotation (Placement(transformation(extent={{-180,-60},{-160,-40}})));
      Modelica.Blocks.Interfaces.RealInput TT_DEC
        annotation (Placement(transformation(extent={{-360,240},{-320,280}})));
      Modelica.StateGraph.StepWithSignal HPSHC1_start(nIn=3, nOut=1)
        annotation (Placement(transformation(extent={{-140,-60},{-120,-40}})));
      Modelica.StateGraph.Transition HPSHC_start_buffer(enableTimer=true, waitTime=2)
        annotation (Placement(transformation(extent={{-100,-60},{-80,-40}})));
      Modelica.StateGraph.StepWithSignal HPSHC1_on(nIn=2, nOut=3)
        annotation (Placement(transformation(extent={{-60,-60},{-40,-40}})));
      Modelica.StateGraph.TransitionWithSignal Temp_solo
        annotation (Placement(transformation(extent={{-20,0},{0,20}})));
      Modelica.StateGraph.TransitionWithSignal HPSHC_turnoff
        annotation (Placement(transformation(extent={{-20,-60},{0,-40}})));
      Modelica.StateGraph.TransitionWithSignal CHA_need
        annotation (Placement(transformation(extent={{-20,-220},{0,-200}})));
      WaitBefore waitBefore(
        threshold=0,
        t_threshold=2,
        superior=false)
        annotation (Placement(transformation(extent={{-238,290},{-218,310}})));
      WaitBefore waitBefore1(
        threshold=53.5,
        t_threshold=2,
        superior=true)
        annotation (Placement(transformation(extent={{-120,-20},{-100,0}})));
      Modelica.StateGraph.StepWithSignal HPSHC_solo_switch
        annotation (Placement(transformation(extent={{20,0},{40,20}})));
      Modelica.StateGraph.Transition HPSHC_solo_buffer(enableTimer=true, waitTime=2)
        annotation (Placement(transformation(extent={{60,0},{80,20}})));
      Modelica.StateGraph.StepWithSignal HPSHC_solo(nOut=2)
        annotation (Placement(transformation(extent={{100,0},{120,20}})));
      Modelica.StateGraph.TransitionWithSignal temp_duo
        annotation (Placement(transformation(extent={{140,40},{160,60}})));
      Modelica.StateGraph.TransitionWithSignal HPSHC_solo_off
        annotation (Placement(transformation(extent={{140,-20},{160,0}})));
      WaitBefore waitBefore2(
        threshold=53.5,
        t_threshold=2,
        superior=false)
        annotation (Placement(transformation(extent={{40,40},{60,60}})));
      Modelica.Blocks.Math.Add add(k1=-1, k2=+1)
        annotation (Placement(transformation(extent={{-260,200},{-240,220}})));
      Modelica.Blocks.Logical.GreaterEqual greaterEqualThreshold
        annotation (Placement(transformation(extent={{-200,200},{-180,220}})));
      Modelica.StateGraph.InitialStepWithSignal initialStepWithSignal
        annotation (Placement(transformation(extent={{-220,-60},{-200,-40}})));
      Modelica.StateGraph.Step HPSHC_off(nIn=2, nOut=1)
        annotation (Placement(transformation(extent={{180,-60},{200,-40}})));
      Modelica.StateGraph.Transition HPSHC_off_buffer(enableTimer=true, waitTime=2)
        annotation (Placement(transformation(extent={{220,-60},{240,-40}})));
      Modelica.StateGraph.StepWithSignal HPSHC_cooling(nIn=1, nOut=2)
        annotation (Placement(transformation(extent={{20,-80},{40,-60}})));
      Modelica.StateGraph.Transition HPSC_turnoff_buffer(enableTimer=true, waitTime=
           2) annotation (Placement(transformation(extent={{140,-80},{160,-60}})));
      Modelica.StateGraph.TransitionWithSignal transitionWithSignal7
        annotation (Placement(transformation(extent={{140,-140},{160,-120}})));
      Modelica.StateGraph.StepWithSignal CHA_start(nIn=1, nOut=1)
        annotation (Placement(transformation(extent={{60,-200},{80,-180}})));
      Modelica.StateGraph.Transition CHA_start_buffer(enableTimer=true, waitTime=2)
        annotation (Placement(transformation(extent={{100,-200},{120,-180}})));
      Modelica.StateGraph.StepWithSignal CHA_on(nOut=1)
        annotation (Placement(transformation(extent={{140,-200},{160,-180}})));
      Modelica.Blocks.Math.Add add2(k1=-1, k2=+1)
        annotation (Placement(transformation(extent={{-220,150},{-200,170}})));
      Modelica.Blocks.Logical.GreaterEqual greaterEqualThreshold1
        annotation (Placement(transformation(extent={{-180,150},{-160,170}})));
      Modelica.StateGraph.TransitionWithSignal CHA_turnoff
        annotation (Placement(transformation(extent={{180,-200},{200,-180}})));
      Modelica.StateGraph.Step CHA_off(nIn=1, nOut=1)
        annotation (Placement(transformation(extent={{220,-200},{240,-180}})));
      Modelica.StateGraph.Transition CHA_off_buffer(enableTimer=true, waitTime=2)
        annotation (Placement(transformation(extent={{300,-220},{320,-200}})));

      Modelica.StateGraph.Parallel parallel
        annotation (Placement(transformation(extent={{14,-240},{288,-180}})));
      Modelica.StateGraph.StepWithSignal HPSHC1_on1(nIn=1, nOut=1)
        annotation (Placement(transformation(extent={{140,-240},{160,-220}})));
      Modelica.Blocks.MathBoolean.Or HPSC_boo(nu=3)
        annotation (Placement(transformation(extent={{-138,-142},{-118,-122}})));
      Modelica.Blocks.Logical.Or HPSC_solo_boo
        annotation (Placement(transformation(extent={{40,-40},{60,-20}})));
      Modelica.Blocks.MathInteger.MultiSwitch HPSHC_exit(
        expr={1,2,3},
        use_pre_as_default=false,
        nu=3) annotation (Placement(transformation(extent={{280,180},{320,200}})));
      Modelica.Blocks.Interfaces.IntegerOutput HPSHC annotation (Placement(
            transformation(extent={{320,220},{360,260}}), iconTransformation(
              extent={{320,220},{360,260}})));
      Modelica.Blocks.MathBoolean.Or CHA_boo(nu=2)
        annotation (Placement(transformation(extent={{160,-322},{180,-302}})));
      Modelica.Blocks.Interfaces.BooleanOutput CHA annotation (Placement(
            transformation(extent={{320,-300},{360,-260}}), iconTransformation(
              extent={{320,-300},{360,-260}})));
    equation
      connect(transitionWithSignal.outPort, HPSHC1_start.inPort[1]) annotation (
          Line(points={{-168.5,-50},{-154,-50},{-154,-49.3333},{-141,-49.3333}},
            color={0,0,0}));
      connect(HPSHC1_start.outPort[1], HPSHC_start_buffer.inPort)
        annotation (Line(points={{-119.5,-50},{-94,-50}}, color={0,0,0}));
      connect(HPSHC_start_buffer.outPort, HPSHC1_on.inPort[1]) annotation (Line(
            points={{-88.5,-50},{-74,-50},{-74,-49.5},{-61,-49.5}}, color={0,0,0}));
      connect(HPSHC1_on.outPort[1], Temp_solo.inPort) annotation (Line(points={{-39.5,
              -49.6667},{-30,-49.6667},{-30,10},{-14,10}},   color={0,0,0}));
      connect(HPSHC1_on.outPort[2], HPSHC_turnoff.inPort)
        annotation (Line(points={{-39.5,-50},{-14,-50}}, color={0,0,0}));
      connect(HPSHC1_on.outPort[3], CHA_need.inPort) annotation (Line(points={{-39.5,
              -50.3333},{-30,-50.3333},{-30,-210},{-14,-210}}, color={0,0,0}));
      connect(dp_DEC, waitBefore.u)
        annotation (Line(points={{-340,300},{-240,300}}, color={0,0,127}));
      connect(waitBefore.y, transitionWithSignal.condition) annotation (Line(points={{-217,
              300},{-180,300},{-180,240},{-280,240},{-280,-80},{-170,-80},{-170,-62}},
                      color={255,0,255}));
      connect(TT_DEC, waitBefore1.u) annotation (Line(points={{-340,260},{-140,260},
              {-140,-10},{-122,-10}},color={0,0,127}));
      connect(waitBefore1.y, Temp_solo.condition) annotation (Line(points={{-99,-10},
              {-10,-10},{-10,-2}},  color={255,0,255}));
      connect(Temp_solo.outPort, HPSHC_solo_switch.inPort[1])
        annotation (Line(points={{-8.5,10},{19,10}},   color={0,0,0}));
      connect(HPSHC_solo_switch.outPort[1], HPSHC_solo_buffer.inPort)
        annotation (Line(points={{40.5,10},{66,10}},   color={0,0,0}));
      connect(HPSHC_solo_buffer.outPort, HPSHC_solo.inPort[1])
        annotation (Line(points={{71.5,10},{99,10}},   color={0,0,0}));
      connect(HPSHC_solo.outPort[1], temp_duo.inPort) annotation (Line(points={{120.5,
              10.25},{132,10.25},{132,50},{146,50}}, color={0,0,0}));
      connect(HPSHC_solo.outPort[2], HPSHC_solo_off.inPort) annotation (Line(points={{120.5,
              9.75},{132,9.75},{132,-10},{146,-10}},            color={0,0,0}));
      connect(TT_DEC, waitBefore2.u) annotation (Line(points={{-340,260},{-102,260},
              {-102,50},{38,50}}, color={0,0,127}));
      connect(waitBefore2.y, temp_duo.condition) annotation (Line(points={{61,50},{120,
              50},{120,30},{150,30},{150,38}}, color={255,0,255}));
      connect(temp_duo.outPort, HPSHC1_start.inPort[2]) annotation (Line(points={{151.5,
              50},{180,50},{180,80},{-152,80},{-152,-50},{-141,-50}}, color={0,0,0}));
      connect(FT_DEC, add.u1) annotation (Line(points={{-340,220},{-290,220},{-290,216},
              {-262,216}}, color={0,0,127}));
      connect(FT_TFP, add.u2) annotation (Line(points={{-340,180},{-290,180},{-290,204},
              {-262,204}}, color={0,0,127}));
      connect(add.y, greaterEqualThreshold.u1)
        annotation (Line(points={{-239,210},{-202,210}}, color={0,0,127}));
      connect(greaterEqualThreshold.y, HPSHC_solo_off.condition) annotation (Line(
            points={{-179,210},{128,210},{128,-40},{150,-40},{150,-22}}, color={255,
              0,255}));
      connect(greaterEqualThreshold.y, HPSHC_turnoff.condition) annotation (Line(
            points={{-179,210},{-20,210},{-20,-80},{-10,-80},{-10,-62}},   color={255,
              0,255}));
      connect(initialStepWithSignal.outPort[1], transitionWithSignal.inPort)
        annotation (Line(points={{-199.5,-50},{-174,-50}}, color={0,0,0}));
      connect(HPSHC_solo_off.outPort, HPSHC_off.inPort[2]) annotation (Line(points={{151.5,
              -10},{166,-10},{166,-50.5},{179,-50.5}},        color={0,0,0}));
      connect(HPSHC_off.outPort[1], HPSHC_off_buffer.inPort)
        annotation (Line(points={{200.5,-50},{226,-50}}, color={0,0,0}));
      connect(HPSHC_off_buffer.outPort, initialStepWithSignal.inPort[1])
        annotation (Line(points={{231.5,-50},{260,-50},{260,100},{-240,100},{-240,-50},
              {-221,-50}}, color={0,0,0}));
      connect(waitBefore.y, CHA_need.condition) annotation (Line(points={{-217,
              300},{-180,300},{-180,240},{-280,240},{-280,-260},{-10,-260},{-10,
              -222}},
            color={255,0,255}));
      connect(HPSHC_turnoff.outPort, HPSHC_cooling.inPort[1]) annotation (Line(
            points={{-8.5,-50},{4,-50},{4,-70},{19,-70}}, color={0,0,0}));
      connect(HPSHC_cooling.outPort[1], HPSC_turnoff_buffer.inPort) annotation (
          Line(points={{40.5,-69.75},{94,-69.75},{94,-70},{146,-70}}, color={0,0,0}));
      connect(HPSC_turnoff_buffer.outPort, HPSHC_off.inPort[1]) annotation (Line(
            points={{151.5,-70},{166,-70},{166,-49.5},{179,-49.5}}, color={0,0,0}));
      connect(waitBefore.y, transitionWithSignal7.condition) annotation (Line(
            points={{-217,300},{-180,300},{-180,240},{-280,240},{-280,-160},{150,-160},
              {150,-142}}, color={255,0,255}));
      connect(HPSHC_cooling.outPort[2], transitionWithSignal7.inPort) annotation (
          Line(points={{40.5,-70.25},{94,-70.25},{94,-130},{146,-130}},   color={0,0,
              0}));
      connect(transitionWithSignal7.outPort, HPSHC1_start.inPort[3]) annotation (
          Line(points={{151.5,-130},{300,-130},{300,94},{-148,94},{-148,-50},{
              -146,-50},{-146,-50.6667},{-141,-50.6667}},
                                color={0,0,0}));
      connect(add2.y, greaterEqualThreshold1.u1) annotation (Line(points={{-199,160},
              {-191.5,160},{-191.5,160},{-182,160}}, color={0,0,127}));
      connect(CHA_off_buffer.outPort, HPSHC1_on.inPort[2]) annotation (Line(points={{311.5,
              -210},{348,-210},{348,90},{-70,90},{-70,-50.5},{-61,-50.5}},
            color={0,0,0}));
      connect(greaterEqualThreshold1.y, CHA_turnoff.condition) annotation (Line(
            points={{-159,160},{-150,160},{-150,120},{-300,120},{-300,-280},{
              190,-280},{190,-202}},
                           color={255,0,255}));
      connect(CHA_start.inPort[1], parallel.split[1]) annotation (Line(points={{59,-190},
              {48,-190},{48,-210},{44.825,-210}}, color={0,0,0}));
      connect(HPSHC1_on1.inPort[1], parallel.split[2]) annotation (Line(points={{139,
              -230},{44,-230},{44,-210},{44.825,-210}}, color={0,0,0}));
      connect(CHA_off.outPort[1], parallel.join[1]) annotation (Line(points={{240.5,
              -190},{256,-190},{256,-210},{257.175,-210}}, color={0,0,0}));
      connect(HPSHC1_on1.outPort[1], parallel.join[2]) annotation (Line(points={{160.5,
              -230},{256,-230},{256,-210},{257.175,-210}}, color={0,0,0}));
      connect(CHA_need.outPort, parallel.inPort)
        annotation (Line(points={{-8.5,-210},{9.89,-210}}, color={0,0,0}));
      connect(parallel.outPort, CHA_off_buffer.inPort)
        annotation (Line(points={{290.74,-210},{306,-210}}, color={0,0,0}));
      connect(CHA_start.outPort[1], CHA_start_buffer.inPort)
        annotation (Line(points={{80.5,-190},{106,-190}}, color={0,0,0}));
      connect(CHA_start_buffer.outPort, CHA_on.inPort[1]) annotation (Line(points={{
              111.5,-190},{126,-190},{126,-190},{139,-190}}, color={0,0,0}));
      connect(CHA_on.outPort[1], CHA_turnoff.inPort) annotation (Line(points={{160.5,
              -190},{174,-190},{174,-190},{186,-190}}, color={0,0,0}));
      connect(CHA_turnoff.outPort, CHA_off.inPort[1]) annotation (Line(points={{191.5,
              -190},{206,-190},{206,-190},{219,-190}}, color={0,0,0}));
      connect(HPSHC1_start.active, HPSC_boo.u[1]) annotation (Line(points={{-130,
              -61},{-130,-90},{-152,-90},{-152,-127.333},{-138,-127.333}},
                                                                      color={255,0,255}));
      connect(HPSHC1_on.active, HPSC_boo.u[2]) annotation (Line(points={{-50,-61},{-50,
              -90},{-152,-90},{-152,-132},{-138,-132}}, color={255,0,255}));
      connect(HPSHC1_on1.active, HPSC_boo.u[3]) annotation (Line(points={{150,
              -241},{150,-250},{-152,-250},{-152,-134},{-138,-134},{-138,
              -136.667}},
            color={255,0,255}));
      connect(HPSHC_solo_switch.active, HPSC_solo_boo.u1)
        annotation (Line(points={{30,-1},{30,-30},{38,-30}}, color={255,0,255}));
      connect(HPSHC_solo.active, HPSC_solo_boo.u2) annotation (Line(points={{110,-1},
              {110,-12},{30,-12},{30,-38},{38,-38}}, color={255,0,255}));
      connect(HPSC_solo_boo.y, HPSHC_exit.u[3]) annotation (Line(points={{61,-30},
              {240,-30},{240,188},{280,188}},
                                         color={255,0,255}));
      connect(HPSC_boo.y, HPSHC_exit.u[2]) annotation (Line(points={{-116.5,-132},{60,
              -132},{60,-100},{270,-100},{270,190},{280,190}}, color={255,0,255}));
      connect(HPSHC_cooling.active, HPSHC_exit.u[1]) annotation (Line(points={{30,-81},
              {30,-100},{270,-100},{270,188.5},{280,188.5},{280,192}}, color={255,0,
              255}));
      connect(CHA_on.active, CHA_boo.u[1]) annotation (Line(points={{150,-201},
              {150,-210},{120,-210},{120,-308.5},{160,-308.5}}, color={255,0,
              255}));
      connect(CHA_start.active, CHA_boo.u[2]) annotation (Line(points={{70,-201},
              {70,-315.5},{160,-315.5}}, color={255,0,255}));
      connect(HPSHC_exit.y, HPSHC) annotation (Line(points={{321,190},{340,190},
              {340,212},{308,212},{308,240},{340,240}}, color={255,127,0}));
      connect(CHA_boo.y, CHA) annotation (Line(points={{181.5,-312},{252,-312},
              {252,-280},{340,-280}}, color={255,0,255}));
      connect(add.y, add2.u1) annotation (Line(points={{-239,210},{-230,210},{-230,166},
              {-222,166}}, color={0,0,127}));
      connect(FT_CHA, add2.u2) annotation (Line(points={{-340,140},{-260,140},{-260,
              154},{-222,154}}, color={0,0,127}));
      connect(FT_TFP, greaterEqualThreshold.u2) annotation (Line(points={{-340,180},
              {-219,180},{-219,202},{-202,202}}, color={0,0,127}));
      connect(FT_CHA, greaterEqualThreshold1.u2) annotation (Line(points={{-340,140},
              {-192,140},{-192,152},{-182,152}}, color={0,0,127}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-320,-320},
                {320,320}})),            Diagram(coordinateSystem(
              preserveAspectRatio=false, extent={{-320,-320},{320,320}})));
    end DEC_controls_parallel;

    model DEG_controls_parallel
      Modelica.Blocks.Interfaces.RealInput dp_DEG
        annotation (Placement(transformation(extent={{-360,280},{-320,320}})));
      Modelica.Blocks.Interfaces.RealInput FT_DEG
        annotation (Placement(transformation(extent={{-360,240},{-320,280}})));
      Modelica.Blocks.Interfaces.RealInput FT_GF1
        annotation (Placement(transformation(extent={{-360,200},{-320,240}})));
      Modelica.Blocks.Interfaces.RealInput FT_GF2
        annotation (Placement(transformation(extent={{-360,160},{-320,200}})));

      Modelica.Blocks.Interfaces.RealInput FT_TFP
        annotation (Placement(transformation(extent={{-360,120},{-320,160}})));
      inner Modelica.StateGraph.StateGraphRoot stateGraphRoot
        annotation (Placement(transformation(extent={{300,300},{320,320}})));
      Modelica.StateGraph.TransitionWithSignal transitionWithSignal
        annotation (Placement(transformation(extent={{-220,-20},{-200,0}})));
      Modelica.StateGraph.StepWithSignal GF1_start(nIn=1, nOut=1)
        annotation (Placement(transformation(extent={{-180,-20},{-160,0}})));
      Modelica.StateGraph.Transition GF1_start_buffer(enableTimer=true, waitTime=2)
        annotation (Placement(transformation(extent={{-140,-20},{-120,0}})));
      Modelica.StateGraph.StepWithSignal GF1_on(nIn=2, nOut=2)
        annotation (Placement(transformation(extent={{-100,-20},{-80,0}})));
      Modelica.StateGraph.TransitionWithSignal GF1_stop
        annotation (Placement(transformation(extent={{-60,20},{-40,40}})));
      WaitBefore waitBefore(
        threshold=0,
        t_threshold=2,
        superior=false)
        annotation (Placement(transformation(extent={{-238,290},{-218,310}})));
      Modelica.Blocks.Math.Add add(k1=-1, k2=+1)
        annotation (Placement(transformation(extent={{-280,240},{-260,260}})));
      Modelica.StateGraph.InitialStep initialStep
        annotation (Placement(transformation(extent={{-260,-20},{-240,0}})));
      Modelica.Blocks.Math.Add add1(k1=+1, k2=+1)
        annotation (Placement(transformation(extent={{-220,200},{-200,220}})));

      Modelica.Blocks.Logical.Or GF1_active
        annotation (Placement(transformation(extent={{-60,-220},{-40,-200}})));
      Modelica.Blocks.MathInteger.MultiSwitch HPSHC_exit(
        expr={1},
        use_pre_as_default=false,
        nu=1) annotation (Placement(transformation(extent={{220,230},{260,250}})));
      Modelica.Blocks.Interfaces.IntegerOutput HPSHC annotation (Placement(
            transformation(extent={{320,220},{360,260}}), iconTransformation(
              extent={{320,220},{360,260}})));
      Modelica.Blocks.Interfaces.BooleanOutput GF2 annotation (Placement(
            transformation(extent={{320,-300},{360,-260}}), iconTransformation(
              extent={{320,-300},{360,-260}})));

      Modelica.Blocks.Logical.GreaterEqual greaterEqual
        annotation (Placement(transformation(extent={{-160,240},{-140,260}})));
      Modelica.Blocks.Logical.GreaterEqual greaterEqual1
        annotation (Placement(transformation(extent={{-160,200},{-140,220}})));
      Modelica.Blocks.Math.Add add2(k1=+1, k2=+1)
        annotation (Placement(transformation(extent={{-160,160},{-140,180}})));
      Modelica.Blocks.Logical.GreaterEqual greaterEqual2
        annotation (Placement(transformation(extent={{-100,160},{-80,180}})));
      Modelica.StateGraph.Step GF1_stopping
        annotation (Placement(transformation(extent={{-20,20},{0,40}})));
      Modelica.StateGraph.Transition GF1_stop_buffer(enableTimer=true, waitTime=2)
        annotation (Placement(transformation(extent={{20,20},{40,40}})));
      Modelica.StateGraph.TransitionWithSignal GF2_need
        annotation (Placement(transformation(extent={{-60,-60},{-40,-40}})));
      Modelica.StateGraph.StepWithSignal GF2_start(nIn=1, nOut=1)
        annotation (Placement(transformation(extent={{-20,-60},{0,-40}})));
      Modelica.StateGraph.Transition GF1_start_buffer1(enableTimer=true, waitTime=2)
        annotation (Placement(transformation(extent={{20,-60},{40,-40}})));
      Modelica.StateGraph.StepWithSignal GF2_on(nIn=2, nOut=2)
        annotation (Placement(transformation(extent={{60,-60},{80,-40}})));
      Modelica.StateGraph.TransitionWithSignal GF2_stop
        annotation (Placement(transformation(extent={{100,-20},{120,0}})));
      Modelica.StateGraph.TransitionWithSignal TFP_need
        annotation (Placement(transformation(extent={{100,-100},{120,-80}})));
      Modelica.StateGraph.StepWithSignal TFP_start(nIn=1, nOut=1)
        annotation (Placement(transformation(extent={{140,-100},{160,-80}})));
      Modelica.StateGraph.Transition TFP_start_buffer(enableTimer=true, waitTime=2)
        annotation (Placement(transformation(extent={{180,-100},{200,-80}})));
      Modelica.StateGraph.StepWithSignal TFP_on(nIn=1, nOut=1)
        annotation (Placement(transformation(extent={{220,-100},{240,-80}})));
      Modelica.Blocks.Interfaces.BooleanOutput GF1 annotation (Placement(
            transformation(extent={{320,-230},{360,-190}}), iconTransformation(
              extent={{320,-300},{360,-260}})));
      Modelica.StateGraph.Transition GF2_stop_buffer(enableTimer=true, waitTime=2)
        annotation (Placement(transformation(extent={{180,-20},{200,0}})));
      Modelica.StateGraph.Step GF2_stopping
        annotation (Placement(transformation(extent={{140,-20},{160,0}})));
      Modelica.Blocks.Logical.Or GF2_active
        annotation (Placement(transformation(extent={{100,-290},{120,-270}})));
      Modelica.StateGraph.TransitionWithSignal TFP_stop
        annotation (Placement(transformation(extent={{260,-100},{280,-80}})));
      Modelica.StateGraph.Step TFP_stopping
        annotation (Placement(transformation(extent={{300,-100},{320,-80}})));
      Modelica.StateGraph.Transition TFP_stop_buffer(enableTimer=true, waitTime=2)
        annotation (Placement(transformation(extent={{340,-100},{360,-80}})));
      Modelica.Blocks.Interfaces.IntegerInput TFP_DEC
        annotation (Placement(transformation(extent={{-360,-180},{-320,-140}})));
      Controls.OBC.CDL.Integers.LessThreshold intLesThr(threshold=1)
        annotation (Placement(transformation(extent={{-280,-170},{-260,-150}})));
      Controls.OBC.CDL.Logical.And and2
        annotation (Placement(transformation(extent={{-220,-140},{-200,-120}})));
      Controls.OBC.CDL.Logical.Or or2
        annotation (Placement(transformation(extent={{240,-160},{260,-140}})));
      Controls.OBC.CDL.Integers.GreaterEqualThreshold intGreEquThr(threshold=1)
        annotation (Placement(transformation(extent={{-280,-240},{-260,-220}})));
      Modelica.Blocks.Logical.Or TFP_active
        annotation (Placement(transformation(extent={{200,-190},{220,-170}})));
    equation
      connect(dp_DEG, waitBefore.u)
        annotation (Line(points={{-340,300},{-240,300}}, color={0,0,127}));
      connect(FT_DEG, add.u1) annotation (Line(points={{-340,260},{-300,260},{-300,256},
              {-282,256}}, color={0,0,127}));
      connect(HPSHC_exit.y, HPSHC) annotation (Line(points={{261,240},{340,240}},
                                                        color={255,127,0}));
      connect(FT_GF1, add.u2) annotation (Line(points={{-340,220},{-300,220},{-300,244},
              {-282,244}}, color={0,0,127}));
      connect(FT_GF2, add1.u2) annotation (Line(points={{-340,180},{-300,180},{-300,
              204},{-222,204}}, color={0,0,127}));
      connect(add.y, add1.u1) annotation (Line(points={{-259,250},{-240,250},{-240,216},
              {-222,216}}, color={0,0,127}));
      connect(add.y, greaterEqual.u1)
        annotation (Line(points={{-259,250},{-162,250}}, color={0,0,127}));
      connect(FT_GF1, greaterEqual.u2) annotation (Line(points={{-340,220},{-254,220},
              {-254,242},{-162,242}}, color={0,0,127}));
      connect(add1.y, greaterEqual1.u1) annotation (Line(points={{-199,210},{-180.5,
              210},{-180.5,210},{-162,210}}, color={0,0,127}));
      connect(FT_GF2, greaterEqual1.u2) annotation (Line(points={{-340,180},{-190,180},
              {-190,202},{-162,202}}, color={0,0,127}));
      connect(FT_TFP, add2.u2) annotation (Line(points={{-340,140},{-252,140},{-252,
              164},{-162,164}}, color={0,0,127}));
      connect(add1.y, add2.u1) annotation (Line(points={{-199,210},{-180,210},{-180,
              176},{-162,176}}, color={0,0,127}));
      connect(add2.y, greaterEqual2.u1)
        annotation (Line(points={{-139,170},{-102,170}}, color={0,0,127}));
      connect(FT_TFP, greaterEqual2.u2) annotation (Line(points={{-340,140},{-128,140},
              {-128,162},{-102,162}}, color={0,0,127}));
      connect(initialStep.outPort[1], transitionWithSignal.inPort)
        annotation (Line(points={{-239.5,-10},{-214,-10}}, color={0,0,0}));
      connect(GF1_start.outPort[1], GF1_start_buffer.inPort)
        annotation (Line(points={{-159.5,-10},{-134,-10}}, color={0,0,0}));
      connect(GF1_start_buffer.outPort, GF1_on.inPort[1]) annotation (Line(points={{
              -128.5,-10},{-114,-10},{-114,-9.5},{-101,-9.5}}, color={0,0,0}));
      connect(waitBefore.y, transitionWithSignal.condition) annotation (Line(points=
             {{-217,300},{0,300},{0,100},{-300,100},{-300,-40},{-210,-40},{-210,-22}},
            color={255,0,255}));
      connect(GF1_on.outPort[1], GF1_stop.inPort) annotation (Line(points={{-79.5,-9.75},
              {-66,-9.75},{-66,30},{-54,30}}, color={0,0,0}));
      connect(greaterEqual.y, GF1_stop.condition) annotation (Line(points={{-139,250},
              {-20,250},{-20,80},{-100,80},{-100,8},{-50,8},{-50,18}}, color={255,0,
              255}));
      connect(GF1_stop.outPort, GF1_stopping.inPort[1])
        annotation (Line(points={{-48.5,30},{-21,30}}, color={0,0,0}));
      connect(GF1_stopping.outPort[1], GF1_stop_buffer.inPort)
        annotation (Line(points={{0.5,30},{26,30}}, color={0,0,0}));
      connect(GF1_stop_buffer.outPort, initialStep.inPort[1]) annotation (Line(
            points={{31.5,30},{80,30},{80,72},{-280,72},{-280,-10},{-261,-10}},
            color={0,0,0}));
      connect(waitBefore.y, GF2_need.condition) annotation (Line(points={{-217,300},
              {0,300},{0,100},{-300,100},{-300,-80},{-50,-80},{-50,-62}}, color={255,
              0,255}));
      connect(GF1_on.outPort[2], GF2_need.inPort) annotation (Line(points={{-79.5,-10.25},
              {-66,-10.25},{-66,-50},{-54,-50}}, color={0,0,0}));
      connect(GF2_start.outPort[1], GF1_start_buffer1.inPort)
        annotation (Line(points={{0.5,-50},{26,-50}}, color={0,0,0}));
      connect(GF1_start_buffer1.outPort, GF2_on.inPort[1]) annotation (Line(points={
              {31.5,-50},{46,-50},{46,-49.5},{59,-49.5}}, color={0,0,0}));
      connect(GF2_need.outPort, GF2_start.inPort[1])
        annotation (Line(points={{-48.5,-50},{-21,-50}}, color={0,0,0}));
      connect(GF2_on.outPort[1], GF2_stop.inPort) annotation (Line(points={{80.5,-49.75},
              {80.5,-50},{94,-50},{94,-10},{106,-10}}, color={0,0,0}));
      connect(GF2_on.outPort[2], TFP_need.inPort) annotation (Line(points={{80.5,-50.25},
              {94,-50.25},{94,-90},{106,-90}}, color={0,0,0}));
      connect(TFP_start.outPort[1], TFP_start_buffer.inPort)
        annotation (Line(points={{160.5,-90},{186,-90}}, color={0,0,0}));
      connect(TFP_start_buffer.outPort, TFP_on.inPort[1])
        annotation (Line(points={{191.5,-90},{219,-90}}, color={0,0,0}));
      connect(TFP_start.inPort[1], TFP_need.outPort)
        annotation (Line(points={{139,-90},{111.5,-90}}, color={0,0,0}));
      connect(GF2_stop.outPort, GF2_stopping.inPort[1]) annotation (Line(points={{111.5,
              -10},{124,-10},{124,-10},{139,-10}}, color={0,0,0}));
      connect(GF2_stopping.outPort[1], GF2_stop_buffer.inPort)
        annotation (Line(points={{160.5,-10},{186,-10}}, color={0,0,0}));
      connect(transitionWithSignal.outPort, GF1_start.inPort[1]) annotation (Line(
            points={{-208.5,-10},{-194,-10},{-194,-10},{-181,-10}}, color={0,0,0}));
      connect(GF1_start.active, GF1_active.u1) annotation (Line(points={{-170,-21},{
              -170,-210},{-62,-210}}, color={255,0,255}));
      connect(GF1_on.active, GF1_active.u2) annotation (Line(points={{-90,-21},{-90,
              -218},{-62,-218}}, color={255,0,255}));
      connect(GF1_active.y, GF1)
        annotation (Line(points={{-39,-210},{340,-210}}, color={255,0,255}));
      connect(GF2_active.y, GF2) annotation (Line(points={{121,-280},{222,-280},{222,
              -280},{340,-280}}, color={255,0,255}));
      connect(GF2_stop_buffer.outPort, GF1_on.inPort[2]) annotation (Line(points={{191.5,
              -10},{220,-10},{220,60},{-108,60},{-108,-10.5},{-101,-10.5}}, color={0,
              0,0}));
      connect(TFP_on.outPort[1], TFP_stop.inPort) annotation (Line(points={{240.5,-90},
              {254,-90},{254,-90},{266,-90}}, color={0,0,0}));
      connect(greaterEqual1.y, GF2_stop.condition) annotation (Line(points={{-139,210},
              {88,210},{88,-40},{110,-40},{110,-22}}, color={255,0,255}));
      connect(TFP_stop.outPort, TFP_stopping.inPort[1])
        annotation (Line(points={{271.5,-90},{299,-90}}, color={0,0,0}));
      connect(TFP_stopping.outPort[1], TFP_stop_buffer.inPort)
        annotation (Line(points={{320.5,-90},{346,-90}}, color={0,0,0}));
      connect(TFP_stop_buffer.outPort, GF2_on.inPort[2]) annotation (Line(points={{351.5,
              -90},{380,-90},{380,20},{50,20},{50,-50.5},{59,-50.5}}, color={0,0,0}));
      connect(GF2_start.active, GF2_active.u1) annotation (Line(points={{-10,-61},{-10,
              -280},{98,-280}}, color={255,0,255}));
      connect(GF2_on.active, GF2_active.u2) annotation (Line(points={{70,-61},{70,-288},
              {98,-288}}, color={255,0,255}));
      connect(TFP_DEC, intLesThr.u)
        annotation (Line(points={{-340,-160},{-282,-160}}, color={255,127,0}));
      connect(intLesThr.y, and2.u2) annotation (Line(points={{-258,-160},{-240,-160},
              {-240,-138},{-222,-138}}, color={255,0,255}));
      connect(waitBefore.y, and2.u1) annotation (Line(points={{-217,300},{0,300},{0,
              100},{-300,100},{-300,-130},{-222,-130}}, color={255,0,255}));
      connect(and2.y, TFP_need.condition) annotation (Line(points={{-198,-130},{110,
              -130},{110,-102}}, color={255,0,255}));
      connect(greaterEqual2.y, or2.u1) annotation (Line(points={{-79,170},{250,170},
              {250,-128},{228,-128},{228,-150},{238,-150}}, color={255,0,255}));
      connect(TFP_DEC, intGreEquThr.u) annotation (Line(points={{-340,-160},{-300,-160},
              {-300,-230},{-282,-230}}, color={255,127,0}));
      connect(intGreEquThr.y, or2.u2) annotation (Line(points={{-258,-230},{-140,-230},
              {-140,-158},{238,-158}}, color={255,0,255}));
      connect(or2.y, TFP_stop.condition) annotation (Line(points={{262,-150},{270,-150},
              {270,-102}}, color={255,0,255}));
      connect(TFP_start.active, TFP_active.u2) annotation (Line(points={{150,-101},{
              150,-188},{198,-188}}, color={255,0,255}));
      connect(TFP_on.active, TFP_active.u1) annotation (Line(points={{230,-101},{230,
              -120},{180,-120},{180,-180},{198,-180}}, color={255,0,255}));
      connect(TFP_active.y, HPSHC_exit.u[1]) annotation (Line(points={{221,-180},{400,
              -180},{400,210},{200,210},{200,240},{220,240}}, color={255,0,255}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-320,-320},
                {320,320}})),            Diagram(coordinateSystem(
              preserveAspectRatio=false, extent={{-320,-320},{320,320}})));
    end DEG_controls_parallel;
  end Controls_a;
  extends Modelica.Icons.VariantsPackage;

  package Plant
    extends Modelica.Icons.VariantsPackage;
    model GF_solo
      annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end GF_solo;

    package Tests
      extends Modelica.Icons.ExamplesPackage;
      model test0
        TFP.TFP_duo tFP_duo
          annotation (Placement(transformation(extent={{-40,60},{-20,80}})));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
              coordinateSystem(preserveAspectRatio=false)));
      end test0;
    end Tests;
  end Plant;

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


              // Chiller parameters
      parameter Modelica.SIunits.MassFlowRate m_flow_chi_evap_nominal= 800 * 1027 / 3600
        "Nominal mass flow rate at condenser water in the chillers";
      parameter Modelica.SIunits.MassFlowRate m_flow_chi_cond_nominal= 500 * 1000 / 3600
        "Nominal mass flow rate at evaporator water in the chillers";
      parameter Modelica.SIunits.PressureDifference dp1_chi_nominal = 0.38*1000
        "Nominal pressure";
      parameter Modelica.SIunits.PressureDifference dp2_chi_nominal = 0.31*1000
        "Nominal pressure";


      Fluid.Chillers.ElectricReformulatedEIR electricReformulatedEIR(
        redeclare package Medium1 =
            Buildings.Applications.DHC_Marseille.Media.Sea_Water,
        redeclare package Medium2 = Buildings.Media.Water,
        m1_flow_nominal=m_flow_chi_cond_nominal,
        m2_flow_nominal=m_flow_chi_evap_nominal,
        dp1_nominal=dp1_chi_nominal,
        dp2_nominal=dp2_chi_nominal,
        per=Fluid.Chillers.Data.ElectricReformulatedEIR.ReformEIRChiller_Carrier_19EX_5148kW_6_34COP_Vanes())
        annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
      Modelica.Blocks.Interfaces.BooleanInput u
        annotation (Placement(transformation(extent={{-140,10},{-100,50}})));
      Modelica.Blocks.Interfaces.RealInput T_cons
        annotation (Placement(transformation(extent={{-140,-50},{-100,-10}})));
      Fluid.Sensors.TemperatureTwoPort TCin(redeclare package Medium =
            Buildings.Applications.DHC_Marseille.Media.Sea_Water, m_flow_nominal=m_flow_chi_cond_nominal)
        annotation (Placement(transformation(extent={{-50,50},{-30,70}})));
      Fluid.Sensors.TemperatureTwoPort TT211(redeclare package Medium =
            Buildings.Applications.DHC_Marseille.Media.Sea_Water, m_flow_nominal=m_flow_chi_cond_nominal)
        annotation (Placement(transformation(extent={{30,50},{50,70}})));
      Fluid.Sensors.TemperatureTwoPort TEin(redeclare package Medium =
            Buildings.Media.Water,          m_flow_nominal=m_flow_chi_evap_nominal)
        annotation (Placement(transformation(extent={{50,-70},{30,-50}})));
      Fluid.Sensors.TemperatureTwoPort TEout(redeclare package Medium =
            Buildings.Media.Water,           m_flow_nominal=m_flow_chi_evap_nominal)
        annotation (Placement(transformation(extent={{-40,-70},{-60,-50}})));
      Modelica.Blocks.Interfaces.RealOutput y annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=-90,
            origin={-30,-110})));
      Modelica.Blocks.Interfaces.RealInput PEM_TT200 annotation (Placement(
            transformation(
            extent={{-20,-20},{20,20}},
            rotation=0,
            origin={-120,110})));
      Fluid.Sensors.Pressure PT211(redeclare package Medium =
            Buildings.Applications.DHC_Marseille.Media.Sea_Water)
        annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={10,40})));
      Fluid.Sensors.Pressure PT221(redeclare package Medium =
            Buildings.Applications.DHC_Marseille.Media.Sea_Water)
        annotation (Placement(transformation(extent={{-80,60},{-60,80}})));
      Fluid.Sensors.MassFlowRate senMasFlo annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=270,
            origin={20,-30})));
      Controls.Continuous.LimPID FT_PID(k=4, Ti=10)
        annotation (Placement(transformation(extent={{100,0},{120,20}})));
      Fluid.Actuators.Valves.TwoWayLinear CV121(
        redeclare package Medium = Buildings.Media.Water,
        m_flow_nominal=m_flow_chi_cond_nominal,
        dpValve_nominal=10)
        annotation (Placement(transformation(extent={{80,-70},{60,-50}})));
      Modelica.Blocks.Interfaces.RealInput FT121_cons annotation (Placement(
            transformation(
            extent={{-20,-20},{20,20}},
            rotation=0,
            origin={-120,-110})));
      Modelica.Blocks.Math.Add TDT(k1=1, k2=-1)
        annotation (Placement(transformation(extent={{60,160},{80,180}})));
      Modelica.Blocks.Sources.Constant TDT_Set(k=5)
        "Scaled differential pressure setpoint"
        annotation (Placement(transformation(extent={{60,200},{80,220}})));
      Controls.Continuous.LimPID TDT_PID(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=2.5,
        Ti=1.7)
        annotation (Placement(transformation(extent={{100,200},{120,220}})));
      Fluid.Actuators.Valves.TwoWayLinear CV211(
        redeclare package Medium = Buildings.Media.Water,
        m_flow_nominal=m_flow_chi_cond_nominal,
        CvData=Buildings.Fluid.Types.CvTypes.OpPoint,
        dpValve_nominal=10)
        annotation (Placement(transformation(extent={{60,50},{80,70}})));
      Modelica.Blocks.Sources.Constant TT_Set(k=30)
        "Scaled differential pressure setpoint"
        annotation (Placement(transformation(extent={{60,120},{80,140}})));
      Controls.Continuous.LimPID TT_PID(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=3,
        Ti=1)
        annotation (Placement(transformation(extent={{100,120},{120,140}})));
      Modelica.Blocks.Math.MinMax maxi(nu=3)
        annotation (Placement(transformation(extent={{160,120},{180,140}})));
      Modelica.Blocks.Sources.Constant TDT_Set1(k=0.4)
        "Scaled differential pressure setpoint"
        annotation (Placement(transformation(extent={{60,280},{80,300}})));
      Controls.Continuous.LimPID TDT_PID1(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=3,
        Ti=15)
        annotation (Placement(transformation(extent={{100,280},{120,300}})));
      Modelica.Blocks.Math.Add TDT1(k1=1, k2=-1)
        annotation (Placement(transformation(extent={{60,240},{80,260}})));
    equation
      connect(T_cons, electricReformulatedEIR.TSet) annotation (Line(points={{-120,-30},
              {-66,-30},{-66,-3},{-12,-3}}, color={0,0,127}));
      connect(u, electricReformulatedEIR.on) annotation (Line(points={{-120,30},
              {-66,30},{-66,3},{-12,3}}, color={255,0,255}));
      connect(port_a1, TCin.port_a)
        annotation (Line(points={{-100,60},{-50,60}}, color={0,127,255}));
      connect(TCin.port_b, electricReformulatedEIR.port_a1) annotation (Line(points={{-30,60},
              {-20,60},{-20,6},{-10,6}},         color={0,127,255}));
      connect(electricReformulatedEIR.port_b1,TT211. port_a) annotation (Line(
            points={{10,6},{20,6},{20,60},{30,60}}, color={0,127,255}));
      connect(port_b2,TEout. port_b)
        annotation (Line(points={{-100,-60},{-60,-60}}, color={0,127,255}));
      connect(TEout.port_a, electricReformulatedEIR.port_b2) annotation (Line(
            points={{-40,-60},{-20,-60},{-20,-6},{-10,-6}}, color={0,127,255}));
      connect(TEout.T, y) annotation (Line(points={{-50,-49},{-50,-40},{-30,-40},
              {-30,-110}}, color={0,0,127}));
      connect(senMasFlo.port_a, TEin.port_b)
        annotation (Line(points={{20,-40},{20,-60},{30,-60}}, color={0,127,255}));
      connect(electricReformulatedEIR.port_a2, senMasFlo.port_b)
        annotation (Line(points={{10,-6},{20,-6},{20,-20}}, color={0,127,255}));
      connect(TEin.port_a, CV121.port_b)
        annotation (Line(points={{50,-60},{60,-60}}, color={0,127,255}));
      connect(CV121.port_a, port_a2)
        annotation (Line(points={{80,-60},{100,-60}}, color={0,127,255}));

      connect(senMasFlo.m_flow, FT_PID.u_m) annotation (Line(points={{31,-30},{
              110,-30},{110,-2}}, color={0,0,127}));
      connect(FT_PID.y, CV121.y) annotation (Line(points={{121,10},{140,10},{
              140,-40},{70,-40},{70,-48}}, color={0,0,127}));
      connect(PEM_TT200, TDT.u1) annotation (Line(points={{-120,110},{-60,110},
              {-60,176},{58,176}}, color={0,0,127}));
      connect(TT211.T, TDT.u2)
        annotation (Line(points={{40,71},{40,164},{58,164}}, color={0,0,127}));
      connect(TDT_Set.y, TDT_PID.u_s)
        annotation (Line(points={{81,210},{98,210}}, color={0,0,127}));
      connect(TDT.y, TDT_PID.u_m) annotation (Line(points={{81,170},{110,170},{
              110,198}}, color={0,0,127}));
      connect(TT211.port_b, CV211.port_a)
        annotation (Line(points={{50,60},{60,60}}, color={0,127,255}));
      connect(CV211.port_b, port_b1)
        annotation (Line(points={{80,60},{100,60}}, color={0,127,255}));
      connect(TT_Set.y, TT_PID.u_s)
        annotation (Line(points={{81,130},{98,130}}, color={0,0,127}));
      connect(TT211.T, TT_PID.u_m) annotation (Line(points={{40,71},{40,88},{
              110,88},{110,118}}, color={0,0,127}));
      connect(port_a1, PT221.port)
        annotation (Line(points={{-100,60},{-70,60}}, color={0,127,255}));
      connect(electricReformulatedEIR.port_b1, PT211.port)
        annotation (Line(points={{10,6},{20,6},{20,40}}, color={0,127,255}));
      connect(TDT_PID.y, maxi.u[1]) annotation (Line(points={{121,210},{140,210},
              {140,134.667},{160,134.667}},
                                        color={0,0,127}));
      connect(TT_PID.y, maxi.u[2]) annotation (Line(points={{121,130},{160,130},{160,
              130}},        color={0,0,127}));
      connect(maxi.yMin, CV211.y) annotation (Line(points={{181,124},{200,124},
              {200,80},{70,80},{70,72}}, color={0,0,127}));
      connect(PT221.p, TDT1.u1) annotation (Line(points={{-59,70},{-50,70},{-50,256},
              {58,256}}, color={0,0,127}));
      connect(PT211.p, TDT1.u2)
        annotation (Line(points={{10,51},{10,244},{58,244}}, color={0,0,127}));
      connect(TDT1.y, TDT_PID1.u_m)
        annotation (Line(points={{81,250},{110,250},{110,278}}, color={0,0,127}));
      connect(TDT_Set1.y, TDT_PID1.u_s)
        annotation (Line(points={{81,290},{98,290}}, color={0,0,127}));
      connect(TDT_PID1.y, maxi.u[3]) annotation (Line(points={{121,290},{150,
              290},{150,125.333},{160,125.333}},
                                       color={0,0,127}));
      connect(FT121_cons, FT_PID.u_s) annotation (Line(points={{-120,-110},{-60,
              -110},{-60,-140},{160,-140},{160,40},{80,40},{80,10},{98,10}},
            color={0,0,127}));
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

    model Chiller_carnot_modele

      extends Fluid.Interfaces.PartialFourPort
      annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)));

              // Chiller parameters
      parameter Modelica.SIunits.MassFlowRate m_flow_chi_evap_nominal= 800 * 1027 / 3600
        "Nominal mass flow rate at condenser water in the chillers";
      parameter Modelica.SIunits.MassFlowRate m_flow_chi_cond_nominal= 500 * 1000 / 3600
        "Nominal mass flow rate at evaporator water in the chillers";
      parameter Modelica.SIunits.PressureDifference dp1_chi_nominal = 0.38*1000
        "Nominal pressure";
      parameter Modelica.SIunits.PressureDifference dp2_chi_nominal = 0.31*1000
        "Nominal pressure";

      Modelica.Blocks.Interfaces.RealInput u1
        annotation (Placement(transformation(extent={{-140,-50},{-100,-10}})));
      Fluid.Sensors.TemperatureTwoPort TCin(redeclare package Medium =
            Buildings.Applications.DHC_Marseille.Media.Sea_Water, m_flow_nominal=m_flow_chi_cond_nominal)
        annotation (Placement(transformation(extent={{-60,50},{-40,70}})));
      Fluid.Sensors.TemperatureTwoPort TCout(redeclare package Medium =
            Buildings.Applications.DHC_Marseille.Media.Sea_Water, m_flow_nominal=m_flow_chi_cond_nominal)
        annotation (Placement(transformation(extent={{40,50},{60,70}})));
      Fluid.Sensors.TemperatureTwoPort TEin(redeclare package Medium =
            Buildings.Media.Water,          m_flow_nominal=m_flow_chi_evap_nominal)
        annotation (Placement(transformation(extent={{60,-70},{40,-50}})));
      Fluid.Sensors.TemperatureTwoPort TEout(redeclare package Medium =
            Buildings.Media.Water,           m_flow_nominal=m_flow_chi_evap_nominal)
        annotation (Placement(transformation(extent={{-40,-70},{-60,-50}})));
      Modelica.Blocks.Interfaces.RealOutput y annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=-90,
            origin={-30,-110})));
      Fluid.Chillers.Carnot_TEva chi(
        redeclare package Medium1 =
            Buildings.Applications.DHC_Marseille.Media.Sea_Water,
        redeclare package Medium2 = Buildings.Media.Water,
        m1_flow_nominal=m_flow_chi_cond_nominal,
        m2_flow_nominal=m_flow_chi_evap_nominal,
        QEva_flow_nominal=-10000000,
        dTEva_nominal=-7,
        dTCon_nominal=10,
        use_eta_Carnot_nominal=false,
        COP_nominal=6,
        TCon_nominal=298.15,
        TEva_nominal=277.15,
        dp1_nominal=380,
        dp2_nominal=310,
        QEva_flow_min=-2000000)
        annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
    equation
      connect(port_a1, TCin.port_a)
        annotation (Line(points={{-100,60},{-60,60}}, color={0,127,255}));
      connect(TCout.port_b, port_b1)
        annotation (Line(points={{60,60},{100,60}}, color={0,127,255}));
      connect(port_a2,TEin. port_a)
        annotation (Line(points={{100,-60},{60,-60}}, color={0,127,255}));
      connect(port_b2,TEout. port_b)
        annotation (Line(points={{-100,-60},{-60,-60}}, color={0,127,255}));
      connect(TEout.T, y) annotation (Line(points={{-50,-49},{-50,-40},{-30,-40},
              {-30,-110}}, color={0,0,127}));
      connect(TCin.port_b, chi.port_a1) annotation (Line(points={{-40,60},{-26,60},{
              -26,6},{-10,6}}, color={0,127,255}));
      connect(chi.port_b1, TCout.port_a) annotation (Line(points={{10,6},{26,6},{26,
              60},{40,60}}, color={0,127,255}));
      connect(TEin.port_b, chi.port_a2) annotation (Line(points={{40,-60},{26,-60},{
              26,-6},{10,-6}}, color={0,127,255}));
      connect(chi.port_b2, TEout.port_a) annotation (Line(points={{-10,-6},{-24,-6},
              {-24,-60},{-40,-60}}, color={0,127,255}));
      connect(u1, chi.TSet) annotation (Line(points={{-120,-30},{-68,-30},{-68,9},{-12,
              9}}, color={0,0,127}));
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
    end Chiller_carnot_modele;

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
        Chiller chiller(redeclare package Medium1 =
              Buildings.Applications.DHC_Marseille.Media.Sea_Water,                                       redeclare
            package Medium2 =
                      Buildings.Media.Water,
          dp1_chi_nominal(displayUnit="Pa"),
          dp2_chi_nominal(displayUnit="Pa"))
          annotation (Placement(transformation(extent={{-10,0},{10,20}})));

        Modelica.Blocks.Sources.RealExpression realExpression(y=4 + 273.15)
          annotation (Placement(transformation(extent={{-120,-20},{-100,0}})));
        Fluid.Sources.Boundary_pT sortie_c(redeclare package Medium =
              Buildings.Applications.DHC_Marseille.Media.Sea_Water, nPorts=1)
          annotation (Placement(transformation(extent={{100,60},{80,80}})));
        Fluid.Sources.MassFlowSource_T entree_c(redeclare package Medium =
              Buildings.Applications.DHC_Marseille.Media.Sea_Water,
          m_flow=800/3.6,
          T=298.15,                                                 nPorts=1)
          annotation (Placement(transformation(extent={{-100,60},{-80,80}})));
        Fluid.Sources.Boundary_pT sortie_e(redeclare package Medium =
              Buildings.Media.Water,
          use_T_in=true,             nPorts=1)
          annotation (Placement(transformation(extent={{-100,-60},{-80,-40}})));
        Fluid.Sources.MassFlowSource_T entree_e(redeclare package Medium =
              Buildings.Media.Water,
          m_flow=500/3.6,
          T=280.15,                  nPorts=1)
          annotation (Placement(transformation(extent={{100,-40},{80,-60}})));
        Modelica.Blocks.Sources.BooleanPulse booleanPulse(period=100000)
          annotation (Placement(transformation(extent={{-120,20},{-100,40}})));
      equation
        connect(realExpression.y, chiller.T_cons) annotation (Line(points={{-99,
                -10},{-56.5,-10},{-56.5,7},{-12,7}}, color={0,0,127}));
        connect(sortie_c.ports[1], chiller.port_b1) annotation (Line(points={{80,70},
                {34,70},{34,16},{10,16}},color={0,127,255}));
        connect(sortie_e.ports[1], chiller.port_b2) annotation (Line(points={{-80,-50},
                {-36,-50},{-36,4},{-10,4}}, color={0,127,255}));
        connect(entree_e.ports[1], chiller.port_a2) annotation (Line(points={{80,-50},
                {36,-50},{36,4},{10,4}}, color={0,127,255}));
        connect(entree_c.ports[1], chiller.port_a1) annotation (Line(points={{-80,70},
                {-36,70},{-36,16},{-10,16}}, color={0,127,255}));
        connect(chiller.y, sortie_e.T_in) annotation (Line(points={{-3,-1},{-3,
                -28},{-120,-28},{-120,-46},{-102,-46}}, color={0,0,127}));
        connect(booleanPulse.y, chiller.u) annotation (Line(points={{-99,30},{
                -56,30},{-56,13},{-12,13}}, color={255,0,255}));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
              coordinateSystem(preserveAspectRatio=false)),
          experiment(
            StopTime=100000,
            Interval=200,
            __Dymola_Algorithm="Dassl"));
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
        connect(realExpression.y, chiller.T_cons) annotation (Line(points={{-99,
                0},{-56.5,0},{-56.5,7},{-12,7}}, color={0,0,127}));
        connect(fan.port_a, boundary.ports[1]) annotation (Line(points={{40,-50},
                {52,-50},{52,-50},{60,-50}}, color={0,127,255}));
        connect(fan.port_b, chiller.port_a2) annotation (Line(points={{20,-50},
                {10,-50},{10,4}}, color={0,127,255}));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
              coordinateSystem(preserveAspectRatio=false)));
      end test_1;



      model test_carnot

        Modelica.Blocks.Sources.RealExpression realExpression(y=4 + 273.15)
          annotation (Placement(transformation(extent={{-120,-20},{-100,0}})));
        Fluid.Sources.Boundary_pT sortie_c(redeclare package Medium =
              Buildings.Applications.DHC_Marseille.Media.Sea_Water, nPorts=1)
          annotation (Placement(transformation(extent={{100,60},{80,80}})));
        Fluid.Sources.MassFlowSource_T entree_c(redeclare package Medium =
              Buildings.Applications.DHC_Marseille.Media.Sea_Water,
          m_flow=800/3.6,
          T=298.15,
          nPorts=1)
          annotation (Placement(transformation(extent={{-100,60},{-80,80}})));
        Fluid.Sources.Boundary_pT sortie_e(redeclare package Medium =
              Buildings.Media.Water,
          use_T_in=true,
          nPorts=1)
          annotation (Placement(transformation(extent={{-100,-60},{-80,-40}})));
        Fluid.Sources.MassFlowSource_T entree_e(redeclare package Medium =
              Buildings.Media.Water,
          m_flow=500/3.6,
          T=285.15,
          nPorts=1)
          annotation (Placement(transformation(extent={{100,-40},{80,-60}})));
        Chiller_carnot_modele chiller_carnot_modele(redeclare package Medium1 =
              Buildings.Applications.DHC_Marseille.Media.Sea_Water, redeclare
            package Medium2 =
              Buildings.Media.Water)
          annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
      equation
        connect(chiller_carnot_modele.port_b2, sortie_e.ports[1]) annotation (Line(
              points={{-10,-6},{-50,-6},{-50,-50},{-80,-50}}, color={0,127,255}));
        connect(realExpression.y, chiller_carnot_modele.u1) annotation (Line(points={{
                -99,-10},{-80,-10},{-80,-3},{-12,-3}}, color={0,0,127}));
        connect(entree_c.ports[1], chiller_carnot_modele.port_a1) annotation (Line(
              points={{-80,70},{-44,70},{-44,6},{-10,6}}, color={0,127,255}));
        connect(chiller_carnot_modele.port_b1, sortie_c.ports[1]) annotation (Line(
              points={{10,6},{44,6},{44,70},{80,70}}, color={0,127,255}));
        connect(entree_e.ports[1], chiller_carnot_modele.port_a2) annotation (Line(
              points={{80,-50},{44,-50},{44,-6},{10,-6}}, color={0,127,255}));
        connect(chiller_carnot_modele.y, sortie_e.T_in) annotation (Line(points={{-3,-11},
                {-3,-20},{-120,-20},{-120,-46},{-102,-46}}, color={0,0,127}));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
              coordinateSystem(preserveAspectRatio=false)),
          experiment(
            StopTime=100000,
            Interval=200,
            __Dymola_Algorithm="Dassl"));
      end test_carnot;

      model test_GF
        Chiller chiller(redeclare package Medium1 =
              Buildings.Applications.DHC_Marseille.Media.Sea_Water,                                       redeclare
            package Medium2 = Buildings.Media.Water)
          annotation (Placement(transformation(extent={{-20,0},{0,20}})));
        Modelica.Blocks.Sources.BooleanExpression booleanExpression(y=true)
          annotation (Placement(transformation(extent={{-100,20},{-80,40}})));
        Fluid.Sources.MassFlowSource_T boundary(
        redeclare package Medium =
              Buildings.Applications.DHC_Marseille.Media.Sea_Water,
          m_flow=800/3.6,
          T=288.15,
        nPorts=1)
          annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
        Fluid.Sources.MassFlowSource_T boundary1(
          redeclare package Medium = Buildings.Media.Water,
          m_flow=480/3.6,
          nPorts=1)
          annotation (Placement(transformation(extent={{100,-100},{80,-80}})));
        Fluid.Sources.Boundary_pT bou(redeclare package Medium =
              Buildings.Media.Water, nPorts=1)
          annotation (Placement(transformation(extent={{-100,-100},{-80,-80}})));
        Fluid.Sources.Boundary_pT bou1(redeclare package Medium =
              Buildings.Applications.DHC_Marseille.Media.Sea_Water,
          p=150000,
              nPorts=1)
          annotation (Placement(transformation(extent={{100,80},{80,100}})));
        Fluid.Sensors.TemperatureTwoPort senTem(redeclare package Medium =
              Buildings.Applications.DHC_Marseille.Media.Sea_Water,            m_flow_nominal=800/3.6)
                                                annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=270,
              origin={-50,50})));
        Modelica.Blocks.Sources.RealExpression realExpression(y=4 + 273.15)
          annotation (Placement(transformation(extent={{-100,-20},{-80,0}})));
        Modelica.Blocks.Sources.RealExpression realExpression1(y=480/3.6)
          annotation (Placement(transformation(extent={{-100,-60},{-80,-40}})));
      equation
        connect(booleanExpression.y, chiller.u) annotation (Line(points={{-79,30},{-52,
                30},{-52,13},{-22,13}}, color={255,0,255}));
        connect(boundary1.ports[1], chiller.port_a2) annotation (Line(points={{80,-90},
                {40,-90},{40,4},{0,4}}, color={0,127,255}));
        connect(chiller.port_b2, bou.ports[1]) annotation (Line(points={{-20,4},{-50,4},
                {-50,-90},{-80,-90}}, color={0,127,255}));
        connect(bou1.ports[1], chiller.port_b1) annotation (Line(points={{80,90},{42,90},
                {42,16},{0,16}}, color={0,127,255}));
        connect(boundary.ports[1], senTem.port_a)
          annotation (Line(points={{-80,90},{-50,90},{-50,60}}, color={0,127,255}));
        connect(chiller.port_a1, senTem.port_b)
          annotation (Line(points={{-20,16},{-50,16},{-50,40}}, color={0,127,255}));
        connect(senTem.T, chiller.PEM_TT200) annotation (Line(points={{-39,50},{-30,50},
                {-30,21},{-22,21}}, color={0,0,127}));
        connect(realExpression.y, chiller.T_cons) annotation (Line(points={{-79,-10},{
                -52,-10},{-52,7},{-22,7}}, color={0,0,127}));
        connect(realExpression1.y, chiller.FT121_cons) annotation (Line(points={{-79,-50},
                {-40,-50},{-40,-1},{-22,-1}}, color={0,0,127}));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
              coordinateSystem(preserveAspectRatio=false)));
      end test_GF;

      model test_gf_basic
        Chiller_basic chiller_basic(redeclare package Medium1 =
              Buildings.Applications.DHC_Marseille.Media.Sea_Water,
            redeclare package Medium2 = Buildings.Media.Water)
          annotation (Placement(transformation(extent={{-20,0},{0,20}})));
        Fluid.Sources.Boundary_pT bou1(redeclare package Medium =
              Media.Sea_Water,
            nPorts=1)
          annotation (Placement(transformation(extent={{100,80},{80,100}})));
        Fluid.Sources.MassFlowSource_T boundary1(
          redeclare package Medium = Buildings.Media.Water,
          m_flow=480/3.6,
          T=283.15,
          nPorts=1)
          annotation (Placement(transformation(extent={{100,-100},{80,-80}})));
        Fluid.Sources.MassFlowSource_T boundary(
          redeclare package Medium = Media.Sea_Water,
          m_flow=800/3.6,
          T=288.15,
          nPorts=1)
          annotation (Placement(transformation(extent={{-120,80},{-100,100}})));
        Fluid.Sources.Boundary_pT bou(redeclare package Medium =
              Buildings.Media.Water, nPorts=1)
          annotation (Placement(transformation(extent={{-100,-100},{-80,-80}})));
        Modelica.Blocks.Sources.BooleanExpression booleanExpression(y=true)
          annotation (Placement(transformation(extent={{-100,20},{-80,40}})));
        Modelica.Blocks.Sources.RealExpression realExpression(y=4 + 273.15)
          annotation (Placement(transformation(extent={{-100,-20},{-80,0}})));
        Fluid.Sensors.TemperatureTwoPort senTem(redeclare package Medium =
              Media.Sea_Water, m_flow_nominal=800/3.6)
                                                annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=270,
              origin={-50,50})));
        Fluid.FixedResistances.PressureDrop res(
          redeclare package Medium = Buildings.Media.Water,
          m_flow_nominal=800/3.6,
          dp_nominal=500)
          annotation (Placement(transformation(extent={{-80,80},{-60,100}})));
      equation
        connect(chiller_basic.port_b2, bou.ports[1]) annotation (Line(points={{-20,4},
                {-50,4},{-50,-90},{-80,-90}}, color={0,127,255}));
        connect(chiller_basic.port_a2, boundary1.ports[1]) annotation (Line(points={{0,
                4},{40,4},{40,-90},{80,-90}}, color={0,127,255}));
        connect(chiller_basic.port_b1, bou1.ports[1]) annotation (Line(points={{0,16},
                {40,16},{40,90},{80,90}}, color={0,127,255}));
        connect(booleanExpression.y, chiller_basic.u) annotation (Line(points={{-79,30},
                {-60,30},{-60,14},{-22,14},{-22,13}}, color={255,0,255}));
        connect(realExpression.y, chiller_basic.T_cons) annotation (Line(points={{-79,
                -10},{-60,-10},{-60,7},{-22,7}}, color={0,0,127}));
        connect(senTem.port_b, chiller_basic.port_a1) annotation (Line(points={
                {-50,40},{-50,16},{-20,16}}, color={0,127,255}));
        connect(boundary.ports[1], res.port_a)
          annotation (Line(points={{-100,90},{-80,90}}, color={0,127,255}));
        connect(res.port_b, senTem.port_a) annotation (Line(points={{-60,90},{
                -50,90},{-50,60}}, color={0,127,255}));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
              coordinateSystem(preserveAspectRatio=false)));
      end test_gf_basic;
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

    model Chiller_debug

      extends Fluid.Interfaces.PartialFourPort
      annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)));

              // Chiller parameters
      parameter Modelica.SIunits.MassFlowRate m_flow_chi_evap_nominal= 800 * 1027 / 3600
        "Nominal mass flow rate at condenser water in the chillers";
      parameter Modelica.SIunits.MassFlowRate m_flow_chi_cond_nominal= 500 * 1000 / 3600
        "Nominal mass flow rate at evaporator water in the chillers";
      parameter Modelica.SIunits.PressureDifference dp1_chi_nominal = 0.38*1000
        "Nominal pressure";
      parameter Modelica.SIunits.PressureDifference dp2_chi_nominal = 0.31*1000
        "Nominal pressure";
      parameter Modelica.SIunits.Power QEva_nominal = m2_flow_chi_nominal*4200*(6.67-18.56)
        "Nominal cooling capaciaty(Negative means cooling)";

      Fluid.Chillers.ElectricReformulatedEIR electricReformulatedEIR(
        redeclare package Medium1 = Buildings.Media.Water,
        redeclare package Medium2 = Media.Water,
        m1_flow_nominal=10,
        m2_flow_nominal=20,
        dp1_nominal=0.5,
        dp2_nominal=0.4,
        per=Fluid.Chillers.Data.ElectricReformulatedEIR.ReformEIRChiller_McQuay_PEH_703kW_7_03COP_Vanes())
        annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
      Fluid.FixedResistances.PressureDrop           res2(
        dp_nominal=6000,
        redeclare package Medium = Medium2,
        m_flow_nominal=mEva_flow_nominal) "Flow resistance"
        annotation (Placement(transformation(extent={{-28,-16},{-48,4}})));
      Fluid.FixedResistances.PressureDrop           res1(
        redeclare package Medium = Medium1,
        m_flow_nominal=mCon_flow_nominal,
        dp_nominal=6000) "Flow resistance"
        annotation (Placement(transformation(extent={{20,-4},{40,16}})));
    equation
      connect(electricReformulatedEIR.port_a1, port_a1) annotation (Line(points=
             {{-10,6},{-54,6},{-54,60},{-100,60}}, color={0,127,255}));
      connect(electricReformulatedEIR.port_a2, port_a2) annotation (Line(points=
             {{10,-6},{54,-6},{54,-60},{100,-60}}, color={0,127,255}));
      connect(port_b2, res2.port_b) annotation (Line(points={{-100,-60},{-56,
              -60},{-56,-6},{-48,-6}}, color={0,127,255}));
      connect(res2.port_a, electricReformulatedEIR.port_b2)
        annotation (Line(points={{-28,-6},{-10,-6}}, color={0,127,255}));
      connect(electricReformulatedEIR.port_b1, res1.port_a)
        annotation (Line(points={{10,6},{20,6}}, color={0,127,255}));
      connect(res1.port_b, port_b1) annotation (Line(points={{40,6},{54,6},{54,
              60},{100,60}}, color={0,127,255}));
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
    end Chiller_debug;

    model Basic
      Chiller chiller(redeclare package Medium1 =
            Buildings.Applications.DHC_Marseille.Media.Sea_Water,                                       redeclare
          package Medium2 =
                    Buildings.Media.Water,
        dp1_chi_nominal(displayUnit="Pa"),
        dp2_chi_nominal(displayUnit="Pa"))
        annotation (Placement(transformation(extent={{-10,0},{10,20}})));

      Modelica.Blocks.Sources.RealExpression realExpression(y=4 + 273.15)
        annotation (Placement(transformation(extent={{-120,-20},{-100,0}})));
      Fluid.Sources.Boundary_pT sortie_c(redeclare package Medium =
            Buildings.Applications.DHC_Marseille.Media.Sea_Water, nPorts=1)
        annotation (Placement(transformation(extent={{100,60},{80,80}})));
      Fluid.Sources.MassFlowSource_T entree_c(redeclare package Medium =
            Buildings.Applications.DHC_Marseille.Media.Sea_Water,
        use_m_flow_in=false,
        m_flow=800/3.6,
        use_T_in=true,
        T=298.15,                                                 nPorts=1)
        annotation (Placement(transformation(extent={{-100,60},{-80,80}})));
      Fluid.Sources.Boundary_pT sortie_e(redeclare package Medium =
            Buildings.Media.Water,
        use_T_in=true,             nPorts=1)
        annotation (Placement(transformation(extent={{-100,-60},{-80,-40}})));
      Fluid.Sources.MassFlowSource_T entree_e(redeclare package Medium =
            Buildings.Media.Water,
        use_m_flow_in=true,
        m_flow=500/3.6,
        use_T_in=true,
        T=291.15,                  nPorts=1)
        annotation (Placement(transformation(extent={{100,-40},{80,-60}})));
      Modelica.Blocks.Sources.CombiTimeTable gf_data(
        tableOnFile=true,
        tableName="tab1",
        fileName=ModelicaServices.ExternalReferences.loadResource(
            "modelica://Buildings/Data/gf1.txt"),
        columns={2,6,7,8},
        extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic)
        annotation (Placement(transformation(extent={{-200,60},{-180,80}})));

      Modelica.Thermal.HeatTransfer.Celsius.ToKelvin toKelvin
        annotation (Placement(transformation(extent={{-160,60},{-140,80}})));
      Modelica.Thermal.HeatTransfer.Celsius.ToKelvin toKelvin1
        annotation (Placement(transformation(extent={{160,-40},{140,-20}})));
      Modelica.Blocks.Math.Product product1
        annotation (Placement(transformation(extent={{160,-120},{140,-100}})));
      Modelica.Blocks.Sources.RealExpression realExpression1(y=4185/3.6/1000)
        annotation (Placement(transformation(extent={{160,-160},{180,-140}})));
      Modelica.Blocks.Interfaces.RealOutput y annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-150,130})));
      Modelica.Blocks.Sources.BooleanExpression booleanExpression(y=true)
        annotation (Placement(transformation(extent={{-100,20},{-80,40}})));
    equation
      connect(realExpression.y, chiller.T_cons) annotation (Line(points={{-99,-10},
              {-56.5,-10},{-56.5,7},{-12,7}}, color={0,0,127}));
      connect(sortie_c.ports[1], chiller.port_b1) annotation (Line(points={{80,70},
              {34,70},{34,16},{10,16}},color={0,127,255}));
      connect(sortie_e.ports[1], chiller.port_b2) annotation (Line(points={{-80,-50},
              {-36,-50},{-36,4},{-10,4}}, color={0,127,255}));
      connect(entree_e.ports[1], chiller.port_a2) annotation (Line(points={{80,-50},
              {36,-50},{36,4},{10,4}}, color={0,127,255}));
      connect(entree_c.ports[1], chiller.port_a1) annotation (Line(points={{-80,70},
              {-36,70},{-36,16},{-10,16}}, color={0,127,255}));
      connect(chiller.y, sortie_e.T_in) annotation (Line(points={{-3,-1},{-3,
              -28},{-120,-28},{-120,-46},{-102,-46}}, color={0,0,127}));
      connect(gf_data.y[2], toKelvin.Celsius)
        annotation (Line(points={{-179,70},{-162,70}}, color={0,0,127}));
      connect(toKelvin.Kelvin, entree_c.T_in) annotation (Line(points={{-139,70},{-122,
              70},{-122,74},{-102,74}}, color={0,0,127}));
      connect(gf_data.y[3], toKelvin1.Celsius) annotation (Line(points={{-179,
              70},{-170,70},{-170,-80},{190,-80},{190,-30},{162,-30}}, color={0,
              0,127}));
      connect(toKelvin1.Kelvin, entree_e.T_in) annotation (Line(points={{139,-30},{128,
              -30},{128,-54},{102,-54}}, color={0,0,127}));
      connect(realExpression1.y, product1.u2) annotation (Line(points={{181,-150},{190,
              -150},{190,-116},{162,-116}}, color={0,0,127}));
      connect(gf_data.y[4], product1.u1) annotation (Line(points={{-179,70},{-170,
              70},{-170,-160},{218,-160},{218,-104},{162,-104}}, color={0,0,127}));
      connect(product1.y, entree_e.m_flow_in) annotation (Line(points={{139,-110},{128,
              -110},{128,-58},{102,-58}}, color={0,0,127}));
      connect(gf_data.y[1], y) annotation (Line(points={{-179,70},{-170,70},{
              -170,108},{-150,108},{-150,130}}, color={0,0,127}));
      connect(booleanExpression.y, chiller.u) annotation (Line(points={{-79,30},
              {-60,30},{-60,13},{-12,13}}, color={255,0,255}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)),
        experiment(
          StopTime=100000,
          Interval=200,
          __Dymola_Algorithm="Dassl"));
    end Basic;

    model Basic_b
      Chiller chiller(redeclare package Medium1 =
            Buildings.Applications.DHC_Marseille.Media.Sea_Water,                                       redeclare
          package Medium2 =
                    Buildings.Media.Water,
        dp1_chi_nominal(displayUnit="Pa"),
        dp2_chi_nominal(displayUnit="Pa"))
        annotation (Placement(transformation(extent={{-10,0},{10,20}})));

      Modelica.Blocks.Sources.RealExpression realExpression(y=4 + 273.15)
        annotation (Placement(transformation(extent={{-120,-20},{-100,0}})));
      Fluid.Sources.Boundary_pT sortie_c(redeclare package Medium =
            Buildings.Applications.DHC_Marseille.Media.Sea_Water, nPorts=1)
        annotation (Placement(transformation(extent={{100,60},{80,80}})));
      Fluid.Sources.MassFlowSource_T entree_c(redeclare package Medium =
            Buildings.Applications.DHC_Marseille.Media.Sea_Water,
        use_m_flow_in=false,
        m_flow=800/3.6,
        use_T_in=true,
        T=298.15,
        nPorts=1)
        annotation (Placement(transformation(extent={{-100,60},{-80,80}})));
      Fluid.Sources.Boundary_pT sortie_e(redeclare package Medium =
            Buildings.Media.Water,
        use_T_in=true,
        nPorts=1)
        annotation (Placement(transformation(extent={{-100,-60},{-80,-40}})));
      Fluid.Sources.MassFlowSource_T entree_e(redeclare package Medium =
            Buildings.Media.Water,
        use_m_flow_in=true,
        m_flow=500/3.6,
        use_T_in=true,
        T=291.15,
        nPorts=1)
        annotation (Placement(transformation(extent={{100,-40},{80,-60}})));
      Modelica.Blocks.Sources.CombiTimeTable gf_data(
        tableOnFile=true,
        tableName="tab1",
        fileName=ModelicaServices.ExternalReferences.loadResource(
            "modelica://Buildings/Data/gf1.txt"),
        columns={2,6,7,8},
        extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic)
        annotation (Placement(transformation(extent={{-200,60},{-180,80}})));

      Modelica.Thermal.HeatTransfer.Celsius.ToKelvin toKelvin
        annotation (Placement(transformation(extent={{-160,60},{-140,80}})));
      Modelica.Thermal.HeatTransfer.Celsius.ToKelvin toKelvin1
        annotation (Placement(transformation(extent={{160,-40},{140,-20}})));
      Modelica.Blocks.Math.Product product1
        annotation (Placement(transformation(extent={{160,-120},{140,-100}})));
      Modelica.Blocks.Sources.RealExpression realExpression1(y=4185/3.6/1000)
        annotation (Placement(transformation(extent={{160,-160},{180,-140}})));
      Modelica.Blocks.Interfaces.RealOutput y annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-150,130})));
      Modelica.Blocks.Sources.BooleanPulse booleanPulse(period=50000)
        annotation (Placement(transformation(extent={{-100,20},{-80,40}})));
      Fluid.Sensors.Pressure senPre(redeclare package Medium =
            Buildings.Applications.DHC_Marseille.Media.Sea_Water)
        annotation (Placement(transformation(extent={{-60,72},{-40,92}})));
      Fluid.Sensors.Pressure senPre1(redeclare package Medium =
            Buildings.Applications.DHC_Marseille.Media.Sea_Water)
        annotation (Placement(transformation(extent={{32,70},{52,90}})));
      Fluid.Sensors.Pressure senPre2(redeclare package Medium =
            Buildings.Media.Water)
        annotation (Placement(transformation(extent={{38,-38},{58,-18}})));
      Fluid.Sensors.Pressure senPre3(redeclare package Medium =
            Buildings.Media.Water)
        annotation (Placement(transformation(extent={{-60,-48},{-40,-28}})));
    equation
      connect(realExpression.y, chiller.T_cons) annotation (Line(points={{-99,-10},
              {-56.5,-10},{-56.5,7},{-12,7}}, color={0,0,127}));
      connect(chiller.y, sortie_e.T_in) annotation (Line(points={{-3,-1},{-3,
              -28},{-120,-28},{-120,-46},{-102,-46}}, color={0,0,127}));
      connect(gf_data.y[2], toKelvin.Celsius)
        annotation (Line(points={{-179,70},{-162,70}}, color={0,0,127}));
      connect(toKelvin.Kelvin, entree_c.T_in) annotation (Line(points={{-139,70},{-122,
              70},{-122,74},{-102,74}}, color={0,0,127}));
      connect(gf_data.y[3], toKelvin1.Celsius) annotation (Line(points={{-179,
              70},{-170,70},{-170,-80},{190,-80},{190,-30},{162,-30}}, color={0,
              0,127}));
      connect(toKelvin1.Kelvin, entree_e.T_in) annotation (Line(points={{139,-30},{128,
              -30},{128,-54},{102,-54}}, color={0,0,127}));
      connect(realExpression1.y, product1.u2) annotation (Line(points={{181,-150},{190,
              -150},{190,-116},{162,-116}}, color={0,0,127}));
      connect(gf_data.y[4], product1.u1) annotation (Line(points={{-179,70},{-170,
              70},{-170,-160},{218,-160},{218,-104},{162,-104}}, color={0,0,127}));
      connect(product1.y, entree_e.m_flow_in) annotation (Line(points={{139,-110},{128,
              -110},{128,-58},{102,-58}}, color={0,0,127}));
      connect(gf_data.y[1], y) annotation (Line(points={{-179,70},{-170,70},{
              -170,108},{-150,108},{-150,130}}, color={0,0,127}));
      connect(booleanPulse.y, chiller.u) annotation (Line(points={{-79,30},{-50,30},
              {-50,13},{-12,13}}, color={255,0,255}));
      connect(entree_c.ports[1], senPre.port) annotation (Line(points={{-80,70},{-66,
              70},{-66,72},{-50,72}}, color={0,127,255}));
      connect(senPre.port, chiller.port_a1) annotation (Line(points={{-50,72},{-30,72},
              {-30,16},{-10,16}}, color={0,127,255}));
      connect(sortie_e.ports[1], senPre3.port) annotation (Line(points={{-80,-50},{-66,
              -50},{-66,-48},{-50,-48}}, color={0,127,255}));
      connect(senPre3.port, chiller.port_b2) annotation (Line(points={{-50,-48},{-30,
              -48},{-30,4},{-10,4}}, color={0,127,255}));
      connect(chiller.port_a2, senPre2.port) annotation (Line(points={{10,4},{30,4},
              {30,-38},{48,-38}}, color={0,127,255}));
      connect(senPre2.port, entree_e.ports[1]) annotation (Line(points={{48,-38},{64,
              -38},{64,-50},{80,-50}}, color={0,127,255}));
      connect(senPre1.port, chiller.port_b1) annotation (Line(points={{42,70},{26,70},
              {26,16},{10,16}}, color={0,127,255}));
      connect(senPre1.port, sortie_c.ports[1])
        annotation (Line(points={{42,70},{80,70}}, color={0,127,255}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)),
        experiment(
          StopTime=100000,
          Interval=200,
          __Dymola_Algorithm="Dassl"));
    end Basic_b;

    model Chiller_basic

      extends Fluid.Interfaces.PartialFourPort
      annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)));

              // Chiller parameters
      parameter Modelica.SIunits.MassFlowRate m_flow_chi_evap_nominal= 800 * 1027 / 3600
        "Nominal mass flow rate at condenser water in the chillers";
      parameter Modelica.SIunits.MassFlowRate m_flow_chi_cond_nominal= 500 * 1000 / 3600
        "Nominal mass flow rate at evaporator water in the chillers";
      parameter Modelica.SIunits.PressureDifference dp1_chi_nominal = 0.38*1000
        "Nominal pressure";
      parameter Modelica.SIunits.PressureDifference dp2_chi_nominal = 0.31*1000
        "Nominal pressure";

      Fluid.Chillers.ElectricReformulatedEIR electricReformulatedEIR(
        redeclare package Medium1 =
            Buildings.Applications.DHC_Marseille.Media.Sea_Water,
        redeclare package Medium2 = Buildings.Media.Water,
        m1_flow_nominal=m_flow_chi_cond_nominal,
        m2_flow_nominal=m_flow_chi_evap_nominal,
        dp1_nominal=dp1_chi_nominal,
        dp2_nominal=dp2_chi_nominal,
        per=Fluid.Chillers.Data.ElectricReformulatedEIR.ReformEIRChiller_Carrier_19EX_5148kW_6_34COP_Vanes())
        annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
      Modelica.Blocks.Interfaces.BooleanInput u
        annotation (Placement(transformation(extent={{-140,10},{-100,50}})));
      Modelica.Blocks.Interfaces.RealInput T_cons
        annotation (Placement(transformation(extent={{-140,-50},{-100,-10}})));
      Fluid.Sensors.TemperatureTwoPort TCin(redeclare package Medium =
            Buildings.Applications.DHC_Marseille.Media.Sea_Water, m_flow_nominal=m_flow_chi_cond_nominal)
        annotation (Placement(transformation(extent={{-50,50},{-30,70}})));
      Fluid.Sensors.TemperatureTwoPort TT211(redeclare package Medium =
            Buildings.Applications.DHC_Marseille.Media.Sea_Water, m_flow_nominal=m_flow_chi_cond_nominal)
        annotation (Placement(transformation(extent={{30,50},{50,70}})));
      Fluid.Sensors.TemperatureTwoPort TEin(redeclare package Medium =
            Buildings.Media.Water,          m_flow_nominal=m_flow_chi_evap_nominal)
        annotation (Placement(transformation(extent={{50,-70},{30,-50}})));
      Fluid.Sensors.TemperatureTwoPort TEout(redeclare package Medium =
            Buildings.Media.Water,           m_flow_nominal=m_flow_chi_evap_nominal)
        annotation (Placement(transformation(extent={{-40,-70},{-60,-50}})));
      Modelica.Blocks.Interfaces.RealOutput y annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=-90,
            origin={-30,-110})));
      Fluid.Sensors.Pressure PT211(redeclare package Medium =
            Buildings.Applications.DHC_Marseille.Media.Sea_Water)
        annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={10,40})));
      Fluid.Sensors.Pressure PT221(redeclare package Medium =
            Buildings.Applications.DHC_Marseille.Media.Sea_Water)
        annotation (Placement(transformation(extent={{-80,60},{-60,80}})));
      Fluid.Actuators.Valves.TwoWayLinear CV121(
        redeclare package Medium = Buildings.Media.Water,
        m_flow_nominal=m_flow_chi_cond_nominal,
        dpValve_nominal=10)
        annotation (Placement(transformation(extent={{80,-70},{60,-50}})));
      Fluid.Actuators.Valves.TwoWayLinear CV211(
        redeclare package Medium = Buildings.Media.Water,
        m_flow_nominal=m_flow_chi_cond_nominal,
        CvData=Buildings.Fluid.Types.CvTypes.OpPoint,
        dpValve_nominal=10)
        annotation (Placement(transformation(extent={{60,50},{80,70}})));
      Modelica.Blocks.Sources.RealExpression realExpression(y=1)
        annotation (Placement(transformation(extent={{40,100},{60,120}})));
    equation
      connect(T_cons, electricReformulatedEIR.TSet) annotation (Line(points={{-120,-30},
              {-66,-30},{-66,-3},{-12,-3}}, color={0,0,127}));
      connect(u, electricReformulatedEIR.on) annotation (Line(points={{-120,30},
              {-66,30},{-66,3},{-12,3}}, color={255,0,255}));
      connect(port_a1, TCin.port_a)
        annotation (Line(points={{-100,60},{-50,60}}, color={0,127,255}));
      connect(TCin.port_b, electricReformulatedEIR.port_a1) annotation (Line(points={{-30,60},
              {-20,60},{-20,6},{-10,6}},         color={0,127,255}));
      connect(electricReformulatedEIR.port_b1,TT211. port_a) annotation (Line(
            points={{10,6},{20,6},{20,60},{30,60}}, color={0,127,255}));
      connect(port_b2,TEout. port_b)
        annotation (Line(points={{-100,-60},{-60,-60}}, color={0,127,255}));
      connect(TEout.port_a, electricReformulatedEIR.port_b2) annotation (Line(
            points={{-40,-60},{-20,-60},{-20,-6},{-10,-6}}, color={0,127,255}));
      connect(TEout.T, y) annotation (Line(points={{-50,-49},{-50,-40},{-30,-40},
              {-30,-110}}, color={0,0,127}));
      connect(TEin.port_a, CV121.port_b)
        annotation (Line(points={{50,-60},{60,-60}}, color={0,127,255}));
      connect(CV121.port_a, port_a2)
        annotation (Line(points={{80,-60},{100,-60}}, color={0,127,255}));

      connect(TT211.port_b, CV211.port_a)
        annotation (Line(points={{50,60},{60,60}}, color={0,127,255}));
      connect(CV211.port_b, port_b1)
        annotation (Line(points={{80,60},{100,60}}, color={0,127,255}));
      connect(port_a1, PT221.port)
        annotation (Line(points={{-100,60},{-70,60}}, color={0,127,255}));
      connect(electricReformulatedEIR.port_b1, PT211.port)
        annotation (Line(points={{10,6},{20,6},{20,40}}, color={0,127,255}));
      connect(CV211.y, realExpression.y)
        annotation (Line(points={{70,72},{70,110},{61,110}}, color={0,0,127}));
      connect(realExpression.y, CV121.y) annotation (Line(points={{61,110},{140,
              110},{140,-40},{70,-40},{70,-48}}, color={0,0,127}));
      connect(electricReformulatedEIR.port_a2, TEin.port_b) annotation (Line(
            points={{10,-6},{10,-34},{30,-34},{30,-60}}, color={0,127,255}));
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
    end Chiller_basic;
  end GF;

  package TFP
    extends Modelica.Icons.VariantsPackage;
    package Tests
      extends Modelica.Icons.ExamplesPackage;

      model TFP_duo_test

        parameter Modelica.SIunits.MassFlowRate m_flow_hot= 332*1000/3600;
        parameter Modelica.SIunits.MassFlowRate m_flow_cold= 211*1000/3600;
        parameter Real T_set_hot = 61;
        parameter Real T_set_hot_max = 63;
        parameter Real T_set_hot_min = 41;
        parameter Real T_set_cold_max = 14;
        parameter Real T_set_cold = 4;

        Fluid.FixedResistances.Junction jun(
          redeclare package Medium = Buildings.Media.Water,
          m_flow_nominal={m_flow_hot,-m_flow_hot,-m_flow_hot},
          dp_nominal={0,0,0})
          annotation (Placement(transformation(extent={{-10,-10},{10,10}},
              rotation=270,
              origin={10,250})));
        Fluid.Actuators.Valves.TwoWayLinear XV521(
          redeclare package Medium = Buildings.Media.Water,
          m_flow_nominal=m_flow_hot,
          CvData=Buildings.Fluid.Types.CvTypes.OpPoint,
          dpValve_nominal=10)
          annotation (Placement(transformation(extent={{-40,180},{-60,200}})));
        Fluid.Actuators.Valves.TwoWayLinear XV522(
          redeclare package Medium = Buildings.Media.Water,
          m_flow_nominal=m_flow_hot,
          CvData=Buildings.Fluid.Types.CvTypes.OpPoint,
          dpValve_nominal=10) annotation (Placement(
              transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={70,230})));
        Fluid.Actuators.Valves.TwoWayLinear CV522(
          redeclare package Medium = Buildings.Media.Water,
          m_flow_nominal=m_flow_hot,
          CvData=Buildings.Fluid.Types.CvTypes.OpPoint,
          dpValve_nominal=10)
          annotation (Placement(transformation(extent={{-60,140},{-40,160}})));
        Fluid.Actuators.Valves.TwoWayLinear CV521(
          redeclare package Medium = Buildings.Media.Water,
          m_flow_nominal=m_flow_hot,
          CvData=Buildings.Fluid.Types.CvTypes.OpPoint,
          dpValve_nominal=10) annotation (Placement(
              transformation(
              extent={{-10,-10},{10,10}},
              rotation=270,
              origin={10,210})));
        Fluid.Actuators.Valves.TwoWayLinear CV523(
          redeclare package Medium = Buildings.Media.Water,
          m_flow_nominal=m_flow_hot,
          CvData=Buildings.Fluid.Types.CvTypes.OpPoint,
          dpValve_nominal=10) annotation (Placement(
              transformation(
              extent={{-10,-10},{10,10}},
              rotation=270,
              origin={10,50})));
        Fluid.FixedResistances.Junction jun1(
          redeclare package Medium = Buildings.Media.Water,
          m_flow_nominal={m_flow_hot,-m_flow_hot,m_flow_hot},
          dp_nominal={0,0,0})
          annotation (Placement(transformation(extent={{-10,10},{10,-10}},
              rotation=270,
              origin={-110,190})));
        Fluid.FixedResistances.Junction jun2(
          redeclare package Medium = Buildings.Media.Water,
          m_flow_nominal={m_flow_hot,-m_flow_hot,m_flow_hot},
          dp_nominal={0,0,0})
          annotation (Placement(transformation(extent={{-10,-10},{10,10}},
              rotation=270,
              origin={10,150})));
        Fluid.FixedResistances.Junction jun3(
          redeclare package Medium = Buildings.Media.Water,
          m_flow_nominal={m_flow_hot,-m_flow_hot,-m_flow_hot},
          dp_nominal={0,0,0})
          annotation (Placement(transformation(extent={{-10,10},{10,-10}},
              rotation=90,
              origin={70,190})));
        Fluid.Chillers.ElectricReformulatedEIR TFPA(redeclare package Medium1 =
              Buildings.Media.Water, redeclare package Medium2 =
              Buildings.Media.Water,
          m1_flow_nominal=m_flow_hot,
          m2_flow_nominal=m_flow_cold/2,
          dp1_nominal=70000,
          dp2_nominal=70000,
          per=Buildings.Fluid.Chillers.Data.ElectricReformulatedEIR.ReformEIRChiller_Trane_RTHB_1051kW_5_05COP_Valve())
          annotation (Placement(transformation(extent={{-40,-20},{-20,0}})));
        Fluid.Chillers.ElectricReformulatedEIR TFPB(redeclare package Medium1 =
              Buildings.Media.Water, redeclare package Medium2 =
              Buildings.Media.Water,
          m1_flow_nominal=m_flow_hot,
          m2_flow_nominal=m_flow_cold/2,
          dp1_nominal=70000,
          dp2_nominal=70000,
          per=Buildings.Fluid.Chillers.Data.ElectricReformulatedEIR.ReformEIRChiller_Trane_RTHB_1051kW_5_05COP_Valve())
          annotation (Placement(transformation(extent={{20,-20},{40,0}})));
        Fluid.FixedResistances.Junction jun4(
          redeclare package Medium = Buildings.Media.Water,
          m_flow_nominal={100,-100,-100},
          dp_nominal={0,0,0})
          annotation (Placement(transformation(extent={{-10,10},{10,-10}},
              rotation=90,
              origin={50,-50})));
        Fluid.Actuators.Valves.TwoWayLinear XV112A(
          redeclare package Medium = Buildings.Media.Water,
          m_flow_nominal=100,
          CvData=Buildings.Fluid.Types.CvTypes.OpPoint,
          dpValve_nominal=10) annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=270,
              origin={-50,-90})));
        Fluid.Actuators.Valves.TwoWayLinear CV121(
          redeclare package Medium = Buildings.Media.Water,
          m_flow_nominal=100,
          CvData=Buildings.Fluid.Types.CvTypes.OpPoint,
          dpValve_nominal=10) annotation (Placement(
              transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={50,-190})));
        Fluid.Actuators.Valves.TwoWayLinear CV123(
          redeclare package Medium = Buildings.Media.Water,
          m_flow_nominal=100,
          CvData=Buildings.Fluid.Types.CvTypes.OpPoint,
          dpValve_nominal=10) annotation (Placement(
              transformation(
              extent={{-10,10},{10,-10}},
              rotation=90,
              origin={50,-90})));
        Fluid.FixedResistances.Junction jun5(
          redeclare package Medium = Buildings.Media.Water,
          m_flow_nominal={100,-100,-100},
          dp_nominal={0,0,0})
          annotation (Placement(transformation(extent={{-10,-10},{10,10}},
              rotation=90,
              origin={50,-230})));
        Fluid.FixedResistances.Junction jun6(
          redeclare package Medium = Buildings.Media.Water,
          m_flow_nominal={100,-100,100},
          dp_nominal={0,0,0})
          annotation (Placement(transformation(extent={{-10,10},{10,-10}},
              rotation=270,
              origin={-50,-130})));
        Fluid.Actuators.Valves.TwoWayLinear CV122(
          redeclare package Medium = Buildings.Media.Water,
          m_flow_nominal=100,
          CvData=Buildings.Fluid.Types.CvTypes.OpPoint,
          dpValve_nominal=10) annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=0,
              origin={-30,-210})));
        Fluid.Actuators.Valves.TwoWayLinear XV112B(
          redeclare package Medium = Buildings.Media.Water,
          m_flow_nominal=100,
          CvData=Buildings.Fluid.Types.CvTypes.OpPoint,
          dpValve_nominal=10) annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=270,
              origin={10,-90})));
        Fluid.FixedResistances.Junction jun7(
          redeclare package Medium = Buildings.Media.Water,
          m_flow_nominal={100,-100,100},
          dp_nominal={0,0,0})
          annotation (Placement(transformation(extent={{10,-10},{-10,10}},
              rotation=270,
              origin={50,-150})));
        Modelica.Blocks.Sources.Constant const(k=m_flow_cold/1000)
          annotation (Placement(transformation(extent={{160,120},{180,140}})));
        Fluid.Sensors.VolumeFlowRate FT521(redeclare package Medium =
              Buildings.Media.Water, m_flow_nominal=100) annotation (Placement(
              transformation(
              extent={{-10,-10},{10,10}},
              rotation=-90,
              origin={10,90})));
        Controls.Continuous.LimPID FT_PID_521(k=1, Ti=1)
          annotation (Placement(transformation(extent={{200,120},{220,140}})));
        Controls.Continuous.LimPID FT_PID_123(k=1, Ti=1)
          annotation (Placement(transformation(extent={{180,-100},{200,-80}})));
        Fluid.Sensors.VolumeFlowRate FT121(redeclare package Medium =
              Buildings.Media.Water, m_flow_nominal=100) annotation (Placement(
              transformation(
              extent={{-10,-10},{10,10}},
              rotation=-90,
              origin={50,-120})));
        Fluid.Sensors.TemperatureTwoPort TT121(redeclare package Medium =
              Buildings.Media.Water, m_flow_nominal=100)
          annotation (Placement(transformation(extent={{80,-290},{60,-270}})));
        Fluid.Sensors.TemperatureTwoPort TT111(redeclare package Medium =
              Buildings.Media.Water, m_flow_nominal=100)
          annotation (Placement(transformation(extent={{-60,-170},{-80,-150}})));
        Fluid.Sensors.TemperatureTwoPort TT511(redeclare package Medium =
              Buildings.Media.Water, m_flow_nominal=100)
          annotation (Placement(transformation(extent={{80,250},{100,270}})));
        Fluid.Sensors.TemperatureTwoPort TT521(redeclare package Medium =
              Buildings.Media.Water, m_flow_nominal=100) annotation (Placement(
              transformation(
              extent={{-10,10},{10,-10}},
              rotation=-90,
              origin={10,120})));
        Modelica.Blocks.Interfaces.IntegerInput mode
          annotation (Placement(transformation(extent={{-360,100},{-280,180}}),
              iconTransformation(extent={{-360,100},{-280,180}})));
        Modelica.Blocks.Sources.RealExpression XV521_switch(y=if mode == 1 then 1
               else 0)
          annotation (Placement(transformation(extent={{-260,260},{-240,280}})));
        Modelica.Blocks.Sources.RealExpression XV522_switch(y=if mode >= 2 then 1
               else 0)
          annotation (Placement(transformation(extent={{-260,240},{-240,260}})));
        Modelica.Blocks.Sources.RealExpression XV112A_switch(y=if mode >= 1 then 1
               else 0)
          annotation (Placement(transformation(extent={{-260,-40},{-240,-20}})));
        Modelica.Blocks.Sources.RealExpression XV112B_switch(y=if mode == 1 or mode ==
              3 then 1 else 0)
          annotation (Placement(transformation(extent={{-260,-80},{-240,-60}})));
        Modelica.Blocks.Sources.RealExpression limit_hot_max(y=T_set_hot_max)
          annotation (Placement(transformation(extent={{-260,200},{-240,220}})));
        Modelica.Blocks.Math.RealToBoolean TFPA_on(threshold=0.5)
          annotation (Placement(transformation(extent={{-200,20},{-180,40}})));
        Modelica.Blocks.Math.RealToBoolean TFPB_on
          annotation (Placement(transformation(extent={{-200,-20},{-180,0}})));
        Modelica.Blocks.Sources.RealExpression cons_cold(y=T_set_cold)
          annotation (Placement(transformation(extent={{-260,40},{-240,60}})));
        Controls.Continuous.LimPID conPID3(
          controllerType=Modelica.Blocks.Types.SimpleController.PI,
          k=3,
          Ti=1,
          initType=Modelica.Blocks.Types.InitPID.NoInit) annotation (Placement(
              transformation(
              extent={{-10,-10},{10,10}},
              rotation=0,
              origin={-210,210})));
        Modelica.Thermal.HeatTransfer.Celsius.FromKelvin fromKelvin
          annotation (Placement(transformation(extent={{-10,-10},{10,10}},
              rotation=-90,
              origin={-320,240})));
        Modelica.Blocks.Sources.RealExpression limit_hot_min(y=T_set_hot_min)
          annotation (Placement(transformation(extent={{-260,140},{-240,160}})));
        Controls.Continuous.LimPID conPID1(
          controllerType=Modelica.Blocks.Types.SimpleController.PI,
          k=3,
          Ti=1,
          initType=Modelica.Blocks.Types.InitPID.NoInit,
          reverseActing=false)                           annotation (Placement(
              transformation(
              extent={{-10,-10},{10,10}},
              rotation=0,
              origin={-210,150})));
        Modelica.Thermal.HeatTransfer.Celsius.FromKelvin fromKelvin1
          annotation (Placement(transformation(extent={{-260,110},{-240,130}})));
        Modelica.Blocks.Math.Min min1
          annotation (Placement(transformation(extent={{-180,140},{-160,160}})));
        Modelica.Blocks.Sources.RealExpression CV123_reg(y=if mode == 1 or mode == 3
               then 166 else 332)
          annotation (Placement(transformation(extent={{140,-100},{160,-80}})));
        Controls_a.opposite opposite
          annotation (Placement(transformation(extent={{-20,170},{0,190}})));
        Modelica.Blocks.Interfaces.RealInput DEC_TT521
          annotation (Placement(transformation(extent={{-360,-280},{-280,-200}}),
              iconTransformation(extent={{-360,-280},{-280,-200}})));
        Modelica.Blocks.Interfaces.RealInput PEM_TT200
          annotation (Placement(transformation(extent={{-362,-200},{-282,-120}}),
              iconTransformation(extent={{-362,-200},{-282,-120}})));
        Modelica.Blocks.Math.Max max1
          annotation (Placement(transformation(extent={{-260,-260},{-240,-240}})));
        Modelica.Blocks.Math.Min min2
          annotation (Placement(transformation(extent={{-220,-240},{-200,-220}})));
        Modelica.Blocks.Sources.RealExpression limit_hot_min1(y=T_set_cold_max)
          annotation (Placement(transformation(extent={{-260,-220},{-240,-200}})));
        Controls.Continuous.LimPID conPID2(
          controllerType=Modelica.Blocks.Types.SimpleController.PI,
          k=3,
          Ti=1,
          initType=Modelica.Blocks.Types.InitPID.NoInit,
          reverseActing=false)                           annotation (Placement(
              transformation(
              extent={{-10,-10},{10,10}},
              rotation=0,
              origin={-170,-170})));
        Modelica.Blocks.Sources.RealExpression limit_hot_min2(y=T_set_hot)
          annotation (Placement(transformation(extent={{-260,-120},{-240,-100}})));
        Controls.Continuous.LimPID conPID4(
          controllerType=Modelica.Blocks.Types.SimpleController.PI,
          k=3,
          Ti=1,
          initType=Modelica.Blocks.Types.InitPID.NoInit,
          reverseActing=false)                           annotation (Placement(
              transformation(
              extent={{-10,-10},{10,10}},
              rotation=0,
              origin={-170,-110})));
        Modelica.Blocks.Math.Min min3
          annotation (Placement(transformation(extent={{-140,-240},{-120,-220}})));
        Controls_a.opposite opposite1
          annotation (Placement(transformation(extent={{-40,-260},{-20,-240}})));
        Modelica.Thermal.HeatTransfer.Celsius.FromKelvin fromKelvin2
          annotation (Placement(transformation(extent={{-100,-270},{-120,-250}})));
      equation
        connect(port_a1, jun.port_1) annotation (Line(points={{-100,80},{-140,80},
                {-140,280},{10,280},{10,260}},
                                         color={238,46,47}));
        connect(jun.port_2, CV521.port_a)
          annotation (Line(points={{10,240},{10,220}}, color={238,46,47}));
        connect(CV521.port_b, jun2.port_1)
          annotation (Line(points={{10,200},{10,160}}, color={238,46,47}));
        connect(jun2.port_3, CV522.port_b)
          annotation (Line(points={{1.77636e-15,150},{-40,150}},
                                                       color={238,46,47}));
        connect(jun1.port_3, XV521.port_b)
          annotation (Line(points={{-100,190},{-60,190}}, color={238,46,47}));
        connect(jun.port_3, jun1.port_1) annotation (Line(points={{0,250},{-110,
                250},{-110,200}},
                            color={238,46,47}));
        connect(CV523.port_b, TFPA.port_a1) annotation (Line(points={{10,40},{10,20},{
                -60,20},{-60,-4},{-40,-4}}, color={238,46,47}));
        connect(TFPA.port_b1, TFPB.port_a1)
          annotation (Line(points={{-20,-4},{20,-4}}, color={238,46,47}));
        connect(port_b2, jun1.port_2) annotation (Line(points={{-100,30},{-110,30},
                {-110,180}},
                       color={238,46,47}));
        connect(jun4.port_2, TFPB.port_a2)
          annotation (Line(points={{50,-40},{50,-16},{40,-16}}, color={0,127,255}));
        connect(jun4.port_3, TFPA.port_a2) annotation (Line(points={{40,-50},{-10,-50},
                {-10,-16},{-20,-16}}, color={0,127,255}));
        connect(XV112A.port_a, TFPA.port_b2) annotation (Line(points={{-50,-80},{-50,-16},
                {-40,-16}}, color={0,127,255}));
        connect(XV112B.port_a, TFPB.port_b2)
          annotation (Line(points={{10,-80},{10,-16},{20,-16}}, color={0,127,255}));
        connect(XV112A.port_b, jun6.port_1)
          annotation (Line(points={{-50,-100},{-50,-120}}, color={0,127,255}));
        connect(jun6.port_3, XV112B.port_b) annotation (Line(points={{-40,-130},{
                10,-130},{10,-100}}, color={0,127,255}));
        connect(port_a2, CV522.port_a) annotation (Line(points={{100,30},{-72,30},{-72,
                150},{-60,150}},      color={238,46,47}));
        connect(jun4.port_1, CV123.port_b)
          annotation (Line(points={{50,-60},{50,-80}}, color={0,127,255}));
        connect(jun7.port_1, CV121.port_b)
          annotation (Line(points={{50,-160},{50,-180}}, color={0,127,255}));
        connect(port_a3, CV122.port_a) annotation (Line(points={{-100,-32},{-140,
                -32},{-140,-210},{-40,-210}}, color={0,127,255}));
        connect(CV122.port_b, jun7.port_3) annotation (Line(points={{-20,-210},{
                10,-210},{10,-150},{40,-150}}, color={0,127,255}));
        connect(TFPB.port_b1, jun3.port_1)
          annotation (Line(points={{40,-4},{70,-4},{70,180}}, color={238,46,47}));
        connect(jun3.port_3, XV521.port_a)
          annotation (Line(points={{60,190},{-40,190}}, color={238,46,47}));
        connect(jun3.port_2, XV522.port_a)
          annotation (Line(points={{70,200},{70,220}}, color={238,46,47}));
        connect(CV121.port_a, jun5.port_2)
          annotation (Line(points={{50,-200},{50,-220}}, color={0,127,255}));
        connect(jun5.port_3, port_b3) annotation (Line(points={{60,-230},{120,
                -230},{120,-30},{100,-30}}, color={0,127,255}));
        connect(FT521.port_b, CV523.port_a)
          annotation (Line(points={{10,80},{10,60}}, color={238,46,47}));
        connect(FT521.V_flow, FT_PID_521.u_m) annotation (Line(points={{21,90},{50,90},
                {50,100},{210,100},{210,118}}, color={0,0,127}));
        connect(const.y, FT_PID_521.u_s)
          annotation (Line(points={{181,130},{198,130}}, color={0,0,127}));
        connect(FT_PID_521.y, CV523.y) annotation (Line(points={{221,130},{240,130},{240,
                50},{22,50}}, color={0,0,127}));
        connect(CV123.port_a, FT121.port_a)
          annotation (Line(points={{50,-100},{50,-110}}, color={0,127,255}));
        connect(FT121.port_b, jun7.port_2)
          annotation (Line(points={{50,-130},{50,-140}}, color={0,127,255}));
        connect(FT121.V_flow, FT_PID_123.u_m) annotation (Line(points={{61,-120},{190,
                -120},{190,-102}}, color={0,0,127}));
        connect(FT_PID_123.y, CV123.y) annotation (Line(points={{201,-90},{220,-90},{220,
                -60},{80,-60},{80,-90},{62,-90}}, color={0,0,127}));
        connect(port_a4, TT121.port_a) annotation (Line(points={{100,-80},{100,
                -280},{80,-280}}, color={0,127,255}));
        connect(TT121.port_b, jun5.port_1) annotation (Line(points={{60,-280},{50,
                -280},{50,-240}}, color={0,127,255}));
        connect(jun6.port_2, TT111.port_a) annotation (Line(points={{-50,-140},{
                -50,-160},{-60,-160}}, color={0,127,255}));
        connect(TT111.port_b, port_b4) annotation (Line(points={{-80,-160},{-100,
                -160},{-100,-80}}, color={0,127,255}));
        connect(XV522.port_b, TT511.port_a) annotation (Line(points={{70,240},{70,
                260},{80,260}}, color={238,46,47}));
        connect(TT511.port_b, port_b1) annotation (Line(points={{100,260},{120,
                260},{120,80},{100,80}}, color={238,46,47}));
        connect(jun2.port_2, TT521.port_a)
          annotation (Line(points={{10,140},{10,130}}, color={238,46,47}));
        connect(TT521.port_b, FT521.port_a)
          annotation (Line(points={{10,110},{10,100}}, color={238,46,47}));
        connect(XV521_switch.y, XV521.y) annotation (Line(points={{-239,270},{-200,270},
                {-200,240},{-50,240},{-50,202}}, color={0,0,127}));
        connect(XV522_switch.y, XV522.y) annotation (Line(points={{-239,250},{-210,250},
                {-210,230},{58,230}}, color={0,0,127}));
        connect(XV112A_switch.y, XV112A.y) annotation (Line(points={{-239,-30},{-200,-30},
                {-200,-50},{-30,-50},{-30,-90},{-38,-90}}, color={0,0,127}));
        connect(XV112B_switch.y, XV112B.y) annotation (Line(points={{-239,-70},{30,-70},
                {30,-90},{22,-90}}, color={0,0,127}));
        connect(XV112A_switch.y, TFPA_on.u) annotation (Line(points={{-239,-30},{-220,
                -30},{-220,30},{-202,30}}, color={0,0,127}));
        connect(XV112B_switch.y, TFPB_on.u) annotation (Line(points={{-239,-70},{-210,
                -70},{-210,-10},{-202,-10}}, color={0,0,127}));
        connect(TFPB_on.y, TFPB.on) annotation (Line(points={{-179,-10},{-64,-10},{-64,
                -24},{4,-24},{4,-7},{18,-7}}, color={255,0,255}));
        connect(TFPA_on.y, TFPA.on) annotation (Line(points={{-179,30},{-160,30},{-160,
                -7},{-42,-7}}, color={255,0,255}));
        connect(cons_cold.y, TFPA.TSet) annotation (Line(points={{-239,50},{-140,50},{
                -140,-13},{-42,-13}}, color={0,0,127}));
        connect(cons_cold.y, TFPB.TSet) annotation (Line(points={{-239,50},{-140,50},{
                -140,8},{8,8},{8,-13},{18,-13}}, color={0,0,127}));
        connect(limit_hot_max.y, conPID3.u_s)
          annotation (Line(points={{-239,210},{-222,210}}, color={0,0,127}));
        connect(TT511.T, fromKelvin.Kelvin) annotation (Line(points={{90,271},{90,300},
                {-320,300},{-320,252}},            color={0,0,127}));
        connect(fromKelvin.Celsius, conPID3.u_m) annotation (Line(points={{-320,229},{
                -320,190},{-210,190},{-210,198}},
                                       color={0,0,127}));
        connect(limit_hot_min.y, conPID1.u_s)
          annotation (Line(points={{-239,150},{-222,150}}, color={0,0,127}));
        connect(fromKelvin1.Celsius, conPID1.u_m) annotation (Line(points={{-239,120},
                {-210,120},{-210,138}}, color={0,0,127}));
        connect(TT521.T, fromKelvin1.Kelvin) annotation (Line(points={{-1,120},{-180,120},
                {-180,100},{-280,100},{-280,120},{-262,120}}, color={0,0,127}));
        connect(conPID3.y, min1.u1) annotation (Line(points={{-199,210},{-190,210},{-190,
                156},{-182,156}}, color={0,0,127}));
        connect(conPID1.y, min1.u2) annotation (Line(points={{-199,150},{-190,150},{-190,
                144},{-182,144}}, color={0,0,127}));
        connect(min1.y, CV522.y) annotation (Line(points={{-159,150},{-90,150},{-90,162},
                {-50,162}}, color={0,0,127}));
        connect(CV123_reg.y, FT_PID_123.u_s)
          annotation (Line(points={{161,-90},{178,-90}}, color={0,0,127}));
        connect(min1.y, opposite.u) annotation (Line(points={{-159,150},{-90,150},{-90,
                168},{-30,168},{-30,180},{-22,180}}, color={0,0,127}));
        connect(opposite.y, CV521.y) annotation (Line(points={{1,180},{32,180},{32,210},
                {22,210}}, color={0,0,127}));
        connect(PEM_TT200, max1.u1) annotation (Line(points={{-322,-160},{-268,-160},{
                -268,-244},{-262,-244}}, color={0,0,127}));
        connect(DEC_TT521, max1.u2) annotation (Line(points={{-320,-240},{-274,-240},{
                -274,-256},{-262,-256}}, color={0,0,127}));
        connect(limit_hot_min1.y, min2.u1) annotation (Line(points={{-239,-210},{-232,
                -210},{-232,-224},{-222,-224}}, color={0,0,127}));
        connect(max1.y, min2.u2) annotation (Line(points={{-239,-250},{-232,-250},{-232,
                -236},{-222,-236}}, color={0,0,127}));
        connect(conPID4.y, min3.u1) annotation (Line(points={{-159,-110},{-148,-110},{
                -148,-224},{-142,-224}}, color={0,0,127}));
        connect(conPID2.y, min3.u2) annotation (Line(points={{-159,-170},{-154,-170},{
                -154,-236},{-142,-236}}, color={0,0,127}));
        connect(min3.y, CV122.y) annotation (Line(points={{-119,-230},{-80,-230},{-80,
                -188},{-30,-188},{-30,-198}}, color={0,0,127}));
        connect(min3.y, opposite1.u) annotation (Line(points={{-119,-230},{-80,-230},{
                -80,-250},{-42,-250}}, color={0,0,127}));
        connect(opposite1.y, CV121.y) annotation (Line(points={{-19,-250},{26,-250},{26,
                -190},{38,-190}}, color={0,0,127}));
        connect(min2.y, conPID2.u_s) annotation (Line(points={{-199,-230},{-192,-230},
                {-192,-170},{-182,-170}}, color={0,0,127}));
        connect(TT121.T, fromKelvin2.Kelvin) annotation (Line(points={{70,-269},{70,-260},
                {-98,-260}}, color={0,0,127}));
        connect(fromKelvin2.Celsius, conPID2.u_m) annotation (Line(points={{-121,-260},
                {-170,-260},{-170,-182}}, color={0,0,127}));
        connect(fromKelvin.Celsius, conPID4.u_m) annotation (Line(points={{-320,229},{
                -320,-132},{-170,-132},{-170,-122}}, color={0,0,127}));
        connect(limit_hot_min2.y, conPID4.u_s)
          annotation (Line(points={{-239,-110},{-182,-110}}, color={0,0,127}));
        annotation (Diagram(coordinateSystem(extent={{-280,-280},{280,280}})), Icon(
              coordinateSystem(extent={{-280,-280},{280,280}}), graphics={Rectangle(
                extent={{-60,80},{60,-80}},
                lineColor={28,108,200},
                fillColor={238,46,47},
                fillPattern=FillPattern.Solid)}));
      end TFP_duo_test;

      model TFP_basic_duo_test

      parameter
          Buildings.Fluid.Chillers.Data.ElectricReformulatedEIR.ReformEIRChiller_Trane_RTHB_1051kW_5_05COP_Valve
          per;

        Fluid.Chillers.ElectricReformulatedEIR chi(
          redeclare package Medium1 = Buildings.Media.Water,
          redeclare package Medium2 = Buildings.Media.Water,
          m1_flow_nominal=211/3.6,
          m2_flow_nominal=166/3.6,
          dp1_nominal=18000,
          dp2_nominal=18000,
          per=per)
          annotation (Placement(transformation(extent={{-38,0},{-18,20}})));
        Fluid.Sources.MassFlowSource_T boundary(
          redeclare package Medium = Buildings.Media.Water,
          use_m_flow_in=true,
          m_flow=190/3.6,
          use_T_in=true,
          nPorts=1)
          annotation (Placement(transformation(extent={{160,-120},{140,-100}})));
        Fluid.Sources.Boundary_pT bou(redeclare package Medium =
              Buildings.Media.Water, nPorts=1)
          annotation (Placement(transformation(extent={{-124,-124},{-104,-104}})));
        Fluid.Sources.Boundary_pT bou1(redeclare package Medium =
              Buildings.Media.Water, nPorts=1)
          annotation (Placement(transformation(extent={{160,100},{140,120}})));
        Fluid.Sources.MassFlowSource_T boundary1(
          redeclare package Medium = Buildings.Media.Water,
          use_m_flow_in=true,
          m_flow=180/3.6,
          use_T_in=true,
          nPorts=1)
          annotation (Placement(transformation(extent={{-160,100},{-140,120}})));
        Modelica.Blocks.Sources.CombiTimeTable combiTimeTable(
          tableOnFile=true,
          tableName="tab1",
          fileName=ModelicaServices.ExternalReferences.loadResource(
              "modelica://Buildings/Data/tfp.txt"),
          columns={7,8,11,12,9,13,14})
          annotation (Placement(transformation(extent={{-200,40},{-180,60}})));
        Modelica.Blocks.Sources.RealExpression realExpression(y=4 + 273.15)
          annotation (Placement(transformation(extent={{-120,-10},{-100,10}})));
        Fluid.Sensors.TemperatureTwoPort Tcondent(redeclare package Medium =
              Buildings.Media.Water, m_flow_nominal=180/3.6)
          annotation (Placement(transformation(extent={{-120,100},{-100,120}})));
        Fluid.Sensors.TemperatureTwoPort Tevapsort(redeclare package Medium =
              Buildings.Media.Water, m_flow_nominal=190/3.6)
          annotation (Placement(transformation(extent={{-84,-124},{-64,-104}})));
        Fluid.Sensors.TemperatureTwoPort Tcondsort(redeclare package Medium =
              Buildings.Media.Water, m_flow_nominal=180/3.6)
          annotation (Placement(transformation(extent={{120,100},{100,120}})));
        Fluid.Sensors.TemperatureTwoPort Tevapent(redeclare package Medium =
              Buildings.Media.Water, m_flow_nominal=190/3.6)
          annotation (Placement(transformation(extent={{120,-120},{100,-100}})));
        Modelica.Thermal.HeatTransfer.Celsius.ToKelvin toKelvin
          annotation (Placement(transformation(extent={{-190,90},{-170,110}})));
        Modelica.Thermal.HeatTransfer.Celsius.ToKelvin toKelvin1
          annotation (Placement(transformation(extent={{190,-122},{170,-102}})));
        Modelica.Blocks.Interfaces.RealOutput P
          annotation (Placement(transformation(extent={{100,158},{120,178}})));
        Modelica.Blocks.Math.Gain gain(k=1/1000)
          annotation (Placement(transformation(extent={{60,140},{80,160}})));
        Modelica.Blocks.Sources.BooleanPulse booleanPulse(period=2244600)
          annotation (Placement(transformation(extent={{-120,20},{-100,40}})));
        Fluid.Chillers.ElectricReformulatedEIR chi1(
          redeclare package Medium1 = Buildings.Media.Water,
          redeclare package Medium2 = Buildings.Media.Water,
          m1_flow_nominal=211/3.6,
          m2_flow_nominal=166/3.6,
          dp1_nominal=18000,
          dp2_nominal=18000,
          per=per)
          annotation (Placement(transformation(extent={{20,0},{40,20}})));
        Fluid.FixedResistances.Junction jun(
          redeclare package Medium = Buildings.Media.Water,
          m_flow_nominal={190/3.6*2,-190/3.6,-190/3.6},
          dp_nominal={0,0,0}) annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=180,
              origin={50,-90})));
        Fluid.FixedResistances.Junction jun1(
          redeclare package Medium = Buildings.Media.Water,
          m_flow_nominal={190/3.6,190/3.6,-190/3.6*2},
          dp_nominal={0,0,0}) annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=180,
              origin={-50,-90})));
        Modelica.Blocks.Sources.BooleanPulse booleanPulse1(period=2244600,
            startTime=2244600/2)
          annotation (Placement(transformation(extent={{-40,60},{-20,80}})));
        Modelica.Blocks.Math.Gain gain1(k=1/1000)
          annotation (Placement(transformation(extent={{100,20},{120,40}})));
        Modelica.Blocks.Interfaces.RealOutput P1
          annotation (Placement(transformation(extent={{140,38},{160,58}})));
        Fluid.Sensors.TemperatureTwoPort Tcondint(redeclare package Medium =
              Buildings.Media.Water, m_flow_nominal=180/3.6)
          annotation (Placement(transformation(extent={{8,6},{-12,26}})));
        Fluid.Sensors.TemperatureTwoPort Tevapint1(redeclare package Medium =
              Buildings.Media.Water, m_flow_nominal=190/3.6)
          annotation (Placement(transformation(extent={{10,-10},{-10,10}},
              rotation=90,
              origin={8,-40})));
        Fluid.Sensors.TemperatureTwoPort Tevapint2(redeclare package Medium =
              Buildings.Media.Water, m_flow_nominal=190/3.6)
          annotation (Placement(transformation(extent={{10,-10},{-10,10}},
              rotation=90,
              origin={-50,-40})));
        Fluid.Actuators.Valves.TwoWayLinear val(
          redeclare package Medium = Buildings.Media.Water,
          m_flow_nominal=190/3.6,
          CvData=Buildings.Fluid.Types.CvTypes.OpPoint,
          Kv=150,
          dpValve_nominal=1000) annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=270,
              origin={-20,-76})));
        Modelica.Blocks.Sources.Ramp ramp(
          height=1,
          offset=0,
          startTime=2244600/2)
          annotation (Placement(transformation(extent={{140,-60},{120,-40}})));
      equation
        connect(combiTimeTable.y[1], boundary1.m_flow_in) annotation (Line(
              points={{-179,50},{-142,50},{-142,80},{-220,80},{-220,118},{-162,
                118}},                                          color={0,0,127}));
        connect(combiTimeTable.y[3], boundary.m_flow_in) annotation (Line(
              points={{-179,50},{-92,50},{-92,-140},{200,-140},{200,-102},{162,
                -102}},color={0,0,127}));
        connect(realExpression.y, chi.TSet) annotation (Line(points={{-99,0},{
                -62,0},{-62,7},{-40,7}}, color={0,0,127}));
        connect(Tevapent.port_a, boundary.ports[1])
          annotation (Line(points={{120,-110},{140,-110}},
                                                       color={0,127,255}));
        connect(bou.ports[1], Tevapsort.port_a)
          annotation (Line(points={{-104,-114},{-84,-114}},
                                                         color={0,127,255}));
        connect(Tcondent.port_a, boundary1.ports[1])
          annotation (Line(points={{-120,110},{-140,110}},
                                                       color={0,127,255}));
        connect(combiTimeTable.y[2], toKelvin.Celsius) annotation (Line(points={{-179,50},
                {-142,50},{-142,80},{-220,80},{-220,100},{-192,100}},
                                                           color={0,0,127}));
        connect(toKelvin.Kelvin, boundary1.T_in) annotation (Line(points={{-169,
                100},{-166,100},{-166,114},{-162,114}},
                                                    color={0,0,127}));
        connect(combiTimeTable.y[4], toKelvin1.Celsius) annotation (Line(points={{-179,50},
                {-142,50},{-142,-140},{200,-140},{200,-112},{192,-112}},
              color={0,0,127}));
        connect(toKelvin1.Kelvin, boundary.T_in) annotation (Line(points={{169,
                -112},{166,-112},{166,-106},{162,-106}},
                                                     color={0,0,127}));
        connect(chi.P, gain.u) annotation (Line(points={{-17,19},{-12,19},{-12,
                148},{24,148},{24,150},{58,150}},
              color={0,0,127}));
        connect(gain.y, P)
          annotation (Line(points={{81,150},{96,150},{96,168},{110,168}},
                                                      color={0,0,127}));
        connect(booleanPulse.y, chi.on) annotation (Line(points={{-99,30},{-62,
                30},{-62,13},{-40,13}}, color={255,0,255}));
        connect(Tcondsort.port_a, bou1.ports[1])
          annotation (Line(points={{120,110},{140,110}}, color={0,127,255}));
        connect(chi.port_a1, Tcondent.port_b) annotation (Line(points={{-38,16},
                {-50,16},{-50,110},{-100,110}}, color={0,127,255}));
        connect(chi1.port_b1, Tcondsort.port_b) annotation (Line(points={{40,16},
                {70,16},{70,110},{100,110}}, color={0,127,255}));
        connect(Tevapent.port_b, jun.port_1) annotation (Line(points={{100,-110},
                {80,-110},{80,-90},{60,-90}}, color={0,127,255}));
        connect(jun.port_3, chi1.port_a2) annotation (Line(points={{50,-80},{50,
                4},{40,4}}, color={0,127,255}));
        connect(jun.port_2, chi.port_a2) annotation (Line(points={{40,-90},{0,
                -90},{0,4},{-18,4}}, color={0,127,255}));
        connect(Tevapsort.port_b, jun1.port_2) annotation (Line(points={{-64,
                -114},{-64,-102},{-64,-90},{-60,-90}}, color={0,127,255}));
        connect(chi1.TSet, realExpression.y) annotation (Line(points={{18,7},{4,
                7},{4,-20},{-80,-20},{-80,0},{-99,0}}, color={0,0,127}));
        connect(booleanPulse1.y, chi1.on) annotation (Line(points={{-19,70},{0,
                70},{0,13},{18,13}}, color={255,0,255}));
        connect(gain1.y, P1) annotation (Line(points={{121,30},{136,30},{136,48},
                {150,48}}, color={0,0,127}));
        connect(chi1.P, gain1.u) annotation (Line(points={{41,19},{60,19},{60,
                30},{98,30}}, color={0,0,127}));
        connect(chi.port_b1, Tcondint.port_b)
          annotation (Line(points={{-18,16},{-12,16}}, color={0,127,255}));
        connect(Tcondint.port_a, chi1.port_a1)
          annotation (Line(points={{8,16},{20,16}}, color={0,127,255}));
        connect(Tevapint1.port_a, chi1.port_b2)
          annotation (Line(points={{8,-30},{8,4},{20,4}}, color={0,127,255}));
        connect(chi.port_b2, Tevapint2.port_a) annotation (Line(points={{-38,4},
                {-50,4},{-50,-30}}, color={0,127,255}));
        connect(Tevapint2.port_b, jun1.port_3)
          annotation (Line(points={{-50,-50},{-50,-80}}, color={0,127,255}));
        connect(jun1.port_1, val.port_b) annotation (Line(points={{-40,-90},{
                -20,-90},{-20,-86}}, color={0,127,255}));
        connect(val.port_a, Tevapint1.port_b) annotation (Line(points={{-20,-66},
                {-20,-60},{8,-60},{8,-50}}, color={0,127,255}));
        connect(ramp.y, val.y) annotation (Line(points={{119,-50},{56,-50},{56,
                -76},{-8,-76}}, color={0,0,127}));
        annotation (
          Icon(coordinateSystem(preserveAspectRatio=false)),
          Diagram(coordinateSystem(preserveAspectRatio=false)),
          experiment(
            StartTime=500000,
            StopTime=2244600,
            Interval=600,
            __Dymola_Algorithm="Dassl"));
      end TFP_basic_duo_test;
    end Tests;


    model TFP_duo
      extends Fluid.Interfaces.PartialEightPortInterface;

      parameter Modelica.SIunits.MassFlowRate m_flow_hot= 332*1000/3600;
      parameter Modelica.SIunits.MassFlowRate m_flow_cold= 211*1000/3600;
      parameter Real T_set_hot = 61;
      parameter Real T_set_hot_max = 63;
      parameter Real T_set_hot_min = 41;
      parameter Real T_set_cold_max = 14;
      parameter Real T_set_cold = 4;

      Fluid.FixedResistances.Junction jun(
        redeclare package Medium = Buildings.Media.Water,
        m_flow_nominal={m_flow_hot,-m_flow_hot,-m_flow_hot},
        dp_nominal={0,0,0})
        annotation (Placement(transformation(extent={{-10,-10},{10,10}},
            rotation=270,
            origin={10,250})));
      Fluid.Actuators.Valves.TwoWayLinear XV521(
        redeclare package Medium = Buildings.Media.Water,
        m_flow_nominal=m_flow_hot,
        CvData=Buildings.Fluid.Types.CvTypes.OpPoint,
        dpValve_nominal=10)
        annotation (Placement(transformation(extent={{-40,180},{-60,200}})));
      Fluid.Actuators.Valves.TwoWayLinear XV522(
        redeclare package Medium = Buildings.Media.Water,
        m_flow_nominal=m_flow_hot,
        CvData=Buildings.Fluid.Types.CvTypes.OpPoint,
        dpValve_nominal=10) annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={70,230})));
      Fluid.Actuators.Valves.TwoWayLinear CV522(
        redeclare package Medium = Buildings.Media.Water,
        m_flow_nominal=m_flow_hot,
        CvData=Buildings.Fluid.Types.CvTypes.OpPoint,
        dpValve_nominal=10)
        annotation (Placement(transformation(extent={{-60,140},{-40,160}})));
      Fluid.Actuators.Valves.TwoWayLinear CV521(
        redeclare package Medium = Buildings.Media.Water,
        m_flow_nominal=m_flow_hot,
        CvData=Buildings.Fluid.Types.CvTypes.OpPoint,
        dpValve_nominal=10) annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={10,210})));
      Fluid.Actuators.Valves.TwoWayLinear CV523(
        redeclare package Medium = Buildings.Media.Water,
        m_flow_nominal=m_flow_hot,
        CvData=Buildings.Fluid.Types.CvTypes.OpPoint,
        dpValve_nominal=10) annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={10,50})));
      Fluid.FixedResistances.Junction jun1(
        redeclare package Medium = Buildings.Media.Water,
        m_flow_nominal={m_flow_hot,-m_flow_hot,m_flow_hot},
        dp_nominal={0,0,0})
        annotation (Placement(transformation(extent={{-10,10},{10,-10}},
            rotation=270,
            origin={-110,190})));
      Fluid.FixedResistances.Junction jun2(
        redeclare package Medium = Buildings.Media.Water,
        m_flow_nominal={m_flow_hot,-m_flow_hot,m_flow_hot},
        dp_nominal={0,0,0})
        annotation (Placement(transformation(extent={{-10,-10},{10,10}},
            rotation=270,
            origin={10,150})));
      Fluid.FixedResistances.Junction jun3(
        redeclare package Medium = Buildings.Media.Water,
        m_flow_nominal={m_flow_hot,-m_flow_hot,-m_flow_hot},
        dp_nominal={0,0,0})
        annotation (Placement(transformation(extent={{-10,10},{10,-10}},
            rotation=90,
            origin={70,190})));
      Fluid.Chillers.ElectricReformulatedEIR TFPA(redeclare package Medium1 =
            Buildings.Media.Water, redeclare package Medium2 =
            Buildings.Media.Water,
        m1_flow_nominal=m_flow_hot,
        m2_flow_nominal=m_flow_cold/2,
        dp1_nominal=70000,
        dp2_nominal=70000,
        per=Buildings.Fluid.Chillers.Data.ElectricReformulatedEIR.ReformEIRChiller_Trane_RTHB_1051kW_5_05COP_Valve())
        annotation (Placement(transformation(extent={{-40,-20},{-20,0}})));
      Fluid.Chillers.ElectricReformulatedEIR TFPB(redeclare package Medium1 =
            Buildings.Media.Water, redeclare package Medium2 =
            Buildings.Media.Water,
        m1_flow_nominal=m_flow_hot,
        m2_flow_nominal=m_flow_cold/2,
        dp1_nominal=70000,
        dp2_nominal=70000,
        per=Buildings.Fluid.Chillers.Data.ElectricReformulatedEIR.ReformEIRChiller_Trane_RTHB_1051kW_5_05COP_Valve())
        annotation (Placement(transformation(extent={{20,-20},{40,0}})));
      Fluid.FixedResistances.Junction jun4(
        redeclare package Medium = Buildings.Media.Water,
        m_flow_nominal={100,-100,-100},
        dp_nominal={0,0,0})
        annotation (Placement(transformation(extent={{-10,10},{10,-10}},
            rotation=90,
            origin={50,-50})));
      Fluid.Actuators.Valves.TwoWayLinear XV112A(
        redeclare package Medium = Buildings.Media.Water,
        m_flow_nominal=100,
        CvData=Buildings.Fluid.Types.CvTypes.OpPoint,
        dpValve_nominal=10) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={-50,-90})));
      Fluid.Actuators.Valves.TwoWayLinear CV121(
        redeclare package Medium = Buildings.Media.Water,
        m_flow_nominal=100,
        CvData=Buildings.Fluid.Types.CvTypes.OpPoint,
        dpValve_nominal=10) annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={50,-190})));
      Fluid.Actuators.Valves.TwoWayLinear CV123(
        redeclare package Medium = Buildings.Media.Water,
        m_flow_nominal=100,
        CvData=Buildings.Fluid.Types.CvTypes.OpPoint,
        dpValve_nominal=10) annotation (Placement(
            transformation(
            extent={{-10,10},{10,-10}},
            rotation=90,
            origin={50,-90})));
      Fluid.FixedResistances.Junction jun5(
        redeclare package Medium = Buildings.Media.Water,
        m_flow_nominal={100,-100,-100},
        dp_nominal={0,0,0})
        annotation (Placement(transformation(extent={{-10,-10},{10,10}},
            rotation=90,
            origin={50,-230})));
      Fluid.FixedResistances.Junction jun6(
        redeclare package Medium = Buildings.Media.Water,
        m_flow_nominal={100,-100,100},
        dp_nominal={0,0,0})
        annotation (Placement(transformation(extent={{-10,10},{10,-10}},
            rotation=270,
            origin={-50,-130})));
      Fluid.Actuators.Valves.TwoWayLinear CV122(
        redeclare package Medium = Buildings.Media.Water,
        m_flow_nominal=100,
        CvData=Buildings.Fluid.Types.CvTypes.OpPoint,
        dpValve_nominal=10) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={-30,-210})));
      Fluid.Actuators.Valves.TwoWayLinear XV112B(
        redeclare package Medium = Buildings.Media.Water,
        m_flow_nominal=100,
        CvData=Buildings.Fluid.Types.CvTypes.OpPoint,
        dpValve_nominal=10) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={10,-90})));
      Fluid.FixedResistances.Junction jun7(
        redeclare package Medium = Buildings.Media.Water,
        m_flow_nominal={100,-100,100},
        dp_nominal={0,0,0})
        annotation (Placement(transformation(extent={{10,-10},{-10,10}},
            rotation=270,
            origin={50,-150})));
      Modelica.Blocks.Sources.Constant const(k=m_flow_cold/1000)
        annotation (Placement(transformation(extent={{160,120},{180,140}})));
      Fluid.Sensors.VolumeFlowRate FT521(redeclare package Medium =
            Buildings.Media.Water, m_flow_nominal=100) annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=-90,
            origin={10,90})));
      Controls.Continuous.LimPID FT_PID_521(k=1, Ti=1)
        annotation (Placement(transformation(extent={{200,120},{220,140}})));
      Controls.Continuous.LimPID FT_PID_123(k=1, Ti=1)
        annotation (Placement(transformation(extent={{180,-100},{200,-80}})));
      Fluid.Sensors.VolumeFlowRate FT121(redeclare package Medium =
            Buildings.Media.Water, m_flow_nominal=100) annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=-90,
            origin={50,-120})));
      Fluid.Sensors.TemperatureTwoPort TT121(redeclare package Medium =
            Buildings.Media.Water, m_flow_nominal=100)
        annotation (Placement(transformation(extent={{80,-290},{60,-270}})));
      Fluid.Sensors.TemperatureTwoPort TT111(redeclare package Medium =
            Buildings.Media.Water, m_flow_nominal=100)
        annotation (Placement(transformation(extent={{-60,-170},{-80,-150}})));
      Fluid.Sensors.TemperatureTwoPort TT511(redeclare package Medium =
            Buildings.Media.Water, m_flow_nominal=100)
        annotation (Placement(transformation(extent={{80,250},{100,270}})));
      Fluid.Sensors.TemperatureTwoPort TT521(redeclare package Medium =
            Buildings.Media.Water, m_flow_nominal=100) annotation (Placement(
            transformation(
            extent={{-10,10},{10,-10}},
            rotation=-90,
            origin={10,120})));
      Modelica.Blocks.Interfaces.IntegerInput mode
        annotation (Placement(transformation(extent={{-360,100},{-280,180}}),
            iconTransformation(extent={{-360,100},{-280,180}})));
      Modelica.Blocks.Sources.RealExpression XV521_switch(y=if mode == 1 then 1
             else 0)
        annotation (Placement(transformation(extent={{-260,260},{-240,280}})));
      Modelica.Blocks.Sources.RealExpression XV522_switch(y=if mode >= 2 then 1
             else 0)
        annotation (Placement(transformation(extent={{-260,240},{-240,260}})));
      Modelica.Blocks.Sources.RealExpression XV112A_switch(y=if mode >= 1 then 1
             else 0)
        annotation (Placement(transformation(extent={{-260,-40},{-240,-20}})));
      Modelica.Blocks.Sources.RealExpression XV112B_switch(y=if mode == 1 or mode ==
            3 then 1 else 0)
        annotation (Placement(transformation(extent={{-260,-80},{-240,-60}})));
      Modelica.Blocks.Sources.RealExpression limit_hot_max(y=T_set_hot_max)
        annotation (Placement(transformation(extent={{-260,200},{-240,220}})));
      Modelica.Blocks.Math.RealToBoolean TFPA_on(threshold=0.5)
        annotation (Placement(transformation(extent={{-200,20},{-180,40}})));
      Modelica.Blocks.Math.RealToBoolean TFPB_on
        annotation (Placement(transformation(extent={{-200,-20},{-180,0}})));
      Modelica.Blocks.Sources.RealExpression cons_cold(y=T_set_cold)
        annotation (Placement(transformation(extent={{-260,40},{-240,60}})));
      Controls.Continuous.LimPID conPID3(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=3,
        Ti=1,
        initType=Modelica.Blocks.Types.InitPID.NoInit) annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={-210,210})));
      Modelica.Thermal.HeatTransfer.Celsius.FromKelvin fromKelvin
        annotation (Placement(transformation(extent={{-10,-10},{10,10}},
            rotation=-90,
            origin={-320,240})));
      Modelica.Blocks.Sources.RealExpression limit_hot_min(y=T_set_hot_min)
        annotation (Placement(transformation(extent={{-260,140},{-240,160}})));
      Controls.Continuous.LimPID conPID1(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=3,
        Ti=1,
        initType=Modelica.Blocks.Types.InitPID.NoInit,
        reverseActing=false)                           annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={-210,150})));
      Modelica.Thermal.HeatTransfer.Celsius.FromKelvin fromKelvin1
        annotation (Placement(transformation(extent={{-260,110},{-240,130}})));
      Modelica.Blocks.Math.Min min1
        annotation (Placement(transformation(extent={{-180,140},{-160,160}})));
      Modelica.Blocks.Sources.RealExpression CV123_reg(y=if mode == 1 or mode == 3
             then 166 else 332)
        annotation (Placement(transformation(extent={{140,-100},{160,-80}})));
      Controls_a.opposite opposite
        annotation (Placement(transformation(extent={{-20,170},{0,190}})));
      Modelica.Blocks.Interfaces.RealInput DEC_TT521
        annotation (Placement(transformation(extent={{-360,-280},{-280,-200}}),
            iconTransformation(extent={{-360,-280},{-280,-200}})));
      Modelica.Blocks.Interfaces.RealInput PEM_TT200
        annotation (Placement(transformation(extent={{-362,-200},{-282,-120}}),
            iconTransformation(extent={{-362,-200},{-282,-120}})));
      Modelica.Blocks.Math.Max max1
        annotation (Placement(transformation(extent={{-260,-260},{-240,-240}})));
      Modelica.Blocks.Math.Min min2
        annotation (Placement(transformation(extent={{-220,-240},{-200,-220}})));
      Modelica.Blocks.Sources.RealExpression limit_hot_min1(y=T_set_cold_max)
        annotation (Placement(transformation(extent={{-260,-220},{-240,-200}})));
      Controls.Continuous.LimPID conPID2(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=3,
        Ti=1,
        initType=Modelica.Blocks.Types.InitPID.NoInit,
        reverseActing=false)                           annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={-170,-170})));
      Modelica.Blocks.Sources.RealExpression limit_hot_min2(y=T_set_hot)
        annotation (Placement(transformation(extent={{-260,-120},{-240,-100}})));
      Controls.Continuous.LimPID conPID4(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=3,
        Ti=1,
        initType=Modelica.Blocks.Types.InitPID.NoInit,
        reverseActing=false)                           annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={-170,-110})));
      Modelica.Blocks.Math.Min min3
        annotation (Placement(transformation(extent={{-140,-240},{-120,-220}})));
      Controls_a.opposite opposite1
        annotation (Placement(transformation(extent={{-40,-260},{-20,-240}})));
      Modelica.Thermal.HeatTransfer.Celsius.FromKelvin fromKelvin2
        annotation (Placement(transformation(extent={{-100,-270},{-120,-250}})));
    equation
      connect(port_a1, jun.port_1) annotation (Line(points={{-100,80},{-140,80},
              {-140,280},{10,280},{10,260}},
                                       color={238,46,47}));
      connect(jun.port_2, CV521.port_a)
        annotation (Line(points={{10,240},{10,220}}, color={238,46,47}));
      connect(CV521.port_b, jun2.port_1)
        annotation (Line(points={{10,200},{10,160}}, color={238,46,47}));
      connect(jun2.port_3, CV522.port_b)
        annotation (Line(points={{1.77636e-15,150},{-40,150}},
                                                     color={238,46,47}));
      connect(jun1.port_3, XV521.port_b)
        annotation (Line(points={{-100,190},{-60,190}}, color={238,46,47}));
      connect(jun.port_3, jun1.port_1) annotation (Line(points={{0,250},{-110,
              250},{-110,200}},
                          color={238,46,47}));
      connect(CV523.port_b, TFPA.port_a1) annotation (Line(points={{10,40},{10,20},{
              -60,20},{-60,-4},{-40,-4}}, color={238,46,47}));
      connect(TFPA.port_b1, TFPB.port_a1)
        annotation (Line(points={{-20,-4},{20,-4}}, color={238,46,47}));
      connect(port_b2, jun1.port_2) annotation (Line(points={{-100,30},{-110,30},
              {-110,180}},
                     color={238,46,47}));
      connect(jun4.port_2, TFPB.port_a2)
        annotation (Line(points={{50,-40},{50,-16},{40,-16}}, color={0,127,255}));
      connect(jun4.port_3, TFPA.port_a2) annotation (Line(points={{40,-50},{-10,-50},
              {-10,-16},{-20,-16}}, color={0,127,255}));
      connect(XV112A.port_a, TFPA.port_b2) annotation (Line(points={{-50,-80},{-50,-16},
              {-40,-16}}, color={0,127,255}));
      connect(XV112B.port_a, TFPB.port_b2)
        annotation (Line(points={{10,-80},{10,-16},{20,-16}}, color={0,127,255}));
      connect(XV112A.port_b, jun6.port_1)
        annotation (Line(points={{-50,-100},{-50,-120}}, color={0,127,255}));
      connect(jun6.port_3, XV112B.port_b) annotation (Line(points={{-40,-130},{
              10,-130},{10,-100}}, color={0,127,255}));
      connect(port_a2, CV522.port_a) annotation (Line(points={{100,30},{-72,30},{-72,
              150},{-60,150}},      color={238,46,47}));
      connect(jun4.port_1, CV123.port_b)
        annotation (Line(points={{50,-60},{50,-80}}, color={0,127,255}));
      connect(jun7.port_1, CV121.port_b)
        annotation (Line(points={{50,-160},{50,-180}}, color={0,127,255}));
      connect(port_a3, CV122.port_a) annotation (Line(points={{-100,-32},{-140,
              -32},{-140,-210},{-40,-210}}, color={0,127,255}));
      connect(CV122.port_b, jun7.port_3) annotation (Line(points={{-20,-210},{
              10,-210},{10,-150},{40,-150}}, color={0,127,255}));
      connect(TFPB.port_b1, jun3.port_1)
        annotation (Line(points={{40,-4},{70,-4},{70,180}}, color={238,46,47}));
      connect(jun3.port_3, XV521.port_a)
        annotation (Line(points={{60,190},{-40,190}}, color={238,46,47}));
      connect(jun3.port_2, XV522.port_a)
        annotation (Line(points={{70,200},{70,220}}, color={238,46,47}));
      connect(CV121.port_a, jun5.port_2)
        annotation (Line(points={{50,-200},{50,-220}}, color={0,127,255}));
      connect(jun5.port_3, port_b3) annotation (Line(points={{60,-230},{120,
              -230},{120,-30},{100,-30}}, color={0,127,255}));
      connect(FT521.port_b, CV523.port_a)
        annotation (Line(points={{10,80},{10,60}}, color={238,46,47}));
      connect(FT521.V_flow, FT_PID_521.u_m) annotation (Line(points={{21,90},{50,90},
              {50,100},{210,100},{210,118}}, color={0,0,127}));
      connect(const.y, FT_PID_521.u_s)
        annotation (Line(points={{181,130},{198,130}}, color={0,0,127}));
      connect(FT_PID_521.y, CV523.y) annotation (Line(points={{221,130},{240,130},{240,
              50},{22,50}}, color={0,0,127}));
      connect(CV123.port_a, FT121.port_a)
        annotation (Line(points={{50,-100},{50,-110}}, color={0,127,255}));
      connect(FT121.port_b, jun7.port_2)
        annotation (Line(points={{50,-130},{50,-140}}, color={0,127,255}));
      connect(FT121.V_flow, FT_PID_123.u_m) annotation (Line(points={{61,-120},{190,
              -120},{190,-102}}, color={0,0,127}));
      connect(FT_PID_123.y, CV123.y) annotation (Line(points={{201,-90},{220,-90},{220,
              -60},{80,-60},{80,-90},{62,-90}}, color={0,0,127}));
      connect(port_a4, TT121.port_a) annotation (Line(points={{100,-80},{100,
              -280},{80,-280}}, color={0,127,255}));
      connect(TT121.port_b, jun5.port_1) annotation (Line(points={{60,-280},{50,
              -280},{50,-240}}, color={0,127,255}));
      connect(jun6.port_2, TT111.port_a) annotation (Line(points={{-50,-140},{
              -50,-160},{-60,-160}}, color={0,127,255}));
      connect(TT111.port_b, port_b4) annotation (Line(points={{-80,-160},{-100,
              -160},{-100,-80}}, color={0,127,255}));
      connect(XV522.port_b, TT511.port_a) annotation (Line(points={{70,240},{70,
              260},{80,260}}, color={238,46,47}));
      connect(TT511.port_b, port_b1) annotation (Line(points={{100,260},{120,
              260},{120,80},{100,80}}, color={238,46,47}));
      connect(jun2.port_2, TT521.port_a)
        annotation (Line(points={{10,140},{10,130}}, color={238,46,47}));
      connect(TT521.port_b, FT521.port_a)
        annotation (Line(points={{10,110},{10,100}}, color={238,46,47}));
      connect(XV521_switch.y, XV521.y) annotation (Line(points={{-239,270},{-200,270},
              {-200,240},{-50,240},{-50,202}}, color={0,0,127}));
      connect(XV522_switch.y, XV522.y) annotation (Line(points={{-239,250},{-210,250},
              {-210,230},{58,230}}, color={0,0,127}));
      connect(XV112A_switch.y, XV112A.y) annotation (Line(points={{-239,-30},{-200,-30},
              {-200,-50},{-30,-50},{-30,-90},{-38,-90}}, color={0,0,127}));
      connect(XV112B_switch.y, XV112B.y) annotation (Line(points={{-239,-70},{30,-70},
              {30,-90},{22,-90}}, color={0,0,127}));
      connect(XV112A_switch.y, TFPA_on.u) annotation (Line(points={{-239,-30},{-220,
              -30},{-220,30},{-202,30}}, color={0,0,127}));
      connect(XV112B_switch.y, TFPB_on.u) annotation (Line(points={{-239,-70},{-210,
              -70},{-210,-10},{-202,-10}}, color={0,0,127}));
      connect(TFPB_on.y, TFPB.on) annotation (Line(points={{-179,-10},{-64,-10},{-64,
              -24},{4,-24},{4,-7},{18,-7}}, color={255,0,255}));
      connect(TFPA_on.y, TFPA.on) annotation (Line(points={{-179,30},{-160,30},{-160,
              -7},{-42,-7}}, color={255,0,255}));
      connect(cons_cold.y, TFPA.TSet) annotation (Line(points={{-239,50},{-140,50},{
              -140,-13},{-42,-13}}, color={0,0,127}));
      connect(cons_cold.y, TFPB.TSet) annotation (Line(points={{-239,50},{-140,50},{
              -140,8},{8,8},{8,-13},{18,-13}}, color={0,0,127}));
      connect(limit_hot_max.y, conPID3.u_s)
        annotation (Line(points={{-239,210},{-222,210}}, color={0,0,127}));
      connect(TT511.T, fromKelvin.Kelvin) annotation (Line(points={{90,271},{90,300},
              {-320,300},{-320,252}},            color={0,0,127}));
      connect(fromKelvin.Celsius, conPID3.u_m) annotation (Line(points={{-320,229},{
              -320,190},{-210,190},{-210,198}},
                                     color={0,0,127}));
      connect(limit_hot_min.y, conPID1.u_s)
        annotation (Line(points={{-239,150},{-222,150}}, color={0,0,127}));
      connect(fromKelvin1.Celsius, conPID1.u_m) annotation (Line(points={{-239,120},
              {-210,120},{-210,138}}, color={0,0,127}));
      connect(TT521.T, fromKelvin1.Kelvin) annotation (Line(points={{-1,120},{-180,120},
              {-180,100},{-280,100},{-280,120},{-262,120}}, color={0,0,127}));
      connect(conPID3.y, min1.u1) annotation (Line(points={{-199,210},{-190,210},{-190,
              156},{-182,156}}, color={0,0,127}));
      connect(conPID1.y, min1.u2) annotation (Line(points={{-199,150},{-190,150},{-190,
              144},{-182,144}}, color={0,0,127}));
      connect(min1.y, CV522.y) annotation (Line(points={{-159,150},{-90,150},{-90,162},
              {-50,162}}, color={0,0,127}));
      connect(CV123_reg.y, FT_PID_123.u_s)
        annotation (Line(points={{161,-90},{178,-90}}, color={0,0,127}));
      connect(min1.y, opposite.u) annotation (Line(points={{-159,150},{-90,150},{-90,
              168},{-30,168},{-30,180},{-22,180}}, color={0,0,127}));
      connect(opposite.y, CV521.y) annotation (Line(points={{1,180},{32,180},{32,210},
              {22,210}}, color={0,0,127}));
      connect(PEM_TT200, max1.u1) annotation (Line(points={{-322,-160},{-268,-160},{
              -268,-244},{-262,-244}}, color={0,0,127}));
      connect(DEC_TT521, max1.u2) annotation (Line(points={{-320,-240},{-274,-240},{
              -274,-256},{-262,-256}}, color={0,0,127}));
      connect(limit_hot_min1.y, min2.u1) annotation (Line(points={{-239,-210},{-232,
              -210},{-232,-224},{-222,-224}}, color={0,0,127}));
      connect(max1.y, min2.u2) annotation (Line(points={{-239,-250},{-232,-250},{-232,
              -236},{-222,-236}}, color={0,0,127}));
      connect(conPID4.y, min3.u1) annotation (Line(points={{-159,-110},{-148,-110},{
              -148,-224},{-142,-224}}, color={0,0,127}));
      connect(conPID2.y, min3.u2) annotation (Line(points={{-159,-170},{-154,-170},{
              -154,-236},{-142,-236}}, color={0,0,127}));
      connect(min3.y, CV122.y) annotation (Line(points={{-119,-230},{-80,-230},{-80,
              -188},{-30,-188},{-30,-198}}, color={0,0,127}));
      connect(min3.y, opposite1.u) annotation (Line(points={{-119,-230},{-80,-230},{
              -80,-250},{-42,-250}}, color={0,0,127}));
      connect(opposite1.y, CV121.y) annotation (Line(points={{-19,-250},{26,-250},{26,
              -190},{38,-190}}, color={0,0,127}));
      connect(min2.y, conPID2.u_s) annotation (Line(points={{-199,-230},{-192,-230},
              {-192,-170},{-182,-170}}, color={0,0,127}));
      connect(TT121.T, fromKelvin2.Kelvin) annotation (Line(points={{70,-269},{70,-260},
              {-98,-260}}, color={0,0,127}));
      connect(fromKelvin2.Celsius, conPID2.u_m) annotation (Line(points={{-121,-260},
              {-170,-260},{-170,-182}}, color={0,0,127}));
      connect(fromKelvin.Celsius, conPID4.u_m) annotation (Line(points={{-320,229},{
              -320,-132},{-170,-132},{-170,-122}}, color={0,0,127}));
      connect(limit_hot_min2.y, conPID4.u_s)
        annotation (Line(points={{-239,-110},{-182,-110}}, color={0,0,127}));
      annotation (Diagram(coordinateSystem(extent={{-280,-280},{280,280}})), Icon(
            coordinateSystem(extent={{-280,-280},{280,280}}), graphics={Rectangle(
              extent={{-60,80},{60,-80}},
              lineColor={28,108,200},
              fillColor={238,46,47},
              fillPattern=FillPattern.Solid)}));
    end TFP_duo;

    model syst_reg_chaud
      Fluid.Sources.MassFlowSource_T boundary(redeclare package Medium =
            Buildings.Media.Water,
        use_m_flow_in=true,
        m_flow=100,                nPorts=1)
        annotation (Placement(transformation(extent={{-20,140},{0,160}})));
      Fluid.FixedResistances.Junction jun(
        redeclare package Medium = Buildings.Media.Water,
        m_flow_nominal={100,-100,-100},
        dp_nominal={0,0,0})
        annotation (Placement(transformation(extent={{-10,-10},{10,10}},
            rotation=270,
            origin={30,110})));
      Fluid.Actuators.Valves.TwoWayLinear XV521(
        redeclare package Medium = Buildings.Media.Water,
        m_flow_nominal=100,
        CvData=Buildings.Fluid.Types.CvTypes.OpPoint,
        dpValve_nominal=10)
        annotation (Placement(transformation(extent={{-20,20},{-40,40}})));
      Fluid.Actuators.Valves.TwoWayLinear XV522(
        redeclare package Medium = Buildings.Media.Water,
        m_flow_nominal=100,
        CvData=Buildings.Fluid.Types.CvTypes.OpPoint,
        dpValve_nominal=10) annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={90,70})));
      Fluid.Actuators.Valves.TwoWayLinear CV522(
        redeclare package Medium = Buildings.Media.Water,
        m_flow_nominal=100,
        CvData=Buildings.Fluid.Types.CvTypes.OpPoint,
        dpValve_nominal=10)
        annotation (Placement(transformation(extent={{-40,-20},{-20,0}})));
      Fluid.Actuators.Valves.TwoWayLinear CV521(
        redeclare package Medium = Buildings.Media.Water,
        m_flow_nominal=100,
        CvData=Buildings.Fluid.Types.CvTypes.OpPoint,
        dpValve_nominal=10) annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={30,70})));
      Fluid.Actuators.Valves.TwoWayLinear CV523(
        redeclare package Medium = Buildings.Media.Water,
        m_flow_nominal=100,
        CvData=Buildings.Fluid.Types.CvTypes.OpPoint,
        dpValve_nominal=10) annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={30,-90})));
      Fluid.Sources.Boundary_pT bou(
        redeclare package Medium = Buildings.Media.Water,
        p=100000,                   nPorts=1)
        annotation (Placement(transformation(extent={{220,160},{200,180}})));
      Fluid.FixedResistances.Junction jun1(
        redeclare package Medium = Buildings.Media.Water,
        m_flow_nominal={100,100,-100},
        dp_nominal={0,0,0})
        annotation (Placement(transformation(extent={{-10,10},{10,-10}},
            rotation=270,
            origin={-90,30})));
      Fluid.FixedResistances.Junction jun2(
        redeclare package Medium = Buildings.Media.Water,
        m_flow_nominal={100,100,-100},
        dp_nominal={0,0,0})
        annotation (Placement(transformation(extent={{-10,-10},{10,10}},
            rotation=270,
            origin={30,-10})));
      Fluid.FixedResistances.Junction jun3(
        redeclare package Medium = Buildings.Media.Water,
        m_flow_nominal={-100,100,-100},
        dp_nominal={0,0,0})
        annotation (Placement(transformation(extent={{-10,-10},{10,10}},
            rotation=270,
            origin={90,30})));
      Controls.OBC.CDL.Conversions.BooleanToReal booToRea1 annotation (
          Placement(transformation(extent={{-160,160},{-140,180}})));
      Modelica.Blocks.Sources.RealExpression realExpression(y=1) annotation (
          Placement(transformation(extent={{-160,120},{-140,140}})));
      Modelica.Blocks.Math.Add add(k1=-1)
        annotation (Placement(transformation(extent={{-100,140},{-80,162}})));
      Modelica.Blocks.Sources.Constant const1(k=0)
        annotation (Placement(transformation(extent={{-220,0},{-200,20}})));
      Modelica.Blocks.Math.Add add1(k1=-1)
        annotation (Placement(transformation(extent={{-160,-20},{-140,2}})));
      Modelica.Blocks.Sources.RealExpression realExpression1(y=1)
        annotation (Placement(transformation(extent={{-220,-40},{-200,-20}})));
      Modelica.Blocks.Sources.Constant const2(k=1) annotation (Placement(
            transformation(extent={{-140,-80},{-120,-60}})));
      Modelica.Blocks.Sources.BooleanPulse booleanPulse(period=2000)
        annotation (Placement(transformation(extent={{-220,160},{-200,180}})));
      Modelica.Blocks.Math.Gain gain(k=100)
        annotation (Placement(transformation(extent={{-60,200},{-40,220}})));
    equation
      connect(boundary.ports[1], jun.port_1) annotation (Line(points={{0,150},{
              30,150},{30,120}},color={244,125,35}));
      connect(jun.port_2, CV521.port_a)
        annotation (Line(points={{30,100},{30,80}},      color={244,125,35}));
      connect(jun.port_3, jun1.port_1) annotation (Line(points={{20,110},{-90,
              110},{-90,40}},
                          color={244,125,35}));
      connect(CV521.port_b, jun2.port_1)
        annotation (Line(points={{30,60},{30,0}},       color={244,125,35}));
      connect(CV522.port_b, jun2.port_3)
        annotation (Line(points={{-20,-10},{20,-10}},  color={244,125,35}));
      connect(jun2.port_2, CV523.port_a)
        annotation (Line(points={{30,-20},{30,-80}},    color={244,125,35}));
      connect(CV523.port_b, jun3.port_2) annotation (Line(points={{30,-100},{30,
              -120},{90,-120},{90,20}},
                                   color={244,125,35}));
      connect(jun3.port_1, XV522.port_a)
        annotation (Line(points={{90,40},{90,60}},    color={244,125,35}));
      connect(XV522.port_b, bou.ports[1]) annotation (Line(points={{90,80},{90,
              170},{200,170}},
                         color={244,125,35}));
      connect(booToRea1.y, add.u1) annotation (Line(points={{-138,170},{-120,
              170},{-120,157.6},{-102,157.6}},
                                          color={0,0,127}));
      connect(realExpression.y, add.u2) annotation (Line(points={{-139,130},{
              -132,130},{-132,144.4},{-102,144.4}},
                                               color={0,0,127}));
      connect(add.y, XV521.y) annotation (Line(points={{-79,151},{-30,151},{-30,
              42}}, color={0,0,127}));
      connect(booToRea1.y, XV522.y) annotation (Line(points={{-138,170},{66,170},
              {66,70},{78,70}}, color={0,0,127}));
      connect(const1.y, add1.u1) annotation (Line(points={{-199,10},{-180,10},{
              -180,-2.4},{-162,-2.4}},  color={0,0,127}));
      connect(realExpression1.y, add1.u2) annotation (Line(points={{-199,-30},{
              -181.5,-30},{-181.5,-15.6},{-162,-15.6}},
                                                     color={0,0,127}));
      connect(add1.y, CV522.y) annotation (Line(points={{-139,-9},{-82,-9},{-82,
              10},{-30,10},{-30,2}},  color={0,0,127}));
      connect(const1.y, CV521.y) annotation (Line(points={{-199,10},{-120,10},{
              -120,88},{54,88},{54,70},{42,70}},    color={0,0,127}));
      connect(const2.y, CV523.y) annotation (Line(points={{-119,-70},{60,-70},{
              60,-90},{42,-90}},  color={0,0,127}));
      connect(booToRea1.y, gain.u) annotation (Line(points={{-138,170},{-72,170},
              {-72,210},{-62,210}}, color={0,0,127}));
      connect(gain.y, boundary.m_flow_in) annotation (Line(points={{-39,210},{
              -34,210},{-34,158},{-22,158}}, color={0,0,127}));
      connect(booleanPulse.y, booToRea1.u)
        annotation (Line(points={{-199,170},{-162,170}}, color={255,0,255}));
      connect(jun1.port_3, XV521.port_b)
        annotation (Line(points={{-80,30},{-40,30}}, color={0,127,255}));
      connect(XV521.port_a, jun3.port_3) annotation (Line(points={{-20,30},{80,
              30}},                 color={0,127,255}));
      connect(jun1.port_2, CV522.port_a) annotation (Line(points={{-90,20},{-90,
              -180},{-20,-180},{-20,-140},{-60,-140},{-60,-10},{-40,-10}},
            color={0,127,255}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-220,
                -240},{220,240}})),
                              Diagram(coordinateSystem(preserveAspectRatio=false,
              extent={{-220,-240},{220,240}})));
    end syst_reg_chaud;

    model syst_reg
      Fluid.Sources.MassFlowSource_T boundary(redeclare package Medium =
            Buildings.Media.Water,
        use_m_flow_in=true,
        m_flow=100,                nPorts=1)
        annotation (Placement(transformation(extent={{-360,140},{-340,160}})));
      Fluid.FixedResistances.Junction jun(
        redeclare package Medium = Buildings.Media.Water,
        m_flow_nominal={100,-100,-100},
        dp_nominal={0,0,0})
        annotation (Placement(transformation(extent={{-10,-10},{10,10}},
            rotation=270,
            origin={-310,110})));
      Fluid.Actuators.Valves.TwoWayLinear XV521(
        redeclare package Medium = Buildings.Media.Water,
        m_flow_nominal=100,
        CvData=Buildings.Fluid.Types.CvTypes.OpPoint,
        dpValve_nominal=10)
        annotation (Placement(transformation(extent={{-360,20},{-380,40}})));
      Fluid.Actuators.Valves.TwoWayLinear XV522(
        redeclare package Medium = Buildings.Media.Water,
        m_flow_nominal=100,
        CvData=Buildings.Fluid.Types.CvTypes.OpPoint,
        dpValve_nominal=10) annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-250,70})));
      Fluid.Actuators.Valves.TwoWayLinear CV522(
        redeclare package Medium = Buildings.Media.Water,
        m_flow_nominal=100,
        CvData=Buildings.Fluid.Types.CvTypes.OpPoint,
        dpValve_nominal=10)
        annotation (Placement(transformation(extent={{-380,-20},{-360,0}})));
      Fluid.Actuators.Valves.TwoWayLinear CV521(
        redeclare package Medium = Buildings.Media.Water,
        m_flow_nominal=100,
        CvData=Buildings.Fluid.Types.CvTypes.OpPoint,
        dpValve_nominal=10) annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={-310,70})));
      Fluid.Actuators.Valves.TwoWayLinear CV523(
        redeclare package Medium = Buildings.Media.Water,
        m_flow_nominal=100,
        CvData=Buildings.Fluid.Types.CvTypes.OpPoint,
        dpValve_nominal=10) annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={-310,-90})));
      Fluid.Sources.Boundary_pT bou(
        redeclare package Medium = Buildings.Media.Water,
        p=100000,                   nPorts=1)
        annotation (Placement(transformation(extent={{-120,160},{-140,180}})));
      Fluid.FixedResistances.Junction jun1(
        redeclare package Medium = Buildings.Media.Water,
        m_flow_nominal={100,100,-100},
        dp_nominal={0,0,0})
        annotation (Placement(transformation(extent={{-10,10},{10,-10}},
            rotation=270,
            origin={-430,30})));
      Fluid.FixedResistances.Junction jun2(
        redeclare package Medium = Buildings.Media.Water,
        m_flow_nominal={100,100,-100},
        dp_nominal={0,0,0})
        annotation (Placement(transformation(extent={{-10,-10},{10,10}},
            rotation=270,
            origin={-310,-10})));
      Fluid.FixedResistances.Junction jun3(
        redeclare package Medium = Buildings.Media.Water,
        m_flow_nominal={-100,100,-100},
        dp_nominal={0,0,0})
        annotation (Placement(transformation(extent={{-10,-10},{10,10}},
            rotation=270,
            origin={-250,30})));
      Controls.OBC.CDL.Conversions.BooleanToReal booToRea1 annotation (
          Placement(transformation(extent={{-500,160},{-480,180}})));
      Modelica.Blocks.Sources.RealExpression realExpression(y=1) annotation (
          Placement(transformation(extent={{-500,120},{-480,140}})));
      Modelica.Blocks.Math.Add add(k1=-1)
        annotation (Placement(transformation(extent={{-440,140},{-420,162}})));
      Modelica.Blocks.Sources.Constant const1(k=0)
        annotation (Placement(transformation(extent={{-560,0},{-540,20}})));
      Modelica.Blocks.Math.Add add1(k1=-1)
        annotation (Placement(transformation(extent={{-500,-20},{-480,2}})));
      Modelica.Blocks.Sources.RealExpression realExpression1(y=1)
        annotation (Placement(transformation(extent={{-560,-40},{-540,-20}})));
      Modelica.Blocks.Sources.Constant const2(k=1) annotation (Placement(
            transformation(extent={{-480,-80},{-460,-60}})));
      Modelica.Blocks.Sources.BooleanPulse booleanPulse(period=2000)
        annotation (Placement(transformation(extent={{-560,160},{-540,180}})));
      Modelica.Blocks.Math.Gain gain(k=100)
        annotation (Placement(transformation(extent={{-400,200},{-380,220}})));
      Fluid.Actuators.Valves.TwoWayLinear CV1(
        redeclare package Medium = Buildings.Media.Water,
        m_flow_nominal=100,
        CvData=Buildings.Fluid.Types.CvTypes.OpPoint,
        dpValve_nominal=10)
        annotation (Placement(transformation(extent={{-10,-10},{10,10}},
            rotation=-90,
            origin={50,110})));
    equation
      connect(boundary.ports[1], jun.port_1) annotation (Line(points={{-340,150},
              {-310,150},{-310,120}},
                                color={244,125,35}));
      connect(jun.port_2, CV521.port_a)
        annotation (Line(points={{-310,100},{-310,80}},  color={244,125,35}));
      connect(jun.port_3, jun1.port_1) annotation (Line(points={{-320,110},{
              -430,110},{-430,40}},
                          color={244,125,35}));
      connect(CV521.port_b, jun2.port_1)
        annotation (Line(points={{-310,60},{-310,0}},   color={244,125,35}));
      connect(CV522.port_b, jun2.port_3)
        annotation (Line(points={{-360,-10},{-320,-10}},
                                                       color={244,125,35}));
      connect(jun2.port_2, CV523.port_a)
        annotation (Line(points={{-310,-20},{-310,-80}},color={244,125,35}));
      connect(CV523.port_b, jun3.port_2) annotation (Line(points={{-310,-100},{
              -310,-120},{-250,-120},{-250,20}},
                                   color={244,125,35}));
      connect(jun3.port_1, XV522.port_a)
        annotation (Line(points={{-250,40},{-250,60}},color={244,125,35}));
      connect(XV522.port_b, bou.ports[1]) annotation (Line(points={{-250,80},{
              -250,170},{-140,170}},
                         color={244,125,35}));
      connect(booToRea1.y, add.u1) annotation (Line(points={{-478,170},{-460,
              170},{-460,157.6},{-442,157.6}},
                                          color={0,0,127}));
      connect(realExpression.y, add.u2) annotation (Line(points={{-479,130},{
              -472,130},{-472,144.4},{-442,144.4}},
                                               color={0,0,127}));
      connect(add.y, XV521.y) annotation (Line(points={{-419,151},{-370,151},{
              -370,42}},
                    color={0,0,127}));
      connect(booToRea1.y, XV522.y) annotation (Line(points={{-478,170},{-274,
              170},{-274,70},{-262,70}},
                                color={0,0,127}));
      connect(const1.y, add1.u1) annotation (Line(points={{-539,10},{-520,10},{
              -520,-2.4},{-502,-2.4}},  color={0,0,127}));
      connect(realExpression1.y, add1.u2) annotation (Line(points={{-539,-30},{
              -521.5,-30},{-521.5,-15.6},{-502,-15.6}},
                                                     color={0,0,127}));
      connect(add1.y, CV522.y) annotation (Line(points={{-479,-9},{-422,-9},{
              -422,10},{-370,10},{-370,2}},
                                      color={0,0,127}));
      connect(const1.y, CV521.y) annotation (Line(points={{-539,10},{-460,10},{
              -460,88},{-286,88},{-286,70},{-298,70}},
                                                    color={0,0,127}));
      connect(const2.y, CV523.y) annotation (Line(points={{-459,-70},{-280,-70},
              {-280,-90},{-298,-90}},
                                  color={0,0,127}));
      connect(booToRea1.y, gain.u) annotation (Line(points={{-478,170},{-412,
              170},{-412,210},{-402,210}},
                                    color={0,0,127}));
      connect(gain.y, boundary.m_flow_in) annotation (Line(points={{-379,210},{
              -374,210},{-374,158},{-362,158}},
                                             color={0,0,127}));
      connect(booleanPulse.y, booToRea1.u)
        annotation (Line(points={{-539,170},{-502,170}}, color={255,0,255}));
      connect(jun1.port_3, XV521.port_b)
        annotation (Line(points={{-420,30},{-380,30}},
                                                     color={0,127,255}));
      connect(XV521.port_a, jun3.port_3) annotation (Line(points={{-360,30},{
              -260,30}},            color={0,127,255}));
      connect(jun1.port_2, CV522.port_a) annotation (Line(points={{-430,20},{
              -430,-180},{-360,-180},{-360,-140},{-402,-140},{-402,-10},{-380,
              -10}}, color={0,127,255}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-580,
                -240},{580,240}})),
                              Diagram(coordinateSystem(preserveAspectRatio=false,
              extent={{-580,-240},{580,240}})));
    end syst_reg;

    model syst_reg_froid



      Fluid.Sources.MassFlowSource_T boundary(redeclare package Medium =
            Buildings.Media.Water,
        use_m_flow_in=true,
        m_flow=100,
        nPorts=1)
        annotation (Placement(transformation(extent={{-20,140},{0,160}})));
      Fluid.FixedResistances.Junction jun(
        redeclare package Medium = Buildings.Media.Water,
        m_flow_nominal={100,-100,-100},
        dp_nominal={0,0,0})
        annotation (Placement(transformation(extent={{-10,10},{10,-10}},
            rotation=270,
            origin={30,90})));
      Fluid.Actuators.Valves.TwoWayLinear XV112A(
        redeclare package Medium = Buildings.Media.Water,
        m_flow_nominal=100,
        CvData=Buildings.Fluid.Types.CvTypes.OpPoint,
        dpValve_nominal=10) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={90,-70})));
      Fluid.Actuators.Valves.TwoWayLinear CV121(
        redeclare package Medium = Buildings.Media.Water,
        m_flow_nominal=100,
        CvData=Buildings.Fluid.Types.CvTypes.OpPoint,
        dpValve_nominal=10) annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={30,50})));
      Fluid.Actuators.Valves.TwoWayLinear CV123(
        redeclare package Medium = Buildings.Media.Water,
        m_flow_nominal=100,
        CvData=Buildings.Fluid.Types.CvTypes.OpPoint,
        dpValve_nominal=10) annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={30,-30})));
      Fluid.Sources.Boundary_pT bou(
        redeclare package Medium = Buildings.Media.Water,
        p=100000,
        nPorts=1)
        annotation (Placement(transformation(extent={{220,160},{200,180}})));
      Fluid.FixedResistances.Junction jun1(
        redeclare package Medium = Buildings.Media.Water,
        m_flow_nominal={100,100,-100},
        dp_nominal={0,0,0})
        annotation (Placement(transformation(extent={{-10,10},{10,-10}},
            rotation=270,
            origin={30,20})));
      Fluid.FixedResistances.Junction jun2(
        redeclare package Medium = Buildings.Media.Water,
        m_flow_nominal={100,-100,-100},
        dp_nominal={0,0,0})
        annotation (Placement(transformation(extent={{-10,10},{10,-10}},
            rotation=270,
            origin={30,-90})));
      Controls.OBC.CDL.Conversions.BooleanToReal booToRea1 annotation (
          Placement(transformation(extent={{-160,160},{-140,180}})));
      Modelica.Blocks.Sources.Constant const1(k=0)
        annotation (Placement(transformation(extent={{260,60},{240,80}})));
      Modelica.Blocks.Math.Add add1(k1=-1)
        annotation (Placement(transformation(extent={{220,38},{200,60}})));
      Modelica.Blocks.Sources.RealExpression realExpression1(y=1)
        annotation (Placement(transformation(extent={{260,20},{240,40}})));
      Modelica.Blocks.Math.Gain gain(k=100)
        annotation (Placement(transformation(extent={{-60,200},{-40,220}})));
      Fluid.Actuators.Valves.TwoWayLinear CV122(
        redeclare package Medium = Buildings.Media.Water,
        m_flow_nominal=100,
        CvData=Buildings.Fluid.Types.CvTypes.OpPoint,
        dpValve_nominal=10) annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=0,
            origin={90,20})));
      Fluid.Actuators.Valves.TwoWayLinear XV112B(
        redeclare package Medium = Buildings.Media.Water,
        m_flow_nominal=100,
        CvData=Buildings.Fluid.Types.CvTypes.OpPoint,
        dpValve_nominal=10) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={150,-70})));
      Fluid.FixedResistances.Junction jun4(
        redeclare package Medium = Buildings.Media.Water,
        m_flow_nominal={100,100,-100},
        dp_nominal={0,0,0})
        annotation (Placement(transformation(extent={{10,10},{-10,-10}},
            rotation=180,
            origin={150,-30})));
      Modelica.Blocks.Sources.BooleanExpression booleanExpression(y=true)
        annotation (Placement(transformation(extent={{-220,160},{-200,180}})));
    equation
      connect(booToRea1.y, gain.u) annotation (Line(points={{-138,170},{-72,170},
              {-72,210},{-62,210}}, color={0,0,127}));
      connect(gain.y, boundary.m_flow_in) annotation (Line(points={{-39,210},{
              -34,210},{-34,158},{-22,158}}, color={0,0,127}));
      connect(jun1.port_2, CV123.port_a)
        annotation (Line(points={{30,10},{30,-20}}, color={0,127,255}));
      connect(jun1.port_3, CV122.port_b)
        annotation (Line(points={{40,20},{80,20}}, color={0,127,255}));
      connect(jun.port_3, CV122.port_a) annotation (Line(points={{40,90},{140,90},{140,
              20},{100,20}},          color={0,127,255}));
      connect(jun.port_2, CV121.port_a)
        annotation (Line(points={{30,80},{30,60}}, color={0,127,255}));
      connect(CV121.port_b, jun1.port_1)
        annotation (Line(points={{30,40},{30,30}}, color={0,127,255}));
      connect(boundary.ports[1], jun.port_1)
        annotation (Line(points={{0,150},{30,150},{30,100}}, color={0,127,255}));
      connect(jun2.port_1, CV123.port_b)
        annotation (Line(points={{30,-80},{30,-40}}, color={0,127,255}));
      connect(jun2.port_2, XV112B.port_a) annotation (Line(points={{30,-100},{30,-120},
              {150,-120},{150,-80}}, color={0,127,255}));
      connect(jun2.port_3, XV112A.port_a)
        annotation (Line(points={{40,-90},{90,-90},{90,-80}}, color={0,127,255}));
      connect(XV112A.port_b, jun4.port_1)
        annotation (Line(points={{90,-60},{90,-30},{140,-30}}, color={0,127,255}));
      connect(jun4.port_3, XV112B.port_b)
        annotation (Line(points={{150,-40},{150,-60}}, color={0,127,255}));
      connect(jun4.port_2, bou.ports[1]) annotation (Line(points={{160,-30},{180,-30},
              {180,170},{200,170}}, color={0,127,255}));
      connect(add1.u1, const1.y) annotation (Line(points={{222,55.6},{231,55.6},{231,
              70},{239,70}}, color={0,0,127}));
      connect(add1.u2, realExpression1.y) annotation (Line(points={{222,42.4},{231,42.4},
              {231,30},{239,30}}, color={0,0,127}));
      connect(add1.y, CV122.y)
        annotation (Line(points={{199,49},{90,49},{90,32}}, color={0,0,127}));
      connect(const1.y, CV121.y) annotation (Line(points={{239,70},{60,70},{60,50},{
              42,50}}, color={0,0,127}));
      connect(booToRea1.y, XV112A.y) annotation (Line(points={{-138,170},{-100,170},
              {-100,-70},{78,-70}}, color={0,0,127}));
      connect(booToRea1.y, XV112B.y) annotation (Line(points={{-138,170},{-100,170},
              {-100,-50},{120,-50},{120,-70},{138,-70}}, color={0,0,127}));
      connect(booToRea1.y, CV123.y) annotation (Line(points={{-138,170},{-100,170},{
              -100,-50},{60,-50},{60,-30},{42,-30}}, color={0,0,127}));
      connect(booleanExpression.y, booToRea1.u)
        annotation (Line(points={{-199,170},{-162,170}}, color={255,0,255}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-220,
                -240},{220,240}})),
                              Diagram(coordinateSystem(preserveAspectRatio=false,
              extent={{-220,-240},{220,240}})));
    end syst_reg_froid;

    package calibration
      model TFP_basic

      parameter
          Buildings.Fluid.Chillers.Data.ElectricReformulatedEIR.ReformEIRChiller_Trane_RTHB_1051kW_5_05COP_Valve
          per;

        Fluid.Chillers.ElectricReformulatedEIR chi(
          redeclare package Medium1 = Buildings.Media.Water,
          redeclare package Medium2 = Buildings.Media.Water,
          m1_flow_nominal=211/3.6,
          m2_flow_nominal=166/3.6,
          dp1_nominal=18000,
          dp2_nominal=18000,
          per=per)
          annotation (Placement(transformation(extent={{-20,0},{0,20}})));
        Fluid.Sources.MassFlowSource_T boundary(
          redeclare package Medium = Buildings.Media.Water,
          use_m_flow_in=true,
          m_flow=190/3.6,
          use_T_in=true,
          nPorts=1)
          annotation (Placement(transformation(extent={{100,-80},{80,-60}})));
        Fluid.Sources.Boundary_pT bou(redeclare package Medium =
              Buildings.Media.Water, nPorts=1)
          annotation (Placement(transformation(extent={{-100,-80},{-80,-60}})));
        Fluid.Sources.Boundary_pT bou1(redeclare package Medium =
              Buildings.Media.Water, nPorts=1)
          annotation (Placement(transformation(extent={{100,60},{80,80}})));
        Fluid.Sources.MassFlowSource_T boundary1(
          redeclare package Medium = Buildings.Media.Water,
          use_m_flow_in=true,
          m_flow=180/3.6,
          use_T_in=true,
          nPorts=1)
          annotation (Placement(transformation(extent={{-100,60},{-80,80}})));
        Modelica.Blocks.Sources.CombiTimeTable combiTimeTable(
          tableOnFile=true,
          tableName="tab1",
          fileName=ModelicaServices.ExternalReferences.loadResource(
              "modelica://Buildings/Data/tfp.txt"),
          columns={7,8,11,12,9,13,14})
          annotation (Placement(transformation(extent={{-200,40},{-180,60}})));
        Modelica.Blocks.Sources.RealExpression realExpression(y=4 + 273.15)
          annotation (Placement(transformation(extent={{-120,-10},{-100,10}})));
        Fluid.Sensors.TemperatureTwoPort Tcondent(redeclare package Medium =
              Buildings.Media.Water, m_flow_nominal=180/3.6)
          annotation (Placement(transformation(extent={{-60,60},{-40,80}})));
        Fluid.Sensors.TemperatureTwoPort Tevapsort(redeclare package Medium =
              Buildings.Media.Water, m_flow_nominal=190/3.6)
          annotation (Placement(transformation(extent={{-60,-80},{-40,-60}})));
        Fluid.Sensors.TemperatureTwoPort Tcondsort(redeclare package Medium =
              Buildings.Media.Water, m_flow_nominal=180/3.6)
          annotation (Placement(transformation(extent={{60,60},{40,80}})));
        Fluid.Sensors.TemperatureTwoPort Tevapent(redeclare package Medium =
              Buildings.Media.Water, m_flow_nominal=190/3.6)
          annotation (Placement(transformation(extent={{60,-80},{40,-60}})));
        Modelica.Thermal.HeatTransfer.Celsius.ToKelvin toKelvin
          annotation (Placement(transformation(extent={{-130,50},{-110,70}})));
        Modelica.Thermal.HeatTransfer.Celsius.ToKelvin toKelvin1
          annotation (Placement(transformation(extent={{130,-82},{110,-62}})));
        Modelica.Blocks.Interfaces.RealOutput P
          annotation (Placement(transformation(extent={{100,0},{120,20}})));
        Modelica.Blocks.Math.Gain gain(k=1/1000)
          annotation (Placement(transformation(extent={{60,0},{80,20}})));
        Modelica.Blocks.Sources.BooleanPulse booleanPulse(period=2244600)
          annotation (Placement(transformation(extent={{-120,20},{-100,40}})));
      equation
        connect(combiTimeTable.y[1], boundary1.m_flow_in) annotation (Line(
              points={{-179,50},{-142,50},{-142,78},{-102,78}}, color={0,0,127}));
        connect(combiTimeTable.y[3], boundary.m_flow_in) annotation (Line(
              points={{-179,50},{-160,50},{-160,-100},{140,-100},{140,-62},{102,
                -62}}, color={0,0,127}));
        connect(realExpression.y, chi.TSet) annotation (Line(points={{-99,0},{
                -62,0},{-62,7},{-22,7}}, color={0,0,127}));
        connect(Tevapent.port_a, boundary.ports[1])
          annotation (Line(points={{60,-70},{80,-70}}, color={0,127,255}));
        connect(Tevapent.port_b, chi.port_a2) annotation (Line(points={{40,-70},
                {20,-70},{20,4},{0,4}}, color={0,127,255}));
        connect(bou.ports[1], Tevapsort.port_a)
          annotation (Line(points={{-80,-70},{-60,-70}}, color={0,127,255}));
        connect(Tevapsort.port_b, chi.port_b2) annotation (Line(points={{-40,
                -70},{-30,-70},{-30,4},{-20,4}}, color={0,127,255}));
        connect(Tcondsort.port_b, chi.port_b1) annotation (Line(points={{40,70},
                {22,70},{22,16},{0,16}}, color={0,127,255}));
        connect(Tcondsort.port_a, bou1.ports[1])
          annotation (Line(points={{60,70},{80,70}}, color={0,127,255}));
        connect(Tcondent.port_b, chi.port_a1) annotation (Line(points={{-40,70},
                {-30,70},{-30,16},{-20,16}}, color={0,127,255}));
        connect(Tcondent.port_a, boundary1.ports[1])
          annotation (Line(points={{-60,70},{-80,70}}, color={0,127,255}));
        connect(combiTimeTable.y[2], toKelvin.Celsius) annotation (Line(points=
                {{-179,50},{-142,50},{-142,60},{-132,60}}, color={0,0,127}));
        connect(toKelvin.Kelvin, boundary1.T_in) annotation (Line(points={{-109,
                60},{-106,60},{-106,74},{-102,74}}, color={0,0,127}));
        connect(combiTimeTable.y[4], toKelvin1.Celsius) annotation (Line(points=
               {{-179,50},{-160,50},{-160,-100},{140,-100},{140,-72},{132,-72}},
              color={0,0,127}));
        connect(toKelvin1.Kelvin, boundary.T_in) annotation (Line(points={{109,
                -72},{106,-72},{106,-66},{102,-66}}, color={0,0,127}));
        connect(chi.P, gain.u) annotation (Line(points={{1,19},{40,19},{40,10},{58,10}},
              color={0,0,127}));
        connect(gain.y, P)
          annotation (Line(points={{81,10},{110,10}}, color={0,0,127}));
        connect(booleanPulse.y, chi.on) annotation (Line(points={{-99,30},{-62,
                30},{-62,13},{-22,13}}, color={255,0,255}));
        annotation (
          Icon(coordinateSystem(preserveAspectRatio=false)),
          Diagram(coordinateSystem(preserveAspectRatio=false)),
          experiment(
            StopTime=2244600,
            Interval=600,
            __Dymola_Algorithm="Dassl"));
      end TFP_basic;

      model TFP_basic_cal

        Fluid.Chillers.ElectricReformulatedEIR chi(
          redeclare package Medium1 = Buildings.Media.Water,
          redeclare package Medium2 = Buildings.Media.Water,
          m1_flow_nominal=211/3.6,
          m2_flow_nominal=166/3.6,
          dp1_nominal=18000,
          dp2_nominal=18000,
          per=Buildings.Fluid.Chillers.Data.ElectricReformulatedEIR.ReformEIRChiller_Trane_RTHB_1051kW_5_05COP_Valve())
          annotation (Placement(transformation(extent={{-20,0},{0,20}})));
        Fluid.Sources.MassFlowSource_T boundary(
          redeclare package Medium = Buildings.Media.Water,
          use_m_flow_in=true,
          m_flow=190/3.6,
          use_T_in=true,
          nPorts=1)
          annotation (Placement(transformation(extent={{100,-80},{80,-60}})));
        Fluid.Sources.Boundary_pT bou(redeclare package Medium =
              Buildings.Media.Water, nPorts=1)
          annotation (Placement(transformation(extent={{-100,-80},{-80,-60}})));
        Fluid.Sources.Boundary_pT bou1(redeclare package Medium =
              Buildings.Media.Water, nPorts=1)
          annotation (Placement(transformation(extent={{100,60},{80,80}})));
        Fluid.Sources.MassFlowSource_T boundary1(
          redeclare package Medium = Buildings.Media.Water,
          use_m_flow_in=true,
          m_flow=180/3.6,
          use_T_in=true,
          nPorts=1)
          annotation (Placement(transformation(extent={{-100,60},{-80,80}})));
        Modelica.Blocks.Sources.CombiTimeTable combiTimeTable(
          tableOnFile=true,
          tableName="tab1",
          fileName=ModelicaServices.ExternalReferences.loadResource(
              "modelica://Buildings/Data/tfp.txt"),
          columns={7,8,11,12,9,13,14})
          annotation (Placement(transformation(extent={{-200,40},{-180,60}})));
        Modelica.Blocks.Sources.RealExpression realExpression(y=4 + 273.15)
          annotation (Placement(transformation(extent={{-120,-10},{-100,10}})));
        Modelica.Blocks.Sources.BooleanExpression booleanExpression(y=true)
          annotation (Placement(transformation(extent={{-120,10},{-100,30}})));
        Fluid.Sensors.TemperatureTwoPort Tcondent(redeclare package Medium =
              Buildings.Media.Water, m_flow_nominal=180/3.6)
          annotation (Placement(transformation(extent={{-60,60},{-40,80}})));
        Fluid.Sensors.TemperatureTwoPort Tevapsort(redeclare package Medium =
              Buildings.Media.Water, m_flow_nominal=190/3.6)
          annotation (Placement(transformation(extent={{-60,-80},{-40,-60}})));
        Fluid.Sensors.TemperatureTwoPort Tcondsort(redeclare package Medium =
              Buildings.Media.Water, m_flow_nominal=180/3.6)
          annotation (Placement(transformation(extent={{60,60},{40,80}})));
        Fluid.Sensors.TemperatureTwoPort Tevapent(redeclare package Medium =
              Buildings.Media.Water, m_flow_nominal=190/3.6)
          annotation (Placement(transformation(extent={{60,-80},{40,-60}})));
        Modelica.Thermal.HeatTransfer.Celsius.ToKelvin toKelvin
          annotation (Placement(transformation(extent={{-130,50},{-110,70}})));
        Modelica.Thermal.HeatTransfer.Celsius.ToKelvin toKelvin1
          annotation (Placement(transformation(extent={{130,-82},{110,-62}})));
      equation
        connect(combiTimeTable.y[1], boundary1.m_flow_in) annotation (Line(
              points={{-179,50},{-142,50},{-142,78},{-102,78}}, color={0,0,127}));
        connect(combiTimeTable.y[3], boundary.m_flow_in) annotation (Line(
              points={{-179,50},{-160,50},{-160,-100},{140,-100},{140,-62},{102,
                -62}}, color={0,0,127}));
        connect(booleanExpression.y, chi.on) annotation (Line(points={{-99,20},
                {-60,20},{-60,13},{-22,13}}, color={255,0,255}));
        connect(realExpression.y, chi.TSet) annotation (Line(points={{-99,0},{
                -62,0},{-62,7},{-22,7}}, color={0,0,127}));
        connect(Tevapent.port_a, boundary.ports[1])
          annotation (Line(points={{60,-70},{80,-70}}, color={0,127,255}));
        connect(Tevapent.port_b, chi.port_a2) annotation (Line(points={{40,-70},
                {20,-70},{20,4},{0,4}}, color={0,127,255}));
        connect(bou.ports[1], Tevapsort.port_a)
          annotation (Line(points={{-80,-70},{-60,-70}}, color={0,127,255}));
        connect(Tevapsort.port_b, chi.port_b2) annotation (Line(points={{-40,
                -70},{-30,-70},{-30,4},{-20,4}}, color={0,127,255}));
        connect(Tcondsort.port_b, chi.port_b1) annotation (Line(points={{40,70},{20,70},
                {20,16},{0,16}},         color={0,127,255}));
        connect(Tcondsort.port_a, bou1.ports[1])
          annotation (Line(points={{60,70},{80,70}}, color={0,127,255}));
        connect(Tcondent.port_b, chi.port_a1) annotation (Line(points={{-40,70},
                {-30,70},{-30,16},{-20,16}}, color={0,127,255}));
        connect(Tcondent.port_a, boundary1.ports[1])
          annotation (Line(points={{-60,70},{-80,70}}, color={0,127,255}));
        connect(combiTimeTable.y[2], toKelvin.Celsius) annotation (Line(points=
                {{-179,50},{-142,50},{-142,60},{-132,60}}, color={0,0,127}));
        connect(toKelvin.Kelvin, boundary1.T_in) annotation (Line(points={{-109,
                60},{-106,60},{-106,74},{-102,74}}, color={0,0,127}));
        connect(combiTimeTable.y[4], toKelvin1.Celsius) annotation (Line(points=
               {{-179,50},{-160,50},{-160,-100},{140,-100},{140,-72},{132,-72}},
              color={0,0,127}));
        connect(toKelvin1.Kelvin, boundary.T_in) annotation (Line(points={{109,
                -72},{106,-72},{106,-66},{102,-66}}, color={0,0,127}));
        annotation (
          Icon(coordinateSystem(preserveAspectRatio=false)),
          Diagram(coordinateSystem(preserveAspectRatio=false)),
          experiment(
            StopTime=2244600,
            Interval=600,
            __Dymola_Algorithm="Dassl"));
      end TFP_basic_cal;

    end calibration;
  end TFP;

    package RJC
    extends Modelica.Icons.VariantsPackage;

      model Heat_exchanger

      extends Fluid.Interfaces.PartialFourPort
      annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)));

        Fluid.HeatExchangers.PlateHeatExchangerEffectivenessNTU RJC(
          redeclare package Medium1 =
              Buildings.Applications.DHC_Marseille.Media.Sea_Water,
          redeclare package Medium2 = Buildings.Media.Water,
        m1_flow_nominal=1020*864.9/3600,
        m2_flow_nominal=994*853.2/3600,
        dp1_nominal=65600,
        dp2_nominal=69500,                                          configuration=
             Buildings.Fluid.Types.HeatExchangerConfiguration.CounterFlow,
          use_Q_flow_nominal=true,
        Q_flow_nominal=4925,
        T_a1_nominal=298.15,
        T_a2_nominal=305.15)
          annotation (Placement(transformation(extent={{-40,0},{-20,20}})));
        Fluid.Actuators.Valves.TwoWayLinear CV211(redeclare package Medium =
              Buildings.Applications.DHC_Marseille.Media.Sea_Water,
        m_flow_nominal=1025*747.6/3600,
        dpValve_nominal=5000)                                       annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=0,
              origin={70,16})));
        Modelica.Blocks.Sources.Constant TDT_Set(k=5)
        "Scaled differential pressure setpoint"
          annotation (Placement(transformation(extent={{-40,160},{-20,180}})));
        Controls.Continuous.LimPID TDT_PID(
          controllerType=Modelica.Blocks.Types.SimpleController.PI,
          k=3,
          Ti=1)
          annotation (Placement(transformation(extent={{0,160},{20,180}})));
        Modelica.Blocks.Math.Add TDT(k1=1, k2=-1)
          annotation (Placement(transformation(extent={{-40,120},{-20,140}})));
        Modelica.Blocks.Sources.Constant T_Set(k=30)
          "Scaled differential pressure setpoint"
          annotation (Placement(transformation(extent={{-40,80},{-20,100}})));
        Controls.Continuous.LimPID T_PID(
          controllerType=Modelica.Blocks.Types.SimpleController.PI,
          k=3,
          Ti=1) annotation (Placement(transformation(extent={{0,80},{20,100}})));
        Fluid.Sensors.TemperatureTwoPort TT211(redeclare package Medium =
              Buildings.Applications.DHC_Marseille.Media.Sea_Water,
          m_flow_nominal=1025*747.6/3600)
                                       annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=0,
              origin={34,16})));
        Modelica.Blocks.Math.MinMax maxi(nu=4)
          annotation (Placement(transformation(extent={{60,160},{80,180}})));
        Modelica.Blocks.Interfaces.RealInput PEM_TT200
          annotation (Placement(transformation(extent={{-140,-40},{-100,0}})));
        Modelica.Blocks.Interfaces.RealInput TFP_CV122
          annotation (Placement(transformation(extent={{-140,0},{-100,40}})));
        Modelica.Blocks.Sources.Constant PDT_Set(k=400)
          "Scaled differential pressure setpoint"
          annotation (Placement(transformation(extent={{-40,240},{-20,260}})));
        Controls.Continuous.LimPID PDT_PID(
          controllerType=Modelica.Blocks.Types.SimpleController.PI,
          k=3,
          Ti=10) annotation (Placement(transformation(extent={{0,240},{20,260}})));
        Modelica.Blocks.Math.Add PDT(k1=-1, k2=1)
          annotation (Placement(transformation(extent={{-40,200},{-20,220}})));
        Fluid.Sensors.Pressure PT211(redeclare package Medium =
              Buildings.Applications.DHC_Marseille.Media.Sea_Water)
          annotation (Placement(transformation(extent={{14,16},{-6,36}})));
        Fluid.Sensors.Pressure PT221(redeclare package Medium = Media.Sea_Water)
          annotation (Placement(transformation(extent={{-42,16},{-62,36}})));
      Fluid.Movers.FlowControlled_m_flow fan(redeclare package Medium =
            Buildings.Media.Water,
        m_flow_nominal=650*994/3600,
        redeclare Fluid.Movers.Data.KSB_RJC per,
        inputType=Buildings.Fluid.Types.InputType.Continuous)
        annotation (Placement(transformation(extent={{-40,-120},{-60,-100}})));
        Fluid.FixedResistances.Junction jun(
        redeclare package Medium = Buildings.Media.Water,
        m_flow_nominal={994*853.2/3600,-994*853.2/3600,-994*853.2/3600},
        dp_nominal={0,0,0})
          annotation (Placement(transformation(extent={{-10,-10},{10,10}},
              rotation=270,
              origin={-20,-80})));
        Fluid.FixedResistances.Junction jun1(
        redeclare package Medium = Buildings.Media.Water,
        m_flow_nominal={994*853.2/3600,994*853.2/3600,-994*853.2/3600},
        dp_nominal={0,0,0})
          annotation (Placement(transformation(extent={{-10,-10},{10,10}},
              rotation=90,
              origin={-80,-80})));
        Modelica.Blocks.Interfaces.RealInput TFP_CV523 annotation (Placement(
            transformation(
            extent={{-20,-20},{20,20}},
            rotation=90,
            origin={40,-120})));
      equation
        connect(RJC.port_b1, TT211.port_a)
          annotation (Line(points={{-20,16},{24,16}}, color={0,127,255}));
        connect(T_Set.y, T_PID.u_s)
          annotation (Line(points={{-19,90},{-2,90}}, color={0,0,127}));
        connect(TDT_Set.y,TDT_PID. u_s)
          annotation (Line(points={{-19,170},{-2,170}},  color={0,0,127}));
        connect(TDT.y,TDT_PID. u_m) annotation (Line(points={{-19,130},{10,130},{10,158}},
                            color={0,0,127}));
        connect(TDT_PID.y,maxi. u[1]) annotation (Line(points={{21,170},{40,170},{40,175.25},
                {60,175.25}},            color={0,0,127}));
        connect(T_PID.y, maxi.u[2]) annotation (Line(points={{21,90},{40,90},{40,171.75},
                {60,171.75}}, color={0,0,127}));
        connect(TT211.T, T_PID.u_m) annotation (Line(points={{34,27},{34,66},{10,66},{
                10,78}}, color={0,0,127}));
        connect(TT211.T, TDT.u2) annotation (Line(points={{34,27},{34,66},{-48,66},{-48,
                124},{-42,124}}, color={0,0,127}));
        connect(port_a1,RJC. port_a1) annotation (Line(points={{-100,60},{-80,60},{-80,
                16},{-40,16}},      color={0,127,255}));
        connect(RJC.port_a2, port_a2) annotation (Line(points={{-20,4},{0,4},{0,
              -60},{100,-60}},       color={0,127,255}));
        connect(TT211.port_b, CV211.port_a)
          annotation (Line(points={{44,16},{60,16}}, color={0,127,255}));
        connect(CV211.port_b, port_b1) annotation (Line(points={{80,16},{88,16},{88,
                60},{100,60}},
                           color={0,127,255}));
        connect(maxi.yMin, CV211.y) annotation (Line(points={{81,164},{92,164},{92,116},
                {70,116},{70,28}}, color={0,0,127}));
        connect(TFP_CV122, maxi.u[3]) annotation (Line(points={{-120,20},{-88,20},{-88,
                270},{50,270},{50,168.25},{60,168.25}},        color={0,0,127}));
        connect(PEM_TT200, TDT.u1) annotation (Line(points={{-120,-20},{-70,-20},{-70,
                136},{-42,136}}, color={0,0,127}));
        connect(RJC.port_b1, PT211.port)
          annotation (Line(points={{-20,16},{4,16}}, color={0,127,255}));
        connect(PT211.p, PDT.u2) annotation (Line(points={{-7,26},{-12,26},{-12,52},{-60,
                52},{-60,204},{-42,204}}, color={0,0,127}));
        connect(PDT.y, PDT_PID.u_m)
          annotation (Line(points={{-19,210},{10,210},{10,238}}, color={0,0,127}));
        connect(PDT_Set.y, PDT_PID.u_s)
          annotation (Line(points={{-19,250},{-2,250}}, color={0,0,127}));
        connect(PDT_PID.y, maxi.u[4]) annotation (Line(points={{21,250},{44,250},{44,164.75},
                {60,164.75}}, color={0,0,127}));
        connect(port_a1, PT221.port) annotation (Line(points={{-100,60},{-80,60},{-80,
                16},{-52,16}}, color={0,127,255}));
        connect(PT221.p, PDT.u1) annotation (Line(points={{-63,26},{-64,26},{-64,216},
                {-42,216}}, color={0,0,127}));
      connect(fan.port_a, jun.port_2) annotation (Line(points={{-40,-110},{-20,
              -110},{-20,-90}}, color={0,127,255}));
      connect(jun.port_1, RJC.port_b2) annotation (Line(points={{-20,-70},{-20,
              -6},{-52,-6},{-52,4},{-40,4}}, color={0,127,255}));
      connect(port_b2, jun1.port_2) annotation (Line(points={{-100,-60},{-80,
              -60},{-80,-70}}, color={0,127,255}));
      connect(jun1.port_3, jun.port_3)
        annotation (Line(points={{-70,-80},{-30,-80}}, color={0,127,255}));
      connect(jun1.port_1, fan.port_b) annotation (Line(points={{-80,-90},{-80,
              -110},{-60,-110}}, color={0,127,255}));
      connect(TFP_CV523, fan.m_flow_in) annotation (Line(points={{40,-120},{40,
              -50},{-50,-50},{-50,-98}}, color={0,0,127}));
        annotation (Icon(coordinateSystem(extent={{-100,-100},{100,100}}),
                         graphics={
              Rectangle(
                extent={{-72,80},{68,-80}},
                lineColor={0,0,255},
                pattern=LinePattern.None,
                fillColor={95,95,95},
                fillPattern=FillPattern.Solid),
              Rectangle(
                extent={{-102,65},{99,55}},
                lineColor={0,0,255},
                pattern=LinePattern.None,
                fillColor={0,0,0},
                fillPattern=FillPattern.Solid),
              Rectangle(
                extent={{-102,-55},{99,-65}},
                lineColor={0,0,255},
                pattern=LinePattern.None,
                fillColor={0,0,0},
                fillPattern=FillPattern.Solid),
                                    Rectangle(
                extent={{-72,78},{68,-80}},
                lineColor={0,0,255},
                pattern=LinePattern.None,
                fillColor={95,95,95},
                fillPattern=FillPattern.Solid),
                                    Rectangle(
                extent={{-72,78},{68,-80}},
                lineColor={0,0,255},
                pattern=LinePattern.None,
                fillColor={95,95,95},
                fillPattern=FillPattern.Solid),
              Rectangle(
                extent={{-64,60},{-52,-58}},
                fillColor={0,0,0},
                fillPattern=FillPattern.Solid,
                pattern=LinePattern.None),
              Rectangle(
                extent={{-52,60},{-36,-58}},
                fillColor={238,46,47},
                fillPattern=FillPattern.Solid,
                pattern=LinePattern.None,
                lineColor={0,0,0}),
              Rectangle(
                extent={{-24,60},{-8,-58}},
                fillColor={238,46,47},
                fillPattern=FillPattern.Solid,
                pattern=LinePattern.None,
                lineColor={0,0,0}),
              Rectangle(
                extent={{-36,60},{-24,-58}},
                fillColor={0,0,0},
                fillPattern=FillPattern.Solid,
                pattern=LinePattern.None),
              Rectangle(
                extent={{4,60},{20,-58}},
                fillColor={238,46,47},
                fillPattern=FillPattern.Solid,
                pattern=LinePattern.None,
                lineColor={0,0,0}),
              Rectangle(
                extent={{-8,60},{4,-58}},
                fillColor={0,0,0},
                fillPattern=FillPattern.Solid,
                pattern=LinePattern.None),
              Rectangle(
                extent={{32,60},{48,-58}},
                fillColor={238,46,47},
                fillPattern=FillPattern.Solid,
                pattern=LinePattern.None,
                lineColor={0,0,0}),
              Rectangle(
                extent={{20,60},{32,-58}},
                fillColor={0,0,0},
                fillPattern=FillPattern.Solid,
                pattern=LinePattern.None),
              Rectangle(
                extent={{48,60},{60,-58}},
                fillColor={0,0,0},
                fillPattern=FillPattern.Solid,
                pattern=LinePattern.None)}), Diagram(coordinateSystem(extent={{-100,-100},
                  {100,100}})));
      end Heat_exchanger;

      package Tests
      extends Modelica.Icons.ExamplesPackage;
        model test_mover
        Fluid.Movers.FlowControlled_m_flow fan(
          redeclare package Medium = Buildings.Media.Water,
          m_flow_nominal=200,
          redeclare Fluid.Movers.Data.KSB_edm per,
          inputType=Buildings.Fluid.Types.InputType.Continuous,
          nominalValuesDefineDefaultPressureCurve=true,
          dp_nominal=600000)
          annotation (Placement(transformation(extent={{-18,0},{2,20}})));
          Fluid.Sources.MassFlowSource_T boundary1(
          redeclare package Medium = Buildings.Media.Water,
          m_flow=200,
          T=281.15,
          nPorts=1)
            annotation (Placement(transformation(extent={{-100,0},{-80,20}})));
          Fluid.Sources.Boundary_pT bou1(
          redeclare package Medium = Buildings.Media.Water,
          p=100000,
          nPorts=1)
            annotation (Placement(transformation(extent={{100,0},{80,20}})));
        Modelica.Blocks.Sources.Ramp ramp(
          height=200,
          duration=200,
          startTime=200)
          annotation (Placement(transformation(extent={{-60,60},{-40,80}})));
        equation
        connect(boundary1.ports[1], fan.port_a)
          annotation (Line(points={{-80,10},{-18,10}}, color={0,127,255}));
        connect(fan.port_b, bou1.ports[1])
          annotation (Line(points={{2,10},{80,10}}, color={0,127,255}));
        connect(ramp.y, fan.m_flow_in) annotation (Line(points={{-39,70},{-8,70},
                {-8,22}}, color={0,0,127}));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
              coordinateSystem(preserveAspectRatio=false)));
        end test_mover;

        model test_temp4
          Fluid.Sources.MassFlowSource_T boundary1(
          redeclare package Medium = Buildings.Media.Water,
          m_flow=200,
          T=293.15,
          nPorts=1)
            annotation (Placement(transformation(extent={{-100,0},{-80,20}})));
          Fluid.Sources.Boundary_pT bou1(
          redeclare package Medium = Buildings.Media.Water,
          p=100000,
          nPorts=1)
            annotation (Placement(transformation(extent={{100,0},{80,20}})));
          Fluid.Sources.MassFlowSource_T boundary2(
          redeclare package Medium = Buildings.Media.Water,
          m_flow=200,
          T=281.15,
          nPorts=1)
            annotation (Placement(transformation(extent={{100,-60},{80,-40}})));
          Fluid.Sources.Boundary_pT bou2(
          redeclare package Medium = Buildings.Media.Water,
          p=100000,
          nPorts=1)
            annotation (Placement(transformation(extent={{-100,-60},{-80,-40}})));
        Fluid.HeatExchangers.ConstantEffectiveness hex(
          redeclare package Medium1 = Buildings.Media.Water,
          redeclare package Medium2 = Buildings.Media.Water,
          m1_flow_nominal=200,
          m2_flow_nominal=200,
          dp1_nominal=1000,
          dp2_nominal=1000)
          annotation (Placement(transformation(extent={{-20,-20},{0,0}})));
        Fluid.Sensors.TemperatureTwoPort senTem(redeclare package Medium =
              Buildings.Media.Water, m_flow_nominal=200)
          annotation (Placement(transformation(extent={{-72,0},{-52,20}})));
        Fluid.Sensors.TemperatureTwoPort senTem1(redeclare package Medium =
              Buildings.Media.Water, m_flow_nominal=200)
          annotation (Placement(transformation(extent={{44,0},{64,20}})));
          Modelica.Blocks.Math.Add TDT(k1=1, k2=-1)
            annotation (Placement(transformation(extent={{-20,60},{0,80}})));
        Fluid.Sensors.RelativeTemperature senRelTem(redeclare package Medium =
              Buildings.Media.Water)
          annotation (Placement(transformation(extent={{-18,14},{2,34}})));
        Fluid.Sensors.Temperature senTem2(redeclare package Medium =
              Buildings.Media.Water)
          annotation (Placement(transformation(extent={{-46,-4},{-26,16}})));
        Fluid.Sensors.Temperature senTem3(redeclare package Medium =
              Buildings.Media.Water)
          annotation (Placement(transformation(extent={{14,-4},{34,16}})));
          Modelica.Blocks.Math.Add TDT1(k1=1, k2=-1)
            annotation (Placement(transformation(extent={{60,60},{80,80}})));
        equation
        connect(bou2.ports[1], hex.port_b2) annotation (Line(points={{-80,-50},
                {-50,-50},{-50,-16},{-20,-16}}, color={0,127,255}));
        connect(hex.port_a2, boundary2.ports[1]) annotation (Line(points={{0,
                -16},{40,-16},{40,-50},{80,-50}}, color={0,127,255}));
        connect(boundary1.ports[1], senTem.port_a)
          annotation (Line(points={{-80,10},{-72,10}}, color={0,127,255}));
        connect(senTem.port_b, hex.port_a1) annotation (Line(points={{-52,10},{
                -50,10},{-50,-4},{-20,-4}}, color={0,127,255}));
        connect(hex.port_b1, senTem1.port_a) annotation (Line(points={{0,-4},{
                40,-4},{40,10},{44,10}}, color={0,127,255}));
        connect(senTem1.port_b, bou1.ports[1])
          annotation (Line(points={{64,10},{80,10}}, color={0,127,255}));
        connect(senTem.T, TDT.u1) annotation (Line(points={{-62,21},{-62,76},{
                -22,76}}, color={0,0,127}));
        connect(senTem1.T, TDT.u2) annotation (Line(points={{54,21},{54,40},{
                -36,40},{-36,64},{-22,64}}, color={0,0,127}));
        connect(senRelTem.port_a, hex.port_a1) annotation (Line(points={{-18,24},
                {-20,24},{-20,-4},{-20,-4}}, color={0,127,255}));
        connect(senRelTem.port_b, hex.port_b1)
          annotation (Line(points={{2,24},{2,-4},{0,-4}}, color={0,127,255}));
        connect(senTem.port_b, senTem2.port) annotation (Line(points={{-52,10},
                {-50,10},{-50,-4},{-36,-4}}, color={0,127,255}));
        connect(hex.port_b1, senTem3.port)
          annotation (Line(points={{0,-4},{24,-4}}, color={0,127,255}));
        connect(senTem2.T, TDT1.u1) annotation (Line(points={{-29,6},{14.5,6},{
                14.5,76},{58,76}}, color={0,0,127}));
        connect(senTem3.T, TDT1.u2) annotation (Line(points={{31,6},{44,6},{44,
                64},{58,64}}, color={0,0,127}));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
              coordinateSystem(preserveAspectRatio=false)));
        end test_temp4;
      end Tests;

    end RJC;

  package RJF
    extends Modelica.Icons.VariantsPackage;

    model Cold_exchanger

    extends Fluid.Interfaces.PartialFourPort
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));

      Fluid.HeatExchangers.PlateHeatExchangerEffectivenessNTU RJF(
        redeclare package Medium1 =
            Buildings.Applications.DHC_Marseille.Media.Sea_Water,
        redeclare package Medium2 = Buildings.Media.Water,
        m1_flow_nominal=1025*747.6/3600,
        m2_flow_nominal=1001*726.2/3600,
        dp1_nominal=69900,
        dp2_nominal=61900,                                        configuration=
           Buildings.Fluid.Types.HeatExchangerConfiguration.CounterFlow,
        use_Q_flow_nominal=true,
        Q_flow_nominal=4250000,
        T_a1_nominal=283.65,
        T_a2_nominal=277.15)
        annotation (Placement(transformation(extent={{-40,0},{-20,20}})));
      Fluid.Actuators.Valves.TwoWayLinear CV211(redeclare package Medium =
            Buildings.Applications.DHC_Marseille.Media.Sea_Water,
        m_flow_nominal=1025*747.6/3600,
        dpValve_nominal=5000)                                     annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={70,16})));
      Modelica.Blocks.Sources.Constant TDT_Set(k=5)
        "Scaled differential pressure setpoint"
        annotation (Placement(transformation(extent={{-40,160},{-20,180}})));
      Controls.Continuous.LimPID TDT_PID(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=3,
        Ti=1)
        annotation (Placement(transformation(extent={{0,160},{20,180}})));
      Modelica.Blocks.Math.Add TDT(k1=1, k2=-1)
        annotation (Placement(transformation(extent={{-40,120},{-20,140}})));
      Modelica.Blocks.Sources.Constant T_Set(k=30)
        "Scaled differential pressure setpoint"
        annotation (Placement(transformation(extent={{-40,80},{-20,100}})));
      Controls.Continuous.LimPID T_PID(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=3,
        Ti=1) annotation (Placement(transformation(extent={{0,80},{20,100}})));
      Fluid.Sensors.TemperatureTwoPort TT211(redeclare package Medium =
            Buildings.Applications.DHC_Marseille.Media.Sea_Water,
          m_flow_nominal=1025*747.6/3600)
                                     annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={34,16})));
      Modelica.Blocks.Math.MinMax maxi(nu=4)
        annotation (Placement(transformation(extent={{60,160},{80,180}})));
      Modelica.Blocks.Interfaces.RealInput PEM_TT200
        annotation (Placement(transformation(extent={{-140,-40},{-100,0}})));
      Modelica.Blocks.Interfaces.RealInput TFP_CV122
        annotation (Placement(transformation(extent={{-140,0},{-100,40}})));
      Modelica.Blocks.Sources.Constant PDT_Set(k=400)
        "Scaled differential pressure setpoint"
        annotation (Placement(transformation(extent={{-40,240},{-20,260}})));
      Controls.Continuous.LimPID PDT_PID(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=3,
        Ti=10) annotation (Placement(transformation(extent={{0,240},{20,260}})));
      Modelica.Blocks.Math.Add PDT(k1=-1, k2=1)
        annotation (Placement(transformation(extent={{-40,200},{-20,220}})));
      Fluid.Sensors.Pressure PT211(redeclare package Medium =
            Buildings.Applications.DHC_Marseille.Media.Sea_Water)
        annotation (Placement(transformation(extent={{14,16},{-6,36}})));
      Fluid.Sensors.Pressure PT221(redeclare package Medium = Media.Sea_Water)
        annotation (Placement(transformation(extent={{-42,16},{-62,36}})));
    equation
      connect(RJF.port_b1, TT211.port_a)
        annotation (Line(points={{-20,16},{24,16}}, color={0,127,255}));
      connect(T_Set.y, T_PID.u_s)
        annotation (Line(points={{-19,90},{-2,90}}, color={0,0,127}));
      connect(TDT_Set.y,TDT_PID. u_s)
        annotation (Line(points={{-19,170},{-2,170}},  color={0,0,127}));
      connect(TDT.y,TDT_PID. u_m) annotation (Line(points={{-19,130},{10,130},{10,158}},
                          color={0,0,127}));
      connect(TDT_PID.y,maxi. u[1]) annotation (Line(points={{21,170},{40,170},
              {40,175.25},{60,175.25}},color={0,0,127}));
      connect(T_PID.y, maxi.u[2]) annotation (Line(points={{21,90},{54,90},{54,
              171.75},{60,171.75}},
                            color={0,0,127}));
      connect(TT211.T, T_PID.u_m) annotation (Line(points={{34,27},{34,66},{10,66},{
              10,78}}, color={0,0,127}));
      connect(TT211.T, TDT.u2) annotation (Line(points={{34,27},{34,66},{-48,66},{-48,
              124},{-42,124}}, color={0,0,127}));
      connect(port_a1, RJF.port_a1) annotation (Line(points={{-100,60},{-80,60},{-80,
              16},{-40,16}},      color={0,127,255}));
      connect(port_b2, RJF.port_b2) annotation (Line(points={{-100,-60},{-80,-60},{-80,
              4},{-40,4}},           color={0,127,255}));
      connect(RJF.port_a2, port_a2) annotation (Line(points={{-20,4},{0,4},{0,-60},{
              100,-60}},           color={0,127,255}));
      connect(TT211.port_b, CV211.port_a)
        annotation (Line(points={{44,16},{60,16}}, color={0,127,255}));
      connect(CV211.port_b, port_b1) annotation (Line(points={{80,16},{88,16},{88,
              60},{100,60}},
                         color={0,127,255}));
      connect(maxi.yMin, CV211.y) annotation (Line(points={{81,164},{92,164},{
              92,116},{70,116},{70,28}},
                                 color={0,0,127}));
      connect(TFP_CV122, maxi.u[3]) annotation (Line(points={{-120,20},{-88,20},
              {-88,270},{50,270},{50,168.25},{60,168.25}},   color={0,0,127}));
      connect(PEM_TT200, TDT.u1) annotation (Line(points={{-120,-20},{-70,-20},{-70,
              136},{-42,136}}, color={0,0,127}));
      connect(RJF.port_b1, PT211.port)
        annotation (Line(points={{-20,16},{4,16}}, color={0,127,255}));
      connect(PT211.p, PDT.u2) annotation (Line(points={{-7,26},{-12,26},{-12,52},{-60,
              52},{-60,204},{-42,204}}, color={0,0,127}));
      connect(PDT.y, PDT_PID.u_m)
        annotation (Line(points={{-19,210},{10,210},{10,238}}, color={0,0,127}));
      connect(PDT_Set.y, PDT_PID.u_s)
        annotation (Line(points={{-19,250},{-2,250}}, color={0,0,127}));
      connect(PDT_PID.y, maxi.u[4]) annotation (Line(points={{21,250},{44,250},
              {44,164.75},{60,164.75}},
                            color={0,0,127}));
      connect(port_a1, PT221.port) annotation (Line(points={{-100,60},{-80,60},{-80,
              16},{-52,16}}, color={0,127,255}));
      connect(PT221.p, PDT.u1) annotation (Line(points={{-63,26},{-64,26},{-64,216},
              {-42,216}}, color={0,0,127}));
      annotation (Icon(coordinateSystem(extent={{-100,-100},{100,100}}),
                       graphics={
            Rectangle(
              extent={{-72,80},{68,-80}},
              lineColor={0,0,255},
              pattern=LinePattern.None,
              fillColor={95,95,95},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-102,65},{99,55}},
              lineColor={0,0,255},
              pattern=LinePattern.None,
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-102,-55},{99,-65}},
              lineColor={0,0,255},
              pattern=LinePattern.None,
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid),
                                  Rectangle(
              extent={{-72,78},{68,-80}},
              lineColor={0,0,255},
              pattern=LinePattern.None,
              fillColor={95,95,95},
              fillPattern=FillPattern.Solid),
                                  Rectangle(
              extent={{-72,78},{68,-80}},
              lineColor={0,0,255},
              pattern=LinePattern.None,
              fillColor={95,95,95},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-64,60},{-52,-58}},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid,
              pattern=LinePattern.None),
            Rectangle(
              extent={{-52,60},{-36,-58}},
              fillColor={28,108,200},
              fillPattern=FillPattern.Solid,
              pattern=LinePattern.None,
              lineColor={0,0,0}),
            Rectangle(
              extent={{-24,60},{-8,-58}},
              fillColor={28,108,200},
              fillPattern=FillPattern.Solid,
              pattern=LinePattern.None,
              lineColor={0,0,0}),
            Rectangle(
              extent={{-36,60},{-24,-58}},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid,
              pattern=LinePattern.None),
            Rectangle(
              extent={{4,60},{20,-58}},
              fillColor={28,108,200},
              fillPattern=FillPattern.Solid,
              pattern=LinePattern.None,
              lineColor={0,0,0}),
            Rectangle(
              extent={{-8,60},{4,-58}},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid,
              pattern=LinePattern.None),
            Rectangle(
              extent={{32,60},{48,-58}},
              fillColor={28,108,200},
              fillPattern=FillPattern.Solid,
              pattern=LinePattern.None,
              lineColor={0,0,0}),
            Rectangle(
              extent={{20,60},{32,-58}},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid,
              pattern=LinePattern.None),
            Rectangle(
              extent={{48,60},{60,-58}},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid,
              pattern=LinePattern.None)}), Diagram(coordinateSystem(extent={{-100,-100},
                {100,100}})));
    end Cold_exchanger;

  package Tests
    extends Modelica.Icons.ExamplesPackage;
    model test_0
      Cold_exchanger cold_exchanger(redeclare package Medium1 =
            Buildings.Applications.DHC_Marseille.Media.Sea_Water, redeclare
            package Medium2 =
            Buildings.Media.Water)
        annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
      Fluid.Sources.MassFlowSource_T boundary(
        redeclare package Medium =
            Buildings.Applications.DHC_Marseille.Media.Sea_Water,
          use_m_flow_in=true,
        m_flow=1025*747/3600,
          use_T_in=true,
          T=288.15,
        nPorts=1)
        annotation (Placement(transformation(extent={{-102,80},{-82,100}})));
      Fluid.Sources.MassFlowSource_T boundary1(
        redeclare package Medium = Buildings.Media.Water,
          use_m_flow_in=true,
        m_flow=726.2/3600,
          use_T_in=true,
          T=281.15,                            nPorts=1)
        annotation (Placement(transformation(extent={{100,-100},{80,-80}})));
      Fluid.Sources.Boundary_pT bou(
        redeclare package Medium =
            Buildings.Applications.DHC_Marseille.Media.Sea_Water,
        p=100000,
        nPorts=1) annotation (Placement(transformation(extent={{100,80},{80,100}})));
      Fluid.Sources.Boundary_pT bou1(
        redeclare package Medium = Buildings.Media.Water,
        p=100000,                    nPorts=1)
        annotation (Placement(transformation(extent={{-100,-100},{-80,-80}})));
      Modelica.Blocks.Sources.Constant CVset(k=0.8)
        "Scaled differential pressure setpoint"
        annotation (Placement(transformation(extent={{-100,20},{-80,40}})));
      Modelica.Thermal.HeatTransfer.Celsius.FromKelvin fromKelvin
        annotation (Placement(transformation(extent={{-36,96},{-16,116}})));
      Fluid.Sensors.TemperatureTwoPort senTem(redeclare package Medium =
            Buildings.Applications.DHC_Marseille.Media.Sea_Water, m_flow_nominal=1025*747/3600)
        annotation (Placement(transformation(extent={{-70,80},{-50,100}})));
      Fluid.Sensors.TemperatureTwoPort senTem1(redeclare package Medium =
            Buildings.Applications.DHC_Marseille.Media.Sea_Water, m_flow_nominal=1025*747/3600)
        annotation (Placement(transformation(extent={{40,80},{60,100}})));
      Fluid.Sensors.TemperatureTwoPort senTem2(redeclare package Medium =
            Buildings.Media.Water, m_flow_nominal=726.2/3600,
          T_start=283.15)
        annotation (Placement(transformation(extent={{60,-100},{40,-80}})));
      Fluid.Sensors.TemperatureTwoPort senTem3(redeclare package Medium =
              Buildings.Media.Water,           m_flow_nominal=726.2/3600,
          T_start=283.15)
        annotation (Placement(transformation(extent={{-50,-100},{-70,-80}})));
      Modelica.Blocks.Sources.CombiTimeTable combiTimeTable(
          tableOnFile=true,
          tableName="tab1",
          fileName=ModelicaServices.ExternalReferences.loadResource(
              "modelica://Buildings/Data/rjf.txt"),
          columns={2,3,4,5,6,7,8,9,10})
        annotation (Placement(transformation(extent={{-180,80},{-160,100}})));
    equation
      connect(CVset.y, cold_exchanger.TFP_CV122) annotation (Line(points={{-79,30},{
              -46,30},{-46,2},{-12,2}}, color={0,0,127}));
      connect(fromKelvin.Celsius, cold_exchanger.PEM_TT200) annotation (Line(points={{-15,106},
                {0,106},{0,160},{-220,160},{-220,-2},{-12,-2}},         color={0,0,127}));
      connect(boundary.ports[1], senTem.port_a)
        annotation (Line(points={{-82,90},{-70,90}}, color={0,127,255}));
      connect(senTem.port_b, cold_exchanger.port_a1) annotation (Line(points={{-50,90},
              {-30,90},{-30,6},{-10,6}}, color={0,127,255}));
      connect(senTem.T, fromKelvin.Kelvin)
        annotation (Line(points={{-60,101},{-60,106},{-38,106}}, color={0,0,127}));
      connect(cold_exchanger.port_b1, senTem1.port_a) annotation (Line(points={{10,6},
              {20,6},{20,90},{40,90}}, color={0,127,255}));
      connect(senTem1.port_b, bou.ports[1])
        annotation (Line(points={{60,90},{80,90}}, color={0,127,255}));
      connect(cold_exchanger.port_a2, senTem2.port_b) annotation (Line(points={{10,-6},
              {20,-6},{20,-90},{40,-90}}, color={0,127,255}));
      connect(senTem2.port_a, boundary1.ports[1])
        annotation (Line(points={{60,-90},{80,-90}}, color={0,127,255}));
      connect(bou1.ports[1], senTem3.port_b)
        annotation (Line(points={{-80,-90},{-70,-90}}, color={0,127,255}));
      connect(senTem3.port_a, cold_exchanger.port_b2) annotation (Line(points={{-50,
              -90},{-40,-90},{-40,-6},{-10,-6}}, color={0,127,255}));
        connect(combiTimeTable.y[7], boundary.m_flow_in) annotation (Line(
              points={{-159,90},{-122,90},{-122,98},{-104,98}}, color={0,0,127}));
        connect(combiTimeTable.y[5], boundary.T_in) annotation (Line(points={{
                -159,90},{-122,90},{-122,94},{-104,94}}, color={0,0,127}));
        connect(combiTimeTable.y[8], boundary1.m_flow_in) annotation (Line(
              points={{-159,90},{-140,90},{-140,-120},{140,-120},{140,-82},{102,
                -82}}, color={0,0,127}));
        connect(combiTimeTable.y[1], boundary1.T_in) annotation (Line(points={{
                -159,90},{-140,90},{-140,-120},{140,-120},{140,-86},{102,-86}},
              color={0,0,127}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)),
          experiment(
            StopTime=2245200,
            Interval=600,
            __Dymola_Algorithm="Dassl"));
    end test_0;

    model Cold_exchanger_basic

      Real sortie2(unit="K");
      Real sortie6(unit="K");

      Fluid.HeatExchangers.PlateHeatExchangerEffectivenessNTU RJF(
        redeclare package Medium1 = Media.Sea_Water,
        redeclare package Medium2 = Buildings.Media.Water,
        m1_flow_nominal=1025*747.6/3600,
        m2_flow_nominal=1001*726.2/3600,
        dp1_nominal=69900,
        dp2_nominal=61900,
        configuration=Buildings.Fluid.Types.HeatExchangerConfiguration.CounterFlow,
        use_Q_flow_nominal=true,
          Q_flow_nominal=4250000,
          T_a1_nominal=283.65,
          T_a2_nominal=277.15)
        annotation (Placement(transformation(extent={{0,0},{20,20}})));

      Fluid.Sources.MassFlowSource_T boundary(
        redeclare package Medium = Media.Sea_Water,
        use_m_flow_in=true,
        m_flow=1025*747/3600,
        use_T_in=true,
        T=288.15,
        nPorts=1)
        annotation (Placement(transformation(extent={{-72,60},{-52,80}})));
      Fluid.Sensors.TemperatureTwoPort senTem(redeclare package Medium =
            Media.Sea_Water, m_flow_nominal=1025*747/3600)
        annotation (Placement(transformation(extent={{-40,60},{-20,80}})));
      Modelica.Blocks.Sources.CombiTimeTable combiTimeTable(
        tableOnFile=true,
        tableName="tab1",
        fileName=ModelicaServices.ExternalReferences.loadResource("modelica://Buildings/Data/rjf.txt"),
        columns={2,3,4,5,6,7,8,9,10})
        annotation (Placement(transformation(extent={{-140,60},{-120,80}})));

      Fluid.Sources.Boundary_pT bou(
        redeclare package Medium = Media.Sea_Water,
        p=100000,
        nPorts=1) annotation (Placement(transformation(extent={{100,60},{80,80}})));
      Fluid.Sensors.TemperatureTwoPort senTem1(redeclare package Medium =
            Media.Sea_Water, m_flow_nominal=1025*747/3600)
        annotation (Placement(transformation(extent={{40,60},{60,80}})));
      Fluid.Sources.MassFlowSource_T boundary1(
        redeclare package Medium = Buildings.Media.Water,
        use_m_flow_in=true,
        m_flow=726.2/3600,
        use_T_in=true,
        T=281.15,
        nPorts=1)
        annotation (Placement(transformation(extent={{100,-80},{80,-60}})));
      Fluid.Sources.Boundary_pT bou1(
        redeclare package Medium = Buildings.Media.Water,
        p=100000,
        nPorts=1)
        annotation (Placement(transformation(extent={{-100,-80},{-80,-60}})));
      Fluid.Sensors.TemperatureTwoPort senTem2(
        redeclare package Medium = Buildings.Media.Water,
        m_flow_nominal=726.2/3600,
        T_start=283.15)
        annotation (Placement(transformation(extent={{60,-80},{40,-60}})));
      Fluid.Sensors.TemperatureTwoPort senTem3(
        redeclare package Medium = Buildings.Media.Water,
        m_flow_nominal=726.2/3600,
        T_start=283.15)
        annotation (Placement(transformation(extent={{-50,-80},{-70,-60}})));
    equation
      sortie2=combiTimeTable.y[2];
      sortie6=combiTimeTable.y[6];
      connect(boundary.ports[1],senTem. port_a)
        annotation (Line(points={{-52,70},{-40,70}}, color={0,127,255}));
      connect(combiTimeTable.y[7], boundary.m_flow_in) annotation (Line(points={{-119,
              70},{-92,70},{-92,78},{-74,78}}, color={0,0,127}));
      connect(combiTimeTable.y[5], boundary.T_in) annotation (Line(points={{-119,70},
              {-92,70},{-92,74},{-74,74}}, color={0,0,127}));
      connect(senTem1.port_b,bou. ports[1])
        annotation (Line(points={{60,70},{80,70}}, color={0,127,255}));
      connect(senTem2.port_a,boundary1. ports[1])
        annotation (Line(points={{60,-70},{80,-70}}, color={0,127,255}));
      connect(bou1.ports[1],senTem3. port_b)
        annotation (Line(points={{-80,-70},{-70,-70}}, color={0,127,255}));
      connect(senTem2.port_b, RJF.port_a2) annotation (Line(points={{40,-70},{32,-70},
              {32,4},{20,4}}, color={0,127,255}));
      connect(RJF.port_b2, senTem3.port_a) annotation (Line(points={{0,4},{-26,4},{-26,
              -70},{-50,-70}}, color={0,127,255}));
      connect(senTem.port_b, RJF.port_a1) annotation (Line(points={{-20,70},{-12,70},
              {-12,16},{0,16}}, color={0,127,255}));
      connect(RJF.port_b1, senTem1.port_a) annotation (Line(points={{20,16},{30,16},
              {30,70},{40,70}}, color={0,127,255}));
      connect(combiTimeTable.y[8], boundary1.m_flow_in) annotation (Line(points={{-119,
              70},{-110,70},{-110,-120},{140,-120},{140,-62},{102,-62}}, color={0,0,
              127}));
      connect(combiTimeTable.y[1], boundary1.T_in) annotation (Line(points={{-119,70},
              {-110,70},{-110,-120},{140,-120},{140,-66},{102,-66}}, color={0,0,127}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end Cold_exchanger_basic;

    model Cold_exchanger_basic_bis
      Fluid.HeatExchangers.PlateHeatExchangerEffectivenessNTU RJF(
        redeclare package Medium1 = Media.Sea_Water,
        redeclare package Medium2 = Buildings.Media.Water,
        m1_flow_nominal=1025*747.6/3600,
        m2_flow_nominal=1001*726.2/3600,
        dp1_nominal=69900,
        dp2_nominal=61900,
        configuration=Buildings.Fluid.Types.HeatExchangerConfiguration.CounterFlow,
        use_Q_flow_nominal=true,
        Q_flow_nominal=4250,
          T_a1_nominal=283.65,
          T_a2_nominal=277.15)
        annotation (Placement(transformation(extent={{0,0},{20,20}})));

      Fluid.Sources.MassFlowSource_T boundary(
        redeclare package Medium = Media.Sea_Water,
          use_m_flow_in=false,
          m_flow=20,
          use_T_in=false,
          T=288.15,
        nPorts=1)
        annotation (Placement(transformation(extent={{-100,60},{-80,80}})));
      Fluid.Sensors.TemperatureTwoPort senTem(redeclare package Medium =
            Media.Sea_Water, m_flow_nominal=1025*747/3600)
        annotation (Placement(transformation(extent={{-40,60},{-20,80}})));

      Fluid.Sources.Boundary_pT bou(
        redeclare package Medium = Media.Sea_Water,
        p=100000,
        nPorts=1) annotation (Placement(transformation(extent={{100,60},{80,80}})));
      Fluid.Sensors.TemperatureTwoPort senTem1(redeclare package Medium =
            Media.Sea_Water, m_flow_nominal=1025*747/3600)
        annotation (Placement(transformation(extent={{40,60},{60,80}})));
      Fluid.Sources.MassFlowSource_T boundary1(
        redeclare package Medium = Buildings.Media.Water,
          use_m_flow_in=false,
          m_flow=100,
          use_T_in=false,
          T=283.15,
        nPorts=1)
        annotation (Placement(transformation(extent={{100,-80},{80,-60}})));
      Fluid.Sources.Boundary_pT bou1(
        redeclare package Medium = Buildings.Media.Water,
        p=100000,
        nPorts=1)
        annotation (Placement(transformation(extent={{-100,-80},{-80,-60}})));
      Fluid.Sensors.TemperatureTwoPort senTem2(
        redeclare package Medium = Buildings.Media.Water,
        m_flow_nominal=726.2/3600,
        T_start=283.15)
        annotation (Placement(transformation(extent={{60,-80},{40,-60}})));
      Fluid.Sensors.TemperatureTwoPort senTem3(
        redeclare package Medium = Buildings.Media.Water,
        m_flow_nominal=726.2/3600,
        T_start=283.15)
        annotation (Placement(transformation(extent={{-50,-80},{-70,-60}})));
      Fluid.Sensors.Pressure PT221(redeclare package Medium = Media.Sea_Water)
        annotation (Placement(transformation(extent={{50,-46},{30,-26}})));
      Fluid.Sensors.Pressure PT1(redeclare package Medium = Media.Sea_Water)
        annotation (Placement(transformation(extent={{-40,-48},{-60,-28}})));
    equation
      connect(boundary.ports[1],senTem. port_a)
        annotation (Line(points={{-80,70},{-40,70}}, color={0,127,255}));
      connect(senTem1.port_b,bou. ports[1])
        annotation (Line(points={{60,70},{80,70}}, color={0,127,255}));
      connect(senTem2.port_a,boundary1. ports[1])
        annotation (Line(points={{60,-70},{80,-70}}, color={0,127,255}));
      connect(bou1.ports[1],senTem3. port_b)
        annotation (Line(points={{-80,-70},{-70,-70}}, color={0,127,255}));
      connect(senTem2.port_b, RJF.port_a2) annotation (Line(points={{40,-70},{32,-70},
              {32,4},{20,4}}, color={0,127,255}));
      connect(RJF.port_b2, senTem3.port_a) annotation (Line(points={{0,4},{-26,4},{-26,
              -70},{-50,-70}}, color={0,127,255}));
      connect(senTem.port_b, RJF.port_a1) annotation (Line(points={{-20,70},{-12,70},
              {-12,16},{0,16}}, color={0,127,255}));
      connect(RJF.port_b1, senTem1.port_a) annotation (Line(points={{20,16},{30,16},
              {30,70},{40,70}}, color={0,127,255}));
        connect(senTem2.port_b, PT221.port)
          annotation (Line(points={{40,-70},{40,-46}}, color={0,127,255}));
        connect(senTem3.port_a, PT1.port)
          annotation (Line(points={{-50,-70},{-50,-48}}, color={0,127,255}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end Cold_exchanger_basic_bis;

    model Cold_exchanger_basic_change

      Fluid.HeatExchangers.PlateHeatExchangerEffectivenessNTU RJF(
        redeclare package Medium1 = Media.Sea_Water,
        redeclare package Medium2 = Buildings.Media.Water,
        m1_flow_nominal=1025*747.6/3600,
        m2_flow_nominal=1001*726.2/3600,
        dp1_nominal=69900,
        dp2_nominal=61900,
        configuration=Buildings.Fluid.Types.HeatExchangerConfiguration.CounterFlow,
        use_Q_flow_nominal=true,
        Q_flow_nominal=4250,
        T_a1_nominal=283.65,
        T_a2_nominal=277.15)
        annotation (Placement(transformation(extent={{0,0},{20,20}})));

      Fluid.Sources.MassFlowSource_T boundary(
        redeclare package Medium = Media.Sea_Water,
        use_m_flow_in=true,
        m_flow=1025*747/3600,
        use_T_in=true,
        T=288.15,
        nPorts=1)
        annotation (Placement(transformation(extent={{-72,60},{-52,80}})));
      Fluid.Sensors.TemperatureTwoPort senTem(redeclare package Medium =
            Media.Sea_Water, m_flow_nominal=1025*747/3600)
        annotation (Placement(transformation(extent={{-40,60},{-20,80}})));
      Modelica.Blocks.Sources.CombiTimeTable combiTimeTable(
        tableOnFile=true,
        tableName="tab1",
        fileName=ModelicaServices.ExternalReferences.loadResource("modelica://Buildings/Data/rjf.txt"),
        columns={2,3,4,5,6,7,8,9,10})
        annotation (Placement(transformation(extent={{-140,60},{-120,80}})));

      Fluid.Sources.Boundary_pT bou(
        redeclare package Medium = Media.Sea_Water,
        p=100000,
        nPorts=1) annotation (Placement(transformation(extent={{100,60},{80,80}})));
      Fluid.Sensors.TemperatureTwoPort senTem1(redeclare package Medium =
            Media.Sea_Water, m_flow_nominal=1025*747/3600)
        annotation (Placement(transformation(extent={{40,60},{60,80}})));
      Fluid.Sources.MassFlowSource_T boundary1(
        redeclare package Medium = Buildings.Media.Water,
        use_m_flow_in=true,
        m_flow=726.2/3600,
        use_T_in=true,
        T=281.15,
        nPorts=1)
        annotation (Placement(transformation(extent={{100,-80},{80,-60}})));
      Fluid.Sources.Boundary_pT bou1(
        redeclare package Medium = Buildings.Media.Water,
        p=100000,
        nPorts=1)
        annotation (Placement(transformation(extent={{-100,-80},{-80,-60}})));
      Fluid.Sensors.TemperatureTwoPort senTem2(
        redeclare package Medium = Buildings.Media.Water,
        m_flow_nominal=726.2/3600,
        T_start=283.15)
        annotation (Placement(transformation(extent={{60,-80},{40,-60}})));
      Fluid.Sensors.TemperatureTwoPort senTem3(
        redeclare package Medium = Buildings.Media.Water,
        m_flow_nominal=726.2/3600,
        T_start=283.15)
        annotation (Placement(transformation(extent={{-50,-80},{-70,-60}})));
      Fluid.Sensors.Pressure PT221(redeclare package Medium = Media.Sea_Water)
        annotation (Placement(transformation(extent={{50,-46},{30,-26}})));
      Fluid.Sensors.Pressure PT1(redeclare package Medium = Media.Sea_Water)
        annotation (Placement(transformation(extent={{-40,-48},{-60,-28}})));
    equation
      connect(boundary.ports[1],senTem. port_a)
        annotation (Line(points={{-52,70},{-40,70}}, color={0,127,255}));
      connect(combiTimeTable.y[7], boundary.m_flow_in) annotation (Line(points={{-119,
              70},{-92,70},{-92,78},{-74,78}}, color={0,0,127}));
      connect(combiTimeTable.y[5], boundary.T_in) annotation (Line(points={{-119,70},
              {-92,70},{-92,74},{-74,74}}, color={0,0,127}));
      connect(senTem1.port_b,bou. ports[1])
        annotation (Line(points={{60,70},{80,70}}, color={0,127,255}));
      connect(senTem2.port_a,boundary1. ports[1])
        annotation (Line(points={{60,-70},{80,-70}}, color={0,127,255}));
      connect(bou1.ports[1],senTem3. port_b)
        annotation (Line(points={{-80,-70},{-70,-70}}, color={0,127,255}));
      connect(senTem2.port_b, RJF.port_a2) annotation (Line(points={{40,-70},{32,-70},
              {32,4},{20,4}}, color={0,127,255}));
      connect(RJF.port_b2, senTem3.port_a) annotation (Line(points={{0,4},{-26,4},{-26,
              -70},{-50,-70}}, color={0,127,255}));
      connect(senTem.port_b, RJF.port_a1) annotation (Line(points={{-20,70},{-12,70},
              {-12,16},{0,16}}, color={0,127,255}));
      connect(RJF.port_b1, senTem1.port_a) annotation (Line(points={{20,16},{30,16},
              {30,70},{40,70}}, color={0,127,255}));
      connect(combiTimeTable.y[8], boundary1.m_flow_in) annotation (Line(points={{-119,
              70},{-110,70},{-110,-120},{140,-120},{140,-62},{102,-62}}, color={0,0,
              127}));
      connect(combiTimeTable.y[1], boundary1.T_in) annotation (Line(points={{-119,70},
              {-110,70},{-110,-120},{140,-120},{140,-66},{102,-66}}, color={0,0,127}));
      connect(senTem2.port_b, PT221.port)
        annotation (Line(points={{40,-70},{40,-46}}, color={0,127,255}));
      connect(senTem3.port_a, PT1.port)
        annotation (Line(points={{-50,-70},{-50,-48}}, color={0,127,255}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end Cold_exchanger_basic_change;
  end Tests;

  end RJF;

  package DEC
    extends Modelica.Icons.VariantsPackage;
    model DEC
      extends Fluid.Interfaces.PartialFourPort;

      parameter Modelica.SIunits.Conversions.NonSIunits.Temperature_degC T_cons_solo = 53.5;
       parameter Modelica.SIunits.Conversions.NonSIunits.Temperature_degC T_cons_ret = 46;


      Fluid.FixedResistances.Junction jun4(
        redeclare package Medium = Buildings.Media.Water,
        m_flow_nominal={100,-100,-100},
        dp_nominal={0,0,0})
        annotation (Placement(transformation(extent={{10,10},{-10,-10}},
            rotation=180,
            origin={-20,60})));
      Fluid.FixedResistances.Junction jun1(
        redeclare package Medium = Buildings.Media.Water,
        m_flow_nominal={100,-100,-100},
        dp_nominal={0,0,0})
        annotation (Placement(transformation(extent={{-10,10},{10,-10}},
            rotation=0,
            origin={-20,-60})));
      Fluid.Actuators.Valves.TwoWayLinear CV501(
        redeclare package Medium = Buildings.Media.Water,
        m_flow_nominal=m_flow_hot,
        CvData=Buildings.Fluid.Types.CvTypes.OpPoint,
        dpValve_nominal=10) annotation (Placement(
            transformation(
            extent={{-10,10},{10,-10}},
            rotation=270,
            origin={-20,0})));
      Controls_a.dp_law_hot dp_law_hot
        annotation (Placement(transformation(extent={{-180,160},{-160,180}})));
      Fluid.Sensors.Pressure PT511(redeclare package Medium =
            Buildings.Media.Water)
        annotation (Placement(transformation(extent={{60,60},{80,80}})));
      Fluid.Sensors.Pressure PT521(redeclare package Medium =
            Buildings.Media.Water)
        annotation (Placement(transformation(extent={{70,-60},{90,-40}})));
      Fluid.Sensors.RelativePressure PDT511(redeclare package Medium =
            Buildings.Media.Water) annotation (Placement(transformation(
            extent={{-10,10},{10,-10}},
            rotation=-90,
            origin={60,10})));
      Controls.Continuous.LimPID conPID1(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=3,
        Ti=1,
        initType=Modelica.Blocks.Types.InitPID.NoInit,
        reverseActing=false)                           annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={-130,170})));
      Modelica.Blocks.Interfaces.RealInput T_ext
        annotation (Placement(transformation(extent={{-240,160},{-200,200}})));
      Modelica.Blocks.Sources.RealExpression dp_set(y=dp_max)
        annotation (Placement(transformation(extent={{-200,120},{-180,140}})));
      Controls.Continuous.LimPID conPID2(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=3,
        Ti=1,
        initType=Modelica.Blocks.Types.InitPID.NoInit,
        reverseActing=false)                           annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={-150,130})));
      Fluid.Sensors.TemperatureTwoPort TT521(redeclare package Medium =
            Buildings.Media.Water, m_flow_nominal=100) annotation (Placement(
            transformation(
            extent={{-10,10},{10,-10}},
            rotation=180,
            origin={10,-60})));
      Modelica.Blocks.Sources.RealExpression dp_set1(y=dp_max)
        annotation (Placement(transformation(extent={{-200,40},{-180,60}})));
      Modelica.Blocks.Sources.RealExpression dp_set2(y=dp_max)
        annotation (Placement(transformation(extent={{-200,-20},{-180,0}})));
      Modelica.Blocks.Sources.BooleanExpression TFP_solo
        annotation (Placement(transformation(extent={{-200,10},{-180,30}})));
      Controls.Continuous.LimPID conPID3(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=3,
        Ti=1,
        initType=Modelica.Blocks.Types.InitPID.NoInit,
        reverseActing=false)                           annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={-110,20})));
      Modelica.Blocks.Logical.Switch switch1
        annotation (Placement(transformation(extent={{-160,10},{-140,30}})));
      Modelica.Blocks.Math.UnitConversions.To_degC to_degC annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-110,-10})));
      Modelica.Blocks.Math.MinMax minMax(nu=3)
        annotation (Placement(transformation(extent={{-80,-20},{-60,0}})));
      Fluid.Sensors.MassFlowRate FT521(redeclare package Medium =
            Buildings.Media.Water)
        annotation (Placement(transformation(extent={{50,-70},{30,-50}})));
      Modelica.Blocks.Interfaces.RealOutput cons_dp
        annotation (Placement(transformation(extent={{200,40},{220,60}})));
      Modelica.Blocks.Interfaces.RealOutput FT_ret
        annotation (Placement(transformation(extent={{200,-60},{220,-40}})));
    equation
      connect(jun4.port_3,CV501. port_a)
        annotation (Line(points={{-20,50},{-20,10}},      color={0,127,255}));
      connect(CV501.port_b, jun1.port_3)
        annotation (Line(points={{-20,-10},{-20,-50}},
                                                     color={0,127,255}));
      connect(port_a1, port_a1)
        annotation (Line(points={{-100,60},{-100,60}}, color={0,127,255}));
      connect(jun4.port_2, port_b1)
        annotation (Line(points={{-10,60},{100,60}},color={0,127,255}));
      connect(jun4.port_2, PT511.port)
        annotation (Line(points={{-10,60},{70,60}},color={0,127,255}));
      connect(PDT511.port_a, port_b1)
        annotation (Line(points={{60,20},{60,60},{100,60}}, color={0,127,255}));
      connect(PDT511.port_b, port_a2)
        annotation (Line(points={{60,0},{60,-60},{100,-60}}, color={0,127,255}));
      connect(jun1.port_1, port_b2)
        annotation (Line(points={{-30,-60},{-100,-60}},
                                                      color={0,127,255}));
      connect(port_a1, jun4.port_1)
        annotation (Line(points={{-100,60},{-30,60}},
                                                    color={0,127,255}));
      connect(PDT511.p_rel, conPID1.u_m) annotation (Line(points={{69,10},{120,
              10},{120,148},{-130,148},{-130,158}},
                                               color={0,0,127}));
      connect(dp_law_hot.y, conPID1.u_s)
        annotation (Line(points={{-159,170},{-142,170}}, color={0,0,127}));
      connect(dp_law_hot.T_ext, T_ext) annotation (Line(points={{-182,178},{-193,178},
              {-193,180},{-220,180}}, color={0,0,127}));
      connect(PT511.p, conPID2.u_m) annotation (Line(points={{81,70},{88,70},{88,112},
              {-150,112},{-150,118}}, color={0,0,127}));
      connect(dp_set.y, conPID2.u_s)
        annotation (Line(points={{-179,130},{-162,130}}, color={0,0,127}));
      connect(jun1.port_2, TT521.port_b)
        annotation (Line(points={{-10,-60},{1.77636e-15,-60}},
                                                      color={0,127,255}));
      connect(port_a2, PT521.port)
        annotation (Line(points={{100,-60},{80,-60}}, color={0,127,255}));
      connect(dp_set1.y, switch1.u1) annotation (Line(points={{-179,50},{-172,50},{-172,
              28},{-162,28}}, color={0,0,127}));
      connect(dp_set2.y, switch1.u3) annotation (Line(points={{-179,-10},{-172,-10},
              {-172,12},{-162,12}}, color={0,0,127}));
      connect(TFP_solo.y, switch1.u2)
        annotation (Line(points={{-179,20},{-162,20}}, color={255,0,255}));
      connect(switch1.y, conPID3.u_s)
        annotation (Line(points={{-139,20},{-122,20}}, color={0,0,127}));
      connect(conPID3.u_m, to_degC.y)
        annotation (Line(points={{-110,8},{-110,1}}, color={0,0,127}));
      connect(to_degC.u, TT521.T) annotation (Line(points={{-110,-22},{-110,-40},
              {10,-40},{10,-49}},
                              color={0,0,127}));
      connect(conPID3.y, minMax.u[1]) annotation (Line(points={{-99,20},{-90,20},
              {-90,-5.33333},{-80,-5.33333}},
                                         color={0,0,127}));
      connect(minMax.yMax, CV501.y) annotation (Line(points={{-59,-4},{-46,-4},
              {-46,0},{-32,0}},
                           color={0,0,127}));
      connect(conPID2.y, minMax.u[2]) annotation (Line(points={{-139,130},{-84,
              130},{-84,-10},{-80,-10}},
                                    color={0,0,127}));
      connect(conPID1.y, minMax.u[3]) annotation (Line(points={{-119,170},{-86,
              170},{-86,-14.6667},{-80,-14.6667}},
                                              color={0,0,127}));
      connect(TT521.port_a, FT521.port_b)
        annotation (Line(points={{20,-60},{30,-60}}, color={0,127,255}));
      connect(FT521.port_a, port_a2)
        annotation (Line(points={{50,-60},{100,-60}}, color={0,127,255}));
      connect(FT521.m_flow, FT_ret) annotation (Line(points={{40,-49},{40,-20},
              {180,-20},{180,-50},{210,-50}}, color={0,0,127}));
      connect(conPID1.y, cons_dp) annotation (Line(points={{-119,170},{160,170},
              {160,50},{210,50}}, color={0,0,127}));
      annotation (Diagram(coordinateSystem(extent={{-200,-180},{200,200}})), Icon(
            coordinateSystem(extent={{-200,-180},{200,200}}), graphics={
            Rectangle(
              extent={{-100,80},{100,40}},
              lineColor={0,0,0},
              fillPattern=FillPattern.HorizontalCylinder,
              fillColor={238,46,47}),
            Rectangle(
              extent={{-100,-40},{100,-80}},
              lineColor={0,0,0},
              fillPattern=FillPattern.HorizontalCylinder,
              fillColor={238,46,47}),
        Polygon(
          points={{2,18},{-38,60},{-38,-20},{2,18}},
          lineColor={0,0,0},
          fillColor=DynamicSelect({0,0,0}, y*{255,255,255}),
          fillPattern=FillPattern.Solid,
              origin={-18,2},
              rotation=270),
        Polygon(
          points={{-2,-20},{38,20},{38,-60},{-2,-20}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
              origin={20,-2},
              rotation=270),
        Line(
          points={{0,20},{0,-20}},
              origin={20,0},
              rotation=270),
            Rectangle(
              extent={{40,20},{80,-20}},
              lineColor={0,0,0},
              fillColor={210,210,210},
              fillPattern=FillPattern.Solid)}));
    end DEC;

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

      model test_sqrt
        parameter Real u=3;

        Modelica.Blocks.Interfaces.RealOutput y
          annotation (Placement(transformation(extent={{100,-10},{120,10}})));
      equation
        y = sqrt(u)^2;
        annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
              coordinateSystem(preserveAspectRatio=false)));
      end test_sqrt;

      model test_switch
        Modelica.Blocks.Logical.Switch switch1
          annotation (Placement(transformation(extent={{-40,20},{-20,40}})));
        Modelica.Blocks.Sources.RealExpression dp_set1(y=10)
          annotation (Placement(transformation(extent={{-100,50},{-80,70}})));
        Modelica.Blocks.Sources.RealExpression dp_set2(y=5)
          annotation (Placement(transformation(extent={{-100,-10},{-80,10}})));
        Modelica.Blocks.Sources.BooleanExpression TFP_solo(y=true)
          annotation (Placement(transformation(extent={{-100,20},{-80,40}})));
      equation
        connect(dp_set1.y, switch1.u1) annotation (Line(points={{-79,60},{-72,
                60},{-72,38},{-42,38}}, color={0,0,127}));
        connect(dp_set2.y, switch1.u3) annotation (Line(points={{-79,0},{-72,0},
                {-72,22},{-42,22}}, color={0,0,127}));
        connect(TFP_solo.y, switch1.u2)
          annotation (Line(points={{-79,30},{-42,30}}, color={255,0,255}));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
              coordinateSystem(preserveAspectRatio=false)));
      end test_switch;

      model pid
        Modelica.Blocks.Sources.RealExpression dp_set(y=10)
          annotation (Placement(transformation(extent={{-80,60},{-60,80}})));
        Controls.Continuous.LimPID conPID2(
          controllerType=Modelica.Blocks.Types.SimpleController.PI,
          k=3,
          Ti=1,
          initType=Modelica.Blocks.Types.InitPID.NoInit,
          reverseActing=false)                           annotation (Placement(
              transformation(
              extent={{-10,-10},{10,10}},
              rotation=0,
              origin={-30,70})));
        Modelica.Blocks.Sources.Ramp ramp(height=15, duration=100)
          annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
      equation
        connect(ramp.y, conPID2.u_m) annotation (Line(points={{-59,30},{-30,30},
                {-30,58}}, color={0,0,127}));
        connect(dp_set.y, conPID2.u_s)
          annotation (Line(points={{-59,70},{-42,70}}, color={0,0,127}));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
              coordinateSystem(preserveAspectRatio=false)));
      end pid;
    end Tests;
  end DEC;

  package DEG
    extends Modelica.Icons.VariantsPackage;
    package Tests
      extends Modelica.Icons.ExamplesPackage;
    end Tests;
  end DEG;

  package PEM
    extends Modelica.Icons.VariantsPackage;

    model pem
      extends Fluid.Interfaces.EightPort_modif;
      Fluid.Movers.FlowControlled_dp fan(
        redeclare package Medium = Media.Water,
        redeclare Fluid.Movers.Data.Generic per,
        inputType=Buildings.Fluid.Types.InputType.Constant,
        constantHead=87000)
        annotation (Placement(transformation(extent={{-10,-10},{10,10}},
            rotation=0,
            origin={90,-70})));
      Fluid.Sensors.TemperatureTwoPort TT200(redeclare package Medium =
            Media.Sea_Water, m_flow_nominal=m_flow_pem)
                        annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={74,-14})));
      Fluid.FixedResistances.Junction jun(
        redeclare package Medium = Media.Sea_Water,
        m_flow_nominal=m_flow_pem*{1,-1,-1},
        dp_nominal={0,0,0})                                       annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={18,38})));
      Fluid.Sensors.MassFlowRate FQT200(redeclare package Medium =
            Media.Sea_Water)
        annotation (Placement(transformation(extent={{-10,-10},{10,10}},
            rotation=0,
            origin={106,0})));
      Fluid.Sensors.TemperatureTwoPort TT201(redeclare package Medium =
            Media.Sea_Water, m_flow_nominal=m_flow_pem) annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={-28,-46})));
    equation
      connect(port_b1, port_a2)
        annotation (Line(points={{20,100},{-40,100}}, color={0,127,255}));
      connect(port_b2, port_a3) annotation (Line(points={{-80,100},{-88,100},{
              -88,60},{-100,60}}, color={0,127,255}));
      connect(port_b3, port_a4)
        annotation (Line(points={{-100,20},{-100,-40}}, color={0,127,255}));
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

    model EDM
      extends Interfaces.SixtPort_modif;

      parameter Modelica.SIunits.MassFlowRate m_flow_pem= 1800 * 1027 / 3600
        "Nominal mass flow rate at condenser water in the chillers";


      Fluid.Sources.Boundary_pT sortie(redeclare package Medium =
            Buildings.Applications.DHC_Marseille.Media.Sea_Water, nPorts=1) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-70,-90})));
      Fluid.FixedResistances.Junction jun(redeclare package Medium =
            Buildings.Applications.DHC_Marseille.Media.Sea_Water,
        m_flow_nominal=m_flow_pem*{1,-1,-1},
        dp_nominal={0,0,0})                                       annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={70,-50})));
      Fluid.FixedResistances.Junction jun1(redeclare package Medium =
            Buildings.Applications.DHC_Marseille.Media.Sea_Water,
        m_flow_nominal=m_flow_pem * {1,-1,-1},
        dp_nominal={0,0,0})         annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={70,50})));
      Fluid.FixedResistances.Junction jun2(redeclare package Medium =
            Buildings.Applications.DHC_Marseille.Media.Sea_Water,
        m_flow_nominal=m_flow_pem * {1,-1,-1},
        dp_nominal={0,0,0})         annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={50,70})));
      Fluid.FixedResistances.Junction jun3(redeclare package Medium =
            Buildings.Applications.DHC_Marseille.Media.Sea_Water,
        m_flow_nominal=m_flow_pem * {1,-1,-1},
        dp_nominal={0,0,0})         annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={-50,70})));
      Fluid.FixedResistances.Junction jun4(redeclare package Medium =
            Buildings.Applications.DHC_Marseille.Media.Sea_Water,
        m_flow_nominal=m_flow_pem * {1,-1,-1},
        dp_nominal={0,0,0})         annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=-90,
            origin={-70,50})));
      Fluid.FixedResistances.Junction jun5(redeclare package Medium =
            Buildings.Applications.DHC_Marseille.Media.Sea_Water,
        m_flow_nominal=m_flow_pem * {1,-1,-1},
        dp_nominal={0,0,0})         annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=-90,
            origin={-70,-50})));
      Fluid.Movers.FlowControlled_dp fan(
        redeclare package Medium =
            Buildings.Applications.DHC_Marseille.Media.Sea_Water,
        m_flow_nominal=m_flow_pem,
        redeclare Fluid.Movers.Data.Generic per,
        inputType=Buildings.Fluid.Types.InputType.Constant,
        dp_nominal=1000,
        constantHead=87000)
        annotation (Placement(transformation(extent={{-10,-10},{10,10}},
            rotation=270,
            origin={30,-10})));
      Fluid.Sources.Boundary_pT entree(
        redeclare package Medium =
            Buildings.Applications.DHC_Marseille.Media.Sea_Water,
        p=100000,
        T=291.15,
        nPorts=1) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={-10,30})));
      Fluid.Sensors.MassFlowRate senMasFlo(redeclare package Medium =
            Buildings.Applications.DHC_Marseille.Media.Sea_Water)
        annotation (Placement(transformation(extent={{40,-90},{60,-70}})));
      Fluid.Sensors.TemperatureTwoPort senTem(redeclare package Medium =
            Buildings.Applications.DHC_Marseille.Media.Sea_Water, m_flow_nominal=
            m_flow_pem)                                           annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={30,-50})));
    equation
      connect(jun.port_3, port_a1) annotation (Line(points={{80,-50},{90,-50},{
              90,-50},{100,-50}}, color={0,127,255}));
      connect(jun.port_2, jun1.port_1)
        annotation (Line(points={{70,-40},{70,40}}, color={0,127,255}));
      connect(jun1.port_3, port_b1)
        annotation (Line(points={{80,50},{100,50}}, color={0,127,255}));
      connect(jun1.port_2, jun2.port_1)
        annotation (Line(points={{70,60},{70,70},{60,70}}, color={0,127,255}));
      connect(port_a2, jun2.port_3) annotation (Line(points={{50,100},{50,100},
              {50,80}}, color={0,127,255}));
      connect(jun2.port_2, jun3.port_1)
        annotation (Line(points={{40,70},{-40,70}}, color={0,127,255}));
      connect(jun3.port_3, port_b2)
        annotation (Line(points={{-50,80},{-50,100}}, color={0,127,255}));
      connect(jun3.port_2, jun4.port_1) annotation (Line(points={{-60,70},{-70,
              70},{-70,60}}, color={0,127,255}));
      connect(jun4.port_3, port_a3)
        annotation (Line(points={{-80,50},{-100,50}}, color={0,127,255}));
      connect(port_b3, jun5.port_3)
        annotation (Line(points={{-100,-50},{-80,-50}}, color={0,127,255}));
      connect(jun5.port_1, jun4.port_2)
        annotation (Line(points={{-70,-40},{-70,40}}, color={0,127,255}));
      connect(entree.ports[1], fan.port_a)
        annotation (Line(points={{0,30},{30,30},{30,0}}, color={0,127,255}));
      connect(fan.port_b, senTem.port_a)
        annotation (Line(points={{30,-20},{30,-40}}, color={0,127,255}));
      connect(senTem.port_b, senMasFlo.port_a)
        annotation (Line(points={{30,-60},{30,-80},{40,-80}}, color={0,127,255}));
      connect(senMasFlo.port_b, jun.port_1)
        annotation (Line(points={{60,-80},{70,-80},{70,-60}}, color={0,127,255}));
      connect(jun5.port_2, sortie.ports[1])
        annotation (Line(points={{-70,-60},{-70,-80}}, color={0,127,255}));
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
    end EDM;

    model EDM_1
      extends Interfaces.SixtPort_modif;

      parameter Modelica.SIunits.MassFlowRate m_flow_pem= 1800 * 1027 / 3600
        "Nominal mass flow rate in the EDM loop";

      Fluid.Sources.Boundary_pT sortie(redeclare package Medium =
            Buildings.Applications.DHC_Marseille.Media.Sea_Water, nPorts=1) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={-10,-90})));
      Fluid.FixedResistances.Junction jun(redeclare package Medium =
            Buildings.Applications.DHC_Marseille.Media.Sea_Water,
        m_flow_nominal=m_flow_pem * {1,-1,-1},
        dp_nominal={0,0,0})                                       annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={70,-50})));
      Fluid.FixedResistances.Junction jun1(redeclare package Medium =
            Buildings.Applications.DHC_Marseille.Media.Sea_Water,
        m_flow_nominal=m_flow_pem * {1,-1,-1},
        dp_nominal={0,0,0})         annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={70,50})));
      Fluid.FixedResistances.Junction jun2(redeclare package Medium =
            Buildings.Applications.DHC_Marseille.Media.Sea_Water,
        m_flow_nominal=m_flow_pem * {1,-1,-1},
        dp_nominal={0,0,0})         annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={50,70})));
      Fluid.FixedResistances.Junction jun3(redeclare package Medium =
            Buildings.Applications.DHC_Marseille.Media.Sea_Water,
        m_flow_nominal=m_flow_pem * {1,-1,-1},
        dp_nominal={0,0,0})         annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={-50,70})));
      Fluid.FixedResistances.Junction jun4(redeclare package Medium =
            Buildings.Applications.DHC_Marseille.Media.Sea_Water,
        m_flow_nominal=m_flow_pem * {1,-1,-1},
        dp_nominal={0,0,0})         annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=-90,
            origin={-70,50})));
      Fluid.FixedResistances.Junction jun5(redeclare package Medium =
            Buildings.Applications.DHC_Marseille.Media.Sea_Water,
        m_flow_nominal=m_flow_pem * {1,-1,-1},
        dp_nominal={0,0,0})         annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=-90,
            origin={-70,-50})));
      Fluid.Sensors.MassFlowRate FQT200(redeclare package Medium =
            Buildings.Applications.DHC_Marseille.Media.Sea_Water)
        annotation (Placement(transformation(extent={{40,-90},{60,-70}})));
      Fluid.Sensors.TemperatureTwoPort TT200(redeclare package Medium =
            Buildings.Applications.DHC_Marseille.Media.Sea_Water, m_flow_nominal=
            m_flow_pem) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={30,-50})));
      Fluid.Sources.MassFlowSource_T boundary(
        redeclare package Medium =
            Buildings.Applications.DHC_Marseille.Media.Sea_Water,
        m_flow=m_flow_pem,
        nPorts=1) annotation (Placement(transformation(extent={{-20,0},{0,20}})));
      Fluid.Sensors.TemperatureTwoPort TT201(redeclare package Medium =
            Media.Sea_Water, m_flow_nominal=m_flow_pem) annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={-50,-90})));
    equation
      connect(jun.port_3, port_a1) annotation (Line(points={{80,-50},{90,-50},{
              90,-50},{100,-50}}, color={0,127,255}));
      connect(jun.port_2, jun1.port_1)
        annotation (Line(points={{70,-40},{70,40}}, color={0,127,255}));
      connect(jun1.port_3, port_b1)
        annotation (Line(points={{80,50},{100,50}}, color={0,127,255}));
      connect(jun1.port_2, jun2.port_1)
        annotation (Line(points={{70,60},{70,70},{60,70}}, color={0,127,255}));
      connect(port_a2, jun2.port_3) annotation (Line(points={{50,100},{50,100},
              {50,80}}, color={0,127,255}));
      connect(jun2.port_2, jun3.port_1)
        annotation (Line(points={{40,70},{-40,70}}, color={0,127,255}));
      connect(jun3.port_3, port_b2)
        annotation (Line(points={{-50,80},{-50,100}}, color={0,127,255}));
      connect(jun3.port_2, jun4.port_1) annotation (Line(points={{-60,70},{-70,
              70},{-70,60}}, color={0,127,255}));
      connect(jun4.port_3, port_a3)
        annotation (Line(points={{-80,50},{-100,50}}, color={0,127,255}));
      connect(port_b3, jun5.port_3)
        annotation (Line(points={{-100,-50},{-80,-50}}, color={0,127,255}));
      connect(jun5.port_1, jun4.port_2)
        annotation (Line(points={{-70,-40},{-70,40}}, color={0,127,255}));
      connect(TT200.port_b, FQT200.port_a)
        annotation (Line(points={{30,-60},{30,-80},{40,-80}}, color={0,127,255}));
      connect(FQT200.port_b, jun.port_1)
        annotation (Line(points={{60,-80},{70,-80},{70,-60}}, color={0,127,255}));
      connect(boundary.ports[1], TT200.port_a)
        annotation (Line(points={{0,10},{30,10},{30,-40}}, color={0,127,255}));
      connect(jun5.port_2, TT201.port_a) annotation (Line(points={{-70,-60},{-70,-90},
              {-60,-90}}, color={0,127,255}));
      connect(TT201.port_b, sortie.ports[1])
        annotation (Line(points={{-40,-90},{-20,-90}}, color={0,127,255}));
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
    end EDM_1;

    model EDM_chiller
      extends Fluid.Interfaces.PartialTwoPort;

      parameter Modelica.SIunits.MassFlowRate m_flow_pem= 1800 * 1027 / 3600
        "Nominal mass flow rate in the EDM loop";


      Fluid.Sources.Boundary_pT sortie(redeclare package Medium =
            Media.Sea_Water,
          nPorts=1)                                                         annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={50,90})));
      Fluid.FixedResistances.Junction jun(
        redeclare package Medium = Media.Sea_Water,
        m_flow_nominal=m_flow_pem*{1,-1,-1},
        dp_nominal={0,0,0})                                       annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=0,
            origin={-70,0})));
      Fluid.FixedResistances.Junction jun1(
        redeclare package Medium = Media.Sea_Water,
        m_flow_nominal=m_flow_pem*{1,-1,-1},
        dp_nominal={0,0,0})         annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={50,0})));
      Fluid.Sensors.MassFlowRate FQT200(redeclare package Medium =
            Media.Sea_Water)
        annotation (Placement(transformation(extent={{-20,-10},{-40,10}})));
      Fluid.Sensors.TemperatureTwoPort TT200(redeclare package Medium =
            Media.Sea_Water, m_flow_nominal=m_flow_pem) annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={-30,50})));
      Fluid.Sources.MassFlowSource_T boundary(
        redeclare package Medium = Media.Sea_Water,
        m_flow=m_flow_pem,
        nPorts=1) annotation (Placement(transformation(extent={{-100,40},{-80,60}})));
      Fluid.Sensors.TemperatureTwoPort TT201(redeclare package Medium =
            Media.Sea_Water, m_flow_nominal=m_flow_pem) annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={50,40})));
    equation
      connect(boundary.ports[1], TT200.port_a)
        annotation (Line(points={{-80,50},{-40,50}}, color={0,127,255}));
      connect(jun.port_1, FQT200.port_b) annotation (Line(points={{-60,0},{-50,0},{-50,
              0},{-40,0}}, color={0,127,255}));
      connect(jun.port_2, port_a)
        annotation (Line(points={{-80,0},{-100,0}}, color={0,127,255}));
      connect(TT200.port_b, FQT200.port_a) annotation (Line(points={{-20,50},{-10,50},
              {-10,0},{-20,0}}, color={0,127,255}));
      connect(jun.port_3, jun1.port_1) annotation (Line(points={{-70,-10},{-70,-32},
              {50,-32},{50,-10}}, color={0,127,255}));
      connect(jun1.port_2, TT201.port_a)
        annotation (Line(points={{50,10},{50,10},{50,30}}, color={0,127,255}));
      connect(TT201.port_b, sortie.ports[1])
        annotation (Line(points={{50,50},{50,80}}, color={0,127,255}));
      connect(jun1.port_3, port_b) annotation (Line(points={{60,-4.44089e-16},{80,-4.44089e-16},
              {80,0},{100,0}}, color={0,127,255}));
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
    end EDM_chiller;
  end PEM;

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
              "modelica://Buildings/Data/gf1.txt"),
          columns={2,3,4,5},
          extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
          offset={0})
          annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
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

      model pid_b
        Modelica.Blocks.Sources.Constant pression(k=1.87)
          "Scaled differential pressure setpoint"
          annotation (Placement(transformation(extent={{-80,40},{-60,60}})));
        Controls.Continuous.LimPID TT_PID(
          controllerType=Modelica.Blocks.Types.SimpleController.PI,
          k=1,
          Ti=2.5,
          reverseActing=true)
                 annotation (Placement(transformation(extent={{-40,40},{-20,60}})));
        Modelica.Blocks.Sources.Constant pression1(k=1.90)
          "Scaled differential pressure setpoint"
          annotation (Placement(transformation(extent={{-80,0},{-60,20}})));
      equation
        connect(pression.y, TT_PID.u_s)
          annotation (Line(points={{-59,50},{-42,50}}, color={0,0,127}));
        connect(pression1.y, TT_PID.u_m) annotation (Line(points={{-59,10},{-30,
                10},{-30,38}}, color={0,0,127}));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
              coordinateSystem(preserveAspectRatio=false)));
      end pid_b;

      model tfp_table
        Modelica.Blocks.Sources.CombiTimeTable combiTimeTable(
          tableOnFile=true,
          tableName="tab1",
          fileName=ModelicaServices.ExternalReferences.loadResource(
              "modelica://Buildings/Data/tfp.txt"),
          columns={7,8,11,12})
          annotation (Placement(transformation(extent={{-60,20},{-40,40}})));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
              coordinateSystem(preserveAspectRatio=false)));
      end tfp_table;
    end data_table;

    model mass_flow
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

    model test_PID
      Modelica.Blocks.Sources.Constant TT_Set(k=30)
        "Scaled differential pressure setpoint"
        annotation (Placement(transformation(extent={{-60,40},{-40,60}})));
      Controls.Continuous.LimPID TT_PID(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=0.05,
        Ti=20) annotation (Placement(transformation(extent={{-20,40},{0,60}})));
      Modelica.Blocks.Sources.Ramp ramp(
        height=50,
        duration=60,
        startTime=20)
        annotation (Placement(transformation(extent={{-60,0},{-40,20}})));
      Modelica.Blocks.Sources.Constant TDT_Set(k=5)
        "Scaled differential pressure setpoint"
        annotation (Placement(transformation(extent={{-60,140},{-40,160}})));
      Controls.Continuous.LimPID TDT_PID(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=2.5,
        Ti=1.7)
        annotation (Placement(transformation(extent={{-20,140},{0,160}})));
      Modelica.Blocks.Sources.Ramp ramp1(
        height=2,
        duration=50,
        offset=4,
        startTime=10)
        annotation (Placement(transformation(extent={{-60,100},{-40,120}})));
      Modelica.Blocks.Math.MinMax maxi(nu=2)
        annotation (Placement(transformation(extent={{40,140},{60,160}})));
    equation
      connect(TT_Set.y, TT_PID.u_s)
        annotation (Line(points={{-39,50},{-22,50}}, color={0,0,127}));
      connect(ramp.y, TT_PID.u_m) annotation (Line(points={{-39,10},{-10,10},{
              -10,38}}, color={0,0,127}));
      connect(TDT_Set.y, TDT_PID.u_s)
        annotation (Line(points={{-39,150},{-22,150}}, color={0,0,127}));
      connect(ramp1.y, TDT_PID.u_m) annotation (Line(points={{-39,110},{-10,110},
              {-10,138}}, color={0,0,127}));
      connect(TDT_PID.y, maxi.u[1]) annotation (Line(points={{1,150},{10,150},{
              10,153.5},{40,153.5}}, color={0,0,127}));
      connect(TT_PID.y, maxi.u[2]) annotation (Line(points={{1,50},{20,50},{20,
              146.5},{40,146.5}}, color={0,0,127}));
      annotation (
        Icon(coordinateSystem(preserveAspectRatio=false)),
        Diagram(coordinateSystem(preserveAspectRatio=false)),
        experiment(
          StopTime=80,
          Interval=1,
          __Dymola_Algorithm="Dassl"));
    end test_PID;

    package parts
      model test_debit
        Fluid.Movers.SpeedControlled_y fan(
          redeclare package Medium =
              Buildings.Applications.DHC_Marseille.Media.Sea_Water,
          redeclare Fluid.Movers.Data.KSB_edm per,
          inputType=Buildings.Fluid.Types.InputType.Continuous,
          addPowerToMedium=false)
          annotation (Placement(transformation(extent={{-20,100},{0,120}})));
        Modelica.Blocks.Sources.Ramp ramp(duration=200, startTime=100)
          annotation (Placement(transformation(extent={{-120,80},{-100,100}})));
        Fluid.Sources.Boundary_pT sortie_e(
          redeclare package Medium =
              Buildings.Applications.DHC_Marseille.Media.Sea_Water,
          p=100000,
          use_T_in=false)
          annotation (Placement(transformation(extent={{-140,0},{-120,20}})));
        Fluid.Movers.SpeedControlled_y fan1(
          redeclare package Medium = Media.Sea_Water,
          redeclare Fluid.Movers.Data.KSB_edm per,
          inputType=Buildings.Fluid.Types.InputType.Continuous,
          addPowerToMedium=false)
          annotation (Placement(transformation(extent={{-20,60},{0,80}})));
        Fluid.Movers.SpeedControlled_y fan2(
          redeclare package Medium = Media.Sea_Water,
          redeclare Fluid.Movers.Data.KSB_edm per,
          inputType=Buildings.Fluid.Types.InputType.Continuous,
          addPowerToMedium=false)
          annotation (Placement(transformation(extent={{-20,20},{0,40}})));
        Fluid.Movers.SpeedControlled_y fan3(
          redeclare package Medium = Media.Sea_Water,
          redeclare Fluid.Movers.Data.KSB_edm per,
          inputType=Buildings.Fluid.Types.InputType.Continuous,
          addPowerToMedium=false)
          annotation (Placement(transformation(extent={{-20,-20},{0,0}})));
        Fluid.Movers.SpeedControlled_y fan4(
          redeclare package Medium = Media.Sea_Water,
          redeclare Fluid.Movers.Data.KSB_edm per,
          inputType=Buildings.Fluid.Types.InputType.Continuous,
          addPowerToMedium=false)
          annotation (Placement(transformation(extent={{-20,-60},{0,-40}})));
        Fluid.Movers.SpeedControlled_y fan5(
          redeclare package Medium = Media.Sea_Water,
          redeclare Fluid.Movers.Data.KSB_edm per,
          inputType=Buildings.Fluid.Types.InputType.Continuous,
          addPowerToMedium=false)
          annotation (Placement(transformation(extent={{-20,-100},{0,-80}})));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{
                  -140,-140},{140,140}})),                             Diagram(
              coordinateSystem(preserveAspectRatio=false, extent={{-140,-140},{
                  140,140}})),
          experiment(
            StopTime=400,
            Interval=10,
            __Dymola_Algorithm="Dassl"));
      end test_debit;

      model PumpsSeries "Two flow machines in series"
        extends Modelica.Icons.Example;
        package Medium = Buildings.Media.Water;

        parameter Modelica.SIunits.MassFlowRate m_flow_nominal=1
          "Nominal mass flow rate";

        Buildings.Fluid.Movers.SpeedControlled_y floMac1(
          redeclare package Medium = Medium,
          per(pressure(V_flow={0, m_flow_nominal/1000}, dp={2*4*1000, 0})),
          energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState)
          "Model of a flow machine"
          annotation (Placement(transformation(extent={{-20,50},{0,70}})));

        Buildings.Fluid.Sources.Boundary_pT sou(
          redeclare package Medium = Medium,
          use_p_in=false,
          p(displayUnit="Pa") = 300000,
          T=293.15,
          nPorts=1) annotation (Placement(transformation(extent={{-92,50},{-72,70}})));

        parameter Medium.ThermodynamicState state_start = Medium.setState_pTX(
            T=Medium.T_default,
            p=Medium.p_default,
            X=Medium.X_default) "Start state";
        parameter Modelica.SIunits.Density rho_nominal=Medium.density(
           state_start) "Density, used to compute fluid mass";

        Buildings.Fluid.Movers.SpeedControlled_y floMac2(
          redeclare package Medium = Medium,
          per(pressure(V_flow={0, m_flow_nominal/1000}, dp={2*4*1000, 0})),
          inputType=Buildings.Fluid.Types.InputType.Constant,
          energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState)
          "Model of a flow machine"
          annotation (Placement(transformation(extent={{60,50},{80,70}})));
        Modelica.Blocks.Sources.Step const1(
          height=-1,
          offset=1,
          startTime=150)
          annotation (Placement(transformation(extent={{-40,80},{-20,100}})));
        Buildings.Fluid.Sources.Boundary_pT sou1(
          redeclare package Medium = Medium,
          use_p_in=false,
          p(displayUnit="Pa") = 300000 + 4000,
          T=293.15,
          nPorts=1) annotation (Placement(transformation(extent={{156,50},{136,70}})));
      equation
        connect(const1.y, floMac1.y) annotation (Line(
            points={{-19,90},{-10,90},{-10,72}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(floMac1.port_b, floMac2.port_a) annotation (Line(
            points={{5.55112e-16,60},{60,60}},
            color={0,127,255}));
        connect(sou.ports[1], floMac1.port_a) annotation (Line(
            points={{-72,60},{-20,60}},
            color={0,127,255}));
        connect(floMac2.port_b, sou1.ports[1]) annotation (Line(
            points={{80,60},{136,60}},
            color={0,127,255}));
        annotation (
          Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{160,
                  160}})),
          __Dymola_Commands(file="modelica://Buildings/Resources/Scripts/Dymola/Fluid/Movers/Examples/PumpsSeries.mos"
              "Simulate and plot"),
          Documentation(info="<html>
This example tests the configuration of two flow machines that are installed in series.
Both flow machines start with full speed.
At <i>t=150</i> seconds, the speed of the flow machine on the left is reduced to zero.
As its speed is reduced, the mass flow rate is reduced. Note that even at zero input, the mass flow rate is non-zero,
but the pressure drop of the pump <code>floMac1.dp</code> is positive, which means that this pump has a flow resistance.
However, <code>flowMac2.dp</code> is always negative, as this pump has a constant control input of 1.
</html>",       revisions="<html>
<ul>
<li>
April 2, 2015, by Filip Jorissen:<br/>
Set constant speed for pump using a <code>parameter</code>
instead of a <code>realInput</code>.
</li>
<li>
May 29, 2014, by Michael Wetter:<br/>
Removed undesirable annotation <code>Evaluate=true</code>.
</li>
<li>
February 14, 2012, by Michael Wetter:<br/>
Added filter for start-up and shut-down transient.
</li>
<li>
March 24 2010, by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"),experiment(
            StopTime=300,
            Tolerance=1e-06));
      end PumpsSeries;

      model aaa
        Fluid.Sources.Boundary_pT bou1(
          redeclare package Medium =
              Buildings.Applications.DHC_Marseille.Media.Sea_Water,
          p=100000,
          nPorts=1)
          annotation (Placement(transformation(extent={{-100,-40},{-80,-20}})));
        Fluid.Sources.Boundary_pT bou2(
          redeclare package Medium =
              Buildings.Applications.DHC_Marseille.Media.Sea_Water,
          p=300000,
          nPorts=1)
          annotation (Placement(transformation(extent={{100,-40},{80,-20}})));
        Fluid.Movers.SpeedControlled_y fan(
          redeclare package Medium =
              Buildings.Applications.DHC_Marseille.Media.Sea_Water,
          redeclare Fluid.Movers.Data.KSB_edm per,
          inputType=Buildings.Fluid.Types.InputType.Continuous,
          addPowerToMedium=false)
          annotation (Placement(transformation(extent={{-20,-40},{0,-20}})));
        Modelica.Blocks.Sources.Ramp ramp(duration=100, startTime=100)
          annotation (Placement(transformation(extent={{-40,20},{-20,40}})));
      equation
        connect(ramp.y, fan.y)
          annotation (Line(points={{-19,30},{-10,30},{-10,-18}}, color={0,0,127}));
        connect(bou1.ports[1], fan.port_a) annotation (Line(points={{-80,-30},{-52,-30},
                {-52,-30},{-20,-30}}, color={0,127,255}));
        connect(fan.port_b, bou2.ports[1])
          annotation (Line(points={{0,-30},{80,-30}}, color={0,127,255}));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
              coordinateSystem(preserveAspectRatio=false)));
      end aaa;
    end parts;
  end Miscellaneous;

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
       cp_const=3979,
       d_const= 1027,
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

  annotation (preferredView="info", Documentation(info="<html>
<p>This package contains media models for sea water. The media models in this package are compatible with <a href=\"modelica://Modelica.Media\">Modelica.Media</a> but the implementation is in general simpler, which often leads to more efficient simulation. Due to the simplifications, the media model of this package are generally accurate for a smaller temperature range than the models in <a href=\"modelica://Modelica.Media\">Modelica.Media</a>, but the smaller temperature range may often be sufficient for building HVAC applications. </p>
</html>"),
  Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
          graphics={
          Line(
            points = {{-76,-80},{-62,-30},{-32,40},{4,66},{48,66},{73,45},{62,-8},{48,-50},{38,-80}},
            color={64,64,64},
            smooth=Smooth.Bezier),
          Line(
            points={{-40,20},{68,20}},
            color={175,175,175}),
          Line(
            points={{-40,20},{-44,88},{-44,88}},
            color={175,175,175}),
          Line(
            points={{68,20},{86,-58}},
            color={175,175,175}),
          Line(
            points={{-60,-28},{56,-28}},
            color={175,175,175}),
          Line(
            points={{-60,-28},{-74,84},{-74,84}},
            color={175,175,175}),
          Line(
            points={{56,-28},{70,-80}},
            color={175,175,175}),
          Line(
            points={{-76,-80},{38,-80}},
            color={175,175,175}),
          Line(
            points={{-76,-80},{-94,-16},{-94,-16}},
            color={175,175,175})}));
  end Media;

  package debug
    model chiller_base
      Fluid.Chillers.ElectricReformulatedEIR electricReformulatedEIR(
        redeclare package Medium1 =
            Buildings.Applications.DHC_Marseille.Media.Sea_Water,
        redeclare package Medium2 = Buildings.Media.Water,
        dp1_nominal=2500,
        dp2_nominal=3000,
        per=Fluid.Chillers.Data.ElectricReformulatedEIR.Test_quantum())
                annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
      Fluid.Sources.MassFlowSource_T boundary(
        redeclare package Medium =
            Buildings.Applications.DHC_Marseille.Media.Sea_Water,
        m_flow=100,
        T=290.15,
        nPorts=1) annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
      Fluid.Sources.Boundary_pT bou(
        redeclare package Medium =
            Buildings.Applications.DHC_Marseille.Media.Sea_Water,
        p=100000,
        nPorts=1) annotation (Placement(transformation(extent={{100,40},{80,60}})));
      Fluid.Sources.Boundary_pT bou1(
        redeclare package Medium = Buildings.Media.Water,
        p=100000,
        nPorts=1)
        annotation (Placement(transformation(extent={{-100,-60},{-80,-40}})));
      Fluid.Sources.MassFlowSource_T boundary1(
        redeclare package Medium = Buildings.Media.Water,
        m_flow=15,
        T=298.15,
        nPorts=1) annotation (Placement(transformation(extent={{78,-60},{58,-40}})));
      Modelica.Blocks.Sources.RealExpression realExpression(y=4 + 273.15)
        annotation (Placement(transformation(extent={{-140,-30},{-120,-10}})));
      Modelica.Blocks.Sources.BooleanExpression booleanExpression(y=true)
        annotation (Placement(transformation(extent={{-140,10},{-120,30}})));
    equation
      connect(boundary1.ports[1], electricReformulatedEIR.port_a2) annotation (Line(
            points={{58,-50},{26,-50},{26,-6},{10,-6}}, color={0,127,255}));
      connect(boundary.ports[1], electricReformulatedEIR.port_a1) annotation (Line(
            points={{-60,30},{-34,30},{-34,6},{-10,6}}, color={0,127,255}));
      connect(realExpression.y, electricReformulatedEIR.TSet) annotation (Line(
            points={{-119,-20},{-66,-20},{-66,-3},{-12,-3}}, color={0,0,127}));
      connect(booleanExpression.y, electricReformulatedEIR.on) annotation (Line(
            points={{-119,20},{-66,20},{-66,3},{-12,3}}, color={255,0,255}));
      connect(bou1.ports[1], electricReformulatedEIR.port_b2) annotation (Line(
            points={{-80,-50},{-46,-50},{-46,-6},{-10,-6}}, color={0,127,255}));
      connect(electricReformulatedEIR.port_b1, bou.ports[1]) annotation (Line(
            points={{10,6},{46,6},{46,50},{80,50}}, color={0,127,255}));
      annotation (
        Icon(coordinateSystem(preserveAspectRatio=false)),
        Diagram(coordinateSystem(preserveAspectRatio=false)),
        experiment(
          StopTime=100000,
          Interval=50,
          __Dymola_Algorithm="Dassl"));
    end chiller_base;

    model ElectricReformulatedEIR
      "Test model for chiller electric reformulated EIR"
      extends Modelica.Icons.Example;
      extends Buildings.Applications.DHC_Marseille.debug.PartialElectric(
          P_nominal=-per.QEva_flow_nominal/per.COP_nominal,
          mEva_flow_nominal=per.mEva_flow_nominal,
          mCon_flow_nominal=per.mCon_flow_nominal,
        sou1(nPorts=1),
        sou2(nPorts=1),
        sin2(nPorts=1));

      parameter
        Fluid.Chillers.Data.ElectricReformulatedEIR.ReformEIRChiller_McQuay_WSC_471kW_5_89COP_Vanes
        per "Chiller performance data"
        annotation (Placement(transformation(extent={{60,80},{80,100}})));

      Buildings.Fluid.Chillers.ElectricReformulatedEIR chi(
           redeclare package Medium1 = Medium1,
           redeclare package Medium2 = Medium2,
           per=per,
           energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
           dp1_nominal=6000,
           dp2_nominal=6000) "Chiller model"
        annotation (Placement(transformation(extent={{0,0},{20,20}})));

      Fluid.Sensors.TemperatureTwoPort senTem(redeclare package Medium =
            Buildings.Media.Water, m_flow_nominal=mEva_flow_nominal)
        annotation (Placement(transformation(extent={{-12,-54},{8,-34}})));
    equation
      connect(sou1.ports[1], chi.port_a1) annotation (Line(
          points={{-40,16},{0,16}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(chi.port_b1, res1.port_a) annotation (Line(
          points={{20,16},{26,16},{26,40},{32,40}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(sou2.ports[1], chi.port_a2) annotation (Line(
          points={{40,4},{20,4}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(chi.on, greaterThreshold.y) annotation (Line(
          points={{-2,13},{-8,13},{-8,90},{-19,90}},
          color={255,0,255},
          smooth=Smooth.None));
      connect(TSet.y, chi.TSet) annotation (Line(
          points={{-59,60},{-20,60},{-20,8},{-2,8},{-2,7}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(chi.port_b2, senTem.port_b) annotation (Line(points={{0,4},{0,-20},{20,
              -20},{20,-44},{8,-44}}, color={0,127,255}));
      connect(senTem.port_a, sin2.ports[1]) annotation (Line(points={{-12,-44},
              {-36,-44},{-36,-20},{-60,-20}}, color={0,127,255}));
      annotation (
    experiment(Tolerance=1e-6, StopTime=14400),
    __Dymola_Commands(file="modelica://Buildings/Resources/Scripts/Dymola/Fluid/Chillers/Examples/ElectricReformulatedEIR.mos"
            "Simulate and plot"),    Documentation(info="<html>
<p>
Example that simulates a chiller whose efficiency is computed based on the
condenser leaving and evaporator leaving fluid temperature.
A bicubic polynomial is used to compute the chiller part load performance.
</p>
</html>",     revisions="<html>
<ul>
<li>
August 14, 2014, by Michael Wetter:<br/>
Added missing <code>redeclare</code> keyword in
performance data redeclaration.
This avoids an error in OpenModelica.
</li>
<li>
September 17, 2010, by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"));
    end ElectricReformulatedEIR;

    partial model PartialElectric
      "Base class for test model of chiller electric EIR"
     package Medium1 = Buildings.Media.Water "Medium model";
     package Medium2 = Buildings.Media.Water "Medium model";

      parameter Modelica.SIunits.Power P_nominal
        "Nominal compressor power (at y=1)";
      parameter Modelica.SIunits.TemperatureDifference dTEva_nominal=10
        "Temperature difference evaporator inlet-outlet";
      parameter Modelica.SIunits.TemperatureDifference dTCon_nominal=10
        "Temperature difference condenser outlet-inlet";
      parameter Real COPc_nominal = 3 "Chiller COP";
      parameter Modelica.SIunits.MassFlowRate mEva_flow_nominal
        "Nominal mass flow rate at evaporator";
      parameter Modelica.SIunits.MassFlowRate mCon_flow_nominal
        "Nominal mass flow rate at condenser";

      Buildings.Fluid.Sources.MassFlowSource_T sou1(
        redeclare package Medium = Medium1,
        use_T_in=true,
        m_flow=mCon_flow_nominal,
        T=298.15)
        annotation (Placement(transformation(extent={{-60,6},{-40,26}})));
      Buildings.Fluid.Sources.MassFlowSource_T sou2(
        redeclare package Medium = Medium2,
        use_T_in=true,
        m_flow=mEva_flow_nominal,
        T=291.15)
        annotation (Placement(transformation(extent={{60,-6},{40,14}})));
      Buildings.Fluid.Sources.Boundary_pT sin1(
        redeclare package Medium = Medium1,
        nPorts=1)                           annotation (Placement(
            transformation(
            extent={{10,-10},{-10,10}},
            origin={70,40})));
      Buildings.Fluid.Sources.Boundary_pT sin2(
        redeclare package Medium = Medium2) annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            origin={-70,-20})));
      Modelica.Blocks.Sources.Ramp TSet(
        duration=3600,
        startTime=3*3600,
        offset=273.15 + 10,
        height=8) "Set point for leaving chilled water temperature"
        annotation (Placement(transformation(extent={{-80,50},{-60,70}})));
      Modelica.Blocks.Sources.Ramp TCon_in(
        height=10,
        offset=273.15 + 20,
        duration=3600,
        startTime=2*3600) "Condenser inlet temperature"
        annotation (Placement(transformation(extent={{-90,10},{-70,30}})));
      Modelica.Blocks.Sources.Ramp TEva_in(
        offset=273.15 + 15,
        height=5,
        startTime=3600,
        duration=3600) "Evaporator inlet temperature"
        annotation (Placement(transformation(extent={{50,-40},{70,-20}})));
      Modelica.Blocks.Sources.Pulse pulse(period=3600/2)
        annotation (Placement(transformation(extent={{-80,80},{-60,100}})));
      Modelica.Blocks.Logical.GreaterThreshold greaterThreshold(threshold=0.5)
        annotation (Placement(transformation(extent={{-40,80},{-20,100}})));
      Buildings.Fluid.FixedResistances.PressureDrop res1(
        redeclare package Medium = Medium1,
        m_flow_nominal=mCon_flow_nominal,
        dp_nominal=6000) "Flow resistance"
        annotation (Placement(transformation(extent={{32,30},{52,50}})));
    equation
      connect(TCon_in.y, sou1.T_in) annotation (Line(
          points={{-69,20},{-62,20}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(TEva_in.y, sou2.T_in) annotation (Line(
          points={{71,-30},{80,-30},{80,8},{62,8}},
          color={0,0,127},
          smooth=Smooth.None));

      connect(greaterThreshold.u, pulse.y) annotation (Line(
          points={{-42,90},{-59,90}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(res1.port_b, sin1.ports[1]) annotation (Line(
          points={{52,40},{60,40}},
          color={0,127,255},
          smooth=Smooth.None));
    end PartialElectric;

    model FlowJunction "Test model for the three way splitter/mixer model"
      extends Modelica.Icons.Example;

     package Medium = Buildings.Media.Air "Medium model";

      Buildings.Fluid.FixedResistances.Junction spl(
        redeclare package Medium = Medium,
        m_flow_nominal={10,10,-10},
        dp_nominal={5,-5,-5000},
        energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial) "Splitter"
        annotation (Placement(transformation(extent={{10,-10},{30,10}})));

      Buildings.Fluid.Sources.Boundary_pT bou1(
        redeclare package Medium = Medium,
        T=273.15 + 10,
        use_p_in=true,
        nPorts=1)
        "Pressure boundary condition"
         annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));

      Buildings.Fluid.Sources.Boundary_pT bou2(
        redeclare package Medium = Medium,
        T=273.15 + 20,
        p(displayUnit="Pa") = 101325,
        nPorts=1)
        "Pressure boundary condition"
        annotation (Placement(transformation(
              extent={{90,-10},{70,10}})));

      Buildings.Fluid.Sources.Boundary_pT bou3(
        redeclare package Medium = Medium,
        T=273.15 + 30,
        use_p_in=true,
        nPorts=1)
        "Pressure boundary condition"
        annotation (Placement(transformation(
              extent={{-60,-70},{-40,-50}})));

        Modelica.Blocks.Sources.Ramp P1(
        offset=101320,
        height=10,
        duration=20,
        startTime=20)
        "Ramp pressure signal"
        annotation (Placement(transformation(extent={{-90,-2},{-70,18}})));

        Modelica.Blocks.Sources.Ramp P3(
          offset=101320,
          height=10,
          duration=20,
          startTime=70)
        "Ramp pressure signal"
        annotation (Placement(transformation(extent={{-92,-62},{-72,-42}})));

      Buildings.Fluid.Sensors.TemperatureTwoPort senTem1(
        redeclare package Medium = Medium,
        m_flow_nominal=1)
        "Temperature sensor"
        annotation (Placement(transformation(extent={{-20,-10},{0,10}})));

      Buildings.Fluid.Sensors.TemperatureTwoPort senTem2(
        redeclare package Medium = Medium,
        m_flow_nominal=2)
        "Temperature sensor"
        annotation (Placement(transformation(extent={{40,-10},{60,10}})));

      Buildings.Fluid.Sensors.TemperatureTwoPort senTem3(
        redeclare package Medium = Medium,
        m_flow_nominal=3)
        "Temperature sensor"
        annotation (Placement(transformation(extent={{-20,-70},{0,-50}})));

    equation
      connect(P1.y, bou1.p_in)
        annotation (Line(points={{-69,8},{-69,8},{-62,8}},
                        color={0,0,127}));
      connect(bou3.p_in, P3.y)
        annotation (Line(points={{-62,-52},{-62,-52},{-71,-52}},
                                                       color={0,0,127}));
      connect(bou3.ports[1], senTem3.port_a) annotation (Line(points={{-40,-60},{-40,
              -60},{-20,-60}}, color={0,127,255}));
      connect(senTem3.port_b, spl.port_3)
        annotation (Line(points={{0,-60},{20,-60},{20,-10}}, color={0,127,255}));
      connect(bou1.ports[1], senTem1.port_a)
        annotation (Line(points={{-40,0},{-30,0},{-20,0}}, color={0,127,255}));
      connect(senTem1.port_b, spl.port_1)
        annotation (Line(points={{0,0},{5,0},{10,0}}, color={0,127,255}));
      connect(spl.port_2, senTem2.port_a)
        annotation (Line(points={{30,0},{35,0},{40,0}}, color={0,127,255}));
      connect(senTem2.port_b, bou2.ports[1])
        annotation (Line(points={{60,0},{70,0}},        color={0,127,255}));
      annotation (experiment(Tolerance=1e-6, StopTime=100),
    __Dymola_Commands(file="modelica://Buildings/Resources/Scripts/Dymola/Fluid/FixedResistances/Examples/FlowJunction.mos"
            "Simulate and plot"),
    Documentation(info="<html>
<p>
This model demonstrates the use of the flow junction model
for different flow directions.
The example is configured such that the flow changes its direction in
each flow leg between <i>t = 0</i> seconds to <i>t = 100</i> seconds.
</p>
</html>",     revisions="<html>
<ul>
<li>
November 2, 2017, by Michael Wetter:<br/>
Removed import statement.
</li>
<li>
October 14, 2017 by Michael Wetter:<br/>
Updated documentation and added to Annex 60 library.<br/>
This is for
<a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/451\">issue 451</a>.
</li>
<li>
July 20, 2007 by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"));
    end FlowJunction;

    model test_transition
      block State1
        Modelica.Blocks.Sources.Constant const(k=10)
          annotation (Placement(transformation(extent={{-60,20},{-40,40}})));
        Modelica.Blocks.Interfaces.RealOutput
                   y "Connector of Real output signal" annotation (Placement(
              transformation(extent={{100,0},{120,20}})));
      equation
        connect(const.y, y) annotation (Line(points={{-39,30},{30,30},{30,10},{
                110,10}}, color={0,0,127}));
        annotation (
          Icon(coordinateSystem(preserveAspectRatio=false), graphics={Text(
                extent={{-100,100},{100,-100}},
                lineColor={0,0,0},
                textString="%name")}),
          Diagram(coordinateSystem(preserveAspectRatio=false), graphics={Text(
                extent={{-100,100},{100,-100}},
                lineColor={0,0,0},
                textString="%stateName",
                fontSize=10)}),
          __Dymola_state=true,
          showDiagram=true,
          singleInstance=true);
      end State1;
      State1 state1
        annotation (Placement(transformation(extent={{-20,40},{0,60}})));
      block State2
        Modelica.Blocks.Sources.Constant const(k=20)
          annotation (Placement(transformation(extent={{-60,20},{-40,40}})));
        annotation (
          Icon(coordinateSystem(preserveAspectRatio=false), graphics={Text(
                extent={{-100,100},{100,-100}},
                lineColor={0,0,0},
                textString="%name")}),
          Diagram(coordinateSystem(preserveAspectRatio=false), graphics={Text(
                extent={{-100,100},{100,-100}},
                lineColor={0,0,0},
                textString="%stateName",
                fontSize=10)}),
          __Dymola_state=true,
          showDiagram=true,
          singleInstance=true);
      end State2;
      State2 state2
        annotation (Placement(transformation(extent={{20,0},{40,20}})));
      Modelica.Blocks.Sources.Ramp ramp(height=100, duration=100)
        annotation (Placement(transformation(extent={{-60,-20},{-40,0}})));
    equation
      transition(
            state1,
            state2,
            ramp.y >= 50) annotation (Line(
          points={{2,48},{30,22}},
          color={175,175,175},
          thickness=0.25,
          smooth=Smooth.Bezier), Text(
          string="%condition",
          extent={{-4,4},{-4,10}},
          fontSize=10,
          textStyle={TextStyle.Bold},
          horizontalAlignment=TextAlignment.Right));
      initialState(state1) annotation (Line(
          points={{-12,62},{-10,72}},
          color={175,175,175},
          thickness=0.25,
          smooth=Smooth.Bezier,
          arrow={Arrow.Filled,Arrow.None}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end test_transition;
  end debug;

  package Interfaces
    extends Modelica.Icons.InterfacesPackage;


    partial model EightPort_modif "Partial model with eight ports"

      replaceable package Medium1 =
        Modelica.Media.Interfaces.PartialMedium "Medium 1 in the component"
          annotation (choices(
            choice(redeclare package Medium = Buildings.Media.Air "Moist air"),
            choice(redeclare package Medium = Buildings.Media.Water "Water"),
            choice(redeclare package Medium =
                Buildings.Media.Antifreeze.PropyleneGlycolWater (
              property_T=293.15,
              X_a=0.40)
              "Propylene glycol water, 40% mass fraction")));
      replaceable package Medium2 =
        Modelica.Media.Interfaces.PartialMedium "Medium 2 in the component"
          annotation (choices(
            choice(redeclare package Medium = Buildings.Media.Air "Moist air"),
            choice(redeclare package Medium = Buildings.Media.Water "Water"),
            choice(redeclare package Medium =
                Buildings.Media.Antifreeze.PropyleneGlycolWater (
              property_T=293.15,
              X_a=0.40)
              "Propylene glycol water, 40% mass fraction")));
      replaceable package Medium3 =
        Modelica.Media.Interfaces.PartialMedium "Medium 3 in the component"
          annotation (choices(
            choice(redeclare package Medium = Buildings.Media.Air "Moist air"),
            choice(redeclare package Medium = Buildings.Media.Water "Water"),
            choice(redeclare package Medium =
                Buildings.Media.Antifreeze.PropyleneGlycolWater (
              property_T=293.15,
              X_a=0.40)
              "Propylene glycol water, 40% mass fraction")));
      replaceable package Medium4 =
        Modelica.Media.Interfaces.PartialMedium "Medium 4 in the component"
          annotation (choices(
            choice(redeclare package Medium = Buildings.Media.Air "Moist air"),
            choice(redeclare package Medium = Buildings.Media.Water "Water"),
            choice(redeclare package Medium =
                Buildings.Media.Antifreeze.PropyleneGlycolWater (
              property_T=293.15,
              X_a=0.40)
              "Propylene glycol water, 40% mass fraction")));

      parameter Boolean allowFlowReversal1 = true
        "= true to allow flow reversal in medium 1, false restricts to design direction (port_a -> port_b)"
        annotation(Dialog(tab="Assumptions"), Evaluate=true);
      parameter Boolean allowFlowReversal2 = true
        "= true to allow flow reversal in medium 2, false restricts to design direction (port_a -> port_b)"
        annotation(Dialog(tab="Assumptions"), Evaluate=true);
      parameter Boolean allowFlowReversal3 = true
        "= true to allow flow reversal in medium 3, false restricts to design direction (port_a -> port_b)"
        annotation(Dialog(tab="Assumptions"), Evaluate=true);
      parameter Boolean allowFlowReversal4 = true
        "= true to allow flow reversal in medium 4, false restricts to design direction (port_a -> port_b)"
        annotation(Dialog(tab="Assumptions"), Evaluate=true);

      parameter Modelica.SIunits.SpecificEnthalpy h_outflow_a1_start = Medium1.h_default
        "Start value for enthalpy flowing out of port a1"
        annotation (Dialog(tab="Advanced", group="Initialization"));

      parameter Modelica.SIunits.SpecificEnthalpy h_outflow_b1_start = Medium1.h_default
        "Start value for enthalpy flowing out of port b1"
        annotation (Dialog(tab="Advanced", group="Initialization"));

      parameter Modelica.SIunits.SpecificEnthalpy h_outflow_a2_start = Medium2.h_default
        "Start value for enthalpy flowing out of port a2"
        annotation (Dialog(tab="Advanced", group="Initialization"));

      parameter Modelica.SIunits.SpecificEnthalpy h_outflow_b2_start = Medium2.h_default
        "Start value for enthalpy flowing out of port b2"
        annotation (Dialog(tab="Advanced", group="Initialization"));

        parameter Modelica.SIunits.SpecificEnthalpy h_outflow_a3_start = Medium3.h_default
        "Start value for enthalpy flowing out of port a1"
        annotation (Dialog(tab="Advanced", group="Initialization"));

      parameter Modelica.SIunits.SpecificEnthalpy h_outflow_b3_start = Medium3.h_default
        "Start value for enthalpy flowing out of port b1"
        annotation (Dialog(tab="Advanced", group="Initialization"));

        parameter Modelica.SIunits.SpecificEnthalpy h_outflow_a4_start = Medium4.h_default
        "Start value for enthalpy flowing out of port a1"
        annotation (Dialog(tab="Advanced", group="Initialization"));

      parameter Modelica.SIunits.SpecificEnthalpy h_outflow_b4_start = Medium4.h_default
        "Start value for enthalpy flowing out of port b1"
        annotation (Dialog(tab="Advanced", group="Initialization"));

      Modelica.Fluid.Interfaces.FluidPort_a port_a1(
                         redeclare final package Medium = Medium1,
                         m_flow(min=if allowFlowReversal1 then -Modelica.Constants.inf else 0),
                         h_outflow(start=h_outflow_a1_start))
        "Fluid connector a1 (positive design flow direction is from port_a1 to port_b1)"
        annotation (Placement(transformation(extent={{50,90},{70,110}})));
      Modelica.Fluid.Interfaces.FluidPort_b port_b1(
                         redeclare final package Medium = Medium1,
                         m_flow(max=if allowFlowReversal1 then +Modelica.Constants.inf else 0),
                         h_outflow(start=h_outflow_b1_start))
        "Fluid connector b1 (positive design flow direction is from port_a1 to port_b1)"
        annotation (Placement(transformation(extent={{30,90},{10,110}}), iconTransformation(extent={{30,90},
                {10,110}})));

      Modelica.Fluid.Interfaces.FluidPort_a port_a2(
                         redeclare final package Medium = Medium2,
                         m_flow(min=if allowFlowReversal2 then -Modelica.Constants.inf else 0),
                         h_outflow(start=h_outflow_a2_start))
        "Fluid connector a2 (positive design flow direction is from port_a2 to port_b2)"
        annotation (Placement(transformation(extent={{-50,90},{-30,110}})));
      Modelica.Fluid.Interfaces.FluidPort_b port_b2(
                         redeclare final package Medium = Medium2,
                         m_flow(max=if allowFlowReversal2 then +Modelica.Constants.inf else 0),
                         h_outflow(start=h_outflow_b2_start))
        "Fluid connector b2 (positive design flow direction is from port_a2 to port_b2)"
        annotation (Placement(transformation(extent={{-70,90},{-90,110}}),
                    iconTransformation(extent={{-70,90},{-90,110}})));

      Modelica.Fluid.Interfaces.FluidPort_a port_a3(
                         redeclare final package Medium = Medium3,
                         m_flow(min=if allowFlowReversal3 then -Modelica.Constants.inf else 0),
                         h_outflow(start=h_outflow_a3_start))
        "Fluid connector a1 (positive design flow direction is from port_a3 to port_b3)"
        annotation (Placement(transformation(extent={{-110,50},{-90,70}})));
      Modelica.Fluid.Interfaces.FluidPort_b port_b3(
                         redeclare final package Medium = Medium3,
                         m_flow(max=if allowFlowReversal3 then +Modelica.Constants.inf else 0),
                         h_outflow(start=h_outflow_b3_start))
        "Fluid connector b2 (positive design flow direction is from port_a3 to port_b3)"
        annotation (Placement(transformation(extent={{-90,10},{-110,30}}),
                    iconTransformation(extent={{-90,10},{-110,30}})));
      Modelica.Fluid.Interfaces.FluidPort_a port_a4(
                         redeclare final package Medium = Medium4,
                         m_flow(min=if allowFlowReversal4 then -Modelica.Constants.inf else 0),
                         h_outflow(start=h_outflow_a4_start))
        "Fluid connector a1 (positive design flow direction is from port_a4 to port_b4)"
        annotation (Placement(transformation(extent={{-110,-50},{-90,-30}})));
      Modelica.Fluid.Interfaces.FluidPort_b port_b4(
                         redeclare final package Medium = Medium4,
                         m_flow(max=if allowFlowReversal4 then +Modelica.Constants.inf else 0),
                         h_outflow(start=h_outflow_b4_start))
        "Fluid connector b2 (positive design flow direction is from port_a4 to port_b4)"
        annotation (Placement(transformation(extent={{-90,-90},{-110,-70}}),
                    iconTransformation(extent={{-90,-95},{-110,-75}})));
      annotation (
        preferredView="info",
        Documentation(info="<html>
<p>This model defines an interface for components with eight ports. The parameters <code>allowFlowReversal1,
</code> <code>allowFlowReversal2</code>, <code>allowFlowReversal3</code> and <code>allowFlowReversal4</code> 
may be used by models that extend this model to treat flow reversal. </p>
<p>This model is identical to <a href=\"modelica://Modelica.Fluid.Interfaces.PartialTwoPort\">Modelica.Fluid.Interfaces.PartialTwoPort</a>, except that it has eight ports. </p>
</html>",     revisions="<html>
<ul>
<li>
January 18, 2019, by Jianjun Hu:<br/>
Limited the media choice.
See <a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/1050\">#1050</a>.
</li>
<li>July 2014, by Damien Picard:<br/>First implementation. </li>
</ul>
</html>"),
        Icon(coordinateSystem(
              preserveAspectRatio=false,
              extent={{-100,-100},{100,100}},
              grid={1,1}), graphics={Text(
              extent={{-151,147},{149,107}},
              lineColor={0,0,255},
              fillPattern=FillPattern.HorizontalCylinder,
              fillColor={0,127,255},
              textString="%name")}),
        Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
                100,100}})));
    end EightPort_modif;

    partial model SixtPort_modif "Partial model with eight ports"

      replaceable package Medium1 =
        Modelica.Media.Interfaces.PartialMedium "Medium 1 in the component"
          annotation (choices(
            choice(redeclare package Medium = Buildings.Media.Air "Moist air"),
            choice(redeclare package Medium = Buildings.Media.Water "Water"),
            choice(redeclare package Medium =
                Buildings.Media.Antifreeze.PropyleneGlycolWater (
              property_T=293.15,
              X_a=0.40)
              "Propylene glycol water, 40% mass fraction")));
      replaceable package Medium2 =
        Modelica.Media.Interfaces.PartialMedium "Medium 2 in the component"
          annotation (choices(
            choice(redeclare package Medium = Buildings.Media.Air "Moist air"),
            choice(redeclare package Medium = Buildings.Media.Water "Water"),
            choice(redeclare package Medium =
                Buildings.Media.Antifreeze.PropyleneGlycolWater (
              property_T=293.15,
              X_a=0.40)
              "Propylene glycol water, 40% mass fraction")));
      replaceable package Medium3 =
        Modelica.Media.Interfaces.PartialMedium "Medium 3 in the component"
          annotation (choices(
            choice(redeclare package Medium = Buildings.Media.Air "Moist air"),
            choice(redeclare package Medium = Buildings.Media.Water "Water"),
            choice(redeclare package Medium =
                Buildings.Media.Antifreeze.PropyleneGlycolWater (
              property_T=293.15,
              X_a=0.40)
              "Propylene glycol water, 40% mass fraction")));
      replaceable package Medium4 =
        Modelica.Media.Interfaces.PartialMedium "Medium 4 in the component"
          annotation (choices(
            choice(redeclare package Medium = Buildings.Media.Air "Moist air"),
            choice(redeclare package Medium = Buildings.Media.Water "Water"),
            choice(redeclare package Medium =
                Buildings.Media.Antifreeze.PropyleneGlycolWater (
              property_T=293.15,
              X_a=0.40)
              "Propylene glycol water, 40% mass fraction")));

      parameter Boolean allowFlowReversal1 = true
        "= true to allow flow reversal in medium 1, false restricts to design direction (port_a -> port_b)"
        annotation(Dialog(tab="Assumptions"), Evaluate=true);
      parameter Boolean allowFlowReversal2 = true
        "= true to allow flow reversal in medium 2, false restricts to design direction (port_a -> port_b)"
        annotation(Dialog(tab="Assumptions"), Evaluate=true);
      parameter Boolean allowFlowReversal3 = true
        "= true to allow flow reversal in medium 3, false restricts to design direction (port_a -> port_b)"
        annotation(Dialog(tab="Assumptions"), Evaluate=true);
      parameter Boolean allowFlowReversal4 = true
        "= true to allow flow reversal in medium 4, false restricts to design direction (port_a -> port_b)"
        annotation(Dialog(tab="Assumptions"), Evaluate=true);

      parameter Modelica.SIunits.SpecificEnthalpy h_outflow_a1_start = Medium1.h_default
        "Start value for enthalpy flowing out of port a1"
        annotation (Dialog(tab="Advanced", group="Initialization"));

      parameter Modelica.SIunits.SpecificEnthalpy h_outflow_b1_start = Medium1.h_default
        "Start value for enthalpy flowing out of port b1"
        annotation (Dialog(tab="Advanced", group="Initialization"));

      parameter Modelica.SIunits.SpecificEnthalpy h_outflow_a2_start = Medium2.h_default
        "Start value for enthalpy flowing out of port a2"
        annotation (Dialog(tab="Advanced", group="Initialization"));

      parameter Modelica.SIunits.SpecificEnthalpy h_outflow_b2_start = Medium2.h_default
        "Start value for enthalpy flowing out of port b2"
        annotation (Dialog(tab="Advanced", group="Initialization"));

        parameter Modelica.SIunits.SpecificEnthalpy h_outflow_a3_start = Medium3.h_default
        "Start value for enthalpy flowing out of port a1"
        annotation (Dialog(tab="Advanced", group="Initialization"));

      parameter Modelica.SIunits.SpecificEnthalpy h_outflow_b3_start = Medium3.h_default
        "Start value for enthalpy flowing out of port b1"
        annotation (Dialog(tab="Advanced", group="Initialization"));

        parameter Modelica.SIunits.SpecificEnthalpy h_outflow_a4_start = Medium4.h_default
        "Start value for enthalpy flowing out of port a1"
        annotation (Dialog(tab="Advanced", group="Initialization"));

      parameter Modelica.SIunits.SpecificEnthalpy h_outflow_b4_start = Medium4.h_default
        "Start value for enthalpy flowing out of port b1"
        annotation (Dialog(tab="Advanced", group="Initialization"));

      Modelica.Fluid.Interfaces.FluidPort_a port_a1(
                         redeclare final package Medium = Medium1,
                         m_flow(min=if allowFlowReversal1 then -Modelica.Constants.inf else 0),
                         h_outflow(start=h_outflow_a1_start))
        "Fluid connector a1 (positive design flow direction is from port_a1 to port_b1)"
        annotation (Placement(transformation(extent={{90,-60},{110,-40}})));
      Modelica.Fluid.Interfaces.FluidPort_b port_b1(
                         redeclare final package Medium = Medium1,
                         m_flow(max=if allowFlowReversal1 then +Modelica.Constants.inf else 0),
                         h_outflow(start=h_outflow_b1_start))
        "Fluid connector b1 (positive design flow direction is from port_a1 to port_b1)"
        annotation (Placement(transformation(extent={{110,40},{90,60}}), iconTransformation(extent={{110,40},
                {90,60}})));

      Modelica.Fluid.Interfaces.FluidPort_a port_a2(
                         redeclare final package Medium = Medium2,
                         m_flow(min=if allowFlowReversal2 then -Modelica.Constants.inf else 0),
                         h_outflow(start=h_outflow_a2_start))
        "Fluid connector a2 (positive design flow direction is from port_a2 to port_b2)"
        annotation (Placement(transformation(extent={{40,90},{60,110}})));
      Modelica.Fluid.Interfaces.FluidPort_b port_b2(
                         redeclare final package Medium = Medium2,
                         m_flow(max=if allowFlowReversal2 then +Modelica.Constants.inf else 0),
                         h_outflow(start=h_outflow_b2_start))
        "Fluid connector b2 (positive design flow direction is from port_a2 to port_b2)"
        annotation (Placement(transformation(extent={{-40,90},{-60,110}}),
                    iconTransformation(extent={{-40,90},{-60,110}})));

      Modelica.Fluid.Interfaces.FluidPort_a port_a3(
                         redeclare final package Medium = Medium3,
                         m_flow(min=if allowFlowReversal3 then -Modelica.Constants.inf else 0),
                         h_outflow(start=h_outflow_a3_start))
        "Fluid connector a1 (positive design flow direction is from port_a3 to port_b3)"
        annotation (Placement(transformation(extent={{-110,40},{-90,60}})));
      Modelica.Fluid.Interfaces.FluidPort_b port_b3(
                         redeclare final package Medium = Medium3,
                         m_flow(max=if allowFlowReversal3 then +Modelica.Constants.inf else 0),
                         h_outflow(start=h_outflow_b3_start))
        "Fluid connector b2 (positive design flow direction is from port_a3 to port_b3)"
        annotation (Placement(transformation(extent={{-90,-60},{-110,-40}}),
                    iconTransformation(extent={{-90,-60},{-110,-40}})));
      annotation (
        preferredView="info",
        Documentation(info="<html>
<p>This model defines an interface for components with eight ports. The parameters <code>allowFlowReversal1,
</code> <code>allowFlowReversal2</code>, <code>allowFlowReversal3</code> and <code>allowFlowReversal4</code> 
may be used by models that extend this model to treat flow reversal. </p>
<p>This model is identical to <a href=\"modelica://Modelica.Fluid.Interfaces.PartialTwoPort\">Modelica.Fluid.Interfaces.PartialTwoPort</a>, except that it has eight ports. </p>
</html>",     revisions="<html>
<ul>
<li>
January 18, 2019, by Jianjun Hu:<br/>
Limited the media choice.
See <a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/1050\">#1050</a>.
</li>
<li>July 2014, by Damien Picard:<br/>First implementation. </li>
</ul>
</html>"),
        Icon(coordinateSystem(
              preserveAspectRatio=false,
              extent={{-100,-100},{100,100}},
              grid={1,1}), graphics={Text(
              extent={{-151,147},{149,107}},
              lineColor={0,0,255},
              fillPattern=FillPattern.HorizontalCylinder,
              fillColor={0,127,255},
              textString="%name")}),
        Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
                100,100}})));
    end SixtPort_modif;
  end Interfaces;

  model Plant_b
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
  end Plant_b;

  package SST
    extends Modelica.Icons.VariantsPackage;
    model sst
      extends Fluid.Interfaces.PartialTwoPort;
      Fluid.Sources.MassFlowSource_T boundary(redeclare package Medium =
            Buildings.Media.Water, nPorts=1)
        annotation (Placement(transformation(extent={{-60,60},{-40,80}})));
      Fluid.Sources.Boundary_pT bou(redeclare package Medium =
            Buildings.Media.Water, nPorts=1)
        annotation (Placement(transformation(extent={{60,60},{40,80}})));
      Fluid.HeatExchangers.PlateHeatExchangerEffectivenessNTU hex(redeclare
          package Medium1 = Buildings.Media.Water, redeclare package Medium2 =
            Buildings.Media.Water)
        annotation (Placement(transformation(extent={{-10,-4},{10,16}})));
    equation
      connect(port_a, hex.port_b2)
        annotation (Line(points={{-100,0},{-10,0}}, color={0,127,255}));
      connect(hex.port_a2, port_b)
        annotation (Line(points={{10,0},{100,0}}, color={0,127,255}));
      connect(boundary.ports[1], hex.port_a1) annotation (Line(points={{-40,70},
              {-26,70},{-26,12},{-10,12}}, color={0,127,255}));
      connect(hex.port_b1, bou.ports[1]) annotation (Line(points={{10,12},{26,
              12},{26,70},{40,70}}, color={0,127,255}));
    end sst;
  end SST;

  annotation ();
end DHC_Marseille;
