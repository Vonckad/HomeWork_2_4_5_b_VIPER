//
//  Configurator.swift
//  HomeWork_2_4_5_b_VIPER
//
//  Created by Vlad Ralovich on 2/20/21.
//

import Foundation

protocol ConfiguratorProtocol: class {
    func configurate(with viewController: ViewController)
}

class Configurator: ConfiguratorProtocol {
    func configurate(with viewController: ViewController) {
        let presenter = Presenter(view: viewController)
        let interactor = Interactor(presenter: presenter)

        viewController.presenter = presenter
        presenter.interactor = interactor
    }
}
