within ThermoSysPro.WaterSteam.Sensors;
model SensorQ "Mass flow sensor"
  parameter Boolean continuous_flow_reversal=false "true : continuous flow reversal - false : discontinuous flow reversal";
  Modelica.SIunits.MassFlowRate Q(start=500) "Mass flow rate";
  annotation(Icon(coordinateSystem(extent={{-100,-100},{100,100}}), graphics={Ellipse(lineColor={0,0,255}, extent={{-60,92},{60,-28}}, fillPattern=FillPattern.Solid, fillColor={0,255,0}),Line(color={0,0,255}, points={{0,-28},{0,-80}}),Line(color={0,0,255}, points={{-98,-80},{102,-80}}),Text(lineColor={0,0,255}, extent={{-60,60},{60,0}}, textString="Q")}), Diagram(coordinateSystem(extent={{-100,-100},{100,100}}), graphics={Ellipse(lineColor={0,0,255}, extent={{-60,92},{60,-28}}, fillPattern=FillPattern.Solid, fillColor={0,255,0}),Line(color={0,0,255}, points={{0,-28},{0,-80}}),Line(color={0,0,255}, points={{-98,-80},{102,-80}}),Text(lineColor={0,0,255}, extent={{-60,60},{60,0}}, textString="Q")}), Documentation(info="<html>
<p><b>Copyright &copy; EDF 2002 - 2010</b></p>
</HTML>
<html>
<p><b>ThermoSysPro Version 2.0</b></p>
</HTML>
", revisions="<html>
<u><p><b>Authors</u> : </p></b>
<ul style='margin-top:0cm' type=disc>
<li>
    Daniel Bouskela</li>
</ul>
</html>
"));
  ThermoSysPro.InstrumentationAndControl.Connectors.OutputReal Measure annotation(Placement(visible=true, transformation(origin={0.0,90.0}, extent={{-10.0,-10.0},{10.0,10.0}}, rotation=0), iconTransformation(origin={0.4992,90.3577}, extent={{-10.0,-10.0},{10.0,10.0}}, rotation=0)));
  ThermoSysPro.WaterSteam.Connectors.FluidInlet C1 annotation(Placement(visible=true, transformation(origin={-100.0,-80.0}, extent={{-10.0,-10.0},{10.0,10.0}}, rotation=0), iconTransformation(origin={-104.8349,-79.8742}, extent={{-10.0,-10.0},{10.0,10.0}}, rotation=0)));
  ThermoSysPro.WaterSteam.Connectors.FluidOutlet C2 annotation(Placement(visible=true, transformation(origin={100.0,-80.0}, extent={{-10.0,-10.0},{10.0,10.0}}, rotation=0), iconTransformation(origin={100.342,-78.8758}, extent={{-10.0,-10.0},{10.0,10.0}}, rotation=0)));
protected
  constant Real pi=Modelica.Constants.pi "pi";
  parameter Modelica.SIunits.MassFlowRate Qeps=0.001 "Minimum mass flow for continuous flow reversal";
equation
  C1.P=C2.P;
  C1.h=C2.h;
  C1.Q=C2.Q;
  Q=C1.Q;
  if continuous_flow_reversal then
    0=noEvent(if Q > Qeps then C1.h - C1.h_vol else if Q < -Qeps then C2.h - C2.h_vol else C1.h - 0.5*((C1.h_vol - C2.h_vol)*Modelica.Math.sin(pi*Q/2/Qeps) + C1.h_vol + C2.h_vol));
  else
    0=if Q > 0 then C1.h - C1.h_vol else C2.h - C2.h_vol;
  end if;
  Measure.signal=Q;
end SensorQ;
