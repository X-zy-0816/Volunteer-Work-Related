#include <bits/stdc++.h>
using namespace std;
int a[1000000]; 
int main()
{
	int n;
	cin>>n;
	for(int i=1;i<=n;i++)
	{
		int x;
		cin>>x;
		a[x]++;
	} 
	for(int i=1;i<=1000;i++)
	{
		//¸öÊýa[i]
		//Öµ  i
		if(a[i])
		    cout<<i<<" "; 
	}
	
    return 0;
}

