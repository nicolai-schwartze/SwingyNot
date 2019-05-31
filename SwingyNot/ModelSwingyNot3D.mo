within SwingyNot;
model ModelSwingyNot3D
  inner Modelica.Mechanics.MultiBody.World world(g=9.81, n(displayUnit="1") = {
      0,0,-1})
              annotation (Placement(transformation(extent={{-78,-52},{-58,-32}})));
  Modelica.Mechanics.MultiBody.Joints.Prismatic prismatic(useAxisFlange=true,
                                                          n(displayUnit="1")=
      {1,0,0}) annotation (Placement(transformation(extent={{-28,36},{-8,56}})));
  Modelica.Mechanics.MultiBody.Parts.Body body1(m=1) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={20,-74})));
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation fixedTranslation(r={0,0,1})
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={20,-30})));
  Modelica.Mechanics.MultiBody.Parts.BodyBox boxBody1(r={0.5,0,0}, width=0.06)
    annotation (Placement(transformation(extent={{44,36},{64,56}})));
  Modelica.Mechanics.MultiBody.Parts.Fixed fixed
    annotation (Placement(transformation(extent={{-76,36},{-56,56}})));
  Modelica.Mechanics.Translational.Sources.Position position(exact=false)
    annotation (Placement(transformation(extent={{-46,68},{-26,88}})));
  Modelica.Blocks.Sources.CombiTimeTable combiTimeTable(table=[0,0; 0.5,0.1; 1,
        0.2; 1.5,0.35; 2,0.4; 2.5,0.41; 3,0.44; 3.5,0.46; 4,0.48; 4.5,0.5; 5,
        0.51; 5.5,0.55; 6,0.6; 6.5,0.7; 7,0.71; 7.5,0.73; 8,0.8; 8.5,0.85; 9,
        0.9; 9.5,1], smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative)
    annotation (Placement(transformation(extent={{-106,66},{-86,86}})));
  Modelica.Mechanics.MultiBody.Joints.Prismatic prismatic1(useAxisFlange=true,
      n(displayUnit="1") = {0,1,0})
               annotation (Placement(transformation(extent={{-40,0},{-20,20}})));
  Modelica.Blocks.Sources.CombiTimeTable combiTimeTable1(table=[0,0; 0.5,0.1; 1,
        0.2; 1.5,0.35; 2,0.4; 2.5,0.41; 3,0.44; 3.5,0.46; 4,0.48; 4.5,0.5; 5,
        0.51; 5.5,0.55; 6,0.6; 6.5,0.7; 7,0.71; 7.5,0.73; 8,0.8; 8.5,0.85; 9,
        0.9; 9.5,1], smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative)
    annotation (Placement(transformation(extent={{-156,2},{-136,22}})));
  Modelica.Mechanics.Translational.Sources.Position position1
    annotation (Placement(transformation(extent={{-102,6},{-82,26}})));
  Universal universal1(
    n_x(displayUnit="1") = {1,0,0},
    n_y(displayUnit="1") = {0,1,0},
    Dx=1,
    Dy=0.1) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={20,34})));

  Real Result;


equation
  connect(body1.frame_a, fixedTranslation.frame_a) annotation (Line(
      points={{20,-64},{20,-40}},
      color={95,95,95},
      thickness=0.5));
  connect(prismatic.frame_a, fixed.frame_b) annotation (Line(
      points={{-28,46},{-56,46}},
      color={95,95,95},
      thickness=0.5));
  connect(position.flange, prismatic.axis) annotation (Line(points={{-26,78},{-12,
          78},{-12,52},{-10,52}},     color={0,127,0}));
  connect(combiTimeTable.y[1], position.s_ref) annotation (Line(points={{-85,76},
          {-66,76},{-66,78},{-48,78}}, color={0,0,127}));
  connect(prismatic1.axis, position1.flange) annotation (Line(points={{-22,16},
          {-22,28},{-54,28},{-54,16},{-82,16}}, color={0,127,0}));
  connect(combiTimeTable1.y[1], position1.s_ref) annotation (Line(points={{-135,
          12},{-120,12},{-120,16},{-104,16}}, color={0,0,127}));
  connect(prismatic.frame_b, prismatic1.frame_a) annotation (Line(
      points={{-8,46},{-6,46},{-6,22},{-44,22},{-44,10},{-40,10}},
      color={95,95,95},
      thickness=0.5));
  connect(prismatic1.frame_b, universal1.frame_a) annotation (Line(
      points={{-20,10},{0,10},{0,44},{20,44}},
      color={95,95,95},
      thickness=0.5));
  connect(boxBody1.frame_a, universal1.frame_a) annotation (Line(
      points={{44,46},{32,46},{32,44},{20,44}},
      color={95,95,95},
      thickness=0.5));
  connect(fixedTranslation.frame_b, universal1.frame_b) annotation (Line(
      points={{20,-20},{20,24}},
      color={95,95,95},
      thickness=0.5));

  Result = max(abs(universal1.phi_x),abs(universal1.phi_y));

   annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-180,-100},
            {100,100}}), graphics={Text(
          extent={{-218,114},{142,-114}},
          lineColor={28,108,200},
          fillColor={0,0,127},
          fillPattern=FillPattern.None,
          textString="3D",
          textStyle={TextStyle.Bold})}),                         Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-180,-100},{100,100}})));
end ModelSwingyNot3D;
