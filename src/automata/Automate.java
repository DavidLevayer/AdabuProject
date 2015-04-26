package automata;

import java.util.ArrayList;
import java.util.List;

public class Automate {

	private List<Integer> stateList;
	private List<Transition> transitionList;
	private int initialState;
	private int currentState;
	
	public Automate(){
		stateList = new ArrayList<Integer>();
		transitionList = new ArrayList<Automate.Transition>();
	}
	
	public void setInitialState(int state){
		this.initialState = state;
	}
	
	public void resetAutomata(){
		this.currentState = initialState;
	}
	
	public void addTransition(int from, int to, List<String> conditions){
		
		if(!stateList.contains(from))
			stateList.add(from);
		
		if(!stateList.contains(to))
			stateList.add(to);
		
		transitionList.add(new Transition(from, to, conditions));
	}
	
	public boolean switchState(int to, String condition){
		
		for(Transition t: transitionList){
			if(t.from() == currentState && t.to() == to && t.containsCondition(condition)){
				currentState = to;
				return true;
			}
		}
		return false;
	}
	
	public class Transition {
		private int from, to;
		private List<String> conditions;
		
		public Transition(int from, int to, List<String> conditions){
			this.from = from;
			this.to = to;
			this.conditions = conditions;
		}
		
		public int from(){ return from; }
		public int to(){ return to; }
		public List<String> getConditions(){ return conditions; }
		public boolean containsCondition(String condition){ return conditions.contains(condition); }
	}
}
