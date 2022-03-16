//
//  ViewController.swift
//  TODO
//
//balajichandupatla1@gmail.com
//A00245077

//nutakki.shivaramakrishna99@gmail.com
//A00245380

//A00245384 - rohith.god1997@gmail.com
//A00245382 - Alekhyachowdary605@gmail.com

//kavyach23@gmail.com
//A00246628

import UIKit
import Foundation
import CoreData

class TodoListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var todos: [ToDo] = []
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title =  "TODOs"
        let rightButtonItem = UIBarButtonItem.init(image: UIImage(systemName: "plus"), style: .done, target: self, action: #selector(createTodo(_:)))
        self.navigationItem.rightBarButtonItem = rightButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadToDos()
    }
    
    //MARK:- Private methods
    
    private func createTodo(with title: String) {
        let newTodo = ToDo(context: context)
        newTodo.title = title
        newTodo.completed = false
        saveRecordInContext()
        loadToDos()
    }
    
    private func deleteTodo(item: ToDo) {
        context.delete(item)
        
        saveRecordInContext()
        loadToDos()
    }
    
    private func updateTodo(item: ToDo, isComplete: Bool) {
        item.completed = isComplete
        
        saveRecordInContext()
    }
    
    private func saveRecordInContext() {
        do {
            try context.save()
        }
        catch {}
    }
    
    private func loadToDos() {
        do {
            todos = try context.fetch(ToDo.fetchRequest())
            tableView.reloadData()
        }  catch {
            fatalError("This was not supposed to happen")
        }
    }
    
    @objc func completeOnTapped(_ sender: UIButton) {
        sender.isSelected.toggle()
        updateTodo(item: todos[sender.tag], isComplete:sender.isSelected)
        self.tableView.reloadData()
    }
    
    @objc func deleteOnTapped(_ sender: UIButton) {
        deleteTodo(item: todos[sender.tag])
        self.tableView.reloadData()
    }
    
    @objc func createTodo(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Add a new todo", message: "", preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Create", style: .default) { [unowned self] action in
            guard let textField = alert.textFields?.first, let titleToSave = textField.text else { return }
            createTodo(with: titleToSave)
        }
        
        alert.addTextField()
        alert.addAction(saveAction)
        alert.addAction(UIAlertAction(title: "Cancel",style: .cancel))
        
        present(alert, animated: true)
    }
}

extension TodoListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell") as? CustomCell {
            
            let todo = todos[indexPath.row]
            cell.completeBtn.isSelected = todo.completed
            
            cell.completeBtn.tag = indexPath.row
            cell.completeBtn.addTarget(self, action: #selector(completeOnTapped(_:)), for: .touchUpInside)
            
            cell.deleteBtn.tag = indexPath.row
            cell.deleteBtn.addTarget(self, action: #selector(deleteOnTapped(_:)), for: .touchUpInside)
            
            if (todo.completed) {
                let attributedString = NSMutableAttributedString(string: todo.title!)
                attributedString.addAttribute(NSAttributedString.Key.baselineOffset, value: 0, range: NSMakeRange(0, attributedString.length))
                attributedString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: NSNumber(value: NSUnderlineStyle.single.rawValue), range: NSMakeRange(0, attributedString.length))
                attributedString.addAttribute(NSAttributedString.Key.strikethroughColor, value: UIColor.darkGray, range: NSMakeRange(0, attributedString.length))
                
                cell.toDoLbl.attributedText = attributedString
                
            } else {
                let attributedString = NSMutableAttributedString(string: todo.title!)
                cell.toDoLbl.attributedText = attributedString
            }
            return cell
        }
        
        return UITableViewCell()
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }

}

