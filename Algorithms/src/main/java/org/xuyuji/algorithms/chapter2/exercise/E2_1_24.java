package org.xuyuji.algorithms.chapter2.exercise;

import org.xuyuji.algorithms.chapter2.BaseTL;

/**
 * 插入排序的哨兵（先将最小值放到数组开头，然后每次循环都可以不用做边界测试）
 * 测试效果发现基本会比原版快一点，但是不多，若是取小数点后一位看不出效果，大的倍率不高，打印出10位小数可以看出效果。
 * 
 * @author xuyuji
 *
 */
public class E2_1_24 extends BaseTL {

	private static E2_1_24 instance = new E2_1_24();

	public static E2_1_24 getInstance() {
		return instance;
	}

	@Override
	public void sort(Comparable[] a) {
		int N = a.length;
		int min = 0;
		for (int i = 1; i < N; i++) {
			if (less(a[i], a[min]))
				min = i;
		}
		if (min != 0)
			exch(a, 0, min);

		for (int i = 1; i < N; i++) {
			for (int j = i; less(a[j], a[j - 1]); j--)
				exch(a, j, j - 1);
		}
	}
}