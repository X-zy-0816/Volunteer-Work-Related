#include <bits/stdc++.h>
using namespace std;

int main()
{
  int a,b;
  cout<<"���ǳ���ʳ�����׷�?1Ϊ��ʳ��2Ϊ�׷�"<<endl;
  cin>>a;
  if(a==1)
  {
    cout<<"���ǳ����滹�ǻ���?1Ϊ���棬2Ϊ����"<<endl;
    cin>>b;
    if(b==1)
      cout<<"�����������棬�����á�"<<endl;
    else if(b==2)
      cout<<"�������Ļ��棬�����á�"<<endl;
    else
      cout<<"�Բ�����ѡ���������档"<<endl;
  }
  else
    cout<<"�Բ��������������û���׷���"<<endl;
  return 0;
}

