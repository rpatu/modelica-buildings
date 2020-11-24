within Buildings.Fluid.Actuators.Valves.Data;
record GF_calc =
             Generic (
    y =  {0,0.113089937666963,0.222617987533392,0.333036509349955,0.444345503116651,0.554318788958147,0.667853962600178,0.780943900267141,1},
    phi = {0.0001,0.00475059382422794,0.0320665083135392,0.0795724465558195,0.154394299287411,0.266627078384799,0.407363420427552,0.585510688836102,1}) "Chiller with correlations"
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
