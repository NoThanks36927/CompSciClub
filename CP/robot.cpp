#include <iostream>

using namespace std;

int main()
{
  int n;

  cin >> n;

  string rooms;

  cin >> rooms;

  int r;

  for (int i = 0; i < n; i++)
  {
    if (rooms[i] == 'R') r = i;
  }

  cout << r;
}