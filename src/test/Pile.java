package test;

import java.util.Stack;

public class Pile {

	private Stack<String> st;
	
	public Pile(){
		st = new Stack<String>();
	}
	
	/*
	 * Mutators
	 * Conditions:
	 * 		- doit etre public
	 */
	public boolean add( String elem ){
		st.push(elem);
		System.out.println("ADD : "+st.lastElement());
		return true;
	}
	
	public String remove(){
		System.out.println("REMOVE : "+st.lastElement());
		return st.pop();
	}
	
	public boolean clear(){
		System.out.println("Clear");
		st.clear();
		return true;
	}
	
	/*
	 * Inspectors
	 * Conditions:
	 * 		- pas un void
	 * 		- pas de paramètres
	 * 		- pas d'effet de bord
	 */
	public boolean isEmpty(){
		return st.empty();
	}
}
