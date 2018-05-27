package org.eclipse.xtext.example.xmleditor.ui.tests

import javax.inject.Inject
import javax.inject.Named
import org.eclipse.xtext.example.xmleditor.tests.AbstractXmlLexerTest
import org.eclipse.xtext.ide.editor.contentassist.antlr.internal.Lexer
import org.eclipse.xtext.testing.InjectWith
import org.eclipse.xtext.testing.XtextRunner
import org.eclipse.xtext.ui.LexerUIBindings
import org.junit.runner.RunWith

@RunWith(XtextRunner)
@InjectWith(XmlUiInjectorProvider)
class XmlContentAssistLexerTests extends AbstractXmlLexerTest {

	@Inject @Named(LexerUIBindings.CONTENT_ASSIST) Lexer lexer

	override lexer() {
		lexer
	}

}
