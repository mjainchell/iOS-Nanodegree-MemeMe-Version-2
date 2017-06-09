//
//  MemeTableViewController.swift
//  MemeMeVersion2
//
//  Created by Mark Jainchell on 6/4/17.
//  Copyright © 2017 Mark Jainchell. All rights reserved.
//

import UIKit

class MemeTableViewController: UITableViewController, UITabBarControllerDelegate {
    
    // MARK: PROPERTIES
    
    // memes property has been changed based on code review
    var memes: [Meme] {
        return (UIApplication.shared.delegate as! AppDelegate).memes
    }
    var finishedMemeToSend: UIImage!
    var memeIndexToSend: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {

        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return memes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "memeTableViewCell", for: indexPath) as! MemeTableViewCell
        let meme = memes[indexPath.row]
        cell.tableCellMemeImage.image = meme.memedImage
        cell.tableCellTopText.text = meme.topText
        cell.tableCellBottomText.text = meme.bottomText

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        finishedMemeToSend = memes[indexPath.row].memedImage
        memeIndexToSend = memes.index { (targetMeme) -> Bool in
            targetMeme.memedImage == finishedMemeToSend
        }
        self.performSegue(withIdentifier: "ShowDetailSegue", sender: indexPath)
    }
    
    // This function has been added based on code review
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let object = UIApplication.shared.delegate
            let appDelegate = object as! AppDelegate
            appDelegate.memes.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if segue.identifier == "ShowDetailSegue" {
            let viewController = segue.destination as! MemeDetailViewController
            let indexPath = sender as! IndexPath
            let meme = memes[indexPath.row]
            // Shruti Choksi provided assistance regarding how to use the Meme object in this context.
            viewController.meme = meme
            viewController.memeIndexToReceive = memeIndexToSend
        }
    }

}
