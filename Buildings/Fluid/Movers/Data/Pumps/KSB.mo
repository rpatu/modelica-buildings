within Buildings.Fluid.Movers.Data.Pumps;
package KSB
  record KSB_PEC "Pump data for the hot water loop"
  extends Generic(
    use_powerCharacteristic=true,
    speed_rpm_nominal=1620,
    power(V_flow={0.027812301,0.055607751,0.083404434,0.09582199,0.111200295,0.138993691}, P={54584.83755,82527.07581,112418.7726,126064.9819,141010.8303,165703.9711}),
    pressure(V_flow={0.017074624,0.02773194,0.055578475,0.083310414,0.095801247,0.111042354,0.138888889,0.142555922}, dp={1120421.032,1117982.003,1094736.03,1037145.303,992473.3646,910869.4275,652508.9084,607669.1372}));

  end KSB_PEC;

  record KSB_PEG "Pump data for the cold water loop"
  extends Generic(
    use_powerCharacteristic=true,
    speed_rpm_nominal=1773,
    power(V_flow={0.083353713,0.111070351,0.138786989,0.166707426,0.194424065,0.210931768}, P={133333.3333,167375.8865,201418.4397,234042.5532,266666.6667,283687.9433}),
    pressure(V_flow={0.083435834,0.111111111,0.138786388,0.166666667,0.194341943,0.211152112,0.222222222,0.24600246}, dp={1305958.756,1293781.984,1266384.248,1199412.004,1111130.41,1050246.552,1004583.659,891948.5211}));

  end KSB_PEG;

  record KSB_edm "Pump data for Sea water"
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

  record KSB_RJC "Pump data for heat exchanger"
  extends Generic(
    use_powerCharacteristic=true,
    speed_rpm_nominal=1494,
    power(V_flow={0.055662944,0.083225945,0.111146907,0.139067869,0.166630871,0.180591352,0.194372852,0.222293814}, P={20437.9562,28102.18978,36277.37226,44963.50365,52627.73723,56715.32847,60036.49635,65912.40876}),
    pressure(V_flow={0.057163654,0.083231769,0.11099262,0.13875347,0.166514321,0.180733293,0.194275171,0.222374568}, dp={353587.0745,345933.6746,330626.8748,318381.435,300013.2753,287767.8355,275522.3957,244908.7962}));

  end KSB_RJC;
  annotation (Documentation(info="<html>
<p>This package contains performance data for KSB pumps used in Thassalia. </p>
</html>"));
end KSB;
