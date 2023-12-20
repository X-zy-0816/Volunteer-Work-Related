#include<bits/stdc++.h>
using namespace std;
struct student
{
    string name;
    int h,n;
};
int main()
{
	int n;
	cin>>n;
	struct student maxs,t;
	maxs.h=0;
	for(int i=1;i<=n;i++)
	{
		cin>>t.name>>t.h>>t.n;
		if(maxs.h<t.h)
		{
			maxs=t;
		}
	}
	cout<<maxs.name<<" "<<maxs.h<<" "<<maxs.n<<endl;
	return 0;
}
