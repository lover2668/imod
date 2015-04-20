<%@ page import="imod.Content"%>
<%@ page import="imod.Help"%>
<%@ page import="imod.KnowledgeDimensionEnum"%>
<html>
	<head>
		<title>
			Content
		</title>

		<g:external dir="css/source" file="learningObjective.css" />
		<g:external dir="css/source" file="content.css" />

		<!-- FIXME These should be loaded when needed, not prefetched -->
		<link id="imgNone" rel="prefetch" href="${resource(dir: 'images/content', file: 'knowDimNone.png')}">
		<link id="imgC" rel="prefetch" href="${resource(dir: 'images/content', file: 'knowDimC.png')}">
		<link id="imgF" rel="prefetch" href="${resource(dir: 'images/content', file: 'knowDimF.png')}">
		<link id="imgM" rel="prefetch" href="${resource(dir: 'images/content', file: 'knowDimM.png')}">
		<link id="imgP" rel="prefetch" href="${resource(dir: 'images/content', file: 'knowDimP.png')}">
		<link id="imgCF" rel="prefetch" href="${resource(dir: 'images/content', file: 'knowDimCF.png')}">
		<link id="imgCM" rel="prefetch" href="${resource(dir: 'images/content', file: 'knowDimCM.png')}">
		<link id="imgCP" rel="prefetch" href="${resource(dir: 'images/content', file: 'knowDimCP.png')}">
		<link id="imgFM" rel="prefetch" href="${resource(dir: 'images/content', file: 'knowDimFM.png')}">
		<link id="imgFP" rel="prefetch" href="${resource(dir: 'images/content', file: 'knowDimFP.png')}">
		<link id="imgMP" rel="prefetch" href="${resource(dir: 'images/content', file: 'knowDimMP.png')}">
		<link id="imgCFM" rel="prefetch" href="${resource(dir: 'images/content', file: 'knowDimCFM.png')}">
		<link id="imgCFP" rel="prefetch" href="${resource(dir: 'images/content', file: 'knowDimCFP.png')}">
		<link id="imgCMP" rel="prefetch" href="${resource(dir: 'images/content', file: 'knowDimCMP.png')}">
		<link id="imgFMP" rel="prefetch" href="${resource(dir: 'images/content', file: 'knowDimFMP.png')}">
		<link id="imgCFMP" rel="prefetch" href="${resource(dir: 'images/content', file: 'knowDimCFMP.png')}">

		<g:javascript src="source/topicDialog.js" defer="defer" />
		<g:javascript src="source/learningObjectiveContent.js" defer="defer" />

		<meta name="layout" content="imod">
	</head>
	<body>
	<g:hiddenField name="imodID" value="${currentImod.id}" />
	
	
	<div id="contentTable">
	<fieldset class="buttons topicButtonField">
		<span class="topicButtonGradient">
			<g:actionSubmit
				class="add showHoverNew topicButton" action="add" id="addTopic"
				title="${Help.toolTip("OVERVIEW", "Add New Topic")}"
				value="${message(code: 'Add Topic', default: 'Add Topic')}"
			/>
		</span>
		<span class="topicButtonGradient">
			<g:actionSubmit
				class="remove showHoverNew topicButton" action="remove"
				id="removeTopic"
				title="${Help.toolTip("OVERVIEW", "Delete Selected Topic")}"
				value="${message(code: 'Remove Topic', default: 'Remove Topic')}"
			/>
		</span>
		<span id="errorMessage"></span>
	</fieldset>
		<table id="topicList">
		<thead>
			<tr>
				<td class="saveIcon saveIcon-parent">
		            <i class="fa fa-square-o"></i>
		        </td>
				<td>Topic</td>
				<td>Knowledge Dimension</td>
				<td>Priority</td>
				<td>Resources</td>
				<td>Pre-Req</td>
			</tr>
		</thead>
		<tbody>
		<g:each var="contentItem" in="${currentImod.contents}">
		<input type="hidden" id="contentID" value="${contentItem.id }"/>
	<tr id="${contentItem.id}" class="topicItem">
						<td class="saveIcon">
							<i class="fa fa-square-o"></i>
						</td>
						<td class="topicTitle">
							<g:textField
								name="topicTitle${contentItem.id}"
								value="${contentItem.topicTitle}"
							/>
							<input
								type="hidden"
								id="topicTitleSaved${contentItem.id}"
								value="${contentItem.topicTitle}"
							/>
						</td>
						<td class="topicDimensions">
							<span>
								<g:img
									dir="images/content"
									file="knowDim${contentItem.dimensions.sort(){it.value}.collect(){it.toString().charAt(0)}.join()?:'None'}.png"
								/>
								<button
									class="knowledgeDimensionButton"
									value="${contentItem.dimensions.join(',')}"
									type="button"
									id="knowDimensionList${contentItem.id }"
								>
									Knowledge Dimensions
								</button>
								<input type="hidden"
									id="knowDimensionListSaved${contentItem.id }"
									value="${contentItem.dimensions.join(',')}"
								/>
							</span>
						</td>
						<td class="topicPriority">
							<g:select size="1"
								name="topicPriority${contentItem.id}"
								from="${Content.priorities()}"
								value="${contentItem.priority}"
							/>
							<input
								type="hidden"
								id="topicPrioritySaved${contentItem.id}"
								value="${contentItem.priority}"
							/>
						</td>
						<td class="topicResources">
							<button class="ResourceButton" id="topicResources${contentItem.id}" type="button">Resources</button>
						</td>
						<td class="topicPreReq">
							<g:checkBox
								name="topicPreReq${contentItem.id}"
								value="${contentItem.preReq }"
							/>
							<input
								type="hidden"
								id="topicPreReqSaved${contentItem.id}"
								value="${contentItem.preReq}"
							/>
						</td>
					</tr>
	</g:each> 
	
			<g:if test="${contentList.getClass()!=String}">
				<g:each var="contentItem" in="${contentList}">
					<tr id="${contentItem.id}" class="topicItem">
						<td class="saveIcon">
							<i class="fa fa-square-o"></i>
						</td>
						<td class="topicTitle">
							<g:textField
								name="topicTitle${contentItem.id}"
								value="${contentItem.topicTitle}"
							/>
							<input
								type="hidden"
								id="topicTitleSaved${contentItem.id}"
								value="${contentItem.topicTitle}"
							/>
						</td>
						<td class="topicDimensions">
							<span>
								<g:img
									dir="images/content"
									file="knowDim${contentItem.dimensions.sort(){it.value}.collect(){it.toString().charAt(0)}.join()?:'None'}.png"
								/>
								<button
									class="knowledgeDimensionButton"
									value="${contentItem.dimensions.join(',')}"
									type="button"
									id="knowDimensionList${contentItem.id }"
								>
									Knowledge Dimensions
								</button>
								<input type="hidden"
									id="knowDimensionListSaved${contentItem.id }"
									value="${contentItem.dimensions.join(',')}"
								/>
							</span>
						</td>
						<td class="topicPriority">
							<g:select size="1"
								name="topicPriority${contentItem.id }"
								from="${Content.priorities()}"
								value="${contentItem.priority}"
							/>
							<input
								type="hidden"
								id="topicPrioritySaved${contentItem.id}"
								value="${contentItem.priority}"
							/>
						</td>
						<td class="topicResources">
							<button class="ResourceButton" id="topicResources${contentItem.id}" type="button">Resources</button>
						</td>
						<td class="topicPreReq">
							<g:checkBox
								name="topicPreReq${contentItem.id}"
								value="${contentItem.preReq }"
							/>
							<input
								type="hidden"
								id="topicPreReqSaved${contentItem.id}"
								value="${contentItem.preReq}"
							/>
						</td>
					</tr>
				</g:each>
			</g:if>
		</tbody>
	</table>
	
		<fieldset id="topicModalClose" class="buttons topicButtonField">
		<span class="topicButtonGradient saveBG">
			<button
				class="save showHoverNew topicButton"
				action="save"
				id="saveTopic"
				title="${Help.toolTip("OVERVIEW", "Save Selected Topics and Finish")}"
			>
				${message(code: 'Save Topic', default: ' Finish')}
			</button>
		</span>
		<span class="topicButtonGradient cancelBG">
			<button
				class="showHoverNew topicButton"
				action="cancel"
				id="cancelTopic"
				title="${Help.toolTip("OVERVIEW", "Leave Add Topics without saving")}"
			>
				<i class="fa fa-times"></i>
				${message(code: 'Cancel Topics', default: ' Cancel')}
			</button>
		</span>
	</fieldset>
	</div>
	<div id="selectKnowledgeDimensionBackground" class="modalBackground">
</div>
<div id="selectKnowledgeDimensions">
	<input type="hidden" id="topicID" />
	<span>
		<ul>
			<g:each var="dimension" in="${KnowledgeDimensionEnum.values()}">
				<li>
					<input
						type="checkbox"
						id="${dimension}"
						value="${dimension}"
					/>
					<label class="knowledge-dim-label" title="${dimension.getInfo()}" for="${dimension}">
						${dimension}
					</label>
				</li>
			</g:each>
		</ul>
		<g:img
			dir="images/content"
			file="knowDimNone.png"
			id="dimImage"
			width="71"
			height="71"
		/>
	</span>
	<button id="knowDimFinished" type="button">Save</button>
</div>	

<div id="selectResourceBackground" class="modalBackground">
</div>	
<div id="selectResource">
<fieldset class="buttons resourceButtonField">
		<span class="resourceButtonGradient">
			<g:actionSubmit
				class="add showHoverNew resourceButton" action="add" id="addResource"
				title="${Help.toolTip("OVERVIEW", "Add New Resource")}"
				value="${message(code: 'Add Resource', default: 'Add Resource')}"
			/>
		</span>
		<span class="resourceButtonGradient">
			<g:actionSubmit
				class="remove showHoverNew resourceButton" action="remove"
				id="removeResource"
				title="${Help.toolTip("OVERVIEW", "Delete Selected Resource")}"
				value="${message(code: 'Remove Resource', default: 'Remove Resource')}"
			/>
		</span>
		<span id="errorMessage"></span>
	</fieldset>
	<table id="resourceList">
		<thead>
			<tr>
				<td></td>
				<td>Title</td>
				<td>Description</td>
				<td>Resource Type</td>
			</tr>
		</thead>
		<tbody>
		</tbody>
		</table>
		<fieldset class="buttons resourceButtonField">
		<span class="resourceButtonGradient saveBG">
			<button
				class="save showHoverNew resourceButton"
				action="save"
				id="saveResource"
				title="${Help.toolTip("OVERVIEW", "Save Selected Resources and Finish")}"
			>
				${message(code: 'Save Resource', default: ' Finish')}
			</button>
		</span>
		<span class="resourceButtonGradient cancelBG">
			<button
				class="showHoverNew resourceButton"
				action="cancel"
				id="cancelResource"
				title="${Help.toolTip("OVERVIEW", "Leave Add Resources without saving")}"
			>
				<i class="fa fa-times"></i>
				${message(code: 'Cancel Resources', default: ' Cancel')}
			</button>
		</span>


</fieldset>
</div>
		<input type="hidden" id="treeData" value="${contentList}">
	</body>
</html>
