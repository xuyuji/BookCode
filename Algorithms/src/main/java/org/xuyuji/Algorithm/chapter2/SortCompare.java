package org.xuyuji.Algorithm.chapter2;

import org.xuyuji.Algorithm.chapter2.exercise.E2_1_24;
import org.xuyuji.Algorithm.chapter2.exercise.E2_1_25;
import org.xuyuji.Algorithm.tools.StdOut;
import org.xuyuji.Algorithm.tools.StdRandom;
import org.xuyuji.Algorithm.tools.Stopwatch;

/**
 * cmd:classes>java org.xuyuji.Algorithm.chapter2.SortCompare Insertion Selection 1000 100
 * cmd:classes>java org.xuyuji.Algorithm.chapter2.SortCompare Shell Insertion 1000 100
 * @author xuyuji
 *
 */
public class SortCompare {
	public static double time(String alg, Double[] a){
		Stopwatch timer = new Stopwatch();
		if(alg.equals("Insertion")) Insertion.getInstance().sort(a);
		if(alg.equals("Selection")) Selection.getInstance().sort(a);
		if(alg.equals("Shell")) Shell.getInstance().sort(a);
		if(alg.equals("E2_1_24")) E2_1_24.getInstance().sort(a);
		if(alg.equals("E2_1_25")) E2_1_25.getInstance().sort(a);
		return timer.elapsedTime();
	}
	
	public static double timeRandomInput(String alg, int N, int T){
		double total = 0.0;
		Double[] a = new Double[N];
		for(int t = 0; t < T; t++){
			for(int i = 0; i < N; i++)
				a[i] = StdRandom.uniform();
			total += time(alg, a);
		}
		return total;
	}
	
	public static void main(String[] args) {
		String alg1 = args[0];
		String alg2 = args[1];
		int N = Integer.parseInt(args[2]);
		int T = Integer.parseInt(args[3]);
		double t1 = timeRandomInput(alg1, N, T);
		double t2 = timeRandomInput(alg2, N, T);
		StdOut.printf("For %d random Doubles\n", N, alg1);
		StdOut.printf("%.10f times faster than %s\n", t2/t1, alg2);
	}
}
