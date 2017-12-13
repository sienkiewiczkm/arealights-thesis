settings.outformat = "pdf";
unitsize(1cm);

draw((0, 0) -- (0, 1.1), arrow=Arrow);
draw((0, 0) -- (1.1, 0), arrow=Arrow);

for (int i = 0; i < 100; ++i) {
  pair pt = (unitrand(), unitrand());
  dot(pt);
}

