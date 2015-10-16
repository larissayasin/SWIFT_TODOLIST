//
//  AddTaskViewController.swift
//  EpicList
//
//  Created by Larissa Gonçalves on 10/13/15.
//  Copyright © 2015 Larissa. All rights reserved.
//

import UIKit
import RealmSwift
import MessageUI

class AddTaskViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, MFMailComposeViewControllerDelegate{
    
    @IBOutlet weak var txtTitulo: UITextField!
    @IBOutlet weak var txtDescricao: UITextField!
    @IBOutlet weak var txtCategoria: UITextField!
    @IBOutlet weak var txtData: UITextField!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var btEmail: UIButton!
    @IBOutlet weak var notificacaoStack: UIStackView!
    @IBOutlet weak var switchNotificacao: UISwitch!
    @IBOutlet weak var btFeito: UIButton!
    
    var realm: Realm!
    var userSet: UserSet!
    var dateSelected = NSDate()
    var tarefa = Task()
    var edit = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        realm = try! Realm()
        userSet = UserSet()
        
        if(edit == true){
            txtTitulo.text = tarefa.titulo
            txtDescricao.text = tarefa.descricao
            if(tarefa.data != nil){
                let dateFormatter = NSDateFormatter()
                dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
                dateFormatter.timeStyle = NSDateFormatterStyle.NoStyle
                txtData.text = dateFormatter.stringFromDate(tarefa.data!)
            }
            txtCategoria.text = tarefa.categoria?.descricao
            if(tarefa.imagem != nil){
                photoImageView.image = loadImageFromPath(tarefa.imagem!)
            }
        }
        
        if(userSet.getUserLevel() == 0){
            btEmail.enabled = false
        }else  if(userSet.getUserLevel() == 3){
            btEmail.enabled = true
        }
    }
    
    @IBAction func setDatePicker(sender: UITextField) {
        let datePickerView:UIDatePicker = UIDatePicker()
        
        datePickerView.datePickerMode = UIDatePickerMode.DateAndTime
        
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
        salvarTarefa()
    }
    
    @IBAction func doneClick(sender: AnyObject) {
        salvarTarefa()
        self.dismissViewControllerAnimated(false, completion: nil)
        
        let alertController = UIAlertController(title: "Hey!", message: "Você adicionou uma tarefa", preferredStyle: .Alert)
        
        let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alertController.addAction(defaultAction)
        
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    func salvarTarefa(){
        let predicate = NSPredicate(format: "descricao = %@", txtDescricao.text!)
        let categorias = realm.objects(Categoria).filter(predicate)
        try! realm.write{
            self.tarefa.titulo = self.txtTitulo.text!
            self.tarefa.descricao = self.txtDescricao.text!
            if(categorias.count == 0){
                let categoria = Categoria()
                categoria.descricao = self.txtCategoria.text!
                categoria.isRemovivel = true
                
                self.realm.add(categoria)
                
                self.tarefa.categoria = categoria
            }else{
                self.tarefa.categoria = categorias.first
            }
            if(self.edit == true){
                self.realm.add(self.tarefa, update:true)
                
            }else{
                self.tarefa.id = self.userSet.nextPKTask()
                self.realm.add(self.tarefa)
            }
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
        if(userSet.getUserLevel() < 1){
            showAlert()
            return
        }
        
        // UIImagePickerController is a view controller that lets a user pick media from their photo library.
        let imagePickerController = UIImagePickerController()
        
        // Only allow photos to be picked, not taken.
        imagePickerController.sourceType = .PhotoLibrary
        
        // Make sure ViewController is notified when the user picks an image.
        imagePickerController.delegate = self
        
        presentViewController(imagePickerController, animated: true, completion: nil)
    }
    
    func showAlert(){
        let alertController = UIAlertController(title: "Hey!", message: "Você ainda não chegou no nível necessário", preferredStyle: .Alert)
        
        let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alertController.addAction(defaultAction)
        
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    @IBAction func sendEmail(sender: AnyObject) {
        if(userSet.getUserLevel() < 3){
            showAlert()
            return
        }
        let mailComposeViewController = configuredMailComposeViewController()
        if MFMailComposeViewController.canSendMail() {
            self.presentViewController(mailComposeViewController, animated: true, completion: nil)
        } else {
            self.showSendMailErrorAlert()
        }
    }
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self // Extremely important to set the --mailComposeDelegate-- property, NOT the --delegate-- property
        
        mailComposerVC.setSubject(tarefa.titulo)
        mailComposerVC.setMessageBody(tarefa.description, isHTML: false)
        
        return mailComposerVC
    }
    
    func showSendMailErrorAlert() {
        let sendMailErrorAlert = UIAlertView(title: "Could Not Send Email", message: "Your device could not send e-mail.  Please check e-mail configuration and try again.", delegate: self, cancelButtonTitle: "OK")
        sendMailErrorAlert.show()
    }
    
    // MARK: MFMailComposeViewControllerDelegate
    
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        controller.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    func loadImageFromPath(path: String) -> UIImage? {
        let image = UIImage(contentsOfFile: path)
        if image == nil {
            print("missing image at: (path)")
        }
        print("(path)")
        return image
        
    }
    
}