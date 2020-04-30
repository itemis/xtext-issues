package org.xtext.example.mydsl;

import java.util.Arrays;
import java.util.List;

public class ProductiveGreetingNamesProvider implements IGreetingNamesProvider {

	@Override
	public List<String> getNames() {
		return Arrays.asList("ProductiveName1", "ProductiveName2");
	}

}
