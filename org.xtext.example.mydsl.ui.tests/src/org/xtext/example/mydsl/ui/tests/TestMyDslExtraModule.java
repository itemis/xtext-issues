package org.xtext.example.mydsl.ui.tests;

import org.xtext.example.mydsl.IGreetingNamesProvider;

import com.google.inject.Binder;
import com.google.inject.Module;

public class TestMyDslExtraModule implements Module {

	@Override
	public void configure(Binder binder) {
		binder.bind(IGreetingNamesProvider.class).to(TestGreetingNamesProvider.class);
	}

}
