package imodv6

import grails.converters.JSON
/* scaffold controller created by Grails for Create Read Update and Delete operation */
class PedagogyTechniqueController {

	static scaffold = PedagogyTechnique

	/**
	 * creates a new Pedagogy Technique
	 */
	def create(Long id) {
		def newTechnique = new PedagogyTechnique()
		// FIXME replace hardcoded values with domain ids
		newTechnique.title = 'new technique'
		newTechnique.pedagogyMode = PedagogyMode.findByName('online')
		newTechnique.addToDomainCategory(DomainCategory.first())
		newTechnique.addToKnowledgeDimension(KnowledgeDimension.first())
		newTechnique.addToLearningDomain(LearningDomain.first())
		newTechnique.save()

		redirect(
			controller: 'pedagogy',
			action: 'index',
			id: id
		)
	}

	def save(Long id) {
		def currentImod = Imod.get(id)
		def pedagogyTechniqueInstance = new PedagogyTechnique(params)

		if (!pedagogyTechniqueInstance.save()) {
			render(
				view: 'create',
				model: [
					pedagogyTechniqueInstance: pedagogyTechniqueInstance
				]
			)
			return
		}

		flash.message = message(
			code: 'default.created.message',
			args: [
				message(
					code: 'imod.label',
					default: 'Imod'
				),
				currentImod
			]
		)

		redirect(
			action: 'list'
		)
	}


	def index(Long id) {

		// To get Learning Domain
		def domains = LearningDomain.list()

		// To get the Domain Category
		// FIXME learning domain should be dynamically set
		LearningDomain domain = LearningDomain.first()
		def domainList = DomainCategory.findAllByLearningDomain(domain);

		//To get the Knowledge Dimension
		def KnowledgeDomainlist = KnowledgeDimension.list()

		[
			currentImod: Imod.get(id),
			domains : domains,
			domainList: domainList,
			KnowledgeDomainlist: KnowledgeDomainlist
		]
	}
}
