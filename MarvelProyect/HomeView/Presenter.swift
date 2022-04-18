//
//  Presenter.swift
//  MarvelProyect
//
//  Created by Ricardo Sanchez on 12/4/22.
//

import Foundation


protocol AnyPresenter {
    var wireframe: AnyWireframe? {get set}
    var interactor: AnyInteractor? {get set}
    var view: AnyView? {get set}

    func interactorDidFetchHeros(with result: Result<[Hero],APIError>)
    func getMoreHeros(numberOfHeros: Int)
}

class HomePresenter: AnyPresenter {

    var wireframe: AnyWireframe?

    var view: AnyView?

    var interactor: AnyInteractor? {
        didSet {
            view?.showActivity()
            interactor?.getData(count: "10")
        }
    }

    func getMoreHeros(numberOfHeros: Int) {
        interactor?.getData(count: numberOfHeros.description)
    }


    func interactorDidFetchHeros(with result: Result<[Hero],APIError>) {
        switch result {
        case .success(let heros):
            view?.stopAndHidenActivity(typeOfHUD: .success)
            view?.update(with: heros)
        case .failure(let error):
            view?.stopAndHidenActivity(typeOfHUD: .error)
            view?.update(with: "Hubo un error")
        }
    }
}
