#include<bits/stdc++.h>
using namespace std;
int a[100000];
int main()
{
	int n;
	cin>>n;
	for(int i=1;i<=n;i++)
	    cin>>a[i];
	int s=0;
	for(int i=1;i<=n;i++)
	{
		int s1=0,s2=0;
		for(int j=1;j<i;j++)
		    if(a[j]>a[i])
		        s1++;
		for(int j=i+1;j<=n;j++)
		    if(a[j]>a[i])
		        s2++;
		if(s1==s2)
		    s++;
	}
	cout<<s<<endl;
	return 0;
}
