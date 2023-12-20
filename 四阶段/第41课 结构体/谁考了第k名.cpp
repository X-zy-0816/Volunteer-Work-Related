#include<bits/stdc++.h>
using namespace std;
struct student
{
    string id;
    float score;
}stu[10000];
bool cmp(student stu1, student stu2)
{
	return stu1.score>stu2.score;
}
int main()
{
	int n,k;
	cin>>n>>k;
	for(int i=1;i<=n;i++)
	{
		cin>>stu[i].id>>stu[i].score;
	}
	sort(stu+1, stu+n+1, cmp);
	cout<<stu[k].id<<" "<<stu[k].score<<endl;
	return 0;
}
