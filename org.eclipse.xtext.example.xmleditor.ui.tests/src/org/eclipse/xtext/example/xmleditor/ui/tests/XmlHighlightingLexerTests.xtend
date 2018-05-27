package org.eclipse.xtext.example.xmleditor.ui.tests

import javax.inject.Inject
import javax.inject.Named
import org.eclipse.xtext.example.xmleditor.tests.AbstractXmlLexerTest
import org.eclipse.xtext.parser.antlr.Lexer
import org.eclipse.xtext.testing.InjectWith
import org.eclipse.xtext.testing.XtextRunner
import org.eclipse.xtext.ui.LexerUIBindings
import org.junit.runner.RunWith

@RunWith(XtextRunner)
@InjectWith(XmlUiInjectorProvider)
class XmlHighlightingLexerTests extends AbstractXmlLexerTest {
	
	@Inject @Named(LexerUIBindings.HIGHLIGHTING) Lexer lexer
	
	override lexer() {
		lexer
	}
	
}
