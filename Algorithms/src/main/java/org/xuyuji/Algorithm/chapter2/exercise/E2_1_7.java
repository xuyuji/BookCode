package org.xuyuji.Algorithm.chapter2.exercise;

import org.xuyuji.Algorithm.chapter2.SortCompare;

public class E2_1_7 {
	public static void main(String[] args) {
		Double[] d = new Double[1000];
		for(int i = 0; i < d.length; i++){
			d[i] = 1000.0 - i;
		}
		
		System.out.println("Selection/Insertion " + SortCompare.time("Selection", d)/SortCompare.time("Insertion", d));
	}
}
