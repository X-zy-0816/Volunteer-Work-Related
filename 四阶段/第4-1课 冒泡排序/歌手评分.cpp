#include <bits/stdc++.h>
using namespace std;
int a[1000000]; 
int main()
{
	for(int i=1;i<=10;i++)
	    cin>>a[i];
	
	for(int i=1;i<10;i++)  //轮次
	    for(int j=1;j<=10-i;j++)  //待比较数值的位置 
	       if(a[j]>a[j+1])
		       swap(a[j],a[j+1]);
	int s=0;
	for(int i=2;i<=9;i++)
	    s+=a[i];
	cout<<s/8.0<<endl;
	return 0;
}
