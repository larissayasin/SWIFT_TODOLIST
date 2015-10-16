//
//  AddTaskViewController.swift
//  EpicList
//
//  Created by Larissa Gonçalves on 10/13/15.
//  Copyright © 2015 Larissa. All rights reserved.
//

import UIKit
import RealmSwift

class AddTaskViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    @IBOutlet weak var txtTitulo: UITextField!
    @IBOutlet weak var txtDescricao: UITextField!
    @IBOutlet weak var txtCategoria: UITextField!
    @IBOutlet weak var txtData: UITextField!
    @IBOutlet weak var photoImageView: UIImageView!

    @IBOutlet weak var btnFeito: UIBarButtonItem!
    
    @IBOutlet weak var btEmail: UIButton!
    @IBOutlet weak var notificacaoStack: UIStackView!
    
    @IBOutlet weak var switchNotificacao: UISwitch!
    var realm: Realm!
    var userSet: UserSet!
    var isEdit = false
    var dateSelected = NSDate()
    var tarefa = Task()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        realm = try! Realm()
        userSet = UserSet()

        if(userSet.getUserLevel() == 0){
            photoImageView.hidden = true
            btEmail.hidden = true
            notificacaoStack.hidden = true
        }
        if(userSet.getUserLevel() == 1){
             photoImageView.hidden = false
        }
        if(userSet.getUserLevel() == 2){
            notificacaoStack.hidden = false
        }
        if(userSet.getUserLevel() == 3){
            btEmail.hidden = false
        }
    }
    
    @IBAction func setDatePicker(sender: UITextField) {
        let datePickerView:UIDatePicker = UIDatePicker()
        
        datePickerView.datePickerMode = UIDatePickerMode.Date
        
        sender.inputView = datePickerView
        
        datePickerView.addTarget(self, action: Selector("datePickerValueChanged:"), forControlEvents: UIControlEvents.ValueChanged)
    }
    
    func datePickerValueChanged(sender:UIDatePicker) {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
        dateFormatter.timeStyle = NSDateFormatterStyle.NoStyle
        txtData.text = dateFormatter.stringFromDate(sender.date)
        dateSelected = sender.date
        
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?){
        if segue.identifier == "feitosegue"
        {
            try! salvarTarefa()
        }
    }
    
    func salvarTarefa() throws{
        let predicate = NSPredicate(format: "descricao = %@", txtDescricao.text!)
        let categorias = realm.objects(Categoria).filter(predicate)
        
        tarefa.titulo = txtTitulo.text!
        tarefa.descricao = txtDescricao.text!
        if(categorias.count == 0){
            let categoria = Categoria()
            categoria.descricao = txtCategoria.text!
            categoria.isRemovivel = true
            try  realm.write{
                self.realm.add(categoria)
            }
            tarefa.categoria = categoria
        }else{
            tarefa.categoria = categorias.first
        }
        try realm.write{
            self.realm.add(self.tarefa)
        }
    }
    
    // MARK: UIImagePickerControllerDelegate
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        // Dismiss the picker if the user canceled.
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        // The info dictionary contains multiple representations of the image, and this uses the original.
        let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        // Set photoImageView to display the selected image.
        photoImageView.image = selectedImage
        
        // Dismiss the picker.
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: Actions
    @IBAction func selectImageFromPhotoLibrary(sender: UITapGestureRecognizer) {
        // Hide the keyboard.
      //  nameTextField.resignFirstResponder()
        
        // UIImagePickerController is a view controller that lets a user pick media from their photo library.
        let imagePickerController = UIImagePickerController()
        
        // Only allow photos to be picked, not taken.
        imagePickerController.sourceType = .PhotoLibrary
        
        // Make sure ViewController is notified when the user picks an image.
        imagePickerController.delegate = self
        
        presentViewController(imagePickerController, animated: true, completion: nil)
    }

    
}