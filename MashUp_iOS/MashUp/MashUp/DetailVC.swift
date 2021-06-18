//
//  DetailVC.swift
//  MashUp
//
//  Created by Hyun on 2021/06/18.
//

import UIKit

class DetailVC: UIViewController {
    var titletext = ""
    var contenttext = ""
    @IBOutlet weak var detailTitle: UILabel!
    @IBOutlet weak var detailContent: UITextView!
    @IBAction func goback(){
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

      
        detailTitle.text = titletext
        detailContent.text = contenttext
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
