//
//  ViewController.swift
//  HomeWork_2_4_5_b_VIPER
//
//  Created by Vlad Ralovich on 2/20/21.
//

import UIKit

protocol ViewProtocol {
    var tableView: UITableView {get}
    var textField: UITextField {get}
}

class ViewController: UIViewController, ViewProtocol {

    @IBOutlet weak var myTextField: UITextField!
    @IBOutlet weak var taslTableView: UITableView!
    @IBOutlet weak var bottomAnchorTextField: NSLayoutConstraint!
    @IBOutlet weak var leftAnchorTextField: NSLayoutConstraint!
    @IBOutlet weak var rightAnchorTextField: NSLayoutConstraint!
    
    var presenter: PresenterProtocol!
    var configurator: ConfiguratorProtocol = Configurator()
   
    var tableView: UITableView {
        get { return taslTableView }
    }
    var textField: UITextField {
        get { return myTextField}
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: nil) { (nc) in
            self.bottomAnchorTextField.constant = 320
            self.leftAnchorTextField.constant = 8
            self.rightAnchorTextField.constant = 8
        }
        
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: nil) { (nc) in
            self.bottomAnchorTextField.constant = 16
            self.leftAnchorTextField.constant = 120
            self.rightAnchorTextField.constant = 120
            self.myTextField.text = nil
        }
        tableView.rowHeight = 60
        textField.layer.cornerRadius = 15
        configurator.configurate(with: self)
        presenter.configurateView()
    }
}

//MARK:- extension ViewController
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.indexToDeleteTask(index: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return presenter.configurateCell(tableView: tableView, indexPath: indexPath)
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if let text = self.myTextField.text {
            presenter.textInTextField(text: text)
        }
        
        if textField == myTextField {
            self.myTextField.resignFirstResponder()
        }
        return true
    }
}
