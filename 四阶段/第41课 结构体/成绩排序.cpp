#include<bits/stdc++.h>
using namespace std;
struct student
{
    string name;
    int score;
};
struct student stu[10000];
bool comp(struct student stu1, struct student stu2)
{
	if(stu1.score>stu2.score||
	   stu1.score==stu2.score&&stu1.name<stu2.name)
	{
		return true;
	}
	return false;
}
int main()
{
	int n;
	cin>>n;
	for(int i=1;i<=n;i++)
	{
		cin>>stu[i].name>>stu[i].score;
	}
	sort(stu+1, stu+n+1, comp);	
	for(int i=1;i<=n;i++)
	{
		cout<<stu[i].name<<" "<<stu[i].score<<endl;
	}
	return 0;
}
