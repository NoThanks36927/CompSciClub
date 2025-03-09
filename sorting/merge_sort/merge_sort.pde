import java.util.ArrayList;

int i = 0;
int j = 1;

int n = 50;

int[] v, t, q;

class Move
{
  int index, value;
  
  Move(int index, int value)
  {
    this.index = index;
    this.value = value;
  }
}

ArrayList<Move> moves;

void setup()
{
  size(1080, 720);
  
  v = new int[n];
  t = new int[n];
  q = new int[n];
  
  for (int i = 0; i < n; i++)
  {
    v[i] = (int) random(n);
  }
  
  for (int i = 0; i < n; i++)
  {
    q[i] = v[i];
  }
  
  moves = new ArrayList<>();
  
  sort(0, n - 1);
  
  frameRate(10);
}

void sort(int l, int r)
{
  if (l == r) return;

  int m = (l + r) / 2;

  sort(l, m);
  sort(m + 1, r);

  int index = l;

  int p1 = l;
  int p2 = m + 1;

  while (index <= r)
  {
    if (p1 > m)
    {
      t[index++] = v[p2++];
      continue;
    }

    if (p2 > r)
    {
      t[index++] = v[p1++];
      continue;
    }

    if (v[p1] <= v[p2])
      t[index++] = v[p1++];
    
    else
      t[index++] = v[p2++];
  }

  for (int i = l; i <= r; i++)
  {
    moves.add(new Move(i, t[i]));
    v[i] = t[i];
  }
}

void draw()
{
  background(0);
  
  Move move = new Move(-1, 0);
  
  if (moves.size() > 0)
  {
    move = moves.get(0); moves.remove(0);
    
    q[move.index] = move.value;
  }
  
  for (int i = 0; i < n; i++)
  {
    if (i == move.index) fill(255, 0, 0);
    else fill(255);
    
    int x = i * width / n;
    int y = height - q[i] * height / n;
    int w = width / n;
    int h = q[i] * height / n;
    
    rect(x, y, w, h);
  }
}
