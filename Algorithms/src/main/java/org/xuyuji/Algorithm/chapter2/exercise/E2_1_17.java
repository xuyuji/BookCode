package org.xuyuji.Algorithm.chapter2.exercise;

import org.xuyuji.Algorithm.chapter2.BaseTL;
import org.xuyuji.Algorithm.tools.StdDraw;
import org.xuyuji.Algorithm.tools.StdRandom;

public class E2_1_17 {
	public static Double[] getDoubleArray(int len){
		Double[] array = new Double[len];
		for(int i = 0; i < len; i++)
			array[i] = StdRandom.random();
		return array;
	}
	
	public static void main(String[] args) {
		Double[] a = E2_1_17.getDoubleArray(50);
		StdDraw.setXscale(0, 50);
		StdDraw.setYscale(0, 1);
		Insertion.getInstance().sort(a);
	}
}

class Selection extends BaseTL{
	
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
			if(min != i){
				exch(a, i, min);
				show(a);
			}
		}
	}
	
	@Override
	protected void show(Comparable[] a) {
		StdDraw.clear();
		Double[] b = (Double[]) a;
		for(int i = 0; i < a.length; i++){
			StdDraw.filledRectangle(i-0.5, b[i]/2, 0.5, b[i]/2);
		}
	}
}

class Insertion extends BaseTL {

	private static Insertion instance = new Insertion();
	
	public static Insertion getInstance(){
		return instance;
	}
	
	@Override
	public void sort(Comparable[] a) {
		int N = a.length;
		for(int i = 1; i < N; i++){
			for(int j = i; j > 0 && less(a[j], a[j-1]); j--){
				exch(a, j, j-1);
				show(a);
			}
		}
	}
	
	@Override
	protected void show(Comparable[] a) {
		StdDraw.clear();
		Double[] b = (Double[]) a;
		for(int i = 0; i < a.length; i++){
			StdDraw.filledRectangle(i-0.5, b[i]/2, 0.5, b[i]/2);
		}
	}
}

class Shell extends BaseTL{
	
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
					show(a);
				}
			}
			h = h/3;
		}
	}
	
	@Override
	protected void show(Comparable[] a) {
		StdDraw.clear();
		Double[] b = (Double[]) a;
		for(int i = 0; i < a.length; i++){
			StdDraw.filledRectangle(i-0.5, b[i]/2, 0.5, b[i]/2);
		}
	}
}