//
//  ViewController.swift
//  EpicList
//
//  Created by Larissa Gonçalves on 9/29/15.
//  Copyright © 2015 Larissa. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var btSelecionar: UIButton!
    @IBOutlet weak var txtCategoria: UITextField!
    @IBOutlet weak var btAdicionar: UIBarButtonItem!
    @IBOutlet weak var progressView: UIProgressView!
    
    var realm: Realm!
    var tarefas = [Task]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        realm = try! Realm()
        let   tarefasArray = realm.objects(Task).map { $0 }
        tarefas = tarefasArray
        
        tableview.delegate = self
        tableview.dataSource = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        return 52.0
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        tableview.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        if section == 0
        {	return 64.0
        }
        
        return 32.0
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tarefas.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellFrame = CGRectMake(0, 0, self.tableview.frame.width, 52.0)
        let retCell = UITableViewCell(frame: cellFrame)
        
        let textLabel = UILabel(frame: CGRectMake(10.0, 0.0, UIScreen.mainScreen().bounds.width - 20.0, 52.0 - 4.0))
        textLabel.textColor = UIColor.blackColor()
        textLabel.text = tarefas[indexPath.row].titulo
        retCell.addSubview(textLabel)
        
        return retCell
    }
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        let done = UITableViewRowAction(style: .Normal, title: "Feito") { action, index in
            print("more button tapped")
        }
        done.backgroundColor = UIColor.greenColor()
        
        
        let delete = UITableViewRowAction(style: .Default, title: "Excluir") { action, index in
            self.deleteTask(indexPath.row)
        }
        delete.backgroundColor = UIColor.redColor()
        
        return [done, delete]
    }
    
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // the cells you would like the actions to appear needs to be editable
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        // you need to implement this method too or you can't swipe to display the actions
    }
    
    func deleteTask(pos : Int){
        let task = tarefas[pos]
        try! realm.write {
            self.realm.delete(task)
        }
        let   tarefasArray = realm.objects(Task).map { $0 }
        tarefas = tarefasArray
        
    }
    
    func doTask(pos : Int){
        let task = tarefas[pos]
        try! realm.write {
            self.realm.delete(task)
        }
        let tarefasArray = realm.objects(Task).map { $0 }
        tarefas = tarefasArray
        
//        let uSet =        UserSet()
//        let level = uSet.getUserLevel()
//        let progresso = uSet.getUserProgress()
       //busca nivel no realm nroNivel
        //verifica nroTarefas com o progresso
        //Se for maior ou igual sobe de nivel e zera o progresso
        //se nao, add +1 no progresso
        // if(leve)
    }
    
    
}

