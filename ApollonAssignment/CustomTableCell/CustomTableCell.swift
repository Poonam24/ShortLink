//
//  CustomTableCell.swift
//  ApollonAssignment
//
//  Created by Poonam on 14/08/21.
//

import Foundation
import UIKit

class CustomTableCell: UITableViewCell {
    
    var viewModel : HomeViewModel?
    
    @IBOutlet weak var outerStackView: UIStackView!
    
    @IBOutlet weak var originalLink: UILabel!
    
    @IBOutlet weak var shortenLink: UILabel!
    
    @IBOutlet weak var copyButton: UIButton!
     
    @IBOutlet weak var deleteButton: UIButton!
    
    @IBAction func copyToClipboard(_ sender: UIButton) {
        print(sender.tag);
        let fetchedData = viewModel?.loadData()
        let shortURL = fetchedData?[sender.tag].short_link
        // copy shortURL to clipboard
        UIPasteboard.general.string = shortURL;
        copyButton.setTitle("COPIED!", for: UIControl.State.normal);
        copyButton.backgroundColor = UIColor.init(red: 59/255, green: 48/255, blue: 84/255, alpha: 1.0)
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
    }

    
    @IBAction func deleteTheLink(_ sender: UIButton) {
       // print(sender.tag);
        // remove data from viewmodel file
        viewModel?.removeLinkAtIndex(indexToBeDeleted: sender.tag)
        
        
    }
    
    func configureCell(viewModel: HomeViewModel, indexPath : Int, resultObject : ResponseResult) {
        self.viewModel = viewModel;
        self.layer.borderColor = UIColor.clear.cgColor;
        self.layer.borderWidth = 1.0;
        self.layer.cornerRadius = 6.0;
        
        self.originalLink.text = resultObject.original_link
        self.shortenLink.text = resultObject.short_link
        self.deleteButton.tag = indexPath
        self.copyButton.tag = indexPath
        
    }
    
}
