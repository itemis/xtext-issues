package org.xtext.example.mydsl.ui;

import org.apache.log4j.Logger;
import org.eclipse.xtext.util.Modules2;
import org.xtext.example.mydsl.ui.internal.MydslActivator;

import com.google.inject.Guice;
import com.google.inject.Injector;
import com.google.inject.Module;

public class MyDslActivatorEx extends MydslActivator {

	private static final Logger logger = Logger.getLogger(MyDslActivatorEx.class);
	
	private Module extraModule = null;
	
	@Override 
	protected Injector createInjector(String language) {
		try {
			com.google.inject.Module runtimeModule = getRuntimeModule(language);
			com.google.inject.Module sharedStateModule = getSharedStateModule();
			com.google.inject.Module uiModule = getUiModule(language);
			
			com.google.inject.Module mergedModule = Modules2.mixin(runtimeModule, sharedStateModule, uiModule);
			if (extraModule != null) {
				mergedModule = Modules2.mixin(mergedModule, extraModule);
			}
			
			return Guice.createInjector(mergedModule);
		} catch (Exception e) {
			logger.error("Failed to create injector for " + language);
			logger.error(e.getMessage(), e);
			throw new RuntimeException("Failed to create injector for " + language, e);
		}
	}
	
	public void setExtraModule(Module extraModule) {
		this.extraModule = extraModule;
	}
}
