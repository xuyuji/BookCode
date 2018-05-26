package org.xuyuji.Algorithm.chapter2;

import org.xuyuji.Algorithm.tools.In;

/**
 * cmd:classes>java org.xuyuji.Algorithm.chapter2.Selection < .\org\xuyuji\Algorithm\chapter2\words3.txt
 * @author xuyuji
 *
 */
public class Selection extends BaseTL{
	
	private static Selection instance = new Selection();
	
	public static Selection getInstance(){
		return instance;
	}
	
	@Override
	public void sort(Comparable[] a) {
		int N = a.length;
		for(int i = 0; i < N; i++){
			int min = i;
			for(int j = i; j < N; j++){
				if(less(a[j], a[min])){
					min = j;
				}
			}
			if(min != i)
				exch(a, i, min);
		}
	}
	
	public static void main(String[] args) {
		Selection s = Selection.getInstance();
		String[] a = In.readStrings();
		s.sort(a);
		assert s.isSorted(a);
		s.show(a);
	}
}
