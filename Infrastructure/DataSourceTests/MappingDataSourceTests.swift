//
//  Created by Joachim Kret on 17.05.2018.
//  Copyright © 2018 eSky. All rights reserved.
//

import XCTest
import DataSource

class MappingDataSourceTests: XCTestCase {
    
    func testInitializeMapDataSource() {
        
        let source = PlainDataSource(list: [4, 3, 5, 8, 9])
        
        let ds = MappingDataSource(source: source, transform: { String($0) })
        
        XCTAssertEqual(ds.numberOfSections(), 1)
        XCTAssertEqual(ds.numberOfItemsInSection(0), 5)
        XCTAssertEqual(ds.numberOfItemsInSection(1), 0)
        
        XCTAssertEqual(ds.item(at: IndexPath(item: 0, section: 0)), "4")
        XCTAssertEqual(ds.item(at: IndexPath(item: 1, section: 0)), "3")
        XCTAssertEqual(ds.item(at: IndexPath(item: 2, section: 0)), "5")
        XCTAssertEqual(ds.item(at: IndexPath(item: 3, section: 0)), "8")
        XCTAssertEqual(ds.item(at: IndexPath(item: 4, section: 0)), "9")
    }
    
    func testEnumerate() {
        
        func modify<T>(_ input: inout [[T]], with value: T, at indexPath: IndexPath) {
            if input.count > indexPath.section {
                if input[indexPath.section].count > indexPath.row {
                    input[indexPath.section][indexPath.row] = value
                }
            }
        }
        
        let input = [
            [5, 4, 6, 7, 3],
            [3, 4, 5, 2, 1],
            [0, 5, 6, 1, 9]
        ]
        
        var result = [
            ["0", "0", "0", "0", "0"],
            ["0", "0", "0", "0", "0"],
            ["0", "0", "0", "0", "0"]
        ]
        
        let source = PlainDataSource(sections: input)
        
        let ds = MappingDataSource(source: source, transform: { String($0) })
        
        ds.forEach { (indexPath, value, stop) in
            modify(&result, with: value, at: indexPath)
        }
        
        let compare = input.map { $0.map { String($0) } }
        
        XCTAssertEqual(compare, result)
    }
    
    func testIsEmpty() {
    
        // Given
        let source = PlainDataSource<Int>(list: [])
        
        let ds = MappingDataSource(source: source, transform: { String($0) })
        
        // When
        let isEmpty = ds.isEmpty
        
        // Then
        XCTAssertTrue(isEmpty)
    }
    
    func testIsNotEmpty() {
        
        // Given
        let source = PlainDataSource<Int>(list: [1, 2, 3])
        
        let ds = MappingDataSource(source: source, transform: { String($0) })
        
        // When
        let isEmpty = ds.isEmpty
        
        // Then
        XCTAssertFalse(isEmpty)
    }
}
