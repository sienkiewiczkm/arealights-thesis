settings.outformat = "pdf";
unitsize(5cm);

draw((0.0, 0.0) -- (0.0, 1.1), arrow=Arrow, L=Label("$u$", position=EndPoint));
draw((0.0, 0.0) -- (1.1, 0.0), arrow=Arrow, L=Label("$v$", position=EndPoint));

draw((0.01, 1) -- (-0.01, 1), L=Label("$1$", position=EndPoint));
draw((1, 0.01) -- (1, -0.01), L=Label("$1$", position=EndPoint));

int nPoints = 32;
int mPoints = 32;

for (int i = 0; i < nPoints; ++i) {
  for (int j = 0; j < mPoints; ++j) {
    pair pt = (i/(nPoints-1), j/(mPoints-1));
    dot(pt, linewidth(1.5));
  }
}

