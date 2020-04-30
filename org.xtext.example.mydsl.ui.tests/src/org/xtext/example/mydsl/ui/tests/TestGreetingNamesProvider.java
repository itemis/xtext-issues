package org.xtext.example.mydsl.ui.tests;

import java.util.Arrays;
import java.util.List;

import org.xtext.example.mydsl.IGreetingNamesProvider;

public class TestGreetingNamesProvider implements IGreetingNamesProvider{

	@Override
	public List<String> getNames() {
		return Arrays.asList("TestName1", "TestName2");
	}

}
