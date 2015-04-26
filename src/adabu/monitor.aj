package adabu;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.aspectj.lang.Signature;

import automata.Automate;

public aspect monitor {
	
	boolean activated = true;
	String automataResource = "resource/test.Pile_0.dot";
	Automate automate;
	pointcut myClass(): within(test.TestPile) || within(test.Pile);

	// Coupe toutes les méthodes des classes de myClass
	pointcut myMethod(): myClass() && execution(* *(..));

	before() : myMethod(){

		if(!activated)
			return;

		// Action réalisée à l'entrée des fonctions coupées par watchCut
		Signature s  = thisJoinPointStaticPart.getSignature();
		String name = s.getName();
		if(name.equals("main")){
			initAutomata();
			return;
		}
		
		boolean transitionAccepted = automate.switchState(name);
		if(transitionAccepted)
			System.out.println("Transition: "+automate.getPreviousState()+" ("+name+") --> "+
					automate.getCurrentState());
		else{
			System.out.println("Echec: "+automate.getPreviousState()+" ("+name+") --> "+
					automate.getCurrentState());
			activated = false;
		}
			
	}
	
	private void initAutomata(){
		File f = new File(automataResource);
		
		if(!f.exists()){
			System.out.println("Fichier ressource introuvable");
			System.exit(0);
		}
		
		automate = new Automate();
		automate.setInitialState(1);
		automate.resetAutomata();
		
		try {
			BufferedReader br = new BufferedReader(new FileReader(f));
			String line;
			while((line = br.readLine()) != null){
				if(line.contains("->"))
					addTransition(line);
			}
			br.close();
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	
	private void addTransition(String line){
		
		// On récupère les états
		Pattern pattern = Pattern.compile("\\d+");
		Matcher matcher = pattern.matcher(line);
		
		int from = -1;
		int to = -1;
		
		if(matcher.find())
			from = Integer.valueOf(matcher.group(0));
		if(matcher.find())
			to = Integer.valueOf(matcher.group(0));
		
		// On récupère le label
		pattern = Pattern.compile("([\"'])(?:(?=(\\?))\2.)*?\1");
		matcher = pattern.matcher(line);
		
		// On récupère les méthodes
		pattern = Pattern.compile("[a-zA-Z]*\\(");
		matcher = pattern.matcher(line);
		List<String> conditions = new ArrayList<String>();
		while(matcher.find()){
			String s = matcher.group(0);
			s = s.substring(0, s.length()-1);
			if(!conditions.contains(s))
				conditions.add(s);
		}
		
		/*
		System.out.println("Adding transition "+from+" -> "+to+ " methodes :");
		for(String s: conditions)
			System.out.println("   --> "+s);
		*/
		automate.addTransition(from, to, conditions);		
	}
}
