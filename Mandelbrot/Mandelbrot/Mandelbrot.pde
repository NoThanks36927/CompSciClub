double pr;
double pi;
double scale = 0.01;

int bailout = 100;

void setup()
{
  size(720, 480);
}

void draw()
{
  render();
}

void render()
{
  color white = color(255, 255, 255);
  color black = color(0, 0, 0);
  
  loadPixels();
  for (int i = 0; i < width; i++)
  {
    for (int j = 0; j < height; j++)
    {
      int iteration = 0;
      
      double cr = (i - width  / 2) * scale + pr;
      double ci = (j - height / 2) * scale + pi;
      
      double zr = 0, zi = 0, zr2 = 0, zi2 = 0;
      
      while (zr2 + zi2 < 4 && iteration < bailout)
      {
        zr2 = zr * zr;
        zi2 = zi * zi;
        
        zi = 2 * zr * zi + ci;
        zr = zr2 - zi2 + cr;
        
        iteration++;
      }
      
      if (iteration < bailout) {
        pixels[j * width + i] = white;
      }
      else
      {
        pixels[j * width + i] = black;
      }
    }
  }
  updatePixels();
}

void mouseDragged() {
  pr -= (mouseX - pmouseX) * scale;
  pi -= (mouseY - pmouseY) * scale;
}

void mouseWheel(MouseEvent event) {
  if (event.getCount() > 0)
  {
    scale *= 1.1;
    pr -= (mouseX - width  / 2) * scale * 0.0909;
    pi -= (mouseY - height / 2) * scale * 0.0909;
  }
  else
  {
    scale /= 1.1;
    pr += (mouseX - width  / 2) * scale * 0.1;
    pi += (mouseY - height / 2) * scale * 0.1;
  }
}
