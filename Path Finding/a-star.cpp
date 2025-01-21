#include <iostream>
#include <queue>
#include <array>
#include <cmath>

#define N 1002

#define X first
#define Y second

#define pb push_back

using namespace std;

typedef pair<int, int> ip;

// F cost
// G cost
// H cost
// position
// parent
typedef pair<array<float, 3>, pair<ip, ip>> Node;

char m[N][N];
bool v[N][N];

ip p[N][N];

float distance(ip a, ip b)
{
  float dx = a.X - b.X;
  float dy = a.Y - b.Y;
  return sqrt(dx * dx + dy * dy);
}

float distance(int ax, int ay, int bx, int by)
{
  float dx = ax - bx;
  float dy = ay - by;
  return sqrt(dx * dx + dy * dy);
}

float a_star(ip start, ip target)
{
  priority_queue<Node, vector<Node>, greater<Node>> q;

  float G = 0;
  float H = distance(start, target);
  float F = G + H;

  q.push({{F, H, G}, {start, {-1, -1}}});

  while (q.size())
  {
    Node n = q.top(); q.pop();

    float F = n.first[0];
    float H = n.first[1];
    float G = n.first[2];

    int x = n.second.first.first;
    int y = n.second.first.second;

    if (m[x][y] == '#' || v[x][y]) continue;

    v[x][y] = true;

    p[x][y] = n.second.second;

    if (x == target.X && y == target.Y) return G;

    for (int dx = -1; dx <= 1; dx++)
    for (int dy = -1; dy <= 1; dy++)
    {
      if (dx == 0 && dy == 0) continue;

      if (dx != 0 && dy != 0) continue;
      
      //if (dx != 0 && dy != 0) continue;

      float newG = G + sqrt(dx * dx + dy * dy);
      float newH = distance(x + dx, y + dy, target.X, target.Y);
      float newF = newG + newH;

      q.push({{newF, newH, newG}, {{x + dx, y + dy}, {x, y}}});
    }
  }

  return -1;
}

void trace(vector<ip> & route, ip end)
{
  ip n = end;
  while (true)
  {
    route.pb(n);

    n = p[n.X][n.Y];

    if (n.X == -1 && n.Y == -1) break;
  }
}

int main()
{
  int w, h; cin >> h >> w;

  for (int y = 0; y < N; y++)
  for (int x = 0; x < N; x++)
  {
    m[x][y] = '#';
  }

  ip start, end;

  for (int y = 1; y <= h; y++)
  for (int x = 1; x <= w; x++)
  {
    char c; cin >> c;

    if (c != '#') m[x][y] = c;

    if (c == 'A') start = {x, y};
    if (c == 'B') end = {x, y};
  }

  // cout << "Start: " << start.X << " " << start.Y << endl;
  // cout << "End: " << end.X << " " << end.Y << endl;

  // for (int y = 0; y <= h + 1; y++)
  // {
  //   for (int x = 0; x <= w + 1; x++)
  //   {
  //     cout << m[x][y] << " ";
  //   }
  //   cout << endl;
  // }

  cout << a_star(start, end) << endl;

  // vector<ip> path;

  // trace(path, end);

  // for (ip p : path)
  // {
  //   cout << p.X << " " << p.Y << endl;
  // }
}