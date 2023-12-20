#include<bits/stdc++.h>
using namespace std;
int main()
{
	string s;
	cin>>s;
	char c;
	cin>>c;
	for(int i=s.size()-1;i>=0;i--)
	{
		if(s[i]==c)
		{
			cout<<i+1;
			return 0;
		}
	} 
	
	return 0;
}
