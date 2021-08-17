//
//  ViewModel.swift
//  ApollonAssignment
//
//  Created by Poonam on 13/08/21.
//

import Foundation
import RxSwift

class HomeViewModel {
    var model : HomeModel?
    var appClient : APIClient = APIClient();
    var storageManager : StorageManager = StorageManager();
    var parsedResponse : [ResponseResult] =  [];
    var delegate : HomeViewProtocol?
    private let disposeBag = DisposeBag()
    
    func shortenProvidedURL(url : String) {
        self.model?.urlToBeShortened = url;
        self.delegate?.showLoading();
        appClient.shortenProvidedURL(url: url).subscribe(
            onNext: { [self] response in
                print(response);
                // add this response into an array which needs to be passed
                self.parsedResponse.append(response.result);
                self.saveData(dataToBeSaved: self.parsedResponse)
                
            },
            onError: { [self] error in
                self.delegate?.viewModelUpdateFailed(error: error)
                self.delegate?.hideLoading();
            }
        ).disposed(by: disposeBag)
    }
    func saveData(dataToBeSaved : [ResponseResult]) {
        storageManager.saveData(dataToBeSaved: self.parsedResponse);
        self.delegate?.hideLoading();
        self.delegate?.viewModelDidUpdate();
    }
    
    func loadData() -> [ResponseResult] {
        // call from storagemanager
        return storageManager.loadData()
    }
    
    func removeLinkAtIndex(indexToBeDeleted : Int)  {
        self.delegate?.showLoading();
        storageManager.removeLinkAtIndex(index: indexToBeDeleted)
        self.delegate?.hideLoading();
        self.delegate?.viewModelDidUpdate();
    }
}
