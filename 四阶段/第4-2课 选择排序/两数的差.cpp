#include <bits/stdc++.h>
using namespace std;
int a[1000000]; 
int main()
{
    int n;
	cin>>n;
	for(int i=1;i<=n;i++)
	    cin>>a[i];
		
	int max1=-10000; 
	for(int i=1;i<n;i++)
	    for(int j=i+1;j<=n;j++)
		    max1=max(max1,a[i]-a[j]); 
				
	cout<<max1<<endl;	
	return 0;
}
