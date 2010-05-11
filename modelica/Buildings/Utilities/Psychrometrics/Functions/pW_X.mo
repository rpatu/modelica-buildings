within Buildings.Utilities.Psychrometrics.Functions;
function pW_X "Water vapor pressure for given humidity ratio"

  input Modelica.SIunits.MassFraction X_w(min=0, max=1, nominal=0.01)
    "Species concentration at dry bulb temperature";
  input Modelica.SIunits.Pressure p = 101325 "Total pressure";
  output Modelica.SIunits.Pressure p_w "Water vapor pressure";

protected
  Modelica.SIunits.MassFraction x_w(nominal=0.01)
    "Water mass fraction per mass of dry air";
algorithm
  x_w := X_w/(1 - X_w);
  p_w := p * x_w / (0.62198+x_w);
  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
            100}}),
            graphics),
    Documentation(info="<html>
<p>
Function to compute the water vapor partial pressure for a given humidity ratio.
</p>
</html>", revisions="<html>
<ul>
<li>
February 17, 2010 by Michael Wetter:<br>
Renamed block from <code>VaporPressure_X</code> to <code>pW_X</code>.
</li>
<li>
April 14, 2009 by Michael Wetter:<br>
Converted model to block because <tt>RealInput</tt> are obsolete in Modelica 3.0.
</li>
<li>
August 7, 2008 by Michael Wetter:<br>
First implementation.
</li>
</ul>
</html>"),
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}}), graphics));
end pW_X;
