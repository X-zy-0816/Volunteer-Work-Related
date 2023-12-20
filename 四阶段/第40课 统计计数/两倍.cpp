#include <bits/stdc++.h>
using namespace std; 
int a[10000];
int main()
{
	int n,x;
	cin>>n;
	for(int i=1;i<=n;i++)
	{
		cin>>x;
		a[x]++; 
	}
	int s=0;
	for(int i=1;i<=100;i++)
	{
		if(a[i]&&a[i*2])
		    s++;
	}
	cout<<s;
    return 0;
}

