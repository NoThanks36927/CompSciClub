int[][] cells, temp;

int grid_size = 1;
int rows;
int cols;

void setup()
{
  size(500, 500);
  
  rows = height / grid_size;
  cols = width  /  grid_size;
  
  cells = new int[cols][rows];
  temp  = new int[cols][rows];
  
  initialize_cells();
}

void initialize_cells()
{
  for (int i = 0; i < cols; i++)
  {
    for (int j = 0; j < rows; j++)
    {
      cells[i][j] = Math.random() < 0.3 ? 1 : 0;
    }
  }
}

void draw()
{
  println(frameRate);
  set_border_cells();
  update();
  render();
}

void set_border_cells()
{
  for (int i = 0; i < cols; i++) cells[i][0] = 0;
  for (int i = 0; i < cols; i++) cells[i][rows - 1] = 0;
  for (int j = 0; j < rows; j++) cells[0][j] = 0;
  for (int j = 0; j < rows; j++) cells[cols - 1][j] = 0;
}

void update()
{
  for (int i = 1; i < cols - 1; i++)
  {
    for (int j = 1; j < rows - 1; j++)
    {
      int sum = 0;
      
      sum += cells[i + 1][j + 1];
      sum += cells[i + 0][j + 1];
      sum += cells[i - 1][j + 1];
      sum += cells[i - 1][j + 0];
      sum += cells[i - 1][j - 1];
      sum += cells[i + 0][j - 1];
      sum += cells[i + 1][j - 1];
      sum += cells[i + 1][j + 0];
      
      if (cells[i][j] == 1)
      {
        if (sum == 2 || sum == 3)
        {
          temp[i][j] = 1;
        }
        else
        {
          temp[i][j] = 0;
        }
      }
      else
      {
        if (sum == 3)
        {
          temp[i][j] = 1;
        }
        else
        {
          temp[i][j] = 0;
        }
      }
    }
  }
  
  for (int i = 0; i < cols; i++)
  {
    for (int j = 0; j < rows; j++)
    {
      cells[i][j] = temp[i][j];
    }
  }
}

void render()
{
  color white = color(255);
  color black = color(0);
  
  loadPixels();
  for (int i = 0; i < width; i++)
  {
    for (int j = 0; j < height; j++)
    {
      pixels[j * width + i] = cells[i / grid_size][j / grid_size] == 1 ? white : black;
    }
  }
  updatePixels();
}
