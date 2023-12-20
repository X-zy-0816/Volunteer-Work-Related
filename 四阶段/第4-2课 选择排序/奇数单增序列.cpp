#include <bits/stdc++.h>
using namespace std;
int a[1000000]; 
int main()
{
    int n,x,m=0;
	cin>>n;
	for(int i=1;i<=n;i++)
	{
	    cin>>x;
	    if(x%2==1)
	    {
	    	m++;
	    	a[m]=x;
		}
	}		
	for(int i=1;i<m;i++)
	    for(int j=i+1;j<=m;j++)
		    if(a[i]>a[j])
			    swap(a[i],a[j]);
	for(int i=1;i<=m;i++)
	    cout<<a[i]<<" ";
	return 0;
}
