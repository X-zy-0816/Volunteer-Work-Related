#include <bits/stdc++.h>
using namespace std;
int a[1000000]; 
int main()
{
    int n,k;
	cin>>n>>k;
	for(int i=1;i<=n;i++)
	    cin>>a[i];
		
	for(int i=1;i<n;i++)
	    for(int j=i+1;j<=n;j++)
		    if(a[i]>a[j])
			    swap(a[i],a[j]);
				
	cout<<a[k]<<endl;	
	return 0;
}
