class DomainExplorerUrlMappings {

    static mappings = {
        "/domain/rest/$className/$id?"(controller: 'domain', action: 'rest')

        "/domain/bbb/**"(view: '/bbb')
    }
}
