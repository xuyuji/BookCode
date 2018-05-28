package org.xuyuji.algorithms.chapter2.exercise;

import org.xuyuji.algorithms.chapter2.BaseTL;

import edu.princeton.cs.algs4.In;

/**
 * 不需要交换的插入排序（只交换头尾，中间仅后移） cmd:classes>java
 * org.xuyuji.Algorithm.chapter2.exercise.E2_1_25 <
 * .\org\xuyuji\Algorithm\chapter2\words3.txt
 * 
 * @author xuyuji
 *
 */
public class E2_1_25 extends BaseTL {

	private static E2_1_25 instance = new E2_1_25();

	public static E2_1_25 getInstance() {
		return instance;
	}

	@Override
	public void sort(Comparable[] a) {
		int N = a.length;
		for (int i = 1; i < N; i++) {
			int j = i;
			Comparable temp = a[j];
			for (; j > 0 && less(a[j], a[j - 1]); j--)
				a[j] = a[j - 1];
			a[j] = temp;
		}
	}

	public static void main(String[] args) {
		E2_1_25 s = E2_1_25.getInstance();
		String[] a = In.readStrings();
		s.sort(a);
		assert s.isSorted(a);
		s.show(a);
	}
}