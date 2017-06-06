//
//  MemeDetailViewController.swift
//  MemeMeVersion2
//
//  Created by Mark Jainchell on 6/4/17.
//  Copyright © 2017 Mark Jainchell. All rights reserved.
//

import UIKit

class MemeDetailViewController: UIViewController {

    @IBOutlet weak var memeDetailImageView: UIImageView!
    
    var memedImagePresentation: UIImage!
    
    var memeOriginalImageToReceive: UIImage?
    var memeOriginalTopTextToReceive: String?
    var memeOriginalBottomTextToReceive: String?

    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.memeDetailImageView.image = memedImagePresentation
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EditMemeSegue" {
            let viewController = segue.destination as! CreateEditMemeViewController
            let _ = viewController.view
            viewController.memeTopText.text = memeOriginalTopTextToReceive
            viewController.memeBottomText.text = memeOriginalBottomTextToReceive
            viewController.memeImageView.image = memeOriginalImageToReceive
        }
    }

    
    // MARK: ACTIONS
    
    @IBAction func doneWithMemeDetailViewButton(_ sender: UIBarButtonItem) {
        var viewController = UINavigationController()
        
        viewController = self.storyboard?.instantiateViewController(withIdentifier: "TableViewNavigationController") as! UINavigationController

        present(viewController, animated: true, completion: nil)
    }
    
    @IBAction func editCurrentMeme(_ sender: UIBarButtonItem) {        
        performSegue(withIdentifier: "EditMemeSegue", sender: sender)
    }

    

}
