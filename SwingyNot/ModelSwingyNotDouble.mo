within SwingyNot;
model ModelSwingyNotDouble
  import Modelica.Utilities.Streams;
  inner Modelica.Mechanics.MultiBody.World world(g=9.81, n(displayUnit="1") = {
      0,0,-1})
              annotation (Placement(transformation(extent={{-78,-38},{-58,-18}})));
  Modelica.Mechanics.MultiBody.Joints.Prismatic prismatic(useAxisFlange=true,
                                                          n(displayUnit="1")=
      {1,0,0}) annotation (Placement(transformation(extent={{-30,50},{-10,70}})));
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation fixedTranslation(r={0,0,0.5})
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={14,4})));
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
    annotation (Placement(transformation(extent={{-46,74},{-26,94}})));
  Modelica.Blocks.Sources.CombiTimeTable combiTimeTable(
    tableOnFile=true,                                   table=[0,0; 0.5,0.1; 1,
        0.2; 1.5,0.35; 2,0.4; 2.5,0.41; 3,0.44; 3.5,0.46; 4,0.48; 4.5,0.5; 5,
        0.51; 5.5,0.55; 6,0.6; 6.5,0.7; 7,0.71; 7.5,0.73; 8,0.8; 8.5,0.85; 9,
        0.9; 9.5,1],
    tableName="path",
    fileName=Modelica.Utilities.Files.loadResource(
        "modelica://SwingyNot/Resources/data.mat"),
                     smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative)
    annotation (Placement(transformation(extent={{-106,74},{-86,94}})));

  Real Result;

  Modelica.Mechanics.MultiBody.Parts.Body body1(m=1) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={14,-80})));
  Modelica.Mechanics.Rotational.Components.Damper damper1(d=0.1)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-20,-34})));
  Modelica.Mechanics.MultiBody.Joints.Revolute revolute2(
    useAxisFlange=true,
    n(displayUnit="1") = {0,1,0},
    phi(fixed=true, start=0),
    w(fixed=true))                                               annotation (Placement(transformation(extent={{-10,-10},
            {10,10}},
        rotation=90,
        origin={14,-28})));
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation fixedTranslation1(r={0,0,0.5})
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={14,-54})));
equation
  connect(prismatic.frame_b, revolute1.frame_b) annotation (Line(
      points={{-10,60},{4,60},{4,50},{14,50}},
      color={95,95,95},
      thickness=0.5));
  connect(boxBody1.frame_a, revolute1.frame_b) annotation (Line(
      points={{44,60},{30,60},{30,50},{14,50}},
      color={95,95,95},
      thickness=0.5));
  connect(fixedTranslation.frame_b, revolute1.frame_a) annotation (Line(
      points={{14,14},{14,30}},
      color={95,95,95},
      thickness=0.5));
  connect(prismatic.frame_a, fixed.frame_b) annotation (Line(
      points={{-30,60},{-56,60}},
      color={95,95,95},
      thickness=0.5));
  connect(revolute1.axis, damper.flange_b)
    annotation (Line(points={{4,40},{-30,40}}, color={0,0,0}));
  connect(revolute1.support, damper.flange_a) annotation (Line(points={{4,34},{
          -14,34},{-14,20},{-30,20}}, color={0,0,0}));
  connect(position.flange, prismatic.axis) annotation (Line(points={{-26,84},{-12,
          84},{-12,66}},              color={0,127,0}));
  connect(combiTimeTable.y[1], position.s_ref) annotation (Line(points={{-85,84},
          {-48,84}},                   color={0,0,127}));

  Result=  max(1 - 0.5*cos(revolute1.phi) - 0.5*cos(revolute2.phi), Result);

  connect(revolute2.frame_b, fixedTranslation.frame_a) annotation (Line(
      points={{14,-18},{14,-6}},
      color={95,95,95},
      thickness=0.5));
  connect(damper1.flange_b, revolute2.axis) annotation (Line(points={{-20,-24},{
          -20,-18},{-2,-18},{-2,-28},{4,-28}}, color={0,0,0}));
  connect(damper1.flange_a, revolute2.support) annotation (Line(points={{-20,-44},
          {-20,-50},{-2,-50},{-2,-34},{4,-34}}, color={0,0,0}));
  connect(revolute2.frame_a, fixedTranslation1.frame_b) annotation (Line(
      points={{14,-38},{14,-44}},
      color={95,95,95},
      thickness=0.5));
  connect(fixedTranslation1.frame_a, body1.frame_a) annotation (Line(
      points={{14,-64},{14,-70}},
      color={95,95,95},
      thickness=0.5));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-140,-100},
            {100,100}}), graphics={Text(
          extent={{-196,114},{164,-114}},
          lineColor={28,108,200},
          fillColor={0,0,127},
          fillPattern=FillPattern.None,
          textStyle={TextStyle.Bold},
          textString="2D")}),                                    Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-140,-100},{100,100}})));
end ModelSwingyNotDouble;
