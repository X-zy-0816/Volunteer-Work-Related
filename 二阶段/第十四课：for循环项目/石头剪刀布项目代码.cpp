#include <bits/stdc++.h>
using namespace std;
int main() 
{
	cout<<"*********��ӭ����ʯͷ��������Ϸ**********\n";
	int win=0,lose=0,tie=0;  //win��¼��Ӯ�ľ�����lose��¼����ľ�����tieƽ����
	int p,c;
	srand(time(0));
	cout<<"��Ϸ��ʼ�������ʤ��"<<endl;
	while(win!=3 && lose!=3)
	{
		c=rand()%3+1;
		while(1)
		{
 			cout<<"�����������ֵ(1.ʯͷ 2.���� 3.��)��";
			cin>>p;
			if(p<1||p>3)
 				cout<<"�����������������\n";
			else
				break;
		}
		if(p==c)
 		{
			cout<<"ƽ��:player("<<p<<") computer("<<c<<")\n";
 			tie++;
		}
 		else if(p==1&&c==2 ||p==2&&c==3 ||p==3&&c==1)
		{
			cout<<"playerӮ:player("<<p<<") computer("<<c<<")\n";
			win++;
		}
		else
		{
 			cout<<"computerӮ:player("<<p<<") computer("<<c<<")\n";
			lose++;
		}
 		cout<<"ʤ��"<<win<<" ����"<<lose<<" ƽ��"<<tie<<endl;
	}
	if(win==3)
		cout<<"����player��ʤ"<<endl;
	else
 		cout<<"���յ��Ի�ʤ"<<endl;
	return 0;

}


