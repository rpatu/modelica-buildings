within Buildings.Fluid.Actuators.Valves.Data;
record TFP_data =
             Generic (
    y =  {0,0.444,0.499,0.514,0.588,0.592,0.615,0.676,0.685,0.834,0.834,0.839,0.936,1},
    phi = {0.0001,0.158235294117647,0.213529411764706,0.227647058823529,0.311764705882353,0.316470588235294,0.345882352941176,0.426470588235294,0.441176470588235,0.697058823529412,0.697058823529412,0.707647058823529,0.894705882352941,1}) "TFP caclulated"
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
