//
//  Wireframe.swift
//  MarvelProyect
//
//  Created by Ricardo Sanchez on 12/4/22.
//

import Foundation
import UIKit

typealias EntryPoint = AnyView & UIViewController

protocol AnyWireframe {
    var entry: EntryPoint? { get }
    static func start() -> AnyWireframe
}

class HomeWireframe: AnyWireframe {
    weak var entry: EntryPoint?

    static func start() -> AnyWireframe {
        let wireframe = HomeWireframe()

        //Assign VIP
        var view: AnyView = HomeViewController()
        var presenter: AnyPresenter = HomePresenter()
        var interactor: AnyInteractor = HomeInteractor()


        view.presenter = presenter
        interactor.presenter = presenter
        presenter.wireframe = wireframe
        presenter.view = view
        presenter.interactor = interactor

        wireframe.entry = view as? EntryPoint

        return wireframe
    }
}
