#include <bits/stdc++.h>
using namespace std;
int a[1000000]; 
int main()
{
	int n,m;
	int x,max1=0,min1=1000000;
	cin>>n;
	for(int i=1;i<=n;i++)  //n���� 
	{
		cin>>x;
		a[x]++;    //����Ͱ 
		max1=max(max1,x);
		min1=min(min1,x);
	}
	for(int i=min1;i<=max1;i++)  //����Ͱ 
	{
		if(a[i]==0)
		    m=i;
		if(a[i]==2)
		    n=i;
	}   
	cout<<m<<" "<<n<<endl;
	return 0;
}
