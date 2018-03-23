settings.outformat = "png";
settings.render = 16;

import graph3;
import contour;
import palette;

size(8cm,0);

real axislength = 2.0;
draw(O--axislength*X, L=Label("$x$", position=Relative(1.1), align=SW), Arrow3);
draw(O--axislength*Y, L=Label("$y$", position=Relative(1.1), align=E), Arrow3);
draw(O--axislength*Z, L=Label("$z$", position=Relative(1.1), align=N), Arrow3);

material lightMaterial = material(diffusepen=gray(0.5)+opacity(0.8), emissivepen=gray(0.6), specularpen=black);

draw(unithemisphere, lightMaterial);

var floorSize = 3.5;
var floor = surface(plane(O=(-floorSize/2,-floorSize/2,0), (floorSize,0,0), (0,floorSize,0)));
draw(floor, lightMaterial);

var rotation = rotate(45.0, (0,0,1)) * rotate(30,(1,0,0));

triple quadCenter = (1, 1, 0.5);
triple quadX = rotation * (0,0,1);
triple quadZ = rotation * (0,1,0);
path3 quad = plane(O=(quadCenter-quadX/2-quadZ/2), quadX, quadZ);

draw(quad);

var pts = intersectionpoints(quad, floor);
for (var i = 1; i < pts.length; ++i) {
  draw(pts[i-1] -- pts[i]);
}