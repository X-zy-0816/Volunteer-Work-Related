#include <bits/stdc++.h>
using namespace std;
int main() 
{
	cout<<"*********欢迎进入石头剪刀布游戏**********\n";
	int win=0,lose=0,tie=0;  //win记录人赢的局数、lose记录人输的局数、tie平局数
	int p,c;
	srand(time(0));
	cout<<"游戏开始，五局三胜制"<<endl;
	while(win!=3 && lose!=3)
	{
		c=rand()%3+1;
		while(1)
		{
 			cout<<"请输入你出的值(1.石头 2.剪刀 3.布)：";
			cin>>p;
			if(p<1||p>3)
 				cout<<"输入错误，请重新输入\n";
			else
				break;
		}
		if(p==c)
 		{
			cout<<"平局:player("<<p<<") computer("<<c<<")\n";
 			tie++;
		}
 		else if(p==1&&c==2 ||p==2&&c==3 ||p==3&&c==1)
		{
			cout<<"player赢:player("<<p<<") computer("<<c<<")\n";
			win++;
		}
		else
		{
 			cout<<"computer赢:player("<<p<<") computer("<<c<<")\n";
			lose++;
		}
 		cout<<"胜："<<win<<" 负："<<lose<<" 平："<<tie<<endl;
	}
	if(win==3)
		cout<<"最终player获胜"<<endl;
	else
 		cout<<"最终电脑获胜"<<endl;
	return 0;

}


