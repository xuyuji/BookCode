package org.xuyuji.Algorithm.chapter2;

import org.xuyuji.Algorithm.tools.In;

/**
 * cmd:classes>java org.xuyuji.Algorithm.chapter2.Insertion < .\org\xuyuji\Algorithm\chapter2\words3.txt
 * @author xuyuji
 *
 */
public class Insertion extends BaseTL {

	private static Insertion instance = new Insertion();
	
	public static Insertion getInstance(){
		return instance;
	}
	
	@Override
	public void sort(Comparable[] a) {
		int N = a.length;
		for(int i = 1; i < N; i++){
			for(int j = i; j > 0 && less(a[j], a[j-1]); j--)
				exch(a, j, j-1);
		}
	}
	
	public static void main(String[] args) {
		Insertion s = Insertion.getInstance();
		String[] a = In.readStrings();
		s.sort(a);
		assert s.isSorted(a);
		s.show(a);
	}
}
