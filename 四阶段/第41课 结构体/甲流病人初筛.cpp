#include<bits/stdc++.h>
using namespace std;
struct patient
{
    string name;
    float h;
	int k;
}pt[100000];
int main()
{
	int n;
	float h;
	cin>>n;
	for(int i=1;i<=n;i++)
	{
		cin>>pt[i].name>>pt[i].h>>pt[i].k;
	}
	cin>>h;
	for(int i=1;i<=n;i++)
	{
		if(pt[i].h>=h&&pt[i].k==1)
		{
			cout<<pt[i].name<<"\n";
		}
	}
	return 0;
}
