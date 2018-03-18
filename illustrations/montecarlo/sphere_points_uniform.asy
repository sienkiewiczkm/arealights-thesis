settings.outformat = "png";
settings.render = 16;

import graph;
import three;
import graph3;
import grid3;

size(8cm,0);

currentprojection = perspective(10,10,20);

pen thickblack = black+0.75;
real axislength = 2.0;

draw(O--axislength*X, L=Label("$x$", position=Relative(1.1), align=SW), Arrow3);
draw(O--axislength*Y, L=Label("$y$", position=Relative(1.1), align=E), Arrow3);
draw(O--axislength*Z, L=Label("$z$", position=Relative(1.1), align=N), Arrow3);

real vanCorput(int n, int base) {
  real denominator = 1.0;
  real result = 0.0;

  while (n > 0) {
    denominator /= base;
    result += denominator * (n%base);
    n = (int)(n/base);
  }

  return result;
}

int nPoints = 500;
for (int i = 0; i < nPoints; ++i) {
  real u = i/nPoints;
  real v = vanCorput(i,2);

  real phi = acos(1-u);
  real theta = 2 * pi * v;

  dot(expi(phi, theta), red);
}

draw(unithemisphere, white);
