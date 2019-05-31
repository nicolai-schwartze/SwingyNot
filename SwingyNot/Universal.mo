within SwingyNot;
model Universal
  "Universal joint (2 degrees-of-freedom, 4 potential states, 2 Dampers)"

  extends Modelica.Mechanics.MultiBody.Interfaces.PartialTwoFrames;
  parameter Boolean animation=true "= true, if animation shall be enabled";
  parameter Modelica.Mechanics.MultiBody.Types.Axis n_x={1,0,0}
    "Axis of revolute joint 1 resolved in frame_a" annotation (Evaluate=true);
  parameter Modelica.Mechanics.MultiBody.Types.Axis n_y={0,1,0}
    "Axis of revolute joint 2 resolved in frame_b" annotation (Evaluate=true);

  parameter Modelica.SIunits.Distance cylinderLength=world.defaultJointLength
    "Length of cylinders representing the joint axes" annotation (Dialog(
      tab="Animation",
      group="if animation = true",
      enable=animation));
  parameter Modelica.SIunits.Distance cylinderDiameter=world.defaultJointWidth
    "Diameter of cylinders representing the joint axes" annotation (Dialog(
      tab="Animation",
      group="if animation = true",
      enable=animation));
  input Modelica.Mechanics.MultiBody.Types.Color cylinderColor=Modelica.Mechanics.MultiBody.Types.Defaults.JointColor
    "Color of cylinders representing the joint axes" annotation (Dialog(
      colorSelector=true,
      tab="Animation",
      group="if animation = true",
      enable=animation));
  input Modelica.Mechanics.MultiBody.Types.SpecularCoefficient specularCoefficient=world.defaultSpecularCoefficient
    "Reflection of ambient light (= 0: light is completely absorbed)"
    annotation (Dialog(
      tab="Animation",
      group="if animation = true",
      enable=animation));
  parameter StateSelect stateSelect=StateSelect.prefer
    "Priority to use joint coordinates (phi_a, phi_b, w_a, w_b) as states" annotation(Dialog(tab="Advanced"));

  parameter Real Dx "DampingCoefficient x-axis";
  parameter Real Dy "DampingCoefficient y-axis";



  Modelica.Mechanics.MultiBody.Joints.Revolute revolute_a(
    useAxisFlange=true,
    n(displayUnit="1") = n_x,
    stateSelect=StateSelect.never,
    cylinderDiameter=cylinderDiameter,
    cylinderLength=cylinderLength,
    cylinderColor=cylinderColor,
    specularCoefficient=specularCoefficient,
    animation=animation) annotation (Placement(transformation(extent={{-36,0},{-10,
            25}})));
  Modelica.Mechanics.MultiBody.Joints.Revolute revolute_b(
    useAxisFlange=true,
    n(displayUnit="1") = n_y,
    stateSelect=StateSelect.never,
    animation=animation,
    cylinderDiameter=cylinderDiameter,
    cylinderLength=cylinderLength,
    cylinderColor=cylinderColor,
    specularCoefficient=specularCoefficient)
    annotation (Placement(transformation(
        origin={48,32},
        extent={{-12,-12},{12,12}},
        rotation=90)));

  Modelica.SIunits.Angle phi_x(start=0, stateSelect=stateSelect)
    "Relative rotation angle from frame_a to intermediate frame";
  Modelica.SIunits.Angle phi_y(start=0, stateSelect=stateSelect)
    "Relative rotation angle from intermediate frame to frame_b";
  Modelica.SIunits.AngularVelocity w_x(start=0, stateSelect=stateSelect)
    "First derivative of angle phi_a (relative angular velocity a)";
  Modelica.SIunits.AngularVelocity w_y(start=0, stateSelect=stateSelect)
    "First derivative of angle phi_b (relative angular velocity b)";
  Modelica.SIunits.AngularAcceleration a_x(start=0)
    "Second derivative of angle phi_a (relative angular acceleration a)";
  Modelica.SIunits.AngularAcceleration a_y(start=0)
    "Second derivative of angle phi_b (relative angular acceleration b)";

  Modelica.Mechanics.Rotational.Components.Damper damper(d=Dx)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-20,58})));
  Modelica.Mechanics.Rotational.Components.Damper damper1(d=Dy)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={14,36})));
equation
  phi_x = revolute_a.phi;
  phi_y = revolute_b.phi;
  w_x = der(phi_x);
  w_y = der(phi_y);
  a_x = der(w_x);
  a_y = der(w_y);
  connect(frame_a, revolute_a.frame_a)
    annotation (Line(
      points={{-100,0},{-80,0},{-80,12.5},{-36,12.5}},
      color={95,95,95},
      thickness=0.5));
  connect(revolute_b.frame_b, frame_b) annotation (Line(
      points={{48,44},{48,90},{70,90},{70,0},{100,0}},
      color={95,95,95},
      thickness=0.5));
  connect(revolute_a.frame_b, revolute_b.frame_a) annotation (Line(
      points={{-10,12.5},{48,12.5},{48,20}},
      color={95,95,95},
      thickness=0.5));
  connect(revolute_a.support, damper.flange_a)
    annotation (Line(points={{-30.8,25},{-30,25},{-30,58}}, color={0,0,0}));
  connect(damper.flange_b, revolute_a.axis)
    annotation (Line(points={{-10,58},{0,58},{0,25},{-23,25}}, color={0,0,0}));
  connect(revolute_b.support, damper1.flange_a) annotation (Line(points={{36,24.8},
          {26,24.8},{26,26},{14,26}}, color={0,0,0}));
  connect(damper1.flange_b, revolute_b.axis) annotation (Line(points={{14,46},{14,
          56},{30,56},{30,32},{36,32}}, color={0,0,0}));
  annotation (
    Documentation(info="<html>
<p>
Joint where frame_a rotates around axis n_a which is fixed in frame_a
and frame_b rotates around axis n_b which is fixed in frame_b.
The two frames coincide when
\"revolute_a.phi=0\" and \"revolute_b.phi=0\". This joint
has the following potential states;
</p>
<ul>
<li> The relative angle phi_a = revolute_a.phi [rad] around axis n_a, </li>
<li> the relative angle phi_b = revolute_b.phi [rad] around axis n_b, </li>
<li> the relative angular velocity w_a (= der(phi_a))  and </li>
<li> the relative angular velocity w_b (= der(phi_b)).</li>
</ul>
<p>
They are used as candidates for automatic selection of states
from the tool. This may be enforced by setting \"stateSelect=StateSelect.<b>always</b>\"
in the <b>Advanced</b> menu. The states are usually selected automatically.
In certain situations, especially when closed kinematic loops are present,
it might be slightly more efficient, when using the \"StateSelect.always\" setting.
</p>

<p>
In the following figure the animation of a universal
joint is shown. The light blue coordinate system is
frame_a and the dark blue coordinate system is
frame_b of the joint
(here: n_a = {0,0,1}, n_b = {0,1,0}, phi_a.start = 90<sup>o</sup>,
phi_b.start = 45<sup>o</sup>).
</p>

<p>
<IMG src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Joints/Universal.png\">
</p>
</html>"),
    Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}}), graphics={
        Rectangle(
          extent={{-100,15},{-65,-15}},
          lineColor={0,0,0},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={235,235,235}),
        Ellipse(
          extent={{-80,-80},{80,80}},
          lineColor={160,160,164},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-60,-60},{60,60}},
          lineColor={160,160,164},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-150,-80},{150,-120}},
          textString="%name",
          lineColor={0,0,255}),
        Rectangle(
          extent={{12,82},{80,-82}},
          lineColor={255,255,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{56,15},{100,-15}},
          lineColor={0,0,0},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={235,235,235}),
        Line(
          points={{12,78},{12,-78}},
          thickness=0.5),
        Ellipse(
          extent={{-52,-40},{80,40}},
          lineColor={160,160,164},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-32,-20},{60,26}},
          lineColor={160,160,164},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-22,-54},{-60,0},{-22,50},{40,52},{-22,-54}},
          pattern=LinePattern.None,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,255}),
        Line(
          points={{12,78},{12,-20}},
          thickness=0.5),
        Line(
          points={{32,38},{-12,-36}},
          thickness=0.5)}));
end Universal;
