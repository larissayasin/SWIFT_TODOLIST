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
    var userSet: UserSet!
    var chosenCellIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        realm = try! Realm()
        userSet = UserSet()
        
        let   tarefasArray = realm.objects(Task).map { $0 }
        tarefas = tarefasArray
        let nivelProgresso = userSet.getUserLevel()+1
        let predicate = NSPredicate(format: "nroNivel = %i", nivelProgresso)
        let level = realm.objects(Nivel).filter(predicate)
        let progressoTotal = level[0].nroAtividades
        let progressFloat = Float(userSet.getUserProgress())/Float(progressoTotal)
        progressView.setProgress(progressFloat, animated: true)
        
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
        performSegueWithIdentifier("cellsegue", sender: nil)
        chosenCellIndex = indexPath.row
    }
    
    func transition(Sender: UIButton!) {
        let secondViewController:AddTaskViewController = AddTaskViewController()
        
        self.presentViewController(secondViewController, animated: true, completion: nil)
        
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
            self.doTask(indexPath.row)
            print("done button tapped")
        }
        done.backgroundColor = UIColor.greenColor()
        
        
        let delete = UITableViewRowAction(style: .Default, title: "Excluir") { action, index in
            self.deleteTask(indexPath.row)
            print("delete button tapped")
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
        self.tableview.reloadData()
        
    }
    
    func doTask(pos : Int){
        let predicate = NSPredicate(format: "nroNivel = %i", userSet.getUserLevel()+1)
        let level = realm.objects(Nivel).filter(predicate)
        if(level.count>0){
            var nroAtividades = level[0].nroAtividades
            userSet.changeUserProgress(userSet.getUserProgress()+1)
            if(userSet.getUserProgress() >= nroAtividades){
                userSet.changeUserProgress(0)
                userSet.changeUserLevel(userSet.getUserLevel()+1)
                let predicate2 = NSPredicate(format: "nroNivel = %i", userSet.getUserLevel()+1)
                let level2 = realm.objects(Nivel).filter(predicate2)
                nroAtividades = level2[0].nroAtividades
                showAlert()
            }
            
            let task = tarefas[pos]
            try! realm.write {
                self.realm.delete(task)
            }
            let tarefasArray = realm.objects(Task).map { $0 }
            tarefas = tarefasArray
            self.tableview.reloadData()
            let progresso = Float(userSet.getUserProgress())/Float(nroAtividades)
            self.progressView.setProgress(progresso, animated: true)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "cellsegue") {
            let svc = segue.destinationViewController as! AddTaskViewController
            svc.tarefa = tarefas[chosenCellIndex]
            svc.edit = true
        }
    }
    
    func showAlert(){
        let alertController = UIAlertController(title: "Hey!", message: "Você subiu de nível!!", preferredStyle: .Alert)
        
        let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alertController.addAction(defaultAction)
        
        presentViewController(alertController, animated: true, completion: nil)
    }
    override func viewDidAppear(animated: Bool) {
        let   tarefasArray = realm.objects(Task).map { $0 }
        tarefas = tarefasArray
        self.tableview.reloadData()
    }
}

