settings.outformat = "pdf";
unitsize(5cm);

import graph;
import geometry;

pair O = (0,0);

real macrosurfaceWidth = 2.0;
path macrosurface = (-macrosurfaceWidth/2,0) -- (+macrosurfaceWidth/2,0);

var mAngle = 60;
pair m = dir(mAngle);
pair perpM = dir(mAngle+90);

var macroViewAngle = 100;
pair v = dir(macroViewAngle);

pair microReflected = 2 * dot(v,m) * m - v;

draw(macrosurface, L=Label("Makropowierzchnia", position=EndPoint, align=N));
draw((-perpM) -- (+perpM), dashed, L=Label("Mikropowierzchnia", position=BeginPoint, align=S));

draw((0,0) -- m, L=Label("$m$", position=EndPoint), arrow=Arrow(TeXHead));
draw((0,0) -- v, L=Label("$\omega_o$", position=EndPoint), arrow=Arrow(TeXHead));
draw((0,0) -- microReflected, L=Label("$\omega_i$", position=EndPoint), arrow=Arrow(TeXHead));

markangle("$\alpha$", line(O, m), line(O, v), n=1);
markangle("$\alpha$", line(O, microReflected), line(O, m), n=1);
