settings.outformat = "png";
settings.render = 16;

import graph;
import three;
import graph3;
import grid3;

size(8cm,0);

pen thickblack = black+0.75;
real axislength = 2.0;

draw(O--axislength*X, L=Label("$x$", position=Relative(1.1), align=SW), Arrow3);
draw(O--axislength*Y, L=Label("$y$", position=Relative(1.1), align=E), Arrow3);
draw(O--axislength*Z, L=Label("$z$", position=Relative(1.1), align=N), Arrow3);

real R = 1;
real dR = 1.25;

real Theta = 0.3pi;
real Phi = 0.3pi;

triple RectCenter = (R+dR) * expi(Theta, Phi);
triple U = 0.3 * (rotate(180*Phi/pi, Z) * rotate(180*Theta/pi, Y) * X);
triple V = 0.3 * (rotate(180*Phi/pi, Z) * rotate(180*Theta/pi, Y) * Y);

triple RectA = RectCenter + U + V;
triple RectB = RectCenter - U + V;
triple RectC = RectCenter - U - V;
triple RectD = RectCenter + U - V;

label(Label("$A$", p=white), 1.05 * unit(RectCenter));

triple SphereRectA = 1.002*unit(RectA);
triple SphereRectB = 1.002*unit(RectB);
triple SphereRectC = 1.002*unit(RectC);
triple SphereRectD = 1.002*unit(RectD);

draw(unithemisphere, white + opacity(0.125));

draw(RectA -- RectB -- RectC -- RectD -- cycle);

triple surfaceOnSphere(pair t) {
  pair a = (polar(SphereRectA), azimuth(SphereRectA));
  pair b = (polar(SphereRectB), azimuth(SphereRectB));
  pair c = (polar(SphereRectD), azimuth(SphereRectD));
  pair d = (polar(SphereRectC), azimuth(SphereRectC));

  pair interp1 = (t.x) * a + (1-t.x) * b;
  pair interp2 = (t.x) * c + (1-t.x) * d;
  pair final = (t.y) * interp1 + (1-t.y) * interp2;

  return (R+0.001) * expi(final.x, final.y);
}

surface innerSurface = surface(surfaceOnSphere, (0,0), (1,1), 16, 16);
draw(innerSurface, emissive(gray));

draw(arc(O, SphereRectA, SphereRectB));
draw(arc(O, SphereRectB, SphereRectC));
draw(arc(O, SphereRectC, SphereRectD));
draw(arc(O, SphereRectD, SphereRectA));

draw(O -- RectA, dashed);
draw(O -- RectB, dashed);
draw(O -- RectC, dashed);
draw(O -- RectD, dashed);
