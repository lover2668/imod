'use strict';

// Load techniques on page load
filterAssessmentTechniques();

// Filters for the pedagogy technique are wrapped in a accordian
$('#filter-assessment-techniques').accordion();

$('#idealCollapser').load(function () {
	$('#ideal-matches1').slideToggle('slow');

	$('#extended-matches').hide();
});

$('#extCollapser').click(function () {
	$('#extended-matches').slideToggle('slow');
});

$('#favorites').click(function () {
	$('.favDiv').css('visibility', 'visible');
	$('.favDiv').css('display', 'block');
	$('#assessmentFavorites').css('visibility', 'visible');
	$('#assessmentFavorites').css('display', 'block');
	$('#assessmentFavoritesDiv').css('visibility', 'visible');
	$('#assessmentFavoritesDiv').css('display', 'block');

	$('#favorites').hide();
	$('#unfavorites').show();
});

$('#unfavorites').click(function () {
	$('.favDiv').css('visibility', 'hidden');
	$('.favDiv').css('display', 'none');
	$('#assessmentFavorites').css('visibility', 'hidden');
	$('#assessmentFavorites').css('display', 'none');
	$('#assessmentFavoritesDiv').css('visibility', 'hidden');
	$('#assessmentFavoritesDiv').css('display', 'none');

	$('#favorites').show();
	$('#unfavorites').hide();
});

// Auto hide the assessment plan modal
$('#assessment-plan').dialog({
	autoOpen: false
});

// Auto hide the add new technique modal
$('#new-technique').dialog({
	autoOpen: false
});

// Auto hide the add new technique modal
$('#display-new-technique').dialog({
	autoOpen: false
});

// Attach a listener to the checkboxes, to update the assessment techniques
// when the filters have been changed
$('input[name=knowledgeDimension]').on('change', filterAssessmentTechniques);
$('input[name=learningDomain]').on('change', filterAssessmentTechniques);
$('input[name=domainCategory]').on('change', filterAssessmentTechniques);

// When add new technique button is clicked open modal
$('#new-technique-button').on('click', openNewAssessmentTechniqueModal);

// When add assessment  plan button is clicked open modal
$('#assessment-plan-button').on('click', openAssessmentPlanModal);

/**
 * Opens the modal to create a new assessment technique
 */
function openAssessmentPlanModal() {
	// Alert ("click calls the displayAssessmentPlan fucntion with ajax data");
	$('#assessment-plan').dialog('open');
	$('#assessment-plan').dialog(
	{
		resizable: false,
		height: 'auto',
		title:'Assessment Plan',
		width: 400,
		modal: true,
		zindex: 1001, // Default is 1000
		buttons: {
			Cancel: function () {
				$(this).dialog('close');
			}
		}
	});

	displayAssessmentPlan();
}

/**
 * Opens the modal to create a new assessment technique
 */
function openNewAssessmentTechniqueModal() {
	$('#techniqueId').val('');
	$('#new-technique').dialog('open');
	$('#new-technique').dialog(
	{
		resizable: false,
		height: 'auto',
		title:'New Assessment Technique',
		width: 'auto',
		modal: true,
		zindex: 1001 // Default is 1000
	});
}

/**
 * Reads which filters are selected and sends information to server to update
 * visible assessment techniques
 */
function filterAssessmentTechniques() {
	// Get all of the selected checkboxes
	var selectedKnowledgeDimensions = $('input[name=knowledgeDimension]:checked');
	var selectedLearningDomains = $('input[name=learningDomain]:checked');
	var selectedDomainCategories = $('input[name=domainCategory]:checked');

	// Arrays to store the data
	var selectedKnowledgeDimensionsData = [];
	var selectedLearningDomainsData = [];
	var selectedDomainCategoriesData = [];

	// Get the id of the grails domain from the value attribute in the html
	for (var index = 0; index < selectedKnowledgeDimensions.length; index++) {
		selectedKnowledgeDimensionsData[index] = selectedKnowledgeDimensions[index].value;
	}
	for (index = 0; index < selectedLearningDomains.length; index++) {
		selectedLearningDomainsData[index] = selectedLearningDomains[index].value;
	}
	for (index = 0; index < selectedDomainCategories.length; index++) {
		selectedDomainCategoriesData[index] = selectedDomainCategories[index].value;
	}

	// Bundle the data into an object
	var data = {
		selectedKnowledgeDimensions: selectedKnowledgeDimensionsData,
		selectedLearningDomains: selectedLearningDomainsData,
		selectedDomainCategories: selectedDomainCategoriesData
	};

	// Send the data to the find matching techniques action in grails
	// and process the response with the display pedagogy techniques callback
	$.ajax({
			url: '../findMatchingTechniques',
			method: 'post',
			data: JSON.stringify(data),
			contentType: 'application/json'
		})
		.done(displayAssessmentTechniques, showAssessmentTechnique, checkForAssign);
}

function checkForAssign(data) {
	// Your code
	for (var index = 0; index < data.idealAssessmentTechniqueMatch.length; index++) {
		var currentTechnique = data.idealAssessmentTechniqueMatch[index];

		if (currentTechnique.assigncheck === true && currentTechnique.favcheck === false) {
			$('#span-' + currentTechnique.id).addClass('icons assessmentUnfavAssign');
		} else if (currentTechnique.assigncheck === true && currentTechnique.favcheck === true) {
			$('#span-' + currentTechnique.id).addClass('icons assessmentFavAssign');
		} else if (currentTechnique.assigncheck === false && currentTechnique.favcheck === true) {
			$('#span-' + currentTechnique.id).addClass('icons assessmentFavUnassign');
		} else if (currentTechnique.assigncheck === false && currentTechnique.favcheck === false) {
			$('#span-' + currentTechnique.id).addClass('icons assessmentUnfavUnassign');
		}
	}

	for (var index = 0; index < data.extendedAssessmentTechniqueMatch.length; index++) {
		var currentTechnique = data.extendedAssessmentTechniqueMatch[index];
		if (currentTechnique.assigncheck === true && currentTechnique.favcheck === false) {
			$('#span-' + currentTechnique.id).addClass('icons assessmentUnfavAssign');
		} else if (currentTechnique.assigncheck === true && currentTechnique.favcheck === true) {
			$('#span-' + currentTechnique.id).addClass('icons assessmentFavAssign');
		} else if (currentTechnique.assigncheck === false && currentTechnique.favcheck === true) {
			$('#span-' + currentTechnique.id).addClass('icons assessmentFavUnassign');
		} else if (currentTechnique.assigncheck === false && currentTechnique.favcheck === false) {
			$('#span-' + currentTechnique.id).addClass('icons assessmentUnfavUnassign');
		}
	}
}

function showAssessmentTechnique() {
	$('#ideal-matches1').buttonset().click(function () {
		$('#display-new-technique').dialog('open');
		$('#display-new-technique').dialog({
			resizable: false,
			height: 'auto',
			title:'Display Technique',
			width: 'auto',
			modal: true,
			zindex: 1001, // Default is 1000
		});
		displayAssessmentInformationInEdit();
	});

	$('#extended-matches').click(function () {
		$('#display-new-technique').dialog('open');
		$('#display-new-technique').dialog({
			resizable: false,
			height: 'auto',
			title:'Display Technique',
			width: 'auto',
			modal: true,
			zindex: 1001, // Default is 1000
		});

		displayAssessmentInformationInEdit();
	});
}

/**
 * Callback for find matching techniques grails action
 * this takes the json data and processes it into html code
 */
function displayAssessmentTechniques(data) {
	var idealText1 = '';
	// Take the titles and make html code to display
	for (var index = 0; index < data.idealAssessmentTechniqueMatch.length; index++) {
		var currentTechnique = data.idealAssessmentTechniqueMatch[index];
		idealText1 += '<input  type="radio" id="' + currentTechnique.id + '" name="assessmentTech1" value="' + currentTechnique.id + '" />';
		idealText1 += '<span id="span-' + currentTechnique.id + '" class="icons">';
		idealText1 += '  <label for="' + currentTechnique.id + '">';
		idealText1 += '    ' + currentTechnique.title;
		idealText1 += '  </label>';
		idealText1 += '</span>';
	}

	var idealText2 = '';
	// Take the titles and make html code to display
	for (var index = 0; index < data.idealAssessmentTechniqueMatch.length; index++) {
		var currentTechnique = data.idealAssessmentTechniqueMatch[index];
		if (currentTechnique.favcheck === true) {
			if (currentTechnique.assigncheck === true) {
				idealText2 += '<input  type="radio" id="fav' + currentTechnique.id + '" name="assessmentTech1" value="' + currentTechnique.id + '" />';
				idealText2 += '<span id="span1-' + currentTechnique.id + '" class="icons assessmentFavAssign">';
				idealText2 += '  <label for="' + currentTechnique.id + '">';
				idealText2 += '    ' + currentTechnique.title;
				idealText2 += '  </label>';
				idealText2 += '</span>';
			} else if (currentTechnique.assigncheck === false){
				idealText2 += '<input  type="radio" id="fav' + currentTechnique.id + '" name="assessmentTech1" value="' + currentTechnique.id + '" />';
				idealText2 += '<span id="span1-' + currentTechnique.id + '" class="icons assessmentFavUnassign">';
				idealText2 += '  <label for="' + currentTechnique.id + '">';
				idealText2 += '    ' + currentTechnique.title;
				idealText2 += '  </label>';
				idealText2 += '</span>';
			}
		}

		$('#assessmentFavoritesDiv').html(idealText2);
		$('#assessmentFavoritesDiv').buttonset();
	}

	var extendedText = '';
	// Take the titles and make html code to display
	for (var index = 0; index < data.extendedAssessmentTechniqueMatch.length; index++) {
		var currentTechnique = data.extendedAssessmentTechniqueMatch[index];
		extendedText += '<input  type="radio" id="' + currentTechnique.id + '" name="assessmentTech1" value="' + currentTechnique.id + '" />';
		extendedText += '<span id="span-' + currentTechnique.id + '" class="icons">';
		extendedText += '  <label for="' + currentTechnique.id + '">';
		extendedText += '    ' + currentTechnique.title;
		extendedText += '  </label>';
		extendedText += '</span>';
	}

	var extendedText2 = '';
	// Take the titles and make html code to display
	for (var index = 0; index < data.extendedAssessmentTechniqueMatch.length; index++) {
		var currentTechnique = data.extendedAssessmentTechniqueMatch[index];
		if (currentTechnique.favcheck === true) {
			if (currentTechnique.assigncheck === true) {
				extendedText2 += '<input  type="radio" id="fav' + currentTechnique.id + '" name="assessmentTech1" value="' + currentTechnique.id + '" />';
				extendedText2 += '<span id="span1-' + currentTechnique.id + '" class="icons assessmentFavAssign ">';
				extendedText2 += '  <label for="' + currentTechnique.id + '">';
				extendedText2 += '    ' + currentTechnique.title;
				extendedText2 += '  </label>';
				extendedText2 += '</span>';
			} else if (currentTechnique.assigncheck === false) {
				extendedText2 += '<input  type="radio" id="' + currentTechnique.id + '" name="assessmentTech1" value="fav' + currentTechnique.id + '" />';
				extendedText2 += '<span id="span1-' + currentTechnique.id + '" class="icons assessmentFavUnassign">';
				extendedText2 += '  <label for="' + currentTechnique.id + '">';
				extendedText2 += '    ' + currentTechnique.title;
				extendedText2 += '  </label>';
				extendedText2 += '</span>';
			}
		}
		$('#assessmentFavoritesDiv1').html(extendedText2);
		$('#assessmentFavoritesDiv1').buttonset();
	}

	// Add html code to the page
	$('#ideal-matches1').html(idealText1);
	$('#extended-matches').html(extendedText);

	$('#ideal-matches1').buttonset();
	$('#extended-matches').buttonset();
}

function displayAssessmentPlan(data) {
	$.ajax({
			url: '../../assessmentTechnique/assessmentplan',
			method: 'post',
			data: JSON.stringify(data),
			contentType: 'application/json'
		})
		.done(assessmentPlanData);
}

function assessmentPlanData(data) {
	var allAssessmentData = '';

	for (var index = 0; index < data.assessmentTechInstance.length; index++) {
		var assessmentPlan = data.assessmentTechInstance[index];

		var techkd = '';
		for (var ind = 0; ind < assessmentPlan.knowledgeDimension.length; ind++) {
			var xx = assessmentPlan.knowledgeDimension[ind];
			techkd = xx.id;
		}

		var xkd = '';
		var xdc = '';
		var xld = '';
		var kd = '';

		for (var index1 = 0; index1 < data.knowledgeDimensions.length; index1++) {
			kd = data.knowledgeDimensions[index1];

			if (kd.id === techkd) {
				var xkd = kd.description;

				alert('final X::' + xkd);
			}
		}

		allAssessmentData += '<div id="' + assessmentPlan.id + '">';
		allAssessmentData += '  <span>';
		allAssessmentData += '    <h2>';
		allAssessmentData += '      ' + assessmentPlan.title;
		allAssessmentData += '    </h2>';
		allAssessmentData += '  </span>';
		allAssessmentData += '  <br/>';
		allAssessmentData += '  <span>';
		allAssessmentData += '    Description : ' + assessmentPlan.description;
		allAssessmentData += '  </span>';
		allAssessmentData += '  <br/>';
		allAssessmentData += '  <span>';
		allAssessmentData += '    ' + assessmentPlan.procedure;
		allAssessmentData += '  </span>';
		allAssessmentData += '  <br/>';
		allAssessmentData += '  <span>';
		allAssessmentData += '    ' + assessmentPlan.duration;
		allAssessmentData += '  </span>';
		allAssessmentData += '  <br/>';
		allAssessmentData += '  <span>';
		allAssessmentData += '    DomainCategory :' + xdc;
		allAssessmentData += '  </span>';
		allAssessmentData += '  <br/>';
		allAssessmentData += '  <span>';
		allAssessmentData += '    Learning Domain :' + xld;
		allAssessmentData += '  </span>';
		allAssessmentData += '  <br/>';
		allAssessmentData += '  <span>';
		allAssessmentData += '    Knowledge Dimension : ' + xkd;
		allAssessmentData += '  </span>';
		allAssessmentData += '  <br/>';
		allAssessmentData += '  <span>';
		allAssessmentData += '    ' + assessmentPlan.assessmentFeedback.name;
		allAssessmentData += '  </span>';
		allAssessmentData += '</div>';
	}

	$('#assessmentData').html(allAssessmentData);
}

function displayAssessmentInformationInEdit() {
	$('#techniqueId1').val($('label.ui-state-active').attr('for'));

	$.ajax({
			url: '../../assessmentTechnique/display/' + $('label.ui-state-active').attr('for'),
			method: 'GET'
		})
		.done(populateAssessmentTechnique);
}

function populateAssessmentTechnique(data) {
	var currentTechnique = data.assessmentTechnique;

	// Set the text fields
	$('#title1').val(currentTechnique.title);
	$('#title2').val(currentTechnique.title);

	$('#description1').val(currentTechnique.description);
	$('#description2').val(currentTechnique.description);

	$('#procedure1').val(currentTechnique.procedure);
	$('#procedure2').val(currentTechnique.procedure);

	$('input[name=\'duration1\']').val(currentTechnique.duration);
	$('input[name=\'duration2\']').val(currentTechnique.duration);

	$('input[name=\'assessmentFeedback1\']').val(currentTechnique.assessmentFeedback);

	var checkedCheckboxes = $('.assessmentFeedback2:checked');

	$('.assessmentFeedback3').val($.each(checkedCheckboxes, function (index, checkbox) {
		// FIXME unused variable
		var theValue = checkbox.value;
	}));

	$('#domainCategory option[value=' + currentTechnique.domainCategory[0].id + ']').prop('selected', true);

	$('.allInputs').hide();

	$('.allInputs1').replaceWith(function () {
		return '<span class="allspans1" style="display:table-cell; width:200px;"> ' + $(this).val() + '</span>';
	});

	$('#viewModal').hide();
}

// Clicking on edit and View in display technique modal
$('#editModal').click(function () {
	$('#viewModal').show();
	$('.allInputs').show();
	$('.allspans1').hide();
});

$('#viewModal').click(function () {
	$('.allInputs').hide();
	$('.allspans1').show();
	$('#editModal').show();
});