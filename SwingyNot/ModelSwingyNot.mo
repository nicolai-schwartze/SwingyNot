within SwingyNot;
model ModelSwingyNot
  inner Modelica.Mechanics.MultiBody.World world(g=9.81, n(displayUnit="1") = {
      0,0,-1})
              annotation (Placement(transformation(extent={{-78,-38},{-58,-18}})));
  Modelica.Mechanics.MultiBody.Joints.Prismatic prismatic(useAxisFlange=true,
                                                          n(displayUnit="1")=
      {1,0,0}) annotation (Placement(transformation(extent={{-28,50},{-8,70}})));
  Modelica.Mechanics.MultiBody.Parts.Body body1(m=1) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={14,-60})));
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation fixedTranslation(r={0,0,1})
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={14,-16})));
  Modelica.Mechanics.MultiBody.Parts.BodyBox boxBody1(r={0.5,0,0}, width=0.06)
    annotation (Placement(transformation(extent={{44,50},{64,70}})));
  Modelica.Mechanics.MultiBody.Joints.Revolute revolute1(
    useAxisFlange=true,
    n(displayUnit="1") = {0,1,0},
    phi(fixed=true, start=0),
    w(fixed=true))                                               annotation (Placement(transformation(extent={{-10,-10},
            {10,10}},
        rotation=90,
        origin={14,40})));
  Modelica.Mechanics.MultiBody.Parts.Fixed fixed
    annotation (Placement(transformation(extent={{-76,50},{-56,70}})));
  Modelica.Mechanics.Rotational.Components.Damper damper(d=0.1)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-30,30})));
  Modelica.Mechanics.Translational.Sources.Position position(useSupport=false,
                                                             exact=false)
    annotation (Placement(transformation(extent={{-46,76},{-26,96}})));
  Modelica.Blocks.Sources.CombiTimeTable combiTimeTable(table=[0,0; 0.5,0.1; 1,
        0.2; 1.5,0.35; 2,0.4; 2.5,0.41; 3,0.44; 3.5,0.46; 4,0.48; 4.5,0.5; 5,
        0.51; 5.5,0.55; 6,0.6; 6.5,0.7; 7,0.71; 7.5,0.73; 8,0.8; 8.5,0.85; 9,
        0.9; 9.5,1], smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative)
    annotation (Placement(transformation(extent={{-106,74},{-86,94}})));
equation
  connect(body1.frame_a, fixedTranslation.frame_a) annotation (Line(
      points={{14,-50},{14,-26}},
      color={95,95,95},
      thickness=0.5));
  connect(prismatic.frame_b, revolute1.frame_b) annotation (Line(
      points={{-8,60},{4,60},{4,50},{14,50}},
      color={95,95,95},
      thickness=0.5));
  connect(boxBody1.frame_a, revolute1.frame_b) annotation (Line(
      points={{44,60},{30,60},{30,50},{14,50}},
      color={95,95,95},
      thickness=0.5));
  connect(fixedTranslation.frame_b, revolute1.frame_a) annotation (Line(
      points={{14,-6},{14,30}},
      color={95,95,95},
      thickness=0.5));
  connect(prismatic.frame_a, fixed.frame_b) annotation (Line(
      points={{-28,60},{-56,60}},
      color={95,95,95},
      thickness=0.5));
  connect(revolute1.axis, damper.flange_b)
    annotation (Line(points={{4,40},{-30,40}}, color={0,0,0}));
  connect(revolute1.support, damper.flange_a) annotation (Line(points={{4,34},{
          -14,34},{-14,20},{-30,20}}, color={0,0,0}));
  connect(position.flange, prismatic.axis) annotation (Line(points={{-26,86},{
          -12,86},{-12,66},{-10,66}}, color={0,127,0}));
  connect(combiTimeTable.y[1], position.s_ref) annotation (Line(points={{-85,84},
          {-66,84},{-66,86},{-48,86}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end ModelSwingyNot;
