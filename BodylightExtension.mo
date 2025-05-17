within ;
package BodylightExtension
  package Components
    package Hydraulic
      model Conductor "Hydraulic resistor, where conductance=1/resistance"
       extends Bodylight.Hydraulic.Interfaces.OnePort;
       extends Bodylight.Icons.HydraulicResistor;

        parameter Boolean enable=true   "if false, no resistance is used"
          annotation(Evaluate=true, HideResult=true, choices(checkBox=true),
          Dialog(group="External inputs/outputs"));

        parameter Boolean useConductanceInput = false
          "=true, if external conductance value is used"
          annotation(Evaluate=true, HideResult=true, choices(checkBox=true),
          Dialog(group="External inputs/outputs"));

        parameter Bodylight.Types.HydraulicConductance Conductance=0
          "Hydraulic conductance if useConductanceInput=false"
          annotation (Dialog(enable=not useConductanceInput));

        Bodylight.Types.RealIO.HydraulicConductanceInput cond(start=Conductance)=c
          if useConductanceInput annotation (Placement(transformation(
              extent={{-20,-20},{20,20}},
              rotation=270,
              origin={0,60})));
        Bodylight.Types.HydraulicResistance resistance=1/max(c, 1e-15)
          "Informative resistance value";
      protected
         Bodylight.Types.HydraulicConductance c;
      equation
        if not useConductanceInput then
          c=Conductance;
        end if;

        // conditionally disable the resistance
        if c >= Modelica.Constants.inf or not enable then
          q_in.pressure = q_out.pressure;
        else
          q_in.q = c * (q_in.pressure - q_out.pressure);
        end if;
        annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{
                  -100,-100},{100,100}}),
                         graphics={Text(
                extent={{-220,-40},{200,-80}},
                lineColor={0,0,255},
                fillColor={58,117,175},
                fillPattern=FillPattern.Solid,
                textString="%name")}),
          Documentation(revisions="<html>
<p><i>2009-2010</i></p>
<p>Marek Matejak, Charles University, Prague, Czech Republic </p>
</html>",   info="<html>
<p>This hydraulic conductance (resistance) element contains two connector sides. No hydraulic medium volume is changing in this element during simulation. That means that sum of flow in both connector sides is zero. The flow through element is determined by <b>Ohm&apos;s law</b>. It is used conductance (=1/resistance) because it could be numerical zero better then infinity in resistance. </p>
</html>"));
      end Conductor;

      model Resistor
        extends Bodylight.Hydraulic.Components.Conductor(final Conductance=
              conditionalConductance);
        parameter Bodylight.Types.HydraulicResistance Resistance=0
          "Hydraulic conductance if useConductanceInput=false"
          annotation (Dialog(enable=not useConductanceInput));
      protected
                  final parameter Bodylight.Types.HydraulicConductance conditionalConductance=if
            useConductanceInput or Resistance == 0 then Modelica.Constants.inf
             else 1/Resistance;
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
      Components.Hydraulic.Resistor resistor
        annotation (Placement(transformation(extent={{-32,18},{-12,38}})));
      Components.Hydraulic.Conductor conductor
        annotation (Placement(transformation(extent={{-28,-22},{-8,-2}})));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end ResistorTest;
  end Tests;
  annotation (uses(Bodylight(version="1.0"), Modelica(version="4.0.0")));
end BodylightExtension;
