//
//  Router.swift
//  viper
//
//  Created by Emir Alkal on 17.01.2023.
//

import UIKit

protocol AnyRouter {
    var entry: (AnyView & UIViewController)? { get set }
    
    static func start() -> AnyRouter
}

final class UserRouter: AnyRouter {
    var entry: (UIViewController & AnyView)?
    
    static func start() -> AnyRouter {
        let router = UserRouter()
        
        var view: AnyView = UserViewController()
        var presenter: AnyPresenter = UserPresenter()
        var interactor: AnyInteractor = UserInteractor()
        
        view.presenter = presenter
        interactor.presenter = presenter
        
        presenter.router = router
        presenter.view = view
        presenter.interactor = interactor
        
        router.entry = view as? (AnyView & UIViewController)
        return router
    }
}
