#include <bits/stdc++.h>
using namespace std;
int a[1000000]; 
int main()
{
	int n,m;
	int x;
	cin>>n>>m;
	for(int i=1;i<=n+m;i++)  //n���� 
	{
		cin>>x;
		a[x]++;    //����Ͱ 
	}
	int f=0;
	for(int i=1;i<=200;i++)  //����Ͱ 
	    if(a[i]==2)
	    {
		    cout<<i<<" ";
		    f=1;
		}
	if(f==0)
	    cout<<-1<<endl;	    
	
	return 0;
}
