within Buildings.Fluid.Actuators.Valves.Data;
record DEC_calc =
             Generic (
    y =  {0,0.0459351210257513,0.0914660996691116,0.676093745627033,0.908507453910694,1},
    phi = {0.0001,0.0350596364558158,0.0673897121535084,0.676045273093964,0.917428274757307,1})
  "DEC with correlations"
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
