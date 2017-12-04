settings.outformat = "pdf";
unitsize(1cm);

path surface = (-2.5,0) -- (-2.5,0.8) -- (-2.0,0.4) -- (-1.5,0.7) -- (-1.0,0.2)
  -- (-0.5,0.5) -- (0.0,0.1) -- (0.5,0.8) -- (1.0,0.2) -- (1.5,0.8)
  -- (2.0,0.7) -- (2.5,0.3) -- (2.5,0) -- cycle;

real minCoord = -4;
real maxCoord = 1.8;
pair lookDirection = expi(0.15pi);

int n = 24;
for (int i = 0; i < n; ++i) {
  real coord = (i/(n-1))*(maxCoord-minCoord)+minCoord;
  pair rayTarget = (coord, 0);
  pair rayOrigin = rayTarget + 3.0*lookDirection;
  path ray = rayOrigin -- rayTarget;

  real[][] isections = intersections(ray, surface);
  if (isections.length > 0) {
    pair pt = point(ray, isections[0][0]);
    draw(rayOrigin -- pt, orange);
  }

}

draw(surface);

path clipbox = box((-2.51,-0.1), (2.51,3));
clip(clipbox);
