package imod

import grails.converters.JSON
import groovy.json.JsonSlurper

class ContentController {

	static allowedMethods = [
		addNewTopic: 'GET',
		saveTopic: 'POST',
		deleteTopic:'GET',
		updateHierarchy: 'POST',
		setLearningObjective: 'POST',
		addResource: 'GET',
	]

	def index(Long id) {
		[
			currentImod: Imod.get(id),
			currentPage: 'content'
		]
	}

	def addNewTopic(Long id) {
		def currentImod = Imod.get(id)
		def contentInstance = new Content(imod: currentImod, failOnError: true)
		contentInstance.save()
		if (!contentInstance) {
			contentInstance.errors.allErrors.each {
				log.error messageSource.getMessage(it,null)
			}
		}
		def dimensions = KnowledgeDimensionEnum.values()*.value
		def priorities = Content.priorities()
		render([
			id: contentInstance.id,
			dimensions: dimensions,
			priorities: priorities,
		] as JSON)
	}

	def saveTopic(String JSONData) {
		def jsonParser = new JsonSlurper()
		def contentData = jsonParser.parseText(JSONData)
		def success = []
		def fail = []
		contentData.each() {
			def contentID = it.contentID.toLong()
			def dimensions = []
			def priority = it.priority
			def preReq = it.preReq
			def topicTitle = it.topicTitle

			def contentInstance = Content.get(contentID)
			if (it.dimensions != '') {
				dimensions = it.dimensions.split(',').collect() {
					it.toUpperCase() as KnowledgeDimensionEnum
				}
			}

			contentInstance.dimensions = dimensions
			contentInstance.priority = priority
			contentInstance.preReq = preReq
			contentInstance.topicTitle = topicTitle
			contentInstance.save()

			if (!contentInstance) {
				contentInstance.errors.allErrors.each {
					log.error messageSource.getMessage(it,null)
				}
				fail.add(contentID)
			}
			else {
				success.add(contentID)
			}
		}

		render(
			[
				success: success,
				fail: fail
			] as JSON
		)
	}

	def deleteTopic(String contentIDs) {
		def success = []
		def contentIDList = new JsonSlurper().parseText(contentIDs)

		contentIDList.each() { item ->

			def deletedContent = Content.get(item)

			// remove any parent association
			def oldParent = deletedContent.parentContent
			if (oldParent != null) {
				oldParent.removeFromSubContents(deletedContent)
			}

			// remove all children association
			def childrenList = []
			def children = deletedContent.subContents
			if (children != null) {
				childrenList.addAll(children)

				childrenList.each() { child ->
					deletedContent.removeFromSubContents(child)
				}
			}

			def learningObjectiveList = []
			def learningObjectives = deletedContent.objectives

			// remove learning objective association
			if (learningObjectives != null) {
				learningObjectiveList.addAll(learningObjectives)
				learningObjectiveList.each() {
					deletedContent.removeFromObjectives(it)
				}
			}

			deletedContent.delete()
			success.add(item)
		}
		render(
			[
				result: success
			] as JSON
		)
	}

	def updateHierarchy() {

		def data = request.JSON
		def contents = data.topics
		def idArray = data.idArray

		contents.each() {
			buildHierarchy(it, null)
		}

		setLearningObjective(data.objId, idArray);

		render(
			[
				success: true
			] as JSON
		)
	}

	def buildHierarchy(content, Long parentID) {

		def childContent = Content.get(content.id)
		def oldParent = childContent.parentContent
		if (oldParent != null) {
			oldParent.removeFromSubContents(childContent)
		}
		if (parentID != null) {
			def parentContent = Content.get(parentID)
			parentContent.addToSubContents(childContent)
			childContent.parentContent = parentContent
		}
		else {
			childContent.parentContent = null
		}

		if (content.child != '') {

			content.child.each(){

				buildHierarchy(it, content.id)

			}

		}

	}

	def setLearningObjective(String objectiveID, idArray) {
		def learningObjectiveInstance = LearningObjective.get(objectiveID)

		if (idArray != null) {
			def contentList = idArray.collect {Content.get(it)}
			learningObjectiveInstance.contents.clear()
			contentList.each() {
				learningObjectiveInstance.addToContents(it)
			}

			// reset the definition
			learningObjectiveInstance.buildDefinition()

			learningObjectiveInstance.save(failOnError:true)
		}
		else {
			learningObjectiveInstance.contents = null
		}

	}

	def addResource(Long contentID) {
		def contentInstance = Content.get(contentID)
		def resourceInstance = new Resource(content: contentInstance)
		resourceInstance.save()
		contentInstance.addToResources(resourceInstance)

		def resources = Resource.resourceTypes()
		render([
			id: resourceInstance.id,
			resources: resources,
		] as JSON)
	}

	def getResource(Long contentID) {
		def contentInstance = Content.get(contentID)
		def resources = contentInstance.getResources()
		def resourceTypes = Resource.resourceTypes()
		render([
			resources: resources,
			resourceTypes: resourceTypes,
		] as JSON)
	}

	def saveResource(String JSONData) {
		def jsonParser = new JsonSlurper()
		def resourceData = jsonParser.parseText(JSONData)
		def success = []
		def fail = []
		resourceData.each() {
			def resourceID = it.resourceID.toLong()
			def resourceName = it.resourceName
			def resourceDescription = it.resourceDescription
			def resourceType = it.resourceType
			def resourceInstance = Resource.get(resourceID)
			resourceInstance.name = resourceName
			resourceInstance.description = resourceDescription
			resourceInstance.resourceType = resourceType
			resourceInstance.save()

			if (!resourceInstance) {
				resourceInstance.errors.allErrors.each {
					log.error messageSource.getMessage(it,null)
				}
				fail.add(resourceID)
			}
			else {
				success.add(resourceID)
			}
		}

		render(
			[
				success: success,
				fail: fail
			] as JSON
		)
	}

	def deleteResource(String resourceIDs) {
		def success = []
		def resourceIDList = new JsonSlurper().parseText(resourceIDs)
		resourceIDList.each() {
			def deletedResource = Resource.get(it)
			deletedResource.delete()
			success.add(it)
		}
		render(
			[
				result: success
			] as JSON
		)
	}
}