#include <iostream>
#include <vector>

using namespace std;

void sort(vector<int> & v)
{
  int s = v.size();

  for (int i = 0; i < s; i++)
    for (int j = 1; j < s - i; j++)
      if (v[j-1] > v[j])
        swap(v[j-1], v[j]);
}

int main()
{
  int n; cin >> n;

  cout << n << endl;

  vector<int> v(n);

  for (int i = 0; i < n; i++)
    cin >> v[i];
  
  for (int x : v)
    cout << x << " ";
  cout << endl;

  sort(v);

  for (int x : v)
    cout << x << " ";
  cout << endl;
}