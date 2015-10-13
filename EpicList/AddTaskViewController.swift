//
//  AddTaskViewController.swift
//  EpicList
//
//  Created by Larissa Gonçalves on 10/13/15.
//  Copyright © 2015 Larissa. All rights reserved.
//

import UIKit
import RealmSwift

class AddTaskViewController: UIViewController{
    
    @IBOutlet weak var txtTitulo: UITextField!
    @IBOutlet weak var txtDescricao: UITextField!
    @IBOutlet weak var txtCategoria: UITextField!
    @IBOutlet weak var txtData: UITextField!
    @IBOutlet weak var imgAdd: UIImageView!
    @IBOutlet weak var btnFeito: UIBarButtonItem!
    
    var realm: Realm!
    var userSet: UserSet!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        realm = try! Realm()
        userSet = UserSet()
        //        let predicate = NSPredicate(format: "nroNivel = %@", userSet.getUserLevel())
        //        let funcionalidade = realm.objects(Nivel).filter(predicate).first
        if(userSet.getUserLevel() == 0){
            imgAdd.hidden = true
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "feitosegue"
        {
            let tarefa = Task()
            let predicate = NSPredicate(format: "descricao = %@", txtDescricao.text!)
            let categorias = realm.objects(Categoria).filter(predicate)
            
            tarefa.titulo = txtTitulo.text!
            tarefa.descricao = txtDescricao.text!
            if(categorias.count == 0){
                let categoria = Categoria()
                categoria.descricao = txtCategoria.text!
                categoria.isRemovivel = true
                realm.write{
                    self.realm.add(categoria)
                }
                tarefa.categoria = categoria
            }else{
                tarefa.categoria = categorias.first
            }
            realm.write{
                self.realm.add(tarefa)
            }
            
        }
    }
    
}