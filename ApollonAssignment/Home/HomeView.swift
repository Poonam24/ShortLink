//
//  ViewController.swift
//  ApollonAssignment
//
//  Created by Poonam on 12/08/21.
//

import UIKit

protocol HomeViewProtocol {
    func viewModelDidUpdate();
    func viewModelUpdateFailed(error : Error);
    func showLoading()
    func hideLoading()
    
    
}

class HomeView: UIViewController {
    
    @IBOutlet weak var defaultView: UIView!
    
    
    @IBOutlet weak var headerView: UIView!
    
    @IBOutlet weak var tableView: UITableView!
    
    var errorMessage = "Please add a link here";
    var placeholder = "Shorten a link here.."
    var viewModel : HomeViewModel!
    var tableDataSource : [ResponseResult] = []
    
    @IBOutlet weak var inputTextField: UITextField!
    
    @IBOutlet weak var shortenURLButton: UIButton!
    
    @IBAction func shortenURL(_ sender: Any) {
        // temp initialization
        //inputTextField.text = "example.org/very/long/link.html";
        
        guard let inputText = inputTextField.text else {
            return
        }
        
        if(inputText.isEmpty) {
            let redColor = UIColor.init(red: 244/255, green: 98/255, blue: 98/255, alpha: 1.0)
            //let redColor = UIColor.init(displayP3Red: 244.0, green: 98.0, blue: 98.0, alpha: 1.0)
            toggleTextField(color: redColor, placeHolderMessage: errorMessage)
        } else {
            
            // call viewModel method to shorten the URL using rxswift and alamofire
            // success case, error case
            // on success call delegate method to come back on view screen and show the result set
            // on error show the failure message
            viewModel.shortenProvidedURL(url: inputText);
        }
    }
    
    func toggleTextField(color : UIColor, placeHolderMessage : String) {
        inputTextField.layer.borderColor = color.cgColor
        inputTextField.layer.borderWidth = 1.0;
        inputTextField.layer.cornerRadius = 6.0;
        let errorMessage = NSMutableAttributedString.init(string: placeHolderMessage);
        let range = NSRange.init(location: 0, length: errorMessage.length);
        errorMessage.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range);
       // errorMessage.addAttribute(NSAttributedString.Key.font, value: 17.0, range: range)
        inputTextField.attributedPlaceholder = errorMessage;
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        viewModel = HomeViewModel();
        viewModel.delegate = self;
        tableView.isHidden = true;
        
        tableView.register(UINib(nibName: "CustomTableCell", bundle: nil), forCellReuseIdentifier: "Cell")

        
    }
    
    var indicator = UIActivityIndicatorView()

    func activityIndicator() {
        indicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        indicator.style = UIActivityIndicatorView.Style.large;
        indicator.center = self.view.center
        self.view.addSubview(indicator)
    }
}


extension HomeView : UITextFieldDelegate {

    func textFieldDidChangeSelection(_ textField: UITextField) {
        toggleTextField(color: UIColor.init(displayP3Red: 158.0, green: 154.0, blue: 167.0, alpha: 1.0), placeHolderMessage: placeholder)
    }
}

extension HomeView : HomeViewProtocol {
    func showLoading() {
        activityIndicator()
        self.view.isUserInteractionEnabled = false;
        indicator.startAnimating()
        indicator.backgroundColor = .white
    }
    
    func hideLoading() {
        indicator.stopAnimating()
        indicator.hidesWhenStopped = true
        self.view.isUserInteractionEnabled = true;
       
    }
    
    func viewModelDidUpdate() {
        // show resultview and hide defaultView
        self.defaultView.isHidden = true;
        self.tableView.isHidden = false;
        self.tableDataSource = []
        self.tableDataSource = viewModel.loadData();
        print("tableDataSourc\(self.tableDataSource)")
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.reloadData();
    }
    
    func viewModelUpdateFailed(error: Error) {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

extension HomeView : UITableViewDelegate {
    
}


extension HomeView : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20;
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return headerView;
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.tableDataSource.count;
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomTableCell
        
        let resultObject : ResponseResult = self.tableDataSource[indexPath.section];
        cell.configureCell(viewModel: self.viewModel, indexPath: indexPath.section, resultObject: resultObject)

        
        return cell;
    }
    
    
}





