#include <bits/stdc++.h>
using namespace std;
int a[1000000]; 
int main()
{
	int n,m;
	int x;
	cin>>n;
	for(int i=1;i<=n;i++)  //n个数 
	{
		cin>>x;
		a[x]++;    //构造桶 
	}
	cin>>m;
	for(int i=1;i<=m;i++)  //n个数 
	{
		cin>>x;
		a[x]++;    //构造桶 
	}
	
	for(int i=1;i<=3000;i++)  //遍历桶 
	    if(a[i])
	    {
		    cout<<i<<" ";
		} 
	cout<<endl;
	for(int i=1;i<=3000;i++)  //遍历桶 
	    if(a[i]==2)
	    {
		    cout<<i<<" ";
		} 
	
	return 0;
}
