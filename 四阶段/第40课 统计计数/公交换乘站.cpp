#include <bits/stdc++.h>
using namespace std;
int a[1000000]; 
int main()
{
	int n,m;
	int x;
	cin>>n>>m;
	for(int i=1;i<=n+m;i++)  //n个数 
	{
		cin>>x;
		a[x]++;    //构造桶 
	}
	int f=0;
	for(int i=1;i<=200;i++)  //遍历桶 
	    if(a[i]==2)
	    {
		    cout<<i<<" ";
		    f=1;
		}
	if(f==0)
	    cout<<-1<<endl;	    
	
	return 0;
}
