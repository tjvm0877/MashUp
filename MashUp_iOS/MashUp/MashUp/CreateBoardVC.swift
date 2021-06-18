//
//  createBoard.swift
//  MashUp
//
//  Created by Hyun on 2021/06/18.
//

import UIKit
import Alamofire

class CreateBoardVC: UIViewController, UITextFieldDelegate, UIPickerViewDelegate,  UIPickerViewDataSource {
    @IBOutlet weak var mashupTitle: UITextField!
    @IBOutlet weak var mashupContent: UITextView!
    @IBOutlet weak var maxheadCount: UITextField!
    @IBOutlet weak var categorySelect: UITextField!
    
    var selectCategory = ""
    let pickerView = UIPickerView()
    var selectedpicker = 0
    
    let categorys = ["없음", "Netflix", "Watcha", "Wavve", "닌텐도 온라인", "LoL", "PBUG", "OverWatch",  "it takes two"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 220)
        pickerView.delegate = self
        pickerView.dataSource = self
        
        // 피커뷰 툴바추가
        let pickerToolbar : UIToolbar = UIToolbar()
        pickerToolbar.barStyle = .default
        pickerToolbar.isTranslucent = true  // 툴바가 반투명인지 여부 (true-반투명, false-투명)
        pickerToolbar.backgroundColor = .lightGray
        pickerToolbar.sizeToFit()   // 서브뷰만큼 툴바 크기를 맞춤
        // 피커뷰 툴바에 확인/취소 버튼추가
        let btnDone = UIBarButtonItem(title: "확인", style: .done, target: self, action: #selector(onPickDone))
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let btnCancel = UIBarButtonItem(title: "취소", style: .done, target: self, action: #selector(onPickCancel))
        pickerToolbar.setItems([btnCancel , space , btnDone], animated: true)   // 버튼추가
        pickerToolbar.isUserInteractionEnabled = true   // 사용자 클릭 이벤트 전달
        
        categorySelect.inputView = pickerView // 피커뷰 추가
        categorySelect.inputAccessoryView = pickerToolbar // 피커뷰 툴바 추가
        
    }
    @IBAction func cancel(){
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @objc func onPickDone() {
        categorySelect.text = selectCategory
        categorySelect.resignFirstResponder()
        selectCategory = ""
      }
    @objc func onPickCancel() {
        categorySelect.resignFirstResponder() // 피커뷰를 내림 (텍스트필드가 responder 상태를 읽음)
        selectCategory = ""
      }
    
    // 피커뷰의 구성요소(컬럼) 수
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1    // 구성요소(컬럼)로 지역만 있으므로 1을 리턴
    }
    
    // 구성요소(컬럼)의 행수
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categorys.count
    }
 
    // 피커뷰에 보여줄 값 전달
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categorys[row]
    }
    
    // 피커뷰에서 선택시 호출
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedpicker = row
        selectCategory = categorys[row]
    }
    @IBAction func upload(_ sender: Any) {
        let url = "http://localhost:8080/board/post"
//        let url = "https://ptsv2.com/t/7970f-1623995609/post"
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.timeoutInterval = 10

        let postTitle:String = mashupTitle.text!
        let postcontent:String = mashupTitle.text!
//        let postheadcount:String = maxheadCount.text!
//        let postcategory:Int = 1
//        let postmax = mashupTitle.text
        
        let param = ["title" : "test",
                     "content" : postcontent,
                     "headcount":"3",
                     "max" : "1",
                     "category" : "1"]
        
        do {
            try request.httpBody = JSONSerialization.data(withJSONObject: param, options: [])
        } catch {
            print("http err")
        }
        
        AF.request(request).responseString{ (response) in
            switch response.result{
            case .success:
                print("bb")
                self.navigationController?.popViewController(animated: true)
                
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
}
