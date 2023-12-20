#include <bits/stdc++.h>
using namespace std;
int a[10000];
int main()
{
	int x;
	for(int i=1;i<=5;i++)
	{
		cin>>x;
		a[x]++;
	}
	for(int i=0;i<=9;i++)
	{
		if(a[i]==0)
		    cout<<i<<" ";
	}
	
    return 0;
}

