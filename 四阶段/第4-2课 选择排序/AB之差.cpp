#include <bits/stdc++.h>
using namespace std;
int a[1000000]; 
int main()
{
    int n,c;
	cin>>n>>c;
	for(int i=1;i<=n;i++)
	    cin>>a[i];
		
	int s=0; 
	for(int i=1;i<n;i++)
	    for(int j=i+1;j<=n;j++)
		    if(a[i]-a[j]==c||a[j]-a[i]==c)
		        s++;
				
	cout<<s<<endl;	
	return 0;
}
