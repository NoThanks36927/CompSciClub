double scale = 0.01;

Noise noise;

void settings()
{
  size(1080, 720);
}

void setup()
{
  
}

void draw()
{
  loadPixels();
  for (int j = 0; j < height; j++)
  for (int i = 0; i < width; i++)
  {
    double x = i * scale;
    double y = j * scale;
    double z = 0.01 * frameCount;

    double v = 0.5 * noise.noise(x, y, z) + 0.5;

    pixels[j * width + i] = RGB((int)(255 * v));
  }
  updatePixels();
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