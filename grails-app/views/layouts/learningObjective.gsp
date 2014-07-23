<%--
	this is the layout for the learning objective tab, it manages switching between the:
	- Performance
	- Content
	- Condition
	- Criteria
	learning objective sections
--%>

<%@ page import="imodv6.Help" %>

<g:applyLayout name="imod">
	<html>

		<head>
			<title>
				<g:layoutTitle default="Learning Objective"/>
			</title>

			<link rel="stylesheet" href="${resource(dir: 'css/source', file: 'learningObjective.css')}" type="text/css">

			<script src="${resource(dir: 'js/source', file: 'learningObjective.js')}" defer></script>

			<g:layoutHead/>
		</head>
		<body>

			<g:if test="${flash.message}">
				<div class="message" role="status">
					${flash.message}
				</div>
			</g:if>
			<g:hasErrors bean="${imodInstance}">
				<ul class="errors" role="alert">
					<g:eachError bean="${imodInstance}" var="error">
						<li
							<g:if test="${error in org.springframework.validation.FieldError}">
								data-field-id="${error.field}"
							</g:if>
						>
							<g:message error="${error}"/>
						</li>
					</g:eachError>
				</ul>
			</g:hasErrors>
			<fieldset class="form">
				 <table  class="LO_inner_table">
					<tr>
						<td id="LO_list_pane" rowspan="2">
							<div class="learning_objectives_list">
								<div class="form_title" style="border-top-left-radius:3px 3px; border-top-right-radius:3px 3px">
									<span class="title_text">
										Learning Objectives
										<a href="/imodv6/learningObjective/create/${imodInstance.id}">
											<button>
												<span class="fa fa-plus">
												</span>
												Add
											</button>
										</a>
									</span>
								</div>
								<ul>
									<g:each in="${learningObjectivesList}" status="i" var="learningObjective">
										<li>
											<g:link action="edit" id="${learningObjective.id}">
												<!-- Definition of the conditions for completing a learning objective -->
												<span class="learning-objective-condition">
													<g:if test="${ learningObjective.condition == null }">
														No Condition
													</g:if>
													<g:else>
														${ learningObjective.condition }
													</g:else>
												</span>

												<!-- Definition of the perfomance evaulations for a learning objective -->
												<span class="learning-objective-performance">
													<g:if test="${ learningObjective.performance == null }">
														No Performance
													</g:if>
													<g:else>
														${ learningObjective.performance }
													</g:else>
												</span>

												<!-- Definition of the criteria for understanding a learning objective -->

												<span class="learning-objective-criteria">
													<g:if test="${ learningObjective.criteria == null }">
														No Criteria
													</g:if>
													<g:else>
														${ learningObjective.criteria }
													</g:else>
												</span>

												<!-- Definition of the indicators used to measure progress through learning objective -->
												<span class="learning-objective-indicator">
													<g:if test="${ learningObjective.indicator == null }">
														No Indicator
													</g:if>
													<g:else>
														${ learningObjective.indicator }
													</g:else>
												</span>
											</g:link>
										</li>
									</g:each>
								</ul>
							</div>
						</td>
						<td id="LO_definition_cell">
							<div id="learning_objectives_definition" class="learning-objective-current">
								<!-- Definition of the conditions for completing a learning objective -->
								<span class="learning-objective-condition">
									<g:if test="${ learningObjective.condition == null }">
										No Condition
									</g:if>
									<g:else>
										${ learningObjective.condition }
									</g:else>
								</span>

								<!-- Definition of the perfomance evaulations for a learning objective -->
								<span class="learning-objective-performance">
									<g:if test="${ learningObjective.performance == null }">
										No Performance
									</g:if>
									<g:else>
										${ learningObjective.performance }
									</g:else>
								</span>

								<!-- Definition of the criteria for understanding a learning objective -->

								<span class="learning-objective-criteria">
									<g:if test="${ learningObjective.criteria == null }">
										No Criteria
									</g:if>
									<g:else>
										${ learningObjective.criteria }
									</g:else>
								</span>

								<!-- Definition of the indicators used to measure progress through learning objective -->
								<span class="learning-objective-indicator">
									<g:if test="${ learningObjective.indicator == null }">
										No Indicator
									</g:if>
									<g:else>
										${ learningObjective.indicator }
									</g:else>
								</span>
							</div>
						</td>
					</tr>
					<tr>
						<td id="LO_creator">
							<div class="learning_objective_creator">
								<img id="LO-type-icon" src="${resource(dir: 'images/learningObjectives', file: 'LO-'+currentPage+'.png')}" alt=""/>

								<div id="tabs-LO-subhead">
									<ul class="ui-tabs-nav">
										<li <g:if test="${currentPage=='performance'}">class="active" </g:if>>
											<g:link
												action="performance"
												learningObjectiveID="${learningObjective.id}"
												id="${imodInstance?.id}"
												class="performance"
											>
												Performance
											</g:link>
										</li>
										<li <g:if test="${currentPage=='content'}">class="active" </g:if>>
											<g:link
												action="content"
												learningObjectiveID="${learningObjective.id}"
												id="${imodInstance?.id}"
												class="content"
											>
												Content
											</g:link>
										</li>
										<li <g:if test="${currentPage=='condition'}">class="active" </g:if>>
											<g:link
												action="condition"
												learningObjectiveID="${learningObjective.id}"
												id="${imodInstance?.id}"
												class="condition"
											>
												Condition
											</g:link>
										</li>
										<li <g:if test="${currentPage=='criteria'}">class="active" </g:if>>
											<g:link
												action="criteria"
												learningObjectiveID="${learningObjective.id}"
												id="${imodInstance?.id}"
												class="criteria"
											>
												Criteria
											</g:link>
										</li>
									</ul>
								</div>
								<div class="tabs-background">
								</div>
								<hr />
								<br>
								<div>
									<g:layoutBody/>
								</div>
							</div>
						</td>
					</tr>
				</table>
			</fieldset>
		</body>
	</html>
</g:applyLayout>
