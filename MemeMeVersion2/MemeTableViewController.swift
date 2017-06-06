//
//  MemeTableViewController.swift
//  MemeMeVersion2
//
//  Created by Mark Jainchell on 6/4/17.
//  Copyright © 2017 Mark Jainchell. All rights reserved.
//

import UIKit

class MemeTableViewController: UITableViewController {
    
    // MARK: PROPERTIES
    var memes = [Meme]()
    var finishedMemeToSend: UIImage!
    var memeIndexToSend: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        memes = appDelegate.memes
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
        print(memes.count)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
