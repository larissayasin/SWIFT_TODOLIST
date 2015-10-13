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
    
    var realm: Realm!
    var tarefas: List<Task>
    
    override func viewDidLoad() {
        super.viewDidLoad()
        realm = try! Realm()
        tableview.delegate = self
        tableview.dataSource = self
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tarefas.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
      return nil
    }
    func loadDataFromDB(){
//        let tarefas = realm.objects(Task)
        
    }
    
}

