//
//  Presenter.swift
//  HomeWork_2_4_5_b_VIPER
//
//  Created by Vlad Ralovich on 2/20/21.
//

import Foundation
import UIKit

protocol PresenterProtocol: class {
    
    var count: Int {get}
    func configurateCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell
    func configurateView()
    func updateView()
    func textInTextField(text: String)
    func indexToDeleteTask(index: Int)
}

class Presenter: PresenterProtocol {

    var view: ViewProtocol!
    var interactor: InteractorProtocol!
    
    var count: Int {
        get { interactor.count }
    }

    init(view: ViewProtocol) {
        self.view = view
    }
    
    func updateView() {
        view.tableView.reloadData()
    }
    
    func textInTextField(text: String) {
        interactor.addTask(text: text)
    }
    
    func indexToDeleteTask(index: Int) {
        interactor.deleteTask(index: index)
    }
    
    func configurateCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = interactor.getTaskName(indexPath: indexPath)
        cell.layer.cornerRadius = 30
        cell.layer.borderWidth = 10
        cell.layer.borderColor = UIColor.systemGray4.cgColor
        return cell
    }
    
    func configurateView() {
        interactor.load()
        view.tableView.layer.cornerRadius = 15
    }
}
