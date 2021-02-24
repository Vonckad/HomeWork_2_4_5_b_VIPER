//
//  Interactor.swift
//  HomeWork_2_4_5_b_VIPER
//
//  Created by Vlad Ralovich on 2/20/21.
//

import Foundation
import UIKit
import RealmSwift

protocol InteractorProtocol: class {
    
    func load()
    var  count: Int {get}
    func getTaskName(indexPath: IndexPath) -> String
    func addTask(text: String)
    func deleteTask(index: Int)
}

class Interactor: InteractorProtocol {
    
    private var realm: Realm!
    var todoList: Results<PersistanceRealm> {
        get { return realm.objects(PersistanceRealm.self)}
    }
    
    weak var presenter: PresenterProtocol!
    
    var count: Int {
        get { todoList.count }
    }
  
    func getTaskName(indexPath: IndexPath) -> String {
        return todoList[indexPath.row].name
    }
    
    func addTask(text: String) {
        
        let item = PersistanceRealm()
        item.name = text
        try! realm.write({
            self.realm.add(item)
            presenter.updateView()
        })
    }
    
    func deleteTask(index: Int) {
        try! realm.write({
            realm.delete(todoList[index])
            presenter.updateView()
        })
    }
    
    init(presenter: PresenterProtocol) {
        self.presenter = presenter
    }
    
    func load() {
        realm = try! Realm()
    }
}
