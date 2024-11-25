import SwiftUI

protocol TodoRouterProtocol: AnyObject {
    static func createModule() -> TodoContentView
   
}

class TodoRouter: TodoRouterProtocol {
    static func createModule() -> TodoContentView {
        let interactor = TodoInteractor()
        let presenter = TodoPresenter()
        let router = TodoRouter()

        interactor.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router

        return TodoContentView(presenter: presenter)
    }
}
