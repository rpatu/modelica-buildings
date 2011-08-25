within Buildings.Fluid.Sensors.BaseClasses;
partial model PartialDynamicFlowSensor
  "Partial component to model sensors that measure flow properties using a dynamic model"
  extends PartialFlowSensor;
  parameter Modelica.SIunits.Time tau(min=0) = 1
    "Time constant at nominal flow rate" annotation (Evaluate=true);
  parameter Boolean use_constantK = false
    "Set to true to use a constant gain. (Not recommended, for testing only. Fixme."
                                                                                     annotation (Evaluate=true);
  parameter Modelica.Blocks.Types.Init initType = Modelica.Blocks.Types.Init.NoInit
    "Type of initialization (InitialState and InitialOutput are identical)"
     annotation(Evaluate=true, Dialog(group="Initialization"));
protected
  Real k(start=1)
    "Gain to take flow rate into account for sensor time constant";
  final parameter Boolean dynamic = tau > 1E-10 or tau < -1E-10
    "Flag, true if the sensor is a dynamic sensor";
equation
  if use_constantK then
    k = 1;
  else
    k = if dynamic then abs(port_a.m_flow/m_flow_nominal) else 1;
  end if;
  annotation (Icon(graphics={
        Line(visible=(tau <> 0),
        points={{52,60},{58,74},{66,86},{76,92},{88,96},{98,96}}, color={0,
              0,127})}));
end PartialDynamicFlowSensor;
