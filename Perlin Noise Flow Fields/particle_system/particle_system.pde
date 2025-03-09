int n = 10000;

int lifetime = 400;

int[] l;

double force = 0.1;
double drag = 0.95;
double scale = 0.003;

double[] px, py, vx, vy;

Noise noise;

void settings()
{
  size(1080, 720);
}

void setup()
{
  l  = new int[n];
  px = new double[n];
  py = new double[n];
  vx = new double[n];
  vy = new double[n];

  for (int i = 0; i < n; i++)
  {
    px[i] = random(width);
    py[i] = random(height);
    vx[i] = 0;
    vy[i] = 0;
    l [i] = (int)random(lifetime);
  }

  stroke(255);
}

void draw()
{
  render();
  update();
}

void render()
{
  background(0);
  for (int i = 0; i < n; i++)
    point((int)px[i], (int)py[i]);
}

void update()
{
  for (int i = 0; i < n; i++)
  {
    if (l[i] >= lifetime)
    {
      px[i] = random(width);
      py[i] = random(height);
      l [i] = 0;
    }

    if      (px[i] <  0     ) px[i] += width;
    else if (px[i] >= width ) px[i] -= width;
    if      (py[i] <  0     ) py[i] += height;
    else if (py[i] >= height) py[i] -= height;

    double x = px[i] * scale;
    double y = py[i] * scale;
    double z = 0.001 * frameCount;

    double d = TWO_PI * noise.noise(x, y, z);
    double m = force * (1 + noise.noise(x + 1000, y, z)) / 2;

    double ax = m * Math.cos(d);
    double ay = m * Math.sin(d);

    vx[i] += ax;
    vy[i] += ay;
    vx[i] *= drag;
    vy[i] *= drag;
    px[i] += vx[i];
    py[i] += vy[i];
    l [i]++;
  }
}

int RGB(int b)
{
  final int a = 255 << 24;
  b = clamp(b, 0, 255);
  return a | (b << 16) | (b << 8) | b;
}

int RGB(int r, int g, int b)
{
  final int a = 255 << 24;
  r = clamp(r, 0, 255);
  g = clamp(g, 0, 255);
  b = clamp(b, 0, 255);
  return a | (r << 16) | (g << 8) | b;
}

int RGB(int a, int r, int g, int b)
{
  a = clamp(a, 0, 255);
  r = clamp(r, 0, 255);
  g = clamp(g, 0, 255);
  b = clamp(b, 0, 255);
  return (a << 24) | (r << 16) | (g << 8) | b;
}

int clamp(int v, int min, int max)
{
  return min(max(v, min), max);
}