package org.xuyuji.Algorithm.chapter2.exercise;

import org.xuyuji.Algorithm.chapter2.BaseTL;
import org.xuyuji.Algorithm.tools.In;

public class E2_1_24and2_1_25 extends BaseTL {
	
	private static E2_1_24and2_1_25 instance = new E2_1_24and2_1_25();
	
	public static E2_1_24and2_1_25 getInstance(){
		return instance;
	}
	
	@Override
	public void sort(Comparable[] a) {
		int N = a.length;
		int min = 0;
		for(int i = 1; i < N; i++){
			if(less(a[i], a[min]))
				min = i;
		}
		if(min != 0)
			exch(a, 0, min);
		
		for(int i = 1; i < N; i++){
			int j = i;
			Comparable temp = a[j];
			for(; less(a[j], a[j-1]); j--)
				a[j] = a[j-1];
			a[j] = temp;
		}
	}
	
	public static void main(String[] args) {
		E2_1_24and2_1_25 s = E2_1_24and2_1_25.getInstance();
		String[] a = In.readStrings();
		s.sort(a);
		assert s.isSorted(a);
		s.show(a);
	}
}
