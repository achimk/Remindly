//
//  Types.swift
//  Functional
//
//  Created by Joachim Kret on 05.01.2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

public typealias Pair<A, B> = Product<A, B>

public typealias Either<A, B> = Coproduct<A, B>

public typealias Function<A, B> = Reader<A, B>

