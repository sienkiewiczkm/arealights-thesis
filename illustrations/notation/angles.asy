settings.outformat = "png";
settings.render = 16;

import graph3;

size(8cm,0);

real axislength = 2.0;
draw(O--axislength*X, L=Label("$x$", position=Relative(1.1), align=SW), Arrow3);
draw(O--axislength*Y, L=Label("$y$", position=Relative(1.1), align=E), Arrow3);
draw(O--axislength*Z, L=Label("$z$", position=Relative(1.1), align=N), Arrow3);


triple testVector = 2.5*dir(50, 70);

triple testVectorXY = (testVector.x, testVector.y, 0);
draw(O -- testVector, Arrow3, L=Label("$r$"));
draw(O -- testVectorXY -- testVector, dotted);

var thetaAngle = arc(O, point(O--testVectorXY, 0.5), point(O--X, 0.5));
draw(thetaAngle, red, L=Label("$\theta$", align=S));

var phiAngle = arc(O, point(O--testVector, 0.5), point(O--Z, 0.5));
draw(phiAngle, red, L=Label("$\phi$"));