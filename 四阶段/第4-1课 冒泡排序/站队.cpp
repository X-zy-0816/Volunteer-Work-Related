#include <bits/stdc++.h>
using namespace std;
int a[1000000]; 
int main()
{
	int n;
	cin>>n;
	for(int i=1;i<=n;i++)
	    cin>>a[i];
		
	for(int i=1;i<n;i++)  //轮次
	    for(int j=1;j<=n-i;j++)  //待比较数值的位置 
	       if(a[j]>a[j+1])
	           swap(a[j],a[j+1]);
				
	for(int i=1;i<=n;i++)
	    cout<<a[i]<<" ";	
	return 0;
}
