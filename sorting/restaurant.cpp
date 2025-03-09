#include <array>
#include <algorithm>
#include <iostream>
#include <vector>

using namespace std;

using event = array<int, 2>;

int main()
{
  ios_base::sync_with_stdio(false); cin.tie(NULL);
  
  int n; cin >> n;

  vector<event> v;

  for (int i = 0; i < n; i++)
  {
    int a, b;
    cin >> a >> b;
    v.push_back({a,  1});
    v.push_back({b, -1});
  }

  sort(v.begin(), v.end());

  int c = 0, m = 0;

  for (event e : v)
  {
    c += e[1];
    m = max(m, c);
  }

  cout << m << endl;
}