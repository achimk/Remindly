//
//  Created by Joachim Kret on 17.05.2018.
//  Copyright © 2018 eSky. All rights reserved.
//

import XCTest
import DataSource

class CombiningDataSourceTests: XCTestCase {
    
    func testAppendingDataSources() {
        
        let ds1 = PlainDataSource(list: [1, 1, 1, 1])
        let ds2 = PlainDataSource(list: [2, 2])
        let ds3 = PlainDataSource(sections: [
                [3, 3, 3],
                [3]
            ])
        let ds4 = PlainDataSource(list: [4, 4, 4])
        let ds5 = PlainDataSource(element: 5)
        
        let ds = CombiningDataSource<Int>()
        
        ds.list.append(ds1)
        ds.list.append(ds2)
        ds.list.append(ds3)
        ds.list.append(ds4)
        ds.list.append(ds5)
        
        XCTAssertEqual(ds.numberOfSections(), 6)
        XCTAssertEqual(ds.numberOfItemsInSection(0), 4)
        XCTAssertEqual(ds.numberOfItemsInSection(1), 2)
        XCTAssertEqual(ds.numberOfItemsInSection(2), 3)
        XCTAssertEqual(ds.numberOfItemsInSection(3), 1)
        XCTAssertEqual(ds.numberOfItemsInSection(4), 3)
        XCTAssertEqual(ds.numberOfItemsInSection(5), 1)
        XCTAssertEqual(ds.numberOfItemsInSection(6), 0)
    }
    
    func testEnumerate() {
        
        func modify<T>(_ input: inout [[T]], with value: T, at indexPath: IndexPath) {
            if input.count > indexPath.section {
                if input[indexPath.section].count > indexPath.row {
                    input[indexPath.section][indexPath.row] = value
                } else {
                    input[indexPath.section].append(value)
                }
            } else {
                input.append(contentsOf: [[value]])
            }
        }
        
        let ds1 = PlainDataSource(list: [1, 1, 1, 1])
        let ds2 = PlainDataSource(list: [2, 2])
        let ds3 = PlainDataSource(sections: [
            [3, 3, 3],
            [3]
        ])
        let dsEmpty = PlainDataSource<Int>(list: [])
        let ds4 = PlainDataSource(list: [4, 4, 4])
        let ds5 = PlainDataSource(element: 5)
        
        let ds = CombiningDataSource<Int>()
        
        ds.list.append(ds1)
        ds.list.append(ds2)
        ds.list.append(ds3)
        ds.list.append(dsEmpty)
        ds.list.append(ds4)
        ds.list.append(ds5)
        
        let input = [
            [1, 1, 1, 1],
            [2, 2],
            [3, 3, 3],
            [3],
            [4, 4, 4],
            [5]
        ]
        
        var result = [
            [0, 0, 0, 0],
            [0, 0],
            [0, 0, 0],
            [0],
            [0, 0, 0],
            [0]
        ]
        
        ds.forEach { (indexPath, value, stop) in
            modify(&result, with: value, at: indexPath)
        }
        
        XCTAssertEqual(input, result)
    }
    
    func testIsEmpty() {
        
        // Given
        let ds = CombiningDataSource<Int>()
        let ds1 = PlainDataSource<Int>(list: [])
        let ds2 = PlainDataSource<Int>(list: [])
        
        ds.list.append(ds1)
        ds.list.append(ds2)
        
        // When
        let isEmpty = ds.isEmpty
        
        // Then
        XCTAssertTrue(isEmpty)
    }
    
    func testIsNotEmpty() {
        
        // Given
        let ds = CombiningDataSource<Int>()
        let ds1 = PlainDataSource<Int>(list: [])
        let ds2 = PlainDataSource<Int>(list: [1])
        
        ds.list.append(ds1)
        ds.list.append(ds2)
        
        // When
        let isEmpty = ds.isEmpty
        
        // Then
        XCTAssertFalse(isEmpty)
    }

}
