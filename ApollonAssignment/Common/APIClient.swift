//
//  APIClient.swift
//  ApollonAssignment
//
//  Created by Poonam on 13/08/21.
//

import Foundation
import Alamofire
import RxSwift

class APIClient {
//    1    No URL specified ("url" parameter is empty)
//    2    Invalid URL submitted
//    3    Rate limit reached. Wait a second and try again
//    4    IP-Address has been blocked because of violating our terms of service
//    5    shrtcode code (slug) already taken/in use
//    6    Unknown error
//    7    No code specified ("code" parameter is empty)
//    8    Invalid code submitted (code not found/there is no such short-link)
//    9    Missing required parameters
//    10    Trying to shorten a disallowed Link. More information on disallowed links
    
    // MARK: - GetFriends
    enum APIClientFailureReason: Int, Error {
        case noURLSpecified
        case invalidURL
        case rateLimitExhausted
        case ipBlocked
        case shortCodeAlreadyInUse
        case unknown
        case noCode
        case invalidCode
        case missingParam
        case disallowedLink
        case badRequest = 400
        
    }
    
    
    func shortenProvidedURL(url : String) -> Observable<Response> {
        let constructedURL = URL.init(string : "https://api.shrtco.de/v2/shorten?url=\(url)")
        
        let request = URLRequest.init(url: constructedURL!);
        
        return Observable.create { observer -> Disposable in
            AF.request(request)
                    .validate()
                    .responseJSON { response in
                        switch response.result {
                        case .success:
                            
                            guard let data = response.data else {
                                // if no error provided by alamofire return .unknown error
                                observer.onError(response.error ?? APIClientFailureReason.unknown)
                                return
                            }
                            do {
                                
                                let response = try JSONDecoder().decode(Response.self, from: data)
                                observer.onNext(response)
                            } catch {
                                observer.onError(error)
                            }
                        case .failure(let error):
                            if let statusCode = response.response?.statusCode,
                                let reason = APIClientFailureReason(rawValue: statusCode)
                            {
                                observer.onError(reason)
                            }
                            observer.onError(error)
                        }
                }

                return Disposables.create()
            }
        }
}
