#include <bits/stdc++.h>
using namespace std;
int abc[1000000]; 
int main()
{
	long long a,b,c,x,y,min1=999999,max1=0,s=0;
	cin>>a>>b>>c;
	for(int i=1;i<=3;i++)
	{
		cin>>x>>y;
		min1=min(x,min1);
		max1=max(y,max1);
		for(int j=x;j<y;j++)
		    abc[j]++;
	}
	for(int i=min1;i<=max1;i++)
	{
		if(abc[i]==1)
		    s+=a;
		else if(abc[i]==2)
		    s+=b*2;
		else if(abc[i]==3)
		    s+=c*3; 
	}
	cout<<s<<endl;
    return 0;
}
