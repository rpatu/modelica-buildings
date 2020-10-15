within Buildings.Fluid.Movers.Data;
record KSB_RJC "Pump data for heat exchanger"
extends Generic(
  use_powerCharacteristic=true,
  speed_rpm_nominal=1494,
  power(V_flow={0.055662944,0.083225945,0.111146907,0.139067869,0.166630871,0.180591352,0.194372852,0.222293814}, P={20437.9562,28102.18978,36277.37226,44963.50365,52627.73723,56715.32847,60036.49635,65912.40876}),
  pressure(V_flow={0.057163654,0.083231769,0.11099262,0.13875347,0.166514321,0.180733293,0.194275171,0.222374568}, dp={353587.0745,345933.6746,330626.8748,318381.435,300013.2753,287767.8355,275522.3957,244908.7962}));

  annotation (Documentation(info="<html>
<p>Data based on this source :</p>
<p align=\"center\"><img src=\"modelica://Buildings/Resources/Images/Fluid/Movers/Data/edm.png\" alt=\"Pump curve\"/></p>
<p>with :<i></p><p>&rho; = 1028 kg/m3</i></p>
</html>"));
end KSB_RJC;
