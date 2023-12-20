#include<bits/stdc++.h>
using namespace std;
int main()
{
	string s;
	getline(cin,s);
	for(int i=0;i<s.size();i++)
	{
		if(isupper(s[i]))
		{
			cout<<s[i];
			return 0; 
		} 
	}
	
	return 0;
}
