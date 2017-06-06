//
//  ViewController.swift
//  MemeMeVersion2
//
//  Created by Mark Jainchell on 6/4/17.
//  Copyright © 2017 Mark Jainchell. All rights reserved.
//

import UIKit

class CreateEditMemeViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // MARK: OUTLETS
    
    @IBOutlet weak var memeImageView: UIImageView!
    
    @IBOutlet weak var memeTopText: UITextField!

    @IBOutlet weak var memeBottomText: UITextField!
    
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    
    @IBOutlet weak var toolbarMenu: UIToolbar!
    
    
    
    
    // MARK: PROPERTIES
    
    let memeTextAttributes:[String:Any] = [
        NSStrokeColorAttributeName: UIColor.black,
        NSForegroundColorAttributeName: UIColor.white,
        NSFontAttributeName: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSStrokeWidthAttributeName: -3.0]
    
    let pickImage = UIImagePickerController()
    
    var meme: Meme?
    
    // MARK: FUNCTIONS
    
    // MARK: Text field configuration functions
    
    // The following function has been added and functions refactored based on Code Review
    func configureTextFields(textField: UITextField, startingText: String) {
        textField.delegate = self
        textField.text = startingText
        textField.defaultTextAttributes = memeTextAttributes
        textField.textAlignment = .center
    }
    
    func memeTextStyle() {
        configureTextFields(textField: memeTopText, startingText: "TOP TEXT")
        configureTextFields(textField: memeBottomText, startingText: "BOTTOM TEXT")
    }
    
    // The following function checks to see if the Camera button should be active
    func checkForCamera() {
        // This function has been refactored to use the Ternary Conditional Operator based on Code Review
        UIImagePickerController.isSourceTypeAvailable(.camera) ? (self.cameraButton.isEnabled = true) : (self.cameraButton.isEnabled = false)
    }
    
    // Shruti Choksi provided assistance regaridng using a conditional for the following two functions.
    func keyboardWillShow(_ notification: Notification) {
        if memeBottomText.isFirstResponder {
            view.frame.origin.y = 0 - getKeyboardHeight(notification)
        }
    }
    
    func keyboardWillHide(_ notification: Notification) {
        if memeBottomText.isFirstResponder {
            view.frame.origin.y = 0
        }
    }
    
    func getKeyboardHeight(_ notification: Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        
        return keyboardSize.cgRectValue.height
    }
    
    func subscribeToKeyboardNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
    }
    
    func unsubscribeFromKeyboardNotification() {
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    
    // The following function has been added and functions refactored based on Code Review
    func adjustTextFieldContent(_ textField: UITextField) {
        if textField == memeTopText {
            if textField.text == "TOP TEXT" {
                textField.text = ""
            } else if textField.text == "" {
                textField.text = "TOP TEXT"
            }
        } else if textField == memeBottomText {
            if textField.text == "BOTTOM TEXT" {
                textField.text = ""
            } else if textField.text == "" {
                textField.text = "BOTTOM TEXT"
            }
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        adjustTextFieldContent(textField)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        adjustTextFieldContent(textField)
    }
    
    // MARK: Selecting an Image or taking a photo
    
    // The following function has been added and functions refactored based on Code Review
    func chooseSourceType(sourceType: UIImagePickerControllerSourceType) {
        if sourceType == .photoLibrary {
            pickImage.allowsEditing = false
            pickImage.sourceType = .photoLibrary
            pickImage.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
            present(pickImage, animated: true, completion: nil)
        } else if sourceType == .camera {
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                pickImage.allowsEditing = false
                pickImage.sourceType = UIImagePickerControllerSourceType.camera
                pickImage.cameraCaptureMode = .photo
                pickImage.modalPresentationStyle = .fullScreen
                present(pickImage, animated: true, completion: nil)
            } else {
                NSLog("NO CAMERA")
            }
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        memeImageView.contentMode = .scaleAspectFill
        memeImageView.image = selectedImage
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
/*
    func generateMemedImage() -> UIImage {
        let targetView = view.viewWithTag(1)
        UIGraphicsBeginImageContext((targetView?.frame.size)!)
        targetView?.drawHierarchy(in: (targetView?.frame)!, afterScreenUpdates: true)
        let memedImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return memedImage
    }
*/
    
 func generateMemedImage() -> UIImage {
 
 self.navigationController?.setNavigationBarHidden(true, animated: false)
 self.navigationController?.setToolbarHidden(true, animated: false)
 toolbarMenu.isHidden = true
 
 UIGraphicsBeginImageContext(self.view.frame.size)
 self.view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
 let memedImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
 UIGraphicsEndImageContext()
 
 self.navigationController?.setNavigationBarHidden(false, animated: false)
 self.navigationController?.setToolbarHidden(false, animated: false)
 toolbarMenu.isHidden = false
 
 return memedImage
 }
 
    func saveMeme() {
        // Addition of this conditional based on Code Review
        if memeImageView.image != nil {
            let meme = Meme(topText: memeTopText.text!, bottomText: memeBottomText.text!, originalImage: memeImageView.image!, memedImage: generateMemedImage())
            let object = UIApplication.shared.delegate
            let appDelegate = object as! AppDelegate
            appDelegate.memes.append(meme)
            
            print(appDelegate.memes)
        }
    }
    
    func instantiateMemeTableViewController() {
        var viewController = UINavigationController()
        viewController = self.storyboard?.instantiateViewController(withIdentifier: "TableViewNavigationController") as! UINavigationController
        present(viewController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        pickImage.delegate = self
        memeTextStyle()
        checkForCamera()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        subscribeToKeyboardNotification()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotification()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: ACTIONS
    
    @IBAction func albumButton(_ sender: UIBarButtonItem) {
        chooseSourceType(sourceType: .photoLibrary)
    }
    
    @IBAction func cameraButton(_ sender: UIBarButtonItem) {
        chooseSourceType(sourceType: .camera)
    }

    @IBAction func cancelButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
        print(generateMemedImage())
    }

    @IBAction func saveButton(_ sender: UIBarButtonItem) {
        saveMeme()
        instantiateMemeTableViewController()
        
    }
    
    @IBAction func shareMeme(_ sender: UIBarButtonItem) {
        
        let memeToShare = [generateMemedImage()] as [Any]
        let showShareScreen = UIActivityViewController(activityItems: memeToShare , applicationActivities: nil)
        present(showShareScreen, animated: true, completion: nil)
        
        // This change made based on Code Review, code example sourced from: https://stackoverflow.com/questions/40120922/uiactivityviewcontrollercompletionwithitemshandler-having-error-with-new-update
        showShareScreen.completionWithItemsHandler =  { (activityType: UIActivityType?, completed: Bool, returnedItems: [Any]?, error: Error?) -> Void in
            if completed == true {
                self.saveMeme()
                self.instantiateMemeTableViewController()
            }
        }
    }

}

