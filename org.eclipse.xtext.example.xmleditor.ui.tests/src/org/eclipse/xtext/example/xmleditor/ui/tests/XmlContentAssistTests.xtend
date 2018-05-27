package org.eclipse.xtext.example.xmleditor.ui.tests

import org.eclipse.xtext.testing.InjectWith
import org.eclipse.xtext.testing.XtextRunner
import org.eclipse.xtext.ui.testing.AbstractContentAssistTest
import org.junit.Ignore
import org.junit.Test
import org.junit.runner.RunWith

@RunWith(XtextRunner)
@InjectWith(XmlUiInjectorProvider)
class XmlContentAssistTests extends AbstractContentAssistTest {

	@Test def void test01() {
		newBuilder.assertText("")
	}

	@Test @Ignore def void test02() {
		newBuilder.append('''<a b="" />''').assertTextAtCursorPosition(6, "")
	}
}
