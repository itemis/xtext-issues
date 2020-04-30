package org.xtext.example.mydsl.ui.tests;

import org.xtext.example.mydsl.ui.MyDslActivatorEx;

import com.google.inject.Injector;

public class CustomizedMyDslUiInjectorProvider extends MyDslUiInjectorProvider {

	@Override
	public Injector getInjector() {
		MyDslActivatorEx myDslActivatorEx = (MyDslActivatorEx) MyDslActivatorEx.getInstance();
		myDslActivatorEx.setExtraModule(new TestMyDslExtraModule());
		return super.getInjector();
	}

}
