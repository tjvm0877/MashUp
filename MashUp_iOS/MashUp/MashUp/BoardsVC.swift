//
//  BoardsVC.swift
//  MashUp
//
//  Created by Hyun on 2021/06/18.
//

import UIKit
import Alamofire

class BoardsVC: UIViewController {
    
    let categorys = ["모든 게시물", "Netflix", "Watcha", "Wavve", "닌텐도 온라인", "LoL", "PBUG", "OverWatch",  "it takes two"]
    
    var dataSource: [Contact] = []
    
    
    @IBOutlet weak var CategoryName: UILabel!
    @IBOutlet weak var BoardTableView: UITableView!
    @IBAction func touched(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let cellSelect = storyboard.instantiateViewController(identifier: "CreateBoardView") as? CreateBoardVC {
            self.navigationController?.pushViewController(cellSelect, animated: true)
        }
    }
    var selectedCategorty:Int = 0
    
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(true)
            
            //perform api call if any
            BoardTableView.reloadData()
            
        }
    override func viewDidLoad() {
        super.viewDidLoad()
        getBoards()
        BoardTableView.delegate = self
        BoardTableView.dataSource = self
        swipeRecognizer()
        CategoryName.text = categorys[selectedCategorty]
    }
    func getBoards() {
        var url = "http://localhost:8080/board/get/boards"
        if selectedCategorty == 0 {
            url = "http://localhost:8080/board/get/boards"
        }else {
            url = "http://localhost:8080/board/get/category/\(selectedCategorty)"
            
        }
        
        AF.request(url,
                  method: .get,
                  encoding: URLEncoding.default,
                  headers: ["Content-Type": "application/json;charset", "Accept": "application/json"])
            .responseJSON{ (response) in
                switch response.result {
                case .success(let res):
                    do {
                        let jsonData = try JSONSerialization.data(withJSONObject: res, options: .prettyPrinted)
                        let json = try JSONDecoder().decode([Contact].self, from: jsonData)
                        self.dataSource = json
                        DispatchQueue.main.async {
                            self.BoardTableView.reloadData()
                        }
                    }catch(let err) {
                        print(err.localizedDescription)
                    }
                case .failure(let e):
                    print(e.localizedDescription)
                }
            }
    }
    
    func swipeRecognizer() {
            let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture(_:)))
            swipeRight.direction = UISwipeGestureRecognizer.Direction.right
            self.view.addGestureRecognizer(swipeRight)
            
        }
    @objc func respondToSwipeGesture(_ gesture: UIGestureRecognizer){
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction{
            case UISwipeGestureRecognizer.Direction.right:
                self.navigationController?.popViewController(animated: true)
                self.dismiss(animated: true, completion: nil)
            default: break
            }
        }
    }
}

extension BoardsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataSource.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = BoardTableView.dequeueReusableCell(withIdentifier: "boardCell") as! boardCell
        
        cell.title.text = dataSource[dataSource.count - indexPath.row - 1].title
        cell.date.text = dataSource[dataSource.count - indexPath.row - 1].createdate
        cell.headCount.text = "\(dataSource[dataSource.count - indexPath.row - 1].headcount) / \(dataSource[dataSource.count - indexPath.row - 1].max)"
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let cellSelect = storyboard.instantiateViewController(identifier: "DetailView") as? DetailVC {
            cellSelect.titletext = dataSource[dataSource.count - indexPath.row - 1].title
            cellSelect.contenttext = dataSource[dataSource.count - indexPath.row - 1].content
            self.navigationController?.pushViewController(cellSelect, animated: true)
        }
    }
    
}

class boardCell: UITableViewCell {
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var headCount: UILabel!
}
