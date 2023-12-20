#include<bits/stdc++.h>
using namespace std;
float a[100000];
int b[100000];
float c[100000],d[100000];
int n1,n2;
bool cmp(float a1,float a2)
{
	return a1>a2;
}
int main()
{
	int n;
	n=10;
	for(int i=1;i<=n;i++)
	    cin>>a[i];
	for(int i=1;i<=n;i++)
	    cin>>b[i];
	for(int i=1;i<=n;i++)
	{
		if(b[i]==1)
		{
			n1++;
			c[n1]=a[i];
		}
		else
		{
			n2++;
			d[n2]=a[i];
		}
	}
	sort(c+1,c+n1+1);
	sort(d+1,d+n2+1,cmp);
	for(int i=1;i<=n1;i++)
	    cout<<c[i]<<" ";
	for(int i=1;i<=n2;i++)
	    cout<<d[i]<<" ";
	return 0;
}
