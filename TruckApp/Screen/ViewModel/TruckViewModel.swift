//
//  TruckViewModel.swift
//  TruckApp
//
//  Created by SAGAR SINGH on 01/04/24.
//

import Foundation

class TruckViewModel {
    //MARK: - PROPERTIES.
    let apiManager: ServiceProtocol
    var truckInfo: [TruckDataModel] = []
    var eventhandler: ((_ event: eventHandler) -> Void)?
    
    init(apiManager: ServiceProtocol = APIManager()) {
        self.apiManager = apiManager
    }
    
    /// FUNCTION TO REQUEST TRUCK INFO.
    func requestTruckInfo() {
        eventhandler?(.startLoading)
        apiManager.request(model: TruckModel.self, reqDescription: Endpoint.test) { response in
            self.eventhandler?(.stopLoading)
            
            switch response {
            case .success(let result):
                self.truckInfo = result.data ?? []
                self.eventhandler?(.dataLoaded)
            case .failure(let error):
                print(error)
                self.eventhandler?(.error(error))
            }
            
        }
    }
}

/// ENUM TO HANDLE API EVENTS.
extension TruckViewModel {
    enum eventHandler {
        case startLoading
        case stopLoading
        case dataLoaded
        case error(Error?)
    }
}
