<%@page import="imodv6.ScheduleWeekDays"%>
<%@page import="imodv6.ScheduleRepeatsEvery"%>
<%@ page import="imodv6.Help; imodv6.Imod; imodv6.ImodUser" %>
<!DOCTYPE html>
<html>
	<head>
		<title>
			Course Overview
		</title>
		<meta name="layout" content="imod">
		<script src="${resource(dir: 'js/source', file: 'courseOverview.js')}" defer></script>
	</head>
	<body>
		<div id="tabs-1">
			<div id="edit-imod" class="content scaffold-edit" role="main">
				<g:if test="${flash.message}">
					<div class="message" role="status">
						${flash.message}
					</div>
				</g:if>
				<g:hasErrors bean="${currentImod}">
					<ul class="errors" role="alert">
						<g:eachError bean="${currentImod}" var="error">
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
				<g:form controller="imod" method="post">
					<g:hiddenField name="id" value="${currentImod?.id}"/>
					<g:hiddenField name="version" value="${currentImod?.version}"/>
					<fieldset class="form">
						<table class="inner-table">
							<tr height="50px">
								<td>
								</td>
								<td>
									<fieldset class="buttons">
										<g:actionSubmit class="save showHoverNew" action="update" title="${Help.toolTip("OVERVIEW", "Save Course Overview")}" value="${message(code: 'Save', default: 'Save')}"/>
										<g:actionSubmit class="delete showHoverNew" action="delete" title="${Help.toolTip("OVERVIEW", "Delete Course Overview")}" value="${message(code: 'default.button.delete.label', default: 'Delete')}" formnovalidate="" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');"/>
									</fieldset>
								</td>
							</tr>
							<tr>
								<td>
									<div class="course-overview-form">
										<div class="form-title">
											<span class="title-text">
												Course Details
											</span>
										</div>
										<div class="fieldcontain ${hasErrors(bean: currentImod, field: 'name', 'error')} required">
											<label for="name">
												<g:message code="imod.name.label" default="Name" />
												<span class="required-indicator">
													*
												</span>
											</label>
											<g:textField name="name" required="" value="${currentImod?.name}"/>
										</div>

										<div class="fieldcontain ${hasErrors(bean: currentImod, field: 'imodNumber', 'error')} ">
											<label for="imodNumber">
												<g:message code="imod.imodNumber.label" default="Course Number" />
												<span class="required-indicator">
													*
												</span>
											</label>
											<g:textField name="imodNumber" required="" value="${currentImod?.imodNumber}"/>
										</div>

										<div class="fieldcontain ${hasErrors(bean: currentImod, field: 'url', 'error')} ">
											<label for="url">
												<g:message code="imod.url.label" default="Url" />
												<span class="required-indicator">
													*
												</span>
											</label>
											<g:textField required="" name="url" value="${currentImod?.url}"/>
										</div>

										<div class="fieldcontain ${hasErrors(bean: currentImod, field: 'courseLocation', 'error')} ">
											<label for="courseLocation">
												<g:message code="imod.courseLocation.label" default="Classroom Location" />
											</label>
											<g:textField name="courseLocation" value="${currentImod?.courseLocation}"/>
										</div>

										<div class="fieldcontain ${hasErrors(bean: currentImod, field: 'courseSemester', 'error')} ">
											<label for="courseSemester">
												<g:message code="imod.courseSemester.label" default="Semester" />
											</label>
											<g:textField name="courseSemester" value="${currentImod?.courseSemester}"/>
										</div>
									</div>
								</td>
								<td>
									<div class="course-overview-form">
										<div class="form-title">
											<span class="title-text">
												Schedule
											</span>
										</div>
										<div class="fieldcontain ${hasErrors(bean: currentImod, field: 'startDate', 'error')} required">
											<label for="startDate">
												<g:message code="imod.schedule.startDate.label" default="Start Date" />
												<span class="required-indicator">
													*
												</span>
											</label>
											<g:datePicker name="schedule.startDate" precision="day"  value="${currentImod?.schedule?.startDate}" class="showHoverNew"  title="${Help.toolTip("OVERVIEW", "Schedule start Date")}"/>
										</div>

										<div class="fieldcontain ${hasErrors(bean: currentImod, field: 'endDate', 'error')} required">
											<label for="endDate">
												<g:message code="imod.schedule.endDate.label" default="End Date" />
												<span class="required-indicator">
													*
												</span>
											</label>
											<g:datePicker name="schedule.endDate" precision="day"  value="${currentImod?.schedule?.endDate}" title="${Help.toolTip("OVERVIEW", "Schedule end Date")}" class="showHoverNew"/>
										</div>

										<div class="fieldcontain ${hasErrors(bean: currentImod, field: 'startTime', 'error')} ">
											<label for="startTime">
												<g:message code="imod.schedule.startTime.label" default="Start Time" />
											</label>
										<joda:timePicker name="schedule.startTime" value="${currentImod?.schedule?.startTime}" />
										</div>
										<div class="fieldcontain ${hasErrors(bean: currentImod, field: 'endTime', 'error')} ">
											<label for="endTime">
												<g:message code="imod.schedule.endTime.label" default="End Time" />
											</label>
										<joda:timePicker name="schedule.endTime" value="${currentImod?.schedule?.endTime}" />
										</div>
										<div class="fieldcontain ${hasErrors(bean: currentImod, field: 'repeats', 'error')} ">
											<label for="repeats">
												<g:message code="imod.schedule.repeats.label" default="Repeats" />
											</label>
											<g:select id="repeats" name="schedule.repeats.id" from="${imodv6.ScheduleRepeats.list()}" optionKey="id" value="${currentImod?.schedule?.repeats?.id}" class="many-to-one"/>
										</div>

										<div class="fieldcontain ${hasErrors(bean: currentImod, field: 'repeatsEvery', 'error')} ">
											<label for="repeatsEvery">
												<g:message code="imod.repeatsEvery.label" default="Repeats Every" />
											</label>
											<g:select id="repeatsEvery" name="schedule.repeatsEvery.id" from="${imodv6.ScheduleRepeatsEvery.list()}" optionKey="id" value="${currentImod?.schedule?.repeatsEvery?.id}" noSelection="${['null':'Nothing Selected']}" class="many-to-one"/>
											<label id="duration"></label>
										</div>

										<div class="fieldcontain ${hasErrors(bean: currentImod, field: 'schedule.scheduleWeekDays', 'error')} ">
										<label for="scheduleWeekDays">
												<g:message code="imod.scheduleWeekDays.label" default="Repeats On" />
											</label>
										<g:each in="${imodv6.ScheduleWeekDays.list()}" var="scheduleWeekDays" status="i">
										    <g:checkBox name="scheduleWeekDays_${scheduleWeekDays.id}" value="${scheduleWeekDays.description == currentImod?.schedule?.scheduleWeekDays?.find{p -> p.id == scheduleWeekDays?.id}.toString()}" />
										    <label for="weekdays">${scheduleWeekDays.description}</label>
										</g:each>
									</div>
								</td>
							</tr>
							<tr>
								<td colspan="2">
									<div class="course-overview-form">
										<div class="form-title">
											<span class="title-text">
												Instructors
											</span>
										</div>
											<div class="fieldcontain ${hasErrors(bean: currentImod, field: 'instructors', 'error')} ">

												<div id="clickthis">
													<g:link controller="courseOverview" action="add" params="['imod.id': currentImod?.id]" title="${Help.toolTip("OVERVIEW", "Add instructor")}" class="showHoverNew">
														${message(code: 'default.add.label', args: [message(code: 'instructor.label', default: 'Instructor')])}
													</g:link>
													<g:link controller="courseOverview" action="delete" params="['imod.id': currentImod?.id]" title="${Help.toolTip("OVERVIEW", "Delete instructor")}" class="showHoverNew">
														${message(code: 'Delete Instructor', args: [message(code: 'instructor.label', default: 'Delete Instructor')])}
													</g:link>
												</div>
													<div id="custom-instructor">
													<table id="instructor-table">
														<thead>
															<tr>
																<g:sortableColumn property="lastName" title="${message(code: 'imod.instructor.lastName.label', default: 'Last Name')}" class="showHoverNew" titleKey="${Help.toolTip("OVERVIEW","Last Name Label")}" title="${Help.toolTip("OVERVIEW","Last Name Label")}"/>
																<g:sortableColumn property="firstName" title="${message(code: 'imod.instructor.firstName.label', default: 'First Name')}" class="showHoverNew" titleKey="${Help.toolTip("OVERVIEW","First Name Label")}" />
																<g:sortableColumn property="email" title="${message(code: 'imod.instructor.email.label', default: 'Email')}" class="showHoverNew"  titleKey="${Help.toolTip("OVERVIEW","Email Label")}"/>
																<g:sortableColumn property="officeHours" title="${message(code: 'imod.instructor.officeHours.label', default: 'Office Hours')}" class="showHoverNew"  titleKey="${Help.toolTip("OVERVIEW","Office Hours Label")}"/>
																<g:sortableColumn property="webPage" title="${message(code: 'imod.instructor.webPage.label', default: 'Web Page')}" class="showHoverNew"  titleKey="${Help.toolTip("OVERVIEW","Last Name Label")}"/>
																<g:sortableColumn property="Role" title="${message(code: 'imod.instructor.Role.label', default: 'Role')}" class="showHoverNew"  titleKey="${Help.toolTip("OVERVIEW","Role Label")}"/>
																<g:sortableColumn property="location" title="${message(code: 'imod.instructor.location.label', default: 'Location')}" class="showHoverNew"  titleKey="${Help.toolTip("OVERVIEW","Location Label")}"/>
															</tr>
														</thead>
														<tbody>
															<g:each in="${currentImod?.instructors?}" var="i">
															    <tr>
															    	<td>
															    		<g:textField name="lastName" value="${i.lastName}"/>
															    	</td>
																	<td>
																		<g:textField name="firstName" value="${i.firstName}"/>
																	</td>
																	<td>
																		<g:textField name="email" value="${i.email}"/>
																	</td>
																	<td>
																		<g:textField name="officeHours" value="${i.officeHours}"/>
																	</td>
																	<td>
																		<g:textField name="webPage" value="${i.webPage}"/>
																	</td>
															    </tr>
															</g:each>
														</tbody>
													</table>
													</div>
													<div class="fieldcontain ${hasErrors(bean: currentImod, field: 'instructors', 'error')} " style="margin-left:-20px;">
														<label for="instructors">
															<g:message code="imod.instructors.label" default="Select Instructors:" />
														</label>
														<g:select name="instructors" from="${imodv6.Instructor.list()}" multiple="multiple" optionKey="id" size="5" value="${currentImod?.instructors*.id}" class="many-to-many" style="width:150px;margin-left:-110px;" />
													</div>
											</div>
									</div>
								</td>
							</tr>
							<tr>
								<td>
									<div class="course-overview-form">
										<div class="form-title">
											<span class="title-text">
												Course Description
											</span>
										</div>
											<div class="fieldcontain ${hasErrors(bean: currentImod, field: 'overview', 'error')} ">
												<label for="overview">
													<g:message code="imod.overview.label" default="Overview" />
												</label>
												<g:textArea name="overview" value="${currentImod?.overview}" rows="4" cols="40"/>
											</div>

											<div class="fieldcontain ${hasErrors(bean: currentImod, field: 'subjectArea', 'error')} ">
												<label for="subjectArea">
													<g:message code="imod.subjectArea.label" default="Subject Area" />
													<span class="required-indicator">
														*
													</span>
												</label>
												<g:textField name="subjectArea" required="" value="${currentImod?.subjectArea}"/>
											</div>

											<div class="fieldcontain ${hasErrors(bean: currentImod, field: 'audience', 'error')} ">
												<label for="audience">
													<g:message code="imod.audience.label" default="Audience" />
												</label>
												<g:select name="audience" from="${imodv6.Audience.list()}" noSelection="${['none':'No Audience'] }"multiple="multiple" optionKey="id" size="5" value="${currentImod?.audience*.id}" class="many-to-many"/>
											</div>

											<div class="fieldcontain ${hasErrors(bean: currentImod, field: 'creditHours', 'error')} ">
												<label for="creditHours">
													<g:message code="imod.creditHours.label" default="Credit Hours" />
												</label>
												<g:field name="creditHours" type="number" value="${currentImod.creditHours}"/>
											</div>

											<div class="fieldcontain ${hasErrors(bean: currentImod, field: 'timeRatio', 'error')} ">
												<label for="timeRatio">
													<g:message code="imod.timeRatio.label" default="Time Ratio" />
												</label>
												<g:textField name="timeRatio" value="${currentImod?.timeRatio}"/>
											</div>

											<div class="fieldcontain ${hasErrors(bean: currentImod, field: 'numberOfSeats', 'error')} ">
												<label for="numberOfSeats">
													<g:message code="imod.numberOfSeats.label" default="Number Of Seats" />
												</label>
												<g:field name="numberOfSeats" type="number" value="${currentImod.numberOfSeats}"/>
											</div>
									</div>
								</td>
								<td>
									<div class="course-overview-form" id="policy">
										<div class="form-title">
											<span class="title-text">
												Course Policy
											</span>
										</div>
										<div id="accordion">
											<h3>
												Grading procedure
											</h3>
											<div>
												<g:textArea name="gradingProcedure" value="${currentImod?.gradingProcedure}" rows="3" cols="30">
												</g:textArea>
											</div>
											<h3>
												Attendance and tardiness
											</h3>
											<div>
												<g:textArea name="attendance" value="${currentImod?.attendance}" rows="3" cols="30">
												</g:textArea>
											</div>
											<h3>
												Class participation
											</h3>
											<div>
												<g:textArea name="classParticipation" value="${currentImod?.classParticipation}" rows="2" cols="30">
												</g:textArea>
											</div>
											<h3>
												Classroom decorum
											</h3>
											<div>
												<g:textArea name="classroomDecorum" value="${currentImod?.classroomDecorum}" rows="2" cols="30">
												</g:textArea>
											</div>
											<h3>
												Missed exams/Make-up exams
											</h3>
											<div>
												<g:textArea name="missedExams" value="${currentImod?.missedExams}" rows="2" cols="30">
												</g:textArea>
											</div>
											<h3>
												Missed Assignments
											</h3>
											<div>
												<g:textArea name="missedAssignments" value="${currentImod?.missedAssignments}" rows="2" cols="30">
												</g:textArea>
											</div>
										</div>
									</div>
								</td>
							</tr>
						</table>
					</fieldset>
				</g:form>
			</div>
		</div>
	</body>
</html>
