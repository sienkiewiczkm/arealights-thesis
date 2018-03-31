settings.outformat = "pdf";
unitsize(2cm);

import graph;
import geometry;

/* PBR */

real distribution_ggx_tr(pair N, pair H, real a) {
    real NdotH = max(dot(N, H), 0.0);
    real NdotHSq = NdotH * NdotH;

    real a2 = a * a;
    real nom = a2;

    real denom = (NdotHSq * (a2 - 1.0) + 1);
    denom = pi * denom * denom;

    return nom / denom;
}

real fresnel_schlick(real cosTheta, real F0)
{
    return F0 + (1 - F0) * (1.0 - cosTheta)^5.0;
}

real geometry_schlick_ggx(real NdotV, real k)
{
    real nom = NdotV;
    real denom = NdotV * (1.0 - k) + k;
    return nom / denom;
}

real geometry_smith(pair N, pair V, pair L, real k)
{
    real NdotV = max(dot(N, V), 0.0);
    real NdotL = max(dot(N, L), 0.0);
    real ggx1 = geometry_schlick_ggx(NdotV, k);
    real ggx2 = geometry_schlick_ggx(NdotL, k);
    return ggx1 * ggx2;
}

void drawUsing(real roughness, real incomingAngle) {
    pair O = (0,0);

    real macrosurfaceWidth = 2.0;
    path macrosurface = (-macrosurfaceWidth/2,0) -- (+macrosurfaceWidth/2,0);

    draw(macrosurface);

    pair n = (0,1);
    pair wi = dir(incomingAngle);
    pair microReflected = 2 * dot(wi,n) * n - wi;

    draw((0,0) -- n, L=Label("$n$", position=EndPoint), arrow=Arrow(TeXHead));
    draw((0,0) -- wi, L=Label("$\omega_i$", position=EndPoint), arrow=Arrow(TeXHead));
    draw((0,0) -- microReflected, L=Label("$r$", position=EndPoint), arrow=Arrow(TeXHead));

    real f0 = 0.04;
    real ndotl = max(dot(n, wi), 0);
    real alpha = roughness^2;
    real k = (roughness+1)^2 / 8;

    path edges;
    path setEdges;

    real maxBrdf = 0;
    pair maxDir;

    int numSamples = 2*1024;
    for (var i = 0; i < numSamples; ++i) {
        real edgeSafety = 0.000;
        real u = ((real)i)/(numSamples-1) * (1-edgeSafety) + (edgeSafety/2);
        pair wo = dir(u * 180);

        pair h = wi + wo; h /= length(h);

        setEdges = setEdges -- wo;

        real ndotv = max(dot(n, wo), 0);
        real hdotl = max(dot(h, wi), 0);

        real d = distribution_ggx_tr(n, h, alpha);
        real f = fresnel_schlick(max(dot(h, wo), 0), f0);
        real g = geometry_smith(n, wo, wi, roughness);

        real brdf = (d*f*g)/max(4*ndotv*ndotl, 0.001);
        brdf *= hdotl;
        
        if (brdf > maxBrdf) {
            maxBrdf = brdf;
            maxDir = wo;
        }

        var point = brdf > 0.001 ? (brdf*wo) : O;
        edges = edges -- point;
    }

    edges = scale(1/maxBrdf) * (edges);
    draw(edges, linewidth(0.2mm)+gray);
    draw(setEdges, dashed+lightgray);
    draw((0,0) -- maxDir, arrow=Arrow(TeXHead), dashed);
}

real[] degs = {5, 15, 30};
real[] rvals = {0.2, 0.4, 0.6, 0.8};

for (int i = 0; i < rvals.length; ++i) {
    for (int j = 0; j < degs.length; ++j) {
        real roughness = rvals[i];
        real deg = degs[j];

        currentpicture = new picture;
        unitsize(2cm);
        drawUsing(roughness, deg);
        shipout(format("offspecular_%d", i*degs.length+j));
    }
}