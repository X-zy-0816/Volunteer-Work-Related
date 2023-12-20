#include <bits/stdc++.h>
using namespace std;
int a[1000000]; 
int main()
{
    int n;
	cin>>n;
	for(int i=1;i<=n;i++)
	    cin>>a[i];
		
	for(int i=1;i<n;i++)
	    for(int j=i+1;j<=n;j++)
		    if(a[i]>a[j])
			    swap(a[i],a[j]); 
	//7 10 3 1
    //1  3  7  10
    int max1=0;
    for(int i=2;i<=n;i++)
	{
		max1=max(a[i]-a[i-1],max1);
	}
	cout<<max1;
	return 0;
}
