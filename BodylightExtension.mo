within ;
package BodylightExtension
  package Components
    package Hydraulic
      model Resistor
        extends Bodylight.Hydraulic.Components.Conductor(final Conductance=
              conditionalConductance);

        parameter Boolean useResistanceInput=false
          "=true if externalresistance value is used"
          annotation (Dialog(enable=(not useConductanceInput)));


        parameter Bodylight.Types.HydraulicResistance Resistance=0
          "Hydraulic conductance if useConductanceInput=false"
          annotation (Dialog(enable=((not useConductanceInput) and (not useResistanceInput))));

        Bodylight.Types.RealIO.HydraulicResistanceInput hydraulicresistance
          if (useResistanceInput and not useConductanceInput) annotation (
            Placement(transformation(extent={{-174,44},
                  {-134,84}}), iconTransformation(
              extent={{-20,-20},{20,20}},
              rotation=270,
              origin={-2,60})));

      protected
        final parameter Bodylight.Types.HydraulicConductance conditionalConductance=
            if useConductanceInput or Resistance == 0 then Modelica.Constants.inf
             else 1/Resistance;
      equation
         if useResistanceInput then
           Resistance=hydraulicResistance;
         end if;
      end Resistor;
    end Hydraulic;
  end Components;

  package Types
    connector HydraulicElastanceInput = input
        Bodylight.Types.HydraulicElastance
      "input HydraulicElastance as connector"
      annotation (defaultComponentName="hydraulicelastance",
      Icon(graphics={Polygon(
              points={{-100,100},{100,0},{-100,-100},{-100,100}},
              lineColor={0,0,127},
              fillColor={0,0,127},
              fillPattern=FillPattern.Solid)},
           coordinateSystem(extent={{-100,-100},{100,100}}, preserveAspectRatio=true, initialScale=0.2)),
      Diagram(coordinateSystem(
            preserveAspectRatio=true, initialScale=0.2,
            extent={{-100,-100},{100,100}},
            grid={1,1}), graphics={Polygon(
              points={{0,50},{100,0},{0,-50},{0,50}},
              lineColor={0,0,127},
              fillColor={0,0,127},
              fillPattern=FillPattern.Solid), Text(
              extent={{-10,85},{-10,60}},
              lineColor={0,0,127},
              textString="%name")}),
        Documentation(info="<html>
    <p>
    Connector with one input signal of type HydraulicCompliance.
    </p>
    </html>"));
    connector HydraulicElastanceOutput = output
        Bodylight.Types.HydraulicElastance
      "output HydraulicElastance as connector"
      annotation (defaultComponentName="hydraulicelastance",
      Icon(coordinateSystem(
            preserveAspectRatio=true,
            extent={{-100,-100},{100,100}},
            grid={1,1}), graphics={Polygon(
              points={{-100,100},{100,0},{-100,-100},{-100,100}},
              lineColor={0,0,127},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid)}),
      Diagram(coordinateSystem(
            preserveAspectRatio=true,
            extent={{-100,-100},{100,100}},
            grid={1,1}), graphics={Polygon(
              points={{-100,50},{0,0},{-100,-50},{-100,50}},
              lineColor={0,0,127},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid), Text(
              extent={{30,110},{30,60}},
              lineColor={0,0,127},
              textString="%name")}),
        Documentation(info="<html>
  <p>
  Connector with one output signal of type Real.
  </p>
  </html>"));
  end Types;

  package Tests
    model ResistorTest
      Bodylight.Types.Constants.HydraulicResistanceConst hydraulicResistance
        annotation (Placement(transformation(extent={{-84,54},{-76,62}})));
      Bodylight.Types.Constants.HydraulicConductanceConst hydraulicConductance
        annotation (Placement(transformation(extent={{-84,72},{-76,80}})));
      Components.Hydraulic.Resistor resistor(
        useConductanceInput=true,
        useResistanceInput=true,
        Resistance=351971102775.6)
        annotation (Placement(transformation(extent={{-40,20},{-20,40}})));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end ResistorTest;
  end Tests;
  annotation (uses(Bodylight(version="1.0"), Modelica(version="4.0.0")));
end BodylightExtension;
