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
    var tarefas: Results<Task>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        realm = try! Realm()
        tarefas = realm.objects(Task)
       
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
        return tarefas!.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellFrame = CGRectMake(0, 0, self.tableview.frame.width, 52.0)
        let retCell = UITableViewCell(frame: cellFrame)
        
        let textLabel = UILabel(frame: CGRectMake(10.0, 0.0, UIScreen.mainScreen().bounds.width - 20.0, 52.0 - 4.0))
        textLabel.textColor = UIColor.blackColor()
        //  textLabel.text = tarefas[indexPath.row].titulo
        retCell.addSubview(textLabel)
        
        return retCell
        
    }
    
}

