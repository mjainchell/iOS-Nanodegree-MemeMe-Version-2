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
    var memeIndexToReceive: Int?
    var meme: Meme?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        memedImagePresentation = meme?.memedImage
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.memeDetailImageView.image = memedImagePresentation
        self.tabBarController?.tabBar.isHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EditMemeSegue" {
            let viewController = segue.destination as! CreateEditMemeViewController
            // Shruti Choksi provided assistance regarding how to use the Meme object in this context
            viewController.meme = meme
            viewController.receivedIndexOfExistingMeme = memeIndexToReceive
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
