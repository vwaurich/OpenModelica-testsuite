within ThermoSysPro.Correlations.Thermal;
function WBInternalSuperCriticalFlowHeatTransferCoefficient "Internal supercritical water flow heat transfer coefficient"
  input ThermoSysPro.Correlations.Misc.Pro_TwoPhaseWaterSteam hy annotation(Placement(transformation(x=-16.0, y=-64.0, scale=0.1, aspectRatio=1.0, flipHorizontal=false, flipVertical=false)));
  input Real geomt[6] "Geometrical data vector";
  input Real Gm "Water mass velocity at the inlet (kg/m2s)";
  input ThermoSysPro.Units.AbsolutePressure Pmc "Water average pressure";
  input ThermoSysPro.Units.AbsoluteTemperature Tmc "Water average temperature";
  input ThermoSysPro.Units.AbsoluteTemperature Tpint "Wall temperature";
  output Modelica.SIunits.CoefficientOfHeatTransfer hi "Internal heat transfer coefficient";
protected
  Modelica.SIunits.DynamicViscosity mul "Dynamic viscosity of the liquid phase";
  Modelica.SIunits.SpecificHeatCapacity cpl "Specific heat capacity of the liquid phase";
  Modelica.SIunits.ThermalConductivity kl "Thermal conductivity of the liquid phase";
  Modelica.SIunits.Diameter dtin "Pipes internal diameter";
  Real Re "Reynolds number for the computation of hi";
  Real Pr "Prandtl number for the computation of hi";
  Real cor1 "Corrective coefficient for hi in the supercritical case";
  Real cor2 "Corrective coefficient for hi in the supercritical case";
protected
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_pT protpint annotation(Placement(transformation(x=-90.0, y=46.0, scale=0.06, aspectRatio=1.0, flipHorizontal=false, flipVertical=false)));
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_pT protmc annotation(Placement(transformation(x=-90.0, y=28.0, scale=0.06, aspectRatio=1.0, flipHorizontal=false, flipVertical=false)));
algorithm
  cpl:=hy.cpl;
  mul:=hy.mul;
  kl:=hy.kl;
  dtin:=geomt[2];
  protmc:=ThermoSysPro.Properties.WaterSteam.IF97.Water_PT(Pmc, Tmc, 2);
  protpint:=ThermoSysPro.Properties.WaterSteam.IF97.Water_PT(Pmc, Tpint, 2);
  Re:=Gm*dtin*mul;
  Pr:=mul*cpl/kl;
  if abs(Tmc - Tpint) > 1e-13 then
    cor1:=(1/(1/protpint.d)/(1/protmc.d))^0.3;
    cor2:=((protpint.h - protmc.h)/(Tpint - Tmc)/cpl)^0.5;
  else
    cor1:=1;
    cor2:=1;
  end if;
  hi:=0.0183*kl/dtin*Re^0.82*Pr^0.5*cor1*cor2;
  annotation(smoothOrder=2, Documentation(revisions="<html>
<u><p><b>Authors</u> : </p></b>
<ul style='margin-top:0cm' type=disc>
<li>
    Baligh El Hefni</li>
</ul>
</html>
", info="<html>
<p><b>Copyright &copy; EDF 2002 - 2010</b></p>
</HTML>
<html>
<p><b>ThermoSysPro Version 2.0</b></p>
</HTML>
"));
end WBInternalSuperCriticalFlowHeatTransferCoefficient;
