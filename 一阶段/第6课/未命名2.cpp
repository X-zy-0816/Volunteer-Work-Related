#include <bits/stdc++.h>
using namespace std;

int main()
{
  int a,b,c;
  cin>>a>>b>>c;
  cout<<max(a,max(b,c))<<endl;
  if(a+b>c&&b+c>a&&c+a>b)
    cout<<"�ܹ���һ�������Ρ�";
  return 0;
}

