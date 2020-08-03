within Buildings.Fluid.Movers.Data;
record KSB_edm
"Pump data for Sea water"
extends Generic(
  use_powerCharacteristic=true,
  speed_rpm_nominal=1491,
  power(V_flow={0,0.070894444,0.139836111,0.190283333,0.202136111,0.278891667,0.351305556}, P={83260,90040,104370,114260,116100,128390,133320}),
  pressure(V_flow={0,0.070894444,0.139836111,0.190283333,0.202136111,0.278891667,0.351305556}, dp={544890.8166,533297.395,512025.9866,477447.3464,465551.4877,389236.5297,293868.0352}));

  annotation (Documentation(info="<html>
<p>Data based on this source :</p>
<p align=\"center\"><img src=\"modelica://Buildings/Resources/Images/Fluid/Movers/Data/edm.png\" alt=\"Pump curve\"/></p>
<p>with :<i></p><p>&rho; = 1028 kg/m3</i></p>
</html>"));
end KSB_edm;
