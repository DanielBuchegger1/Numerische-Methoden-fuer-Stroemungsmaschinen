SetFactory("OpenCASCADE");
Merge "S85_1mm_Piece_CFD.STEP";
 
Delete {
  Volume{1}; Surface{1:6}; Curve{1:3, 6:9, 12}; Point{1, 3, 6:7};
}
 
// Translate {-55*Cos(68*Pi/180), 55*Sin(68*Pi/180), 0} {
//   Duplicata { Curve{4:5, 10:11}; }
// }
 
Point(100) = {-100, -40, 0, 2.0};
Point(101) = {-10, 40, 0, 1.0};
Point(102) = {40, 55, 0, 1.0};
Point(103) = {70, 35, 0, 1.0};
Point(104) = {100, 15, 0, 1.0};
Point(105) = {130, 5, 0, 1.0};
Point(106) = {230, 5, 0, 2.0};
 
Line(16) = {100, 101};
Spline(17) = {101:105};
Line(18) = {105, 106};
 
Translate {55*Cos(68*Pi/180), -55*Sin(68*Pi/180), 0} {
  Duplicata { Curve{16:18}; }
}
 
Line(22) = {100, 111};
Line(23) = {106, 114};
 
Curve Loop(7) = {16, 17, 18, 23, -21, -20, -19, -22};
Curve Loop(8) = {10, 11, 4, 5};
Plane Surface(1) = {7, 8};

// Mesh
 
Transfinite Curve {4} = 120 Using Progression 1;
Transfinite Curve {11} = 25 Using Progression 1;
Transfinite Curve {10} = 160 Using Progression 1;
Transfinite Curve {5} = 12 Using Progression 1;
 
 
Field[1] = BoundaryLayer;
 
Field[1].CurvesList = {4, 5, 10, 11};
Field[1].FanPointsList = {1};
Field[1].IntersectMetrics = 1;
Field[1].Quads = 1;
Field[1].Ratio = 1.2;
Field[1].Size = 0.01;
Field[1].Thickness = 2;
 
BoundaryLayer Field = 1;
 

// 3D
 
Extrude {0, 0, 1} {
  Surface{1}; Layers {1}; Recombine;
}

//Periodicity

Periodic Surface {8} = {2} Translate {55*Cos(68*Pi/180), -55*Sin(68*Pi/180), 0};
Periodic Surface {7} = {3} Translate {55*Cos(68*Pi/180), -55*Sin(68*Pi/180), 0};
Periodic Surface {6} = {4} Translate {55*Cos(68*Pi/180), -55*Sin(68*Pi/180), 0};
 
// Boundary names
Physical Surface("inlet", 48) = {9};
Physical Surface("outlet", 49) = {5};
Physical Surface("blade", 50) = {11, 10, 12, 13};
Physical Surface("perL", 51) = {7, 6, 8};
Physical Surface("perU", 52) = {2, 3, 4};
Physical Surface("frontAndBack", 53) = {14, 1};
Physical Volume("fluid", 54) = {1};
 