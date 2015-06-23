---
title:   "something"
description:   "happy wife, happy life ..."
keywords:   others
category:   Note
tags:   [others] 
---


{% include JB/setup %}
```
public int BinarySearch(int a[],int num){
	int len=a.lenght;
	int low=0,high=len-1;
	while(low<=high){
		int mid=(low+high)/2;
		if(a[mid]==num){
			return mid;
		}else if(a[mid]<num){
			low=mid+1;
		}else{
			high=mid-1;
		}
	}
	return -1;
	
}


public int  BinarySearch(int a[],int lo, int hi,int key){
	if(lo<=hi){
		int mid=(low+high)/2;
		if(key==a[mid])
			return mid;
		else if(key<a[mid]) 
			return BinarySearch(key,lo,mid-1,key);
		else if(key>a[mid]) 
			return BinarySearch(key,mid+1,high,key);
	}
	else
		return -1;
	
}


// swap
void swap(int a[] ,int i,int j){
	int temp=a[i];
	a[i]=a[j];
	a[j]=temp;
}
// select sort
void selectsort(int a[],int len){
	for(int i=0;i<len;i++){
		int min=i;
		//from i+1 to find the mini
		for(int j=i+1;j<len;j++){
			if(a[min]>a[j]){
				min=j;
			}
		}
		//swap with the i element
		swap(a,i,min);
	}	
}


void insertsort(int a[],int len){
	for(int i=1;i<len;i++){
		for(int j=i;j>0;j--){
			if(a[j]<a[j-1]){
				swap(a,j,j-1)
			}
			else
				break;
		}
	}
}


void shellsort(int a[] ,int len){
	int h=1;
	while(h<len/3) h=h*3+1;
	
	while(h>=1){
		for(int i=1;i<h;i++){
			for(int j=i;j>=h;j=j-h){
				if(a[j]<a[j-h]){
					swap(a,j,j-h);
				}
				else
					break;
			}
		}
		
		h=h/3;
	}
	
}

//heap swim to top
//from boot to top
void swim(int k ){
	while(k>1&&pq[k]>pq[k/2]){
		swap(pq,k,k/2);
		k=k/2;
	}
}

void sink(int k){
	while(2*k<n){
		int j=2*k;
		if(pq[j]<pq[j+1]) j++;
		if(pq[k]>pq[j]) break;
		//else swap the parent and the bigger chilren
		swap(pq,k,j);
		//set the current node to chilren
		k=j;
	}
}


void insertheap(int s){
	pq[++N]=s;
	swim(N);
}

public int delheaptop(){
	int max=pq[1];
	swap(pq,1,N--);
	sink(1); //rebuild the heap from up to down
	//set the last to default value
	return max;
}


int getvalue(Node root,int key){
	if(root=null) return;
	if(key>root.key) return getvalue(root.right);
	if(key<root.key) return getvalue(root.left);
	else return root.value;
}


int getvalue(int key){
	Node node=root;
	while(node!=null){
		if(key>node.key){
			node=node.right;
		}
		else if(key<node.key){
			node=node.left;
		}
		else
		{
			result=node.value;
			break;
		}
	}
	
	return result;
}





int partition(int a[] ,int left,int right){
	int i=left,j=right+1;
	while(true){
		while(a[++i]<a[left])
			if(i==right) break;
		while(a[--j]>a[left])
			if(i==left) break;
		if(i>=j) break;
		swap(a,i,j)
	}
	swap(a,j,left);
	return j;
}

void sort(int a[],int low,int high){
	if(low>=high) return;
	int partition=partition(a,low,high);
	sort(a,low,partion-1);
	sort(a,partion+1,high);
}


void dfs(Graph g,int v){
	marked[v]=true;
	count++;
	foreach(int vertical in g.GetAdjacency(v)){
		if(!marked(vertical)){
			dfs(g,vertical);
		}
	}
}

```
