#include <bits/stdc++.h>
using namespace std;
int a[1000000]; 
int main()
{
    string s;
    cin>>s;
    for(int i=0;i<s.size();i++)
    {
    	a[s[i]]++;
	}
	int max1=0;
	for(char c='a';c<='z';c++)
	    max1=max(max1,a[c]);
	for(char c='a';c<='z';c++)
	{
		if(max1==a[c])
		{
			cout<<c<<" "<<a[c];
			break;
		}
	}
    return 0;
}

