within Buildings.Fluid.Actuators.Valves.Data;
record TFP_calc =
             Generic (
    y =  {0,0.113721804511278,0.156145711441113,0.260515664699151,0.333176691729323,0.364885617957188,0.445018796992481,0.46098864422449,0.571380626195607,0.665883458646616,0.674378697172854,0.764281528197104,0.843571183484273,0.915669628714951,0.976638215271626,1},
    phi = {0.0001,0.00485830245612206,0.0161035285172298,0.0490340140091132,0.0791455747636807,0.101574808926671,0.154820849360824,0.172878274265646,0.288369187366807,0.403920443972291,0.419892411061508,0.559127480833624,0.703694269176182,0.840660881836383,0.956203286494552,1}) "TFP with correlations"
  annotation (
defaultComponentName="datValLin",
defaultComponentPrefixes="parameter",
Documentation(info="<html>
<p>
Linear valve opening characteristics with
a normalized leakage flow rate of <i>0.0001</i>.
</p>
<p>
<b>Note</b>: This record is only for demonstration,
as the implementation in
<a href=\"modelica://Buildings.Fluid.Actuators.Valves.TwoWayLinear\">
Buildings.Fluid.Actuators.Valves.TwoWayLinear</a>
is more efficient.
</p>
</html>", revisions="<html>
<ul>
<li>
December 12, 2014, by Michael Wetter:<br/>
Added annotation <code>defaultComponentPrefixes=\"parameter\"</code>
so that the <code>parameter</code> keyword is added when dragging
the record into a model.
</li>
<li>
March 27, 2014, by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"));
