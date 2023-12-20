#include <bits/stdc++.h>
using namespace std;
int a[1000000]; 
int main()
{
    string s;
	cin>>s;
	for(int i=0;i<s.length();i++)
	{
		char x=s[i];
		a[x]++;
	}
	for(int i=0;i<s.length();i++)
	{
		char x=s[i];
		if(a[x]==1)
		{
			cout<<x<<endl;
			return 0;
		}
	}
	cout<<"no";	
	
    return 0;
}

