/*******************************************************************************
 * Copyright (c) 2020 itemis AG and others.
 *
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 *
 * Contributors:
 *    Tamas Miklossy (itemis AG) - initial API and implementation
 *******************************************************************************/
package org.xtext.example.mydsl.ui.tests

import com.google.common.collect.Lists
import com.google.inject.Inject
import org.eclipse.core.resources.IFile
import org.eclipse.core.resources.IMarker
import org.eclipse.core.resources.IResource
import org.eclipse.core.runtime.NullProgressMonitor
import org.eclipse.ui.views.markers.WorkbenchMarkerResolution
import org.eclipse.xtext.resource.FileExtensionProvider
import org.eclipse.xtext.testing.InjectWith
import org.eclipse.xtext.testing.XtextRunner
import org.eclipse.xtext.ui.MarkerTypes
import org.eclipse.xtext.ui.XtextProjectHelper
import org.eclipse.xtext.ui.editor.quickfix.MarkerResolutionGenerator
import org.eclipse.xtext.ui.testing.AbstractEditorTest
import org.eclipse.xtext.ui.testing.util.AnnotatedTextToString
import org.eclipse.xtext.ui.testing.util.IResourcesSetupUtil
import org.junit.Assert
import org.junit.Test
import org.junit.runner.RunWith

import static extension org.eclipse.xtext.ui.testing.util.IResourcesSetupUtil.addNature
import static extension org.eclipse.xtext.util.Strings.toUnixLineSeparator

@RunWith(XtextRunner)
@InjectWith(MyDslUiInjectorProvider)
class MyDslMultiQuickfixTest extends AbstractEditorTest {

	@Inject extension FileExtensionProvider
	@Inject extension MarkerResolutionGenerator

	@Test def single_quickfix() {
		'''
			Hallo Tamas!
			Hallo Christian!
		'''.testSingleQuickfix('''
			<0<Hallo>0> Tamas!
			<1<Hallo>1> Christian!
			----------------------
			0: message=Welcome word should be in english!
			1: message=Welcome word should be in english!
		''', [firstMarker], '''
			Hello Tamas!
			<0<Hallo>0> Christian!
			----------------------
			0: message=Welcome word should be in english!
		''')
	}

	@Test def multi_quickfix() {
		'''
			Hallo Tamas!
			Hallo Christian!
		'''.testMultiQuickfix('''
			<0<Hallo>0> Tamas!
			<1<Hallo>1> Christian!
			----------------------
			0: message=Welcome word should be in english!
			1: message=Welcome word should be in english!
		''', '''
			Hello Tamas!
			Hello Christian!
			----------------
			(no markers found)
		''')
	}

	private def testSingleQuickfix(CharSequence it, CharSequence initialWithMarkers, extension (IMarker[])=>IMarker markerProvider, CharSequence resultWithMarkers) {
		// Given
		val file = dslFile
		file.hasContentWithMarkers(initialWithMarkers)

		// When
		val marker = file.markers.apply
		applyQuickfixOnSingleMarker(marker)

		// Then
		file.hasContentWithMarkers(resultWithMarkers)
	}

	private def testMultiQuickfix(CharSequence it, CharSequence initialWithMarkers, CharSequence resultWithMarkers) {
		// Given
		val file = dslFile
		file.hasContentWithMarkers(initialWithMarkers)

		// When
		applyQuickfixOnMultipleMarkers(file.markers)

		// Then
		file.hasContentWithMarkers(resultWithMarkers)
	}

	private def dslFile(CharSequence content) {
		val file = IResourcesSetupUtil.createFile(projectName, fileName, fileExtension, content.toString)

		val project = file.project
		if(!project.hasNature(XtextProjectHelper.NATURE_ID)) {
			project.addNature(XtextProjectHelper.NATURE_ID)
		}

		file
	}

	private def hasContentWithMarkers(IFile file, CharSequence expectation) {
		val actual = new AnnotatedTextToString().withFile(file).withMarkers(file.markers).toString.trim
		val expected = expectation.toString.trim
		assertEquals(expected.toUnixLineSeparator(), actual.toUnixLineSeparator)
	}

	private def void applyQuickfixOnSingleMarker(IMarker marker) {
		val resolutions = marker.getResolutions
		assertEquals(1, resolutions.length)
		val resolution = resolutions.head
		resolution.run(marker)
	}

	private def void applyQuickfixOnMultipleMarkers(IMarker[] markers) {
		val primaryMarker = markers.head
		val resolutions = primaryMarker.getResolutions
		Assert.assertEquals(1, resolutions.length)
		val resolution = resolutions.head 
		assertTrue(resolution instanceof WorkbenchMarkerResolution)
		val workbenchMarkerResolution = resolution as WorkbenchMarkerResolution
		val others = Lists.newArrayList(workbenchMarkerResolution.findOtherMarkers(markers))
		assertFalse(others.contains(primaryMarker))
		assertEquals(markers.length - 1, others.size)
		others.add(primaryMarker)
		workbenchMarkerResolution.run(others, new NullProgressMonitor)
	}

	private def getFirstMarker(IMarker[] markers) {
		markers.sortBy[it.getAttribute(IMarker.CHAR_START) as Integer].head
	}

	private def getMarkers(IFile file) {
		IResourcesSetupUtil.waitForBuild
		file.findMarkers(MarkerTypes.FAST_VALIDATION, true,	IResource.DEPTH_INFINITE)
	}

	private def getProjectName() {
		"MultiQuickfixTestProject"
	}

	private def getFileName() {
		"test"
	}

	private def getFileExtension() {
		primaryFileExtension
	}
}
