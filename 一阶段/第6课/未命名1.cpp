#include <bits/stdc++.h>
using namespace std;

int main()
{
  int a,b;
  cout<<"您是吃面食还是米饭?1为面食，2为米饭"<<endl;
  cin>>a;
  if(a==1)
  {
    cout<<"您是吃素面还是荤面?1为素面，2为荤面"<<endl;
    cin>>b;
    if(b==1)
      cout<<"这是您的素面，请慢用。"<<endl;
    else if(b==2)
      cout<<"这是您的荤面，请慢用。"<<endl;
    else
      cout<<"对不起，请选择荤面或素面。"<<endl;
  }
  else
    cout<<"对不起我们这是面馆没有米饭。"<<endl;
  return 0;
}

