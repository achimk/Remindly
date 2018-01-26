//
//  FlowCoordinator.swift
//  Remindly
//
//  Created by Joachim Kret on 26.01.2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation
import CoreApp

final class FlowCoordinator: FlowCoordinatorType {
    private var flows: [FlowType] = []
    private let presenter: ViewPresenter
    
    init(_ presenter: ViewPresenter) {
        self.presenter = presenter
    }
    
    func open(_ flow: FlowType) {
        let current = self.presenter
        let custom: ViewPresenter = CustomPresenter(
            onPresent: { [weak self] view in self?.append(flow); current.present(view) },
            onDismiss: { [weak self] in self?.remove(flow); current.dismiss() }
        )
        
        flow.present(custom)
    }
    
    private func contains(_ flow: FlowType) -> Bool {
        return index(of: flow) != nil
    }
    
    private func index(of flow: FlowType) -> Int? {
        return flows.index { $0 ===  flow }
    }
    
    private func append(_ flow: FlowType) {
        if !contains(flow) {
            flows.append(flow)
        }
    }
    
    private func remove(_ flow: FlowType) {
        if let index = index(of: flow) {
            flows.remove(at: index)
        }
    }
}
