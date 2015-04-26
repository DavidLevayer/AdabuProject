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
		return true;
	}
	
	public String remove(){
		return st.pop();
	}
	
	public boolean clear(){
		st.clear();
		return true;
	}
	
	/*
	 * Inspectors
	 * Conditions:
	 * 		- pas un void
	 * 		- pas de param�tres
	 * 		- pas d'effet de bord
	 */
	public boolean isEmpty(){
		return st.empty();
	}
}
