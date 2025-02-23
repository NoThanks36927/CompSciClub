import java.util.ArrayList;

int i = 0;
int j = 1;

int n = 30;

int[] v, t;

class Move
{
  int a, b;
  
  Move(int a, int b)
  {
    this.a = a;
    this.b = b;
  }
}

ArrayList<Move> moves;

void setup()
{
  size(1080, 720);
  
  v = new int[n];
  t = new int[n];
  
  for (int i = 0; i < n; i++)
  {
    v[i] = (int) random(n);
  }
  
  for (int i = 0; i < n; i++)
  {
    t[i] = v[i];
  }
  
  moves = new ArrayList<>();
  
  sort();
  
  frameRate(5);
}

void sort()
{
  for (int i = 0; i < n; i++)
  {
    for (int j = 1; j < n - i; j++)
    {
      if (v[j-1] > v[j])
      {
        int t = v[j];
        v[j] = v[j-1];
        v[j-1] = t;
        
        moves.add(new Move(j-1, j));
      }
    }
  }
}

void draw()
{
  background(0);
  
  Move move = new Move(-1, -1);
  
  if (moves.size() > 0)
  {
    move = moves.get(0); moves.remove(0);
  
    int temp = v[move.a];
    t[move.a] = t[move.b];
    t[move.b] = temp;
  }
  
  for (int i = 0; i < n; i++)
  {
    if (i == move.a  || i == move.b) fill(255, 0, 0);
    else fill(255);
    
    int x = i * width / n;
    int y = height - t[i] * height / n;
    int w = width / n;
    int h = t[i] * height / n;
    
    rect(x, y, w, h);
  }
}
