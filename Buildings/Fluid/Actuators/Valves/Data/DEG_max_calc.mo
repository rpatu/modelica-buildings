within Buildings.Fluid.Actuators.Valves.Data;
record DEG_max_calc =
             Generic (
    y =  {0,0.112456651613278,0.2231344159055,0.334713684111274,0.444520643315824,0.66864454816262,0.778495911026031,1},
    phi = {0.0001,0.00416666666666677,0.0321428571428572,0.0797619047619046,0.154761904761905,0.408333333333333,0.579761904761904,1})
  "DEG max with correlations"
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
