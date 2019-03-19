within Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.Generic;
block IdentifyStage "Sequence for identifying current plant stage"
  CDL.Interfaces.BooleanInput                        uChi[nChi]
    "Chiller status: true=ON"
    annotation (Placement(transformation(extent={{-200,100},{-160,140}}),
      iconTransformation(extent={{-240,80},{-200,120}})));
  CDL.Interfaces.BooleanInput                        uWSE if haveWSE
    "Water side economizer status: true = ON, false = OFF"
    annotation (Placement(transformation(extent={{-200,-80},{-160,-40}}),
      iconTransformation(extent={{-240,-80},{-200,-40}})));
  CDL.Logical.Sources.Constant con(k=noPony)
    "Indicate if the plant has no pony chiller"
    annotation (Placement(transformation(extent={{-20,70},{0,90}})));
  CDL.Conversions.BooleanToInteger booToInt[nChi]
    "Convert boolean input to integer output"
    annotation (Placement(transformation(extent={{-120,110},{-100,130}})));
  CDL.Integers.MultiSum mulSumInt(final nin=nChi)
    annotation (Placement(transformation(extent={{-80,110},{-60,130}})));
  CDL.Logical.Not not2[nChi] "Logical not"
    annotation (Placement(transformation(extent={{-60,-40},{-40,-20}})));
  CDL.Logical.And enaPonChi[nChi] "Enabled pony chillers"
    annotation (Placement(transformation(extent={{-20,20},{0,40}})));
  CDL.Logical.And enaRegChi[nChi] "Enabled regular chillers"
    annotation (Placement(transformation(extent={{-20,-20},{0,0}})));
  CDL.Conversions.BooleanToInteger booToInt1[nChi]
    "Convert boolean input to integer output"
    annotation (Placement(transformation(extent={{20,20},{40,40}})));
  CDL.Conversions.BooleanToInteger booToInt2[nChi]
    "Convert boolean input to integer output"
    annotation (Placement(transformation(extent={{20,-20},{40,0}})));
  CDL.Integers.MultiSum totEnaPonChi(final nin=nChi) "Total number of enabled pony chillers"
    annotation (Placement(transformation(extent={{60,20},{80,40}})));
  CDL.Integers.MultiSum totEnaRegChi(final nin=nChi) "Total number of enabled regular chillers"
    annotation (Placement(transformation(extent={{60,-20},{80,0}})));
  CDL.Conversions.IntegerToReal intToRea[nSta]
    "Convert integer input to real output"
    annotation (Placement(transformation(extent={{-60,-80},{-40,-60}})));
  CDL.Continuous.Sources.Constant zer[nSta](k=0) "Zero constant"
    annotation (Placement(transformation(extent={{-60,-190},{-40,-170}})));
  CDL.Integers.Equal intEqu[nSta] "Check integer inputs equality"
    annotation (Placement(transformation(extent={{-60,-110},{-40,-90}})));
  CDL.Logical.Switch swi[nSta] "Logical switch"
    annotation (Placement(transformation(extent={{20,-110},{40,-90}})));
  CDL.Routing.IntegerReplicator intRep(nout=nSta) "Replicate integer input"
    annotation (Placement(transformation(extent={{100,20},{120,40}})));
  CDL.Routing.IntegerReplicator intRep1(nout=nSta) "Replicate integer input"
    annotation (Placement(transformation(extent={{100,-20},{120,0}})));
  CDL.Integers.Equal intEqu1[nSta] "Check integer inputs equality"
    annotation (Placement(transformation(extent={{-60,-150},{-40,-130}})));
  CDL.Logical.Switch swi1[nSta] "Logical switch"
    annotation (Placement(transformation(extent={{20,-150},{40,-130}})));
  CDL.Conversions.RealToInteger reaToInt[nSta]
    "Convert real input to integer output"
    annotation (Placement(transformation(extent={{60,-110},{80,-90}})));
  CDL.Conversions.RealToInteger reaToInt1[nSta]
    "Convert real input to integer output"
    annotation (Placement(transformation(extent={{60,-150},{80,-130}})));
  CDL.Integers.Equal intEqu2[nSta] "Check integer inputs equality"
    annotation (Placement(transformation(extent={{100,-110},{120,-90}})));
  CDL.Logical.Switch swi2[nSta] "Logical switch"
    annotation (Placement(transformation(extent={{20,-190},{40,-170}})));
  CDL.Continuous.MultiSum mulSum
    annotation (Placement(transformation(extent={{60,-190},{80,-170}})));
  CDL.Conversions.RealToInteger reaToInt2
    annotation (Placement(transformation(extent={{100,70},{120,90}})));
  CDL.Interfaces.IntegerOutput ySta "Current chiller stage index" annotation (
      Placement(transformation(extent={{160,70},{180,90}}), iconTransformation(
          extent={{150,-190},{170,-170}})));
  CDL.Logical.Switch swi3 "Logical switch"
    annotation (Placement(transformation(extent={{60,70},{80,90}})));
  CDL.Conversions.IntegerToReal intToRea1
    "Convert integer input to real output"
    annotation (Placement(transformation(extent={{-40,110},{-20,130}})));
protected
  CDL.Logical.Sources.Constant ponChi[nPonChi](final k=ponChiFlg)
    "Pony chiller flag"
    annotation (Placement(transformation(extent={{-120,0},{-100,20}})));
  CDL.Integers.Sources.Constant ponChiNum[nSta](final k=ponChiCou)
    "Number of pony chiller at each stage"
    annotation (Placement(transformation(extent={{-120,-110},{-100,-90}})));
  CDL.Integers.Sources.Constant regChiNum[nSta](final k=regChiCou)
    "Number of regular chiller at each stage"
    annotation (Placement(transformation(extent={{-120,-150},{-100,-130}})));
  CDL.Integers.Sources.Constant staInd[nSta](final k=staIndVec) "Stage index"
    annotation (Placement(transformation(extent={{-120,-80},{-100,-60}})));
equation
  connect(uChi, enaPonChi.u1) annotation (Line(points={{-180,120},{-140,120},{-140,
          30},{-22,30}}, color={255,0,255}));
  connect(ponChi.y, not2.u) annotation (Line(points={{-99,10},{-80,10},{-80,-30},
          {-62,-30}}, color={255,0,255}));
  connect(ponChi.y, enaPonChi.u2) annotation (Line(points={{-99,10},{-80,10},{-80,
          22},{-22,22}}, color={255,0,255}));
  connect(uChi, enaRegChi.u1) annotation (Line(points={{-180,120},{-140,120},{-140,
          -10},{-22,-10}}, color={255,0,255}));
  connect(not2.y, enaRegChi.u2) annotation (Line(points={{-39,-30},{-32,-30},{-32,
          -18},{-22,-18}}, color={255,0,255}));
  connect(enaPonChi.y, booToInt1.u)
    annotation (Line(points={{1,30},{18,30}}, color={255,0,255}));
  connect(enaRegChi.y, booToInt2.u)
    annotation (Line(points={{1,-10},{18,-10}}, color={255,0,255}));
  connect(staInd.y, intToRea.u)
    annotation (Line(points={{-99,-70},{-62,-70}}, color={255,127,0}));
  connect(totEnaPonChi.y, intRep.u)
    annotation (Line(points={{81.7,30},{98,30}}, color={255,127,0}));
  connect(totEnaRegChi.y, intRep1.u)
    annotation (Line(points={{81.7,-10},{98,-10}}, color={255,127,0}));
  connect(intRep1.y, intEqu1.u2) annotation (Line(points={{121,-10},{130,-10},{130,
          -48},{-80,-48},{-80,-148},{-62,-148}}, color={255,127,0}));
  connect(intRep.y, intEqu.u2) annotation (Line(points={{121,30},{134,30},{134,-52},
          {-76,-52},{-76,-108},{-62,-108}}, color={255,127,0}));
  connect(ponChiNum.y, intEqu.u1)
    annotation (Line(points={{-99,-100},{-62,-100}}, color={255,127,0}));
  connect(regChiNum.y, intEqu1.u1)
    annotation (Line(points={{-99,-140},{-62,-140}}, color={255,127,0}));
  connect(intEqu.y, swi.u2)
    annotation (Line(points={{-39,-100},{18,-100}}, color={255,0,255}));
  connect(intToRea.y, swi.u1) annotation (Line(points={{-39,-70},{-20,-70},{-20,
          -92},{18,-92}}, color={0,0,127}));
  connect(zer.y, swi.u3) annotation (Line(points={{-39,-180},{0,-180},{0,-108},{
          18,-108}}, color={0,0,127}));
  connect(intToRea.y, swi1.u1) annotation (Line(points={{-39,-70},{-20,-70},{-20,
          -132},{18,-132}}, color={0,0,127}));
  connect(intEqu1.y, swi1.u2)
    annotation (Line(points={{-39,-140},{18,-140}}, color={255,0,255}));
  connect(zer.y, swi1.u3) annotation (Line(points={{-39,-180},{0,-180},{0,-148},
          {18,-148}}, color={0,0,127}));
  connect(swi1.y, reaToInt1.u)
    annotation (Line(points={{41,-140},{58,-140}}, color={0,0,127}));
  connect(swi.y, reaToInt.u)
    annotation (Line(points={{41,-100},{58,-100}}, color={0,0,127}));
  connect(reaToInt.y, intEqu2.u1)
    annotation (Line(points={{81,-100},{98,-100}}, color={255,127,0}));
  connect(reaToInt1.y, intEqu2.u2) annotation (Line(points={{81,-140},{90,-140},
          {90,-108},{98,-108}}, color={255,127,0}));
  connect(intToRea.y, swi2.u1) annotation (Line(points={{-39,-70},{-20,-70},{-20,
          -172},{18,-172}}, color={0,0,127}));
  connect(intEqu2.y, swi2.u2) annotation (Line(points={{121,-100},{140,-100},{140,
          -160},{6,-160},{6,-180},{18,-180}}, color={255,0,255}));
  connect(zer.y, swi2.u3) annotation (Line(points={{-39,-180},{0,-180},{0,-188},
          {18,-188}}, color={0,0,127}));
  connect(uChi, booToInt.u)
    annotation (Line(points={{-180,120},{-122,120}}, color={255,0,255}));
  connect(mulSumInt.y, intToRea1.u)
    annotation (Line(points={{-58.3,120},{-42,120}}, color={255,127,0}));
  connect(swi3.y, reaToInt2.u)
    annotation (Line(points={{81,80},{98,80}}, color={0,0,127}));
  connect(reaToInt2.y, ySta)
    annotation (Line(points={{121,80},{170,80}}, color={255,127,0}));
  connect(con.y, swi3.u2)
    annotation (Line(points={{1,80},{58,80}}, color={255,0,255}));
  connect(intToRea1.y, swi3.u1) annotation (Line(points={{-19,120},{40,120},{40,
          88},{58,88}}, color={0,0,127}));
  connect(mulSum.y, swi3.u3) annotation (Line(points={{81,-180},{150,-180},{150,
          60},{40,60},{40,72},{58,72}}, color={0,0,127}));
  connect(booToInt.y, mulSumInt.u) annotation (Line(points={{-99,120},{-82,120}},
                                        color={255,127,0}));
  connect(booToInt1.y, totEnaPonChi.u) annotation (Line(points={{41,30},{58,30}},
                                        color={255,127,0}));
  connect(booToInt2.y, totEnaRegChi.u) annotation (Line(points={{41,-10},{58,-10}},
                                        color={255,127,0}));
  connect(swi2.y, mulSum.u) annotation (Line(points={{41,-180},{58,-180}},
                                        color={0,0,127}));





  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-160,
            -200},{160,140}})),
                          Diagram(coordinateSystem(preserveAspectRatio=false,
          extent={{-160,-200},{160,140}})));
end IdentifyStage;
