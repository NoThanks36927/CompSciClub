class Node
{
  int depth;
  boolean visited;
  
  Point position;
  Point parent;
  
  Node ()
  {
    depth = 0;
    visited = false;
    position = new Point();
    parent = new Point();
  }
  
  Node (Point position, Point parent, int depth)
  {
    this.depth = depth;
    this.visited = false;
    this.position = position;
    this.parent = parent;
  }
  
  Node (Point position, Point parent, int depth, boolean visited)
  {
    this.depth = depth;
    this.visited = visited;
    this.position = position;
    this.parent = parent;
  }
}
