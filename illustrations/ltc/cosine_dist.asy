settings.outformat = "png";
settings.render = 16;

import graph3;
import palette;

real m11 = 1;
real m22 = 1;
real m33 = 1;
real m13 = 0;
real m31 = 0;

real i11, i22, i33, i13, i31;

void calcInv() {
  real denom = m11 * m33 - m13 * m31;
  i11 = m33 / denom;
  i13 = m13 / -denom;
  i22 = 1 / m22;
  i31 = m31 / -denom;
  i33 = m11 / denom;
}

triple transformDirectionLTC(triple t0) {
  return (
    m11 * t0.x + m13 * t0.z,
    m22 * t0.y,
    m31 * t0.x + m33 * t0.z
  );
}

triple invTransformDirectionLTC(triple t0) {
  return (
    i11 * t0.x + i13 * t0.z,
    i22 * t0.y,
    i31 * t0.x + i33 * t0.z
  );
}

triple transformDirectionLTC(triple t0) {
  return (
    m11 * t0.x + m13 * t0.z,
    m22 * t0.y,
    m31 * t0.x + m33 * t0.z
  );
}

void drawSample(triple v) {
  triple direction = unit(transformDirectionLTC(v));

  draw(O--2.0*direction);
  dot(direction);
}

void drawSamplesPreview() {
  for (int i = 0; i < 4; ++i) {
    drawSample(expi(0.1pi, i*2pi/4));
  }

  for (int i = 0; i < 8; ++i) {
    drawSample(expi(0.2pi, i*2pi/8));
  }
}

real cosineDistribution(triple v) {
  triple transformed = unit(invTransformDirectionLTC(v));
  return max(0,transformed.z)/pi;
}

real R=1;
triple f(pair t) {
  return (R*sin(t.y)*cos(t.x), R*sin(t.y)*sin(t.x), R*cos(t.y));
}

void drawCosineSphere() {
  surface s = surface(f, (0,0), (2pi,0.5pi), 100, Spline);
  s.colors(palette(s.map(cosineDistribution), Gradient(blue, red)));
  draw(s, light=nolight);
}

void drawAxes() {
  pen thickblack = gray+0.5;
  real axislength = 1.25;
  draw(L=Label("$x$",black, position=Relative(1.1), align=SW), O--axislength*X,thickblack, Arrow3);
  draw(L=Label("$y$",black, position=Relative(1.1), align=E), O--axislength*Y,thickblack, Arrow3);
  draw(L=Label("$z$",black, position=Relative(1.1), align=N), O--axislength*Z,thickblack, Arrow3);
}

size(5cm, 0);
currentprojection = orthographic(5,2,5);
calcInv();
drawCosineSphere();
drawAxes();
shipout("cosine_dist_clear");

currentpicture = new picture;
size(5cm, 0);
currentprojection = orthographic(5,2,5);
drawCosineSphere();
drawSamplesPreview();
drawAxes();
shipout("cosine_dist_samples");

currentpicture = new picture;
size(5cm, 0);
currentprojection = orthographic(5,2,5);
m11 = 0.2;
m22 = 0.2;
m33 = 1;
m13 = 0;
m31 = 0;
calcInv();
drawCosineSphere();
drawSamplesPreview();
drawAxes();
shipout("cosine_dist_scale");

currentpicture = new picture;
size(5cm, 0);
currentprojection = orthographic(5,2,5);
m11 = 2;
m22 = 0.5;
m33 = 1;
m13 = 0;
m31 = 0;
calcInv();
drawCosineSphere();
drawSamplesPreview();
drawAxes();
shipout("cosine_dist_scale_aniso");

currentpicture = new picture;
size(5cm, 0);
currentprojection = orthographic(5,2,5);
m11 = 0.25;
m22 = 0.25;
m33 = 1;
m13 = 0;
m31 = -0.5;
calcInv();
drawCosineSphere();
drawSamplesPreview();
drawAxes();
shipout("cosine_dist_skew");
