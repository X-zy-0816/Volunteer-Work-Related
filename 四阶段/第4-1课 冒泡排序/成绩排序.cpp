#include <bits/stdc++.h>
using namespace std;
int a[1000000]; 
int main()
{
	for(int i=1;i<=10;i++)
	    cin>>a[i];
		
	for(int i=1;i<10;i++)  //�ִ�
	    for(int j=1;j<=10-i;j++)  //���Ƚ���ֵ��λ�� 
	       if(a[j]<a[j+1])
	           swap(a[j],a[j+1]);
				
	for(int i=1;i<=10;i++)
	    cout<<a[i]<<" ";	
	return 0;
}
