#include <bits/stdc++.h>
using namespace std;
int a[1000000]; 
int main()
{
	int n;
	cin>>n;
	for(int i=1;i<=n;i++)
	    cin>>a[i];
	
	int s=0;
	for(int i=1;i<n;i++)  //�ִ�
	    for(int j=1;j<=n-i;j++)  //���Ƚ���ֵ��λ�� 
	       if(a[j]>a[j+1])
	       {
		       swap(a[j],a[j+1]);
		       s++;
		   }
	           
	cout<<s<<endl;	
	return 0;
}
