#include <bits/stdc++.h>
using namespace std;
int a[1000000]; 
int main()
{
	int n,m;
	int x;
	cin>>n;
	for(int i=1;i<=n;i++)  //n���� 
	{
		cin>>x;
		a[x]++;    //����Ͱ 
	}
	cin>>m;
	for(int i=1;i<=m;i++)  //n���� 
	{
		cin>>x;
		a[x]++;    //����Ͱ 
	}
	
	for(int i=1;i<=3000;i++)  //����Ͱ 
	    if(a[i])
	    {
		    cout<<i<<" ";
		} 
	cout<<endl;
	for(int i=1;i<=3000;i++)  //����Ͱ 
	    if(a[i]==2)
	    {
		    cout<<i<<" ";
		} 
	
	return 0;
}
