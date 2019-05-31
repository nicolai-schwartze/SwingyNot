within ;
model table

  Modelica.Blocks.Sources.CombiTimeTable combiTimeTable(
    tableOnFile=true,
    tableName="A1",
    fileName=Modelica.Utilities.Files.loadResource(
        "modelica://SwingyNot/Resources/data.mat"))
    annotation (Placement(transformation(extent={{-70,-72},{-50,-52}})));
  annotation (uses(Modelica(version="3.2.2")));
end table;
