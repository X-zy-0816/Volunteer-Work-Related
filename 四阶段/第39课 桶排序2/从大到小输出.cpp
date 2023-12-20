#include <bits/stdc++.h>
using namespace std;
int a[100000];
int main()
{
	int n,x;
	cin>>n;
	for(int i=1;i<=n;i++)
	{
		cin>>x;
		a[x]++;
	}
	for(int i=10000;i>=1;i--)
	{
		for(int j=1;j<=a[i];j++)
		{
			cout<<i<<" ";
		} 
	}
	return 0;
} 

