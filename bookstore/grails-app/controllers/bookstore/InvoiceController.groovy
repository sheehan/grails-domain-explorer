package bookstore

import org.springframework.dao.DataIntegrityViolationException

class InvoiceController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [invoiceInstanceList: Invoice.list(params), invoiceInstanceTotal: Invoice.count()]
    }

    def create() {
        [invoiceInstance: new Invoice(params)]
    }

    def save() {
        def invoiceInstance = new Invoice(params)
        if (!invoiceInstance.save(flush: true)) {
            render(view: "create", model: [invoiceInstance: invoiceInstance])
            return
        }

		flash.message = message(code: 'default.created.message', args: [message(code: 'invoice.label', default: 'Invoice'), invoiceInstance.id])
        redirect(action: "show", id: invoiceInstance.id)
    }

    def show() {
        def invoiceInstance = Invoice.get(params.id)
        if (!invoiceInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'invoice.label', default: 'Invoice'), params.id])
            redirect(action: "list")
            return
        }

        [invoiceInstance: invoiceInstance]
    }

    def edit() {
        def invoiceInstance = Invoice.get(params.id)
        if (!invoiceInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'invoice.label', default: 'Invoice'), params.id])
            redirect(action: "list")
            return
        }

        [invoiceInstance: invoiceInstance]
    }

    def update() {
        def invoiceInstance = Invoice.get(params.id)
        if (!invoiceInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'invoice.label', default: 'Invoice'), params.id])
            redirect(action: "list")
            return
        }

        if (params.version) {
            def version = params.version.toLong()
            if (invoiceInstance.version > version) {
                invoiceInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'invoice.label', default: 'Invoice')] as Object[],
                          "Another user has updated this Invoice while you were editing")
                render(view: "edit", model: [invoiceInstance: invoiceInstance])
                return
            }
        }

        invoiceInstance.properties = params

        if (!invoiceInstance.save(flush: true)) {
            render(view: "edit", model: [invoiceInstance: invoiceInstance])
            return
        }

		flash.message = message(code: 'default.updated.message', args: [message(code: 'invoice.label', default: 'Invoice'), invoiceInstance.id])
        redirect(action: "show", id: invoiceInstance.id)
    }

    def delete() {
        def invoiceInstance = Invoice.get(params.id)
        if (!invoiceInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'invoice.label', default: 'Invoice'), params.id])
            redirect(action: "list")
            return
        }

        try {
            invoiceInstance.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'invoice.label', default: 'Invoice'), params.id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'invoice.label', default: 'Invoice'), params.id])
            redirect(action: "show", id: params.id)
        }
    }
}
