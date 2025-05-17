within ;
package BodylightExtension
  package Components
    package Hydraulic
      model Resistor
        extends Bodylight.Hydraulic.Components.Conductor(final Conductance=
              conditionalConductance);

        parameter Boolean useResistanceInput=false
          "=true if externalresistance value is used"
          annotation (Dialog(enable=(not useConductanceInput)),
           choices(Evaluate=true, HideResult=true, checkBox=true));


        parameter Bodylight.Types.HydraulicResistance Resistance=0
          "Hydraulic conductance if useConductanceInput=false"
          annotation (Dialog(enable=((not useConductanceInput) and (not useResistanceInput))));

        Bodylight.Types.RealIO.HydraulicResistanceInput condRes(start=Resistance)=hr
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
        Bodylight.Types.HydraulicResistance hr;
      equation
         if not useResistanceInput then
           hr=Resistance;
         end if;
         if useResistanceInput and useConductanceInput then
           hr=1/c;
         end if;
      end Resistor;
    end Hydraulic;
  end Components;

  package Types
    package RealIO
      connector HydraulicResistanceOutput =  output
          Bodylight.Types.HydraulicResistance
        "output HydraulicResistance as connector"
        annotation (defaultComponentName="hydraulicconductance",
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
        connector HydraulicResistanceInput =  input
          Bodylight.Types.HydraulicResistance
        "input HydraulicResistance as connector"
        annotation (defaultComponentName="hydraulicconductance",
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
    Connector with one input signal of type HydraulicConductance.
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
    end RealIO;
  end Types;

  package Tests
    model ResistorTest
      extends Modelica.Icons.Example;
      Bodylight.Hydraulic.Sources.UnlimitedPump unlimitedPump(SolutionFlow=
            1.6666666666667e-08)
        annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
      Bodylight.Hydraulic.Sources.UnlimitedVolume unlimitedVolume(P=
            133.322387415)
        annotation (Placement(transformation(extent={{4,22},{-12,38}})));
      Bodylight.Types.Constants.HydraulicResistanceConst hydraulicResistance(k=
            7999343244.9)
        annotation (Placement(transformation(extent={{-80,76},{-72,84}})));
      Bodylight.Types.Constants.HydraulicConductanceConst hydraulicConductance(
          k=1.2501026264094e-10)
        annotation (Placement(transformation(extent={{-78,54},{-70,62}})));
      Components.Hydraulic.Resistor resistor(useConductanceInput=false,
          useResistanceInput=true)
        annotation (Placement(transformation(extent={{-46,20},{-26,40}})));
    equation
      connect(unlimitedPump.q_out, resistor.q_in) annotation (Line(
          points={{-60,30},{-46,30}},
          color={0,0,0},
          thickness=1));
      connect(resistor.q_out, unlimitedVolume.y) annotation (Line(
          points={{-26,30},{-12,30}},
          color={0,0,0},
          thickness=1));
      connect(resistor.condRes, hydraulicResistance.y) annotation (Line(points=
              {{-36.2,36},{-36,36},{-36,80},{-71,80}}, color={0,0,127}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end ResistorTest;
  end Tests;
  annotation (uses(Bodylight(version="1.0"), Modelica(version="4.0.0")));
end BodylightExtension;
