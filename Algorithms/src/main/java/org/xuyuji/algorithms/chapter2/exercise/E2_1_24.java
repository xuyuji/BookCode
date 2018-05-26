package org.xuyuji.algorithms.chapter2.exercise;

import org.xuyuji.algorithms.chapter2.BaseTL;

/**
 * ����������ڱ����Ƚ���Сֵ�ŵ����鿪ͷ��Ȼ��ÿ��ѭ�������Բ������߽���ԣ�
 * ����Ч�����ֻ������ԭ���һ�㣬���ǲ��࣬����ȡС�����һλ������Ч������ı��ʲ��ߣ���ӡ��10λС�����Կ���Ч����
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