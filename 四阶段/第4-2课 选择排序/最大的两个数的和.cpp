#include <bits/stdc++.h>
using namespace std;
int a[1000000]; 
int main()
{
	for(int i=1;i<=6;i++)
	    cin>>a[i];
		
	for(int i=1;i<6;i++)
	    for(int j=i+1;j<=6;j++)
		    if(a[i]<a[j])
			    swap(a[i],a[j]);
				
	cout<<a[1]+a[2]<<endl;	
	return 0;
}
