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

real ang = 2*pi*(40/360.0);

/*
real m11 = cos(ang);
real m22 = 0.8;
real m33 = cos(ang);
real m13 = sin(ang);
real m31 = -sin(ang) * 0.2;
*/

real m11 = 1;
real m22 = 1;
real m33 = 1;
real m13 = 0;
real m31 = 0;

// m11       m13
//      m22
// m31       m33

triple transformltc(triple t0) {
  return (
    m11 * t0.x + m13 * t0.z,
    m22 * t0.y,
    m31 * t0.x + m33 * t0.z
  );
}

triple quadCenter = transformltc((0,0,1.5));
triple quadX = transformltc((1,1,-0.5));
triple quadZ = transformltc((1,0,0));

surface quadSurface = surface(plane(O=(quadCenter-quadX/2-quadZ/2), quadX, quadZ)); 

draw(quadSurface, lightMaterial);

real minX = -1.0, maxX = 1.0;
real minZ = -1.0, maxZ = 1.0;
real rayLength = 10;

int nSamples = 16;

for (int i = 0; i < nSamples; ++i) {
  real x = minX + (maxX - minX) * ((real)i)/(nSamples-1);
  for (int j = 0; j < nSamples; ++j) {
    real z = minZ + (maxZ - minZ) * ((real)j)/(nSamples-1);
    var rayDir = (x, z, 1);
    rayDir /= length(rayDir);

    rayDir = transformltc(rayDir);
    rayDir /= length(rayDir);

    path3 ray = O -- (rayLength * rayDir);

    triple[] ip = intersectionpoints(ray, quadSurface);
    if (ip.length > 0) {
      draw(O--ip[0], red, Arrow3);
      dot(ip[0], red);
    }
  }
}