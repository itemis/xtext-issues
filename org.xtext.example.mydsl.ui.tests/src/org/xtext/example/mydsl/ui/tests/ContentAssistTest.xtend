package org.xtext.example.mydsl.ui.tests

import java.util.List
import org.eclipse.xtext.testing.InjectWith
import org.eclipse.xtext.testing.XtextRunner
import org.eclipse.xtext.ui.testing.AbstractContentAssistTest
import org.junit.Test
import org.junit.runner.RunWith

@RunWith(XtextRunner)
@InjectWith(CustomizedMyDslUiInjectorProvider)
class ContentAssistTest extends AbstractContentAssistTest {

	// cursor position marker
	val c = '''<|>'''

	@Test def test() {
		'''
			Hello «c»
		'''.testContentAssistant(#[
			'Name', 'TestName1', 'TestName2'
		], 'Name', '''
			Hello Name
		''')
	}

	private def void testContentAssistant(CharSequence text, List<String> expectedProposals, String proposalToApply, String expectedContent) {

		val cursorPosition = text.toString.indexOf(c)
		val content = text.toString.replace(c, "")

		newBuilder.append(content).
		assertTextAtCursorPosition(cursorPosition, expectedProposals).
		applyProposal(cursorPosition, proposalToApply).
		expectContent(expectedContent)
	}
}
