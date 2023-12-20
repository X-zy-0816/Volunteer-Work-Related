#include <bits/stdc++.h>
using namespace std;
int a[1000000]; 
int main()
{
	int n,s=0;
	int x;
	cin>>n;
	for(int i=1;i<=n;i++)  //n个数 
	{
		cin>>x;
		a[x]++;    //构造桶 
		if(a[x]==1)
		   s++;
	}
	cout<<s<<endl;
	for(int i=1;i<=1000;i++)  //遍历桶 
	    if(a[i])
		    cout<<i<<" ";
	
	return 0;
}
