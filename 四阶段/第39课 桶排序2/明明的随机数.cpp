#include <bits/stdc++.h>
using namespace std;
int a[1000000]; 
int main()
{
	int n,s=0;
	int x;
	cin>>n;
	for(int i=1;i<=n;i++)  //n���� 
	{
		cin>>x;
		a[x]++;    //����Ͱ 
		if(a[x]==1)
		   s++;
	}
	cout<<s<<endl;
	for(int i=1;i<=1000;i++)  //����Ͱ 
	    if(a[i])
		    cout<<i<<" ";
	
	return 0;
}
