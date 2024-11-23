//
//  Delegate.swift
//  PulseInsights
//
//  Created by LeoChao on 2020/04/14.
//  Copyright © 2020 Pulse Insights. All rights reserved.
//

import Foundation

class Delegate<Input, Output> {
    private var block: ((Input) -> Output?)?

    func delegate<T: AnyObject>(on target: T, block: ((T, Input) -> Output)?) {
        self.block = { [weak target] input in
            guard let target = target else {
                return nil
            }

            return block?(target, input)
        }
    }

    func call(_ input: Input) -> Output? {
        return block?(input)
    }
}

extension Delegate where Input == Void {
    func call() -> Output? {
        return call(())
    }
}
