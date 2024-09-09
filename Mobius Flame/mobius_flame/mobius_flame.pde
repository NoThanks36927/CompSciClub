float[][][] image;
float[][] density;

/*
The transformation colors array defines the colors of the images.
The valuas are set later in a function called setTransformationColors.
You can change the values and see how they affect the resulting images!
The values are in the RGB format and in the range from 0 to 1.
*/
float[][] transformation_colors;

float[] t;

// The color blend factor changes how distinct the color regions are from one another.
float color_blend_factor = 0.2;
float chaos = 1.0;

//Gamma correction. Affects the brightness of the image. Larger values darken the image. Smaller ones brighten it.
float gamma = 0.4;
float zoom = 100;
float viewx = 0;
float viewy = 0;

float cr, cg, cb;

long iterations;

int w, h, numberOfTransformations = 4;

void setup() {
  fullScreen();

  w = width / 2;
  h = height / 2;

  image = new float[width][height][3];

  density = new float[width][height];

  setTransformation();
  setTransformationColors();
  printTransformation();
}

void setTransformation() {
  t = new float[8 * numberOfTransformations];
  for (int i = 0; i < t.length; i++)
  {
    t[i] = random(-chaos, chaos);
  }
}

void setTransformationColors()
{
  transformation_colors = new float[][]{
    {1, 0, 0},
    {1, 0.5, 0},
    {1, 0.8, 0},
    {1, 0, 0.8}
  };
  
  transformation_colors = new float[][]{
    {0.28, 1, 0.99},
    {0.28, 1, 0.63},
    {0.28, 0.58, 1},
    {1, 0.28, 0.88}
  }; 
}

void draw() {
  simulate(1000000);

  render();
    
  text("Iterations: " + iterations / 1000000 / 1000.0 + " milliard", 20, 30);
  text("Frame rate: " + frameRate, 20, 50);
  
  if (mousePressed)
  {
    resetDensity();
  
    viewx += (mouseX - pmouseX) / zoom;
    viewy += (mouseY - pmouseY) / zoom;
  }
}

void simulate(int n) {
  iterations += n;
  
  float x, y, or, oi, nr, ni;
  
  float px = random(-1, 1);
  float py = random(-1, 1);

  int ix, iy, ti = 0;

  for (int i = 0; i < n; i++) {
    ti = int(random(numberOfTransformations));

    cr = cr + (transformation_colors[ti][0] - cr) * color_blend_factor;
    cg = cg + (transformation_colors[ti][1] - cg) * color_blend_factor;
    cb = cb + (transformation_colors[ti][2] - cb) * color_blend_factor;
    
    ti *= 8;
    
    or = t[ti+0]*px - t[ti+1]*py + t[ti+2];
    oi = t[ti+0]*py + t[ti+1]*px + t[ti+3];
    
    nr = t[ti+4]*px - t[ti+5]*py + t[ti+6];
    ni = t[ti+4]*py + t[ti+5]*py + t[ti+7];
    
    px = or / nr - oi / ni;
    py = or / ni + oi / nr;

    x = (px + viewx) * zoom + w;
    y = (py + viewy) * zoom + h;

    if (x < 0 || x >= width || y < 0 || y >= height) continue;

    ix = int(x);
    iy = int(y);

    image[ix][iy][0] += cr;
    image[ix][iy][1] += cg;
    image[ix][iy][2] += cb;

    density[ix][iy] += 1;
  }
}

void render() {
  float max = 0;
  for (int i = 0; i < width; i++) {
    for (int j = 0; j < height; j++) {
      max = max(max, density[i][j]);
    }
  }

  float min = max;
  for (int i = 0; i < width; i++) {
    for (int j = 0; j < height; j++) {
      min = min(min, density[i][j]);
    }
  }

  max -= min;

  float s, v, d, log_max = log(max - min);

  int a = 255 << 24, r, g, b;

  loadPixels();
  for (int i = 0; i < width; i++) {
    for (int j = 0; j < height; j++) {
      d = density[i][j] - min;
      
      // Logarithmic scale
      v = log(d) / log_max;
      
      // Gamma correction
      v = pow(v, gamma);
      
      // Scaling the colors to a range of 0 to 1
      d = 1 / d;
      
      // Calculating total scale factor
      s = 400 * v * d;
      
      r = int(s * image[i][j][0]);
      g = int(s * image[i][j][1]);
      b = int(s * image[i][j][2]);

      if (r > 255) r = 255;
      if (g > 255) g = 255;
      if (b > 255) b = 255;

      r = r << 16;
      g = g << 8;

      pixels[j * width + i] = a | r | g | b;
    }
  }
  updatePixels();
}

void keyPressed() {
  if (key == 's') {
    render();
    save("image " + frameCount + ".png");
  }
  if (key == 't') {
    setTransformation();
    printTransformation();
    resetDensity();
  }
}

void mouseWheel(MouseEvent event) {
  float scale = event.getCount() < 0 ? 1.1 : 0.9;
  zoom *= scale;
  resetDensity();
}

void resetDensity()
{
  iterations = 0;

  for (int i = 0; i < width; i++) {
    for (int j = 0; j < height; j++) {
      density[i][j] = 0;
      image[i][j][0] = 0;
      image[i][j][1] = 0;
      image[i][j][2] = 0;
    }
  }
}

void printTransformation()
{
  for (int i = 0; i < t.length; i++) {
    println(t[i] + ",");
  }
  println();
}
