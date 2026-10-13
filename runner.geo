SetFactory("OpenCASCADE");  // optional geometry kernel

Geometry.Tolerance = 1e-6;

Geometry.OCCSewFaces = 1;

//--------------------------------------------------------------------

Merge "periodic.stp";

Extrude { {0,0,1} , {0,0,0} , -2*Pi/7 } {
Surface{1,2};
}

// merge the two volumes that are created from the extrude command

BooleanUnion{Volume{1};Delete;}{Volume{2};Delete;}

// imports the blade

Merge "schaufel.stp";

// create a volume from the imported blade surfaces and curves

Curve Loop(20) = {48, 46};

Surface(20) = {20};

Curve Loop(22) = {49, 43};

Surface(21) = {22};

Surface Loop(2) = {18, 19, 20, 21};

Volume(2) = {2};

// substract the blade from the rest of the volume

BooleanDifference{Volume{1};Delete;}{Volume{2};Delete;}

//--------------------------------------------------------------------
// Periodic surfaces
//--------------------------------------------------------------------

Periodic Surface {4} = {5} Rotate {{0,0,1}, {0,0,0}, 2*Pi/7};

Periodic Surface {12} = {14} Rotate {{0,0,1}, {0,0,0}, 2*Pi/7};


//--------------------------------------------------------------------
// Physical groups
//--------------------------------------------------------------------

// surfaces

Physical Surface("IF_LAUF_LEIT") = {1};

Physical Surface("IF_LAUF_SAUGROHR") = {16};

Physical Surface("SCHAUFEL") = {7, 8};

Physical Surface("KRANZ") = {3, 11, 13, 10, 18, 17};

Physical Surface("NABE") = {2, 6, 9, 15, 19, 20, 21};

Physical Surface("cyclicA") = {4,12};

Physical Surface("cyclicB") = {5,14};

// volumina

Physical Volume("internalMesh") = {1};


//--------------------------------------------------------------------
// Fields
//--------------------------------------------------------------------

// in principle one field would be enough except the mesh at the blade 
// should be finer than at the rest of the walls


// field to refine mesh at "SCHAUFEL" (blades)

Field[1] = Attractor;

Field[1].SurfacesList = {7,8};

Field[1].NumPointsPerCurve = 100;


// defines the mesh size at "SCHAUFEL" (blades)

Field[2] = Threshold;

Field[2].DistMin = 0.1;

Field[2].DistMax = 3;

Field[2].InField = 1;

Field[2].Sigmoid = 1;

Field[2].SizeMax = 2;

Field[2].SizeMin = 0.65;

Field[2].StopAtDistMax = 1;


// field to refine mesh at "NABE" and "KRANZ"

Field[3] = Attractor;

Field[3].SurfacesList = {3, 11, 13, 10, 18, 17, 2, 6, 9, 15, 19, 20, 21};

Field[3].NumPointsPerCurve = 100;


// defines the mesh size at "NABE" and "KRANZ"

Field[4] = Threshold;

Field[4].DistMin = 0.1;

Field[4].DistMax = 3;

Field[4].InField = 3;

Field[4].Sigmoid = 1;

Field[4].SizeMax = 2;

Field[4].SizeMin = 0.65;

Field[4].StopAtDistMax = 1;


// takes the minimum of the field values from above

Field[5] = Min;

Field[5].FieldsList = {2, 4};


// set the result of the minimum field as the mesh size

Background Field = 5;


//--------------------------------------------------------------------
// Mesh size settings
//--------------------------------------------------------------------

// global mesh thresholds

Mesh.MeshSizeMin = 0.65;

Mesh.MeshSizeMax = 7;


// settings for mesh size, mesh size only from fields

Mesh.MeshSizeFromPoints = 0;

Mesh.MeshSizeFromCurvature = 0;

Mesh.MeshSizeExtendFromBoundary = 0;


// mesh smoother

Mesh.Smoothing = 20;
