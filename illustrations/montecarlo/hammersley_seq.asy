settings.outformat = "pdf";
unitsize(5cm);

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

draw((0.0, 0.0) -- (0.0, 1.1), arrow=Arrow, L=Label("$u$", position=EndPoint));
draw((0.0, 0.0) -- (1.1, 0.0), arrow=Arrow, L=Label("$v$", position=EndPoint));

draw((0.01, 1) -- (-0.01, 1), L=Label("$1$", position=EndPoint));
draw((1, 0.01) -- (1, -0.01), L=Label("$1$", position=EndPoint));

int nPoints = 1024;
for (int i = 0; i < nPoints; ++i) {
  pair pt = (i/nPoints, vanCorput(i,2));
  dot(pt, linewidth(1.5));
}

