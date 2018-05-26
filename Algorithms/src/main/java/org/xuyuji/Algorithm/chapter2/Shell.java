package org.xuyuji.Algorithm.chapter2;

import org.xuyuji.Algorithm.tools.In;

/**
 * cmd:classes>java org.xuyuji.Algorithm.chapter2.Shell < .\org\xuyuji\Algorithm\chapter2\words3.txt
 * @author xuyuji
 *
 */
public class Shell extends BaseTL{
	
	private static Shell instance = new Shell();
	
	public static Shell getInstance(){
		return instance;
	}
	
	@Override
	public void sort(Comparable[] a) {
		int N = a.length;
		int h = 1;
		while(h < N/3) h = h*3 + 1;
		while(h >= 1){
			for(int i = h; i < N; i++){
				for(int j = i; j >= h && less(a[j], a[j-h]); j -= h){
					exch(a, j, j-h);
				}
			}
			h = h/3;
		}
	}
	
	public static void main(String[] args) {
		Shell s = Shell.getInstance();
		String[] a = In.readStrings();
		s.sort(a);
		assert s.isSorted(a);
		s.show(a);
	}
}
