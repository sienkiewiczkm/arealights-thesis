settings.outformat = "pdf";
unitsize(5cm);

import graph;

real f(real x) {
  return cos(pi*x/2);
}

real g(real x) {
  return 1-cos(pi*x/2);
}

real axisLength = 1.1;
draw((0.0, 0.0) -- (0.0, axisLength), arrow=Arrow);
draw((0.0, 0.0) -- (axisLength, 0.0), arrow=Arrow);

path fpath= graph(f, 0, 1);
draw(fpath,  L=Label("$g$", position=Relative(0.3)));

path gpath = graph(g, 0, 1);
draw(gpath, dashed,  L=Label("$h$", position=Relative(0.3)));