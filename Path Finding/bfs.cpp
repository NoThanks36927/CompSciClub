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
typedef pair<ip, ip> Node;

char m[N][N];
bool v[N][N];

ip p[N][N];

void bfs(ip start, ip target)
{
  queue<Node> q;

  q.push({start, {-1, -1}});

  while (q.size())
  {
    Node n = q.front(); q.pop();

    int x = n.first.first;
    int y = n.first.second;

    if (m[x][y] == '#' || v[x][y]) continue;

    v[x][y] = true;

    p[x][y] = n.second;

    if (x == target.X && y == target.Y) break;

    for (int dx = -1; dx <= 1; dx++)
    for (int dy = -1; dy <= 1; dy++)
    {
      if (dx == 0 && dy == 0) continue;

      if (dx != 0 && dy != 0) continue;

      q.push({{x + dx, y + dy}, {x, y}});
    }
  }
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

  bfs(start, end);

  vector<ip> path;

  trace(path, end);

  cout << path.size() - 1 << endl;

  // for (ip p : path)
  // {
  //   cout << p.X << " " << p.Y << endl;
  // }
}