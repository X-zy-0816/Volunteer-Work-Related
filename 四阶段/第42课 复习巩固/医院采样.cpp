#include<bits/stdc++.h>
using namespace std;
float a[100000];
int main()
{
	int n;
	cin>>n;
	for(int i=1;i<=n;i++)
	    cin>>a[i];
	
	sort(a+1,a+n+1);
	float s=0,avg;
	for(int i=2;i<n;i++)
	    s+=a[i];
	avg=s/(n-2);
	cout<<avg<<" "<<max(avg-a[2],a[n-1]-avg); 
	return 0;
}
