#include <iostream>
#include <vector>

using namespace std;

vector<int> v, t;

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
    v[i] = t[i];
}

int main()
{
  int n; cin >> n;

  v.resize(n);
  t.resize(n);

  cout << n << endl;

  for (int i = 0; i < n; i++)
    cin >> v[i];
  
  for (int x : v)
    cout << x << " ";
  cout << endl;

  sort(0, n - 1);

  for (int x : v)
    cout << x << " ";
  cout << endl;
}