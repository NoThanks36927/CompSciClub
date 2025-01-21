import java.util.LinkedList;
import java.util.Queue;
import java.util.ArrayList;

Queue<Node> queue;

Point start, end;

Node[][] graph;

int rows = 10;
int cols = 10;

void setup()
{
  size(500, 500);
  
  start = new Point(0, 0);
  end   = new Point(cols - 1, rows - 1);
  
  graph = new Node[cols][rows]; 
  
  for (int y = 0; y < rows; y++)
  for (int x = 0; x < cols; x++)
  { 
    graph[x][y] = new Node(new Point(x, y), new Point(0, 0), 0);
  }
  
  queue = new LinkedList<>();
  queue.add(new Node(start, new Point(-1, -1), 0));
}

void draw()
{
  show();
  for (int i = 0; i < 1; i++) bfs();
}

void show()
{
  float tile_width  = float(width ) / cols;
  float tile_height = float(height) / rows;
  
  for (int y = 0; y < rows; y++)
  for (int x = 0; x < cols; x++)
  {
    Node n = graph[x][y];
    
    fill(255);
    
    if (n.visited) fill(255, 100, 100);
    
    rect(tile_width * x, tile_height * y, tile_width, tile_height);
  }
  
  fill(100, 255, 100);
  rect(tile_width * start.x, tile_height * start.y, tile_width, tile_height);
  
  fill(100, 100, 255);
  rect(tile_width * end.x, tile_height * end.y, tile_width, tile_height);
}

void bfs()
{
  if (queue.size() == 0) return;
  
  Node n = queue.remove();
  
  int x = n.position.x;
  int y = n.position.y;
  
  int px = n.parent.x;
  int py = n.parent.y;
  
  int d = n.depth;
  
  if (x < 0 || x >= cols || y < 0 || y >= rows) return;
  
  if (graph[x][y].visited) return;
  
  graph[x][y].visited = true;
  
  graph[x][y].parent.x = py;
  graph[x][y].parent.y = px;
  
  graph[x][y].depth = d;
  
  if (x == end.x && y == end.y)
  {
    queue.clear();
    trace(end);
    return;
  }
  
  for (int dx = -1; dx <= 1; dx++)
  for (int dy = -1; dy <= 1; dy++)
  {
    if (dx == 0 && dy == 0) continue;
    
    //if (dx != 0 && dy != 0) continue;
    
    queue.add(new Node(new Point(x + dx, y + dy), new Point(x, y), d + 1));
  }
}

void trace(Point end)
{ 
  ArrayList<Point> trace = new ArrayList<>();
  
  int d = graph[end.x][end.y].depth;
  
  println(d);
  
  while (d > 0)
  {
    end = graph[end.x][end.y].parent;
    
    trace.add(new Point(end.x, end.y));
    
    d--;
  }
  
  for (int y = 0; y < rows; y++)
  for (int x = 0; x < cols; x++)
  {
    Node n = graph[x][y];
    
    n.visited = false;
    n.parent.x = 0;
    n.parent.y = 0;
  }
  
  for (Point p : trace)
  {
    graph[p.x][p.y].visited = true;
  }
}
