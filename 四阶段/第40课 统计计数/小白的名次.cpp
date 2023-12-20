#include <bits/stdc++.h>
using namespace std;
int a[1000000]; 
int main()
{
	int n,k,x;
	cin>>n;
	for(int i=1;i<=n;i++)
	{
		cin>>x;
		a[x]++;
	} 
	cin>>k;
    int s=0; 
	for(int i=1000;i>=k;i--)
	{
		if(a[i])
		    s++;
	} 
	cout<<s<<endl;
	return 0;
}
