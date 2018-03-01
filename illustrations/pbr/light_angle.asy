settings.outformat = "pdf";
unitsize(2cm);

import geometry;

path baseFloor = (-5,0) -- (5,0);

pair refLightCenter = (-3,3);
pair refLightVec = (1,0);
pair refLightRight = refLightCenter + refLightVec;
pair refLightVecPerp = (0,-1);
pair refCenterBottom = (-3,0);
pair refRightBottom = refCenterBottom + refLightVec;

draw((refLightCenter-refLightVec) -- refLightCenter);
draw(refLightCenter -- refLightRight, L=Label("$a$", position=MidPoint, align=N));
draw(refCenterBottom -- refRightBottom, L=Label("$a$", position=MidPoint, align=N));

perpendicularmark(line(refLightCenter, refLightRight), line(refLightCenter, refCenterBottom), quarter=4);
perpendicularmark(line(refLightRight, refLightCenter), line(refLightRight, refRightBottom), quarter=1);
perpendicularmark(line(refLightCenter, refCenterBottom), line(refCenterBottom, refRightBottom), quarter=2);
perpendicularmark(line(refLightRight, refRightBottom), line(refCenterBottom, refRightBottom), quarter=3);


draw(refLightCenter -- refCenterBottom, dotted);
draw(refLightRight -- refRightBottom, dotted);

dot(refLightCenter);
dot(refLightRight);
dot(refCenterBottom);
dot(refRightBottom);

pair lightCenter = (1,3);
pair lightVec = expi(0.15*pi);
pair lightVecPerp = (lightVec.y, -lightVec.x);

pair lightRight = (lightCenter+lightVec);

draw((lightCenter-lightVec) -- lightCenter);
draw(lightCenter -- lightRight, L=Label("$a$", position=MidPoint, align=N));

draw((lightCenter-(2,0))--lightCenter--(lightCenter+(2,0)), dashed);

path centerRay = lightCenter -- (lightCenter + 5 * lightVecPerp);
path rightRay = lightRight -- (lightRight + 5 * lightVecPerp);

real[] centerIntersectTime = intersect(centerRay, baseFloor);
pair centerIntersect = point(centerRay, centerIntersectTime[0]);

real[] rightIntersectTime = intersect(rightRay, baseFloor);
pair rightIntersect = point(rightRay, rightIntersectTime[0]);

pair nearRight = centerIntersect + lightVec;

draw(arc(lightCenter, lightCenter + (0.5, 0), lightRight), arrow=Arrow(TeXHead), L=Label("$\alpha$"));
draw(arc(centerIntersect, centerIntersect + (0.5, 0), nearRight), arrow=Arrow(TeXHead), L=Label("$\alpha$"));

draw(centerIntersect -- nearRight, L=Label("$a$", position=MidPoint, align=N));
draw(lightCenter -- centerIntersect, dotted);
draw(lightRight -- rightIntersect, dotted);

draw(centerIntersect -- rightIntersect, L=Label("$x$", position=MidPoint, align=S));

dot(lightCenter);
dot(lightRight);
dot(centerIntersect);
dot(rightIntersect);
dot(nearRight);

perpendicularmark(line(lightCenter, lightRight), line(lightCenter, centerIntersect), quarter=4);
perpendicularmark(line(lightRight, lightCenter), line(lightRight, rightIntersect), quarter=1);
perpendicularmark(line(nearRight, centerIntersect), line(nearRight, rightIntersect), quarter=1);

label("$\cos\alpha = \frac{a}{x} \Rightarrow x = \frac{a}{\cos\alpha}$", (0.25, 1.5));

draw(baseFloor);