//
//  NotesProtocols.swift
//  Trainee app
//
//  Created by Stanislav Lezovsky on 31.05.2022.
//

import Foundation

protocol CounterDataPassing {
    var dataStore: CounterDataStore { get }
}

protocol CounterDataStore {
    
}

protocol CounterBusinessLogic {
    func requestInitForm(_ request: CounterCleanModel.InitForm.Request)
}

protocol CounterWorkerLogic {}

protocol CounterPresentationLogic {
    func presentInitForm(_ response: CounterCleanModel.InitForm.Response)
}

protocol CounterDisplayLogic: AnyObject {
    func displayInitForm(_ viewModel: CounterCleanModel.InitForm.ViewModel)
}

protocol CounterRoutingLogic {}
