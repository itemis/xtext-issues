package org.eclipse.xtext.example.xmleditor.tests

import javax.inject.Inject
import javax.inject.Named
import org.eclipse.xtext.parser.antlr.Lexer
import org.eclipse.xtext.parser.antlr.LexerBindings
import org.eclipse.xtext.testing.InjectWith
import org.eclipse.xtext.testing.XtextRunner
import org.junit.runner.RunWith

@RunWith(XtextRunner)
@InjectWith(XmlInjectorProvider)
class XmlLexerTests extends AbstractXmlLexerTest {

	@Inject @Named(LexerBindings.RUNTIME) Lexer lexer
	
	override lexer() {
		lexer
	}

}
