settings.outformat = "png";
settings.render = 16;
settings.prc = false;

import settings;
interactiveView=false;

import graph;
import three;
import graph3;
import grid3;

size(8cm,0);

pen thickblack = black+0.75;
real axislength = 2.0;

pair lightSize = (1.5,1.5);

real labelX = lightSize.x + 0.2;
real labelZ = lightSize.y + 0.2;

int numLightsX = 4;
int numLightsY = 4;

for (int i = 0; i+1 <= numLightsX; ++i) {
  real x = lightSize.x * ((i+1)/numLightsX);
  draw( (x, 0, 0) -- (x, 0, labelZ), dotted );

  real xPrev = lightSize.x * ((i)/numLightsX);
  draw( (xPrev, 0, labelZ) -- (x, 0, labelZ), L=Label("$\Delta x$", position=MidPoint, align=N), Arrows3);
}

for (int i = 0; i+1 <= numLightsY; ++i) {
  real z = lightSize.y * ((i+1)/numLightsY);
  draw( (0, 0, z) -- (labelX, 0, z), dotted );

  real zPrev = lightSize.x * ((i)/numLightsX);
  draw( (labelX, 0, zPrev) -- (labelX, 0, z), L=Label("$\Delta y$", position=MidPoint, align=W), Arrows3);
}

draw( plane((lightSize.x, 0, 0), (0, 0, lightSize.y)) );

for (int i = 0; i < numLightsX; ++i) {
  real x = lightSize.x * ((i+0.5)/numLightsX);
  for (int j = 0; j < numLightsY; ++j) {
    real z = lightSize.y * ((j+0.5)/numLightsY);
    dot( (x,0,z) );
  }
}

draw(O--axislength*X, L=Label("$x$", position=Relative(1.1), align=SW), Arrow3);
draw(O--0.2*axislength*Y, L=Label("$z$", position=Relative(1.1), align=E), Arrow3);
draw(O--axislength*Z, L=Label("$y$", position=Relative(1.1), align=N), Arrow3);