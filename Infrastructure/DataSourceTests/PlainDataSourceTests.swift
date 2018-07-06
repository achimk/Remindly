//
//  Created by Joachim Kret on 17.05.2018.
//  Copyright © 2018 eSky. All rights reserved.
//

import XCTest
import DataSource

class PlainDataSourceTests: XCTestCase {
    
    func testInitializeWithOneElement() {
        
        let ds = PlainDataSource(element: 1)
        
        XCTAssertEqual(ds.numberOfSections(), 1)
        XCTAssertEqual(ds.numberOfItemsInSection(0), 1)
        XCTAssertEqual(ds.numberOfItemsInSection(1), 0)
        XCTAssertEqual(ds.item(at: IndexPath(item: 0, section: 0)), 1)
    }
    
    func testInitializeWithManyElements() {
        
        let ds = PlainDataSource(list: [1, 2, 3])
        
        XCTAssertEqual(ds.numberOfSections(), 1)
        XCTAssertEqual(ds.numberOfItemsInSection(0), 3)
        XCTAssertEqual(ds.numberOfItemsInSection(1), 0)
        XCTAssertEqual(ds.item(at: IndexPath(item: 0, section: 0)), 1)
        XCTAssertEqual(ds.item(at: IndexPath(item: 1, section: 0)), 2)
        XCTAssertEqual(ds.item(at: IndexPath(item: 2, section: 0)), 3)
    }
    
    func testInitializeWithSections() {
        
        let ds = PlainDataSource(sections: [
            [1, 1, 1],
            [2, 2, 2],
            [3, 3, 3]
        ])
        
        XCTAssertEqual(ds.numberOfSections(), 3)
        XCTAssertEqual(ds.numberOfItemsInSection(0), 3)
        XCTAssertEqual(ds.numberOfItemsInSection(1), 3)
        XCTAssertEqual(ds.numberOfItemsInSection(2), 3)
        XCTAssertEqual(ds.numberOfItemsInSection(3), 0)
        
        XCTAssertEqual(ds.item(at: IndexPath(item: 0, section: 0)), 1)
        XCTAssertEqual(ds.item(at: IndexPath(item: 1, section: 0)), 1)
        XCTAssertEqual(ds.item(at: IndexPath(item: 2, section: 0)), 1)
        
        XCTAssertEqual(ds.item(at: IndexPath(item: 0, section: 1)), 2)
        XCTAssertEqual(ds.item(at: IndexPath(item: 1, section: 1)), 2)
        XCTAssertEqual(ds.item(at: IndexPath(item: 2, section: 1)), 2)
        
        XCTAssertEqual(ds.item(at: IndexPath(item: 0, section: 2)), 3)
        XCTAssertEqual(ds.item(at: IndexPath(item: 1, section: 2)), 3)
        XCTAssertEqual(ds.item(at: IndexPath(item: 2, section: 2)), 3)
    }
    
    func testEnumarate() {
        
        func modify<T>(_ input: inout [[T]], with value: T, at indexPath: IndexPath) {
            if input.count > indexPath.section {
                if input[indexPath.section].count > indexPath.row {
                    input[indexPath.section][indexPath.row] = value
                }
            }
        }
        
        let input = [
            [1, 1, 1],
            [2, 2, 2],
            [3, 3, 3]
        ]
        
        var result = [
            [0, 0, 0],
            [0, 0, 0],
            [0, 0, 0]
        ]
        
        let ds = PlainDataSource(sections: input)
        
        ds.forEach { (indexPath, value, stop) in
            modify(&result, with: value, at: indexPath)
        }
        
        XCTAssertEqual(input, result)
    }
    
    func testIsEmpty() {
        
        // Given
        let ds = PlainDataSource<Int>(list: [])
        
        // When
        let isEmpty = ds.isEmpty
        
        // Then
        XCTAssertTrue(isEmpty)
    }
    
    func testIsNotEmpty() {
        
        // Given
        let ds = PlainDataSource(list: [1, 2, 3])
        
        // When
        let isEmpty = ds.isEmpty
        
        // Then
        XCTAssertFalse(isEmpty)
    }
}
