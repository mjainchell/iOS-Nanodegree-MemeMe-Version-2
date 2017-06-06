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
    var memeOriginalImageToSend: UIImage!
    var memeOriginalTopTextToSend: String!
    var memeOriginalBottomTextToSend: String!
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
        memeOriginalImageToSend = memes[indexPath.row].originalImage
        memeOriginalTopTextToSend = memes[indexPath.row].topText
        memeOriginalBottomTextToSend = memes[indexPath.row].bottomText
        
        memeIndexToSend = memes.index { (targetMeme) -> Bool in
            targetMeme.memedImage == finishedMemeToSend
        }
        
        self.performSegue(withIdentifier: "ShowDetailSegue", sender: indexPath)
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if segue.identifier == "ShowDetailSegue" {
            let viewController = segue.destination as! MemeDetailViewController
            viewController.memedImagePresentation = finishedMemeToSend
            viewController.memeOriginalImageToReceive = memeOriginalImageToSend
            viewController.memeOriginalTopTextToReceive = memeOriginalTopTextToSend
            viewController.memeOriginalBottomTextToReceive = memeOriginalBottomTextToSend
            viewController.memeIndexToReceive = memeIndexToSend
        }
    }

}
