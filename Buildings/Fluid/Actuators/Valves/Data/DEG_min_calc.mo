within Buildings.Fluid.Actuators.Valves.Data;
record DEG_min_calc =
             Generic (
    y =  {0,0.0914655302362538,0.273189388887611,0.36305834681056,0.454951315913858,0.908533703286399,1},
    phi = {0.0001,0.0340359698317541,0.068265325855734,0.107716109069813,0.18893830980468,0.90021272481145,1})
  "DEG min with correlations"
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
