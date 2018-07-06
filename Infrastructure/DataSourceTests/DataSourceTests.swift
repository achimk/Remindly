//
//  Created by Joachim Kret on 11.05.2018.
//  Copyright © 2018 eSky. All rights reserved.
//

import XCTest
import DataSource

class DataSourceTests: XCTestCase {
    
    func testUsingPlainFactoryForOneElement() {
        
        let ds = DataSource.using(element: 3)
        
        XCTAssertEqual(ds.numberOfSections(), 1)
        XCTAssertEqual(ds.numberOfItemsInSection(0), 1)
        XCTAssertEqual(ds.numberOfItemsInSection(1), 0)
        XCTAssertEqual(ds.item(at: IndexPath(item: 0, section: 0)), 3)
    }
    
    func testUsingPlainFactoryForListOfElements() {
        
        let ds = DataSource.using(list: [3, 2, 1])
        
        XCTAssertEqual(ds.numberOfSections(), 1)
        XCTAssertEqual(ds.numberOfItemsInSection(0), 3)
        XCTAssertEqual(ds.numberOfItemsInSection(1), 0)
        XCTAssertEqual(ds.item(at: IndexPath(item: 0, section: 0)), 3)
        XCTAssertEqual(ds.item(at: IndexPath(item: 1, section: 0)), 2)
        XCTAssertEqual(ds.item(at: IndexPath(item: 2, section: 0)), 1)
    }
    
    func testUsingPlainFactoryForManyListsOfElements() {
     
        let ds = DataSource.using(sections: [
            [1, 1, 1],
            [2],
            [3, 3]
        ])
        
        XCTAssertEqual(ds.numberOfSections(), 3)
        XCTAssertEqual(ds.numberOfItemsInSection(0), 3)
        XCTAssertEqual(ds.numberOfItemsInSection(1), 1)
        XCTAssertEqual(ds.numberOfItemsInSection(2), 2)
        XCTAssertEqual(ds.numberOfItemsInSection(3), 0)
        
        XCTAssertEqual(ds.item(at: IndexPath(item: 0, section: 0)), 1)
        XCTAssertEqual(ds.item(at: IndexPath(item: 1, section: 0)), 1)
        XCTAssertEqual(ds.item(at: IndexPath(item: 2, section: 0)), 1)
        
        XCTAssertEqual(ds.item(at: IndexPath(item: 0, section: 1)), 2)
        
        XCTAssertEqual(ds.item(at: IndexPath(item: 0, section: 2)), 3)
        XCTAssertEqual(ds.item(at: IndexPath(item: 1, section: 2)), 3)
    }
    
    func testUsingOfFactory() {
        
        let ds = DataSource.of([5, 3, 6, 8, 2, 7, 7])
        
        XCTAssertEqual(ds.numberOfSections(), 1)
        XCTAssertEqual(ds.numberOfItemsInSection(0), 7)
        XCTAssertEqual(ds.numberOfItemsInSection(1), 0)
        
        XCTAssertEqual(ds.item(at: IndexPath(item: 0, section: 0)), 5)
        XCTAssertEqual(ds.item(at: IndexPath(item: 1, section: 0)), 3)
        XCTAssertEqual(ds.item(at: IndexPath(item: 2, section: 0)), 6)
        XCTAssertEqual(ds.item(at: IndexPath(item: 3, section: 0)), 8)
        XCTAssertEqual(ds.item(at: IndexPath(item: 4, section: 0)), 2)
        XCTAssertEqual(ds.item(at: IndexPath(item: 5, section: 0)), 7)
        XCTAssertEqual(ds.item(at: IndexPath(item: 6, section: 0)), 7)
    }
    
    func testUsingFlattenFactory() {
        
        let ds1 = PlainDataSource(sections: [
            [1, 2],
            [3]
        ])
        let ds2 = PlainDataSource(list: [4, 4, 4])
        let ds3 = PlainDataSource(element: 5)
        
        let ds = DataSource.flatten(of: [ds1, ds2, ds3])
        
        XCTAssertEqual(ds.numberOfSections(), 1)
        XCTAssertEqual(ds.numberOfItemsInSection(0), 7)
    }
    
    func testCreateEmptyFlattingDataSource() {
        
        let ds: DataSource<Int> = DataSource.flatten()
        
        XCTAssertEqual(ds.numberOfSections(), 0)
        XCTAssertEqual(ds.numberOfItemsInSection(0), 0)
    }
    
    func testUsingCombinedFactory() {
        
        let ds1 = PlainDataSource(sections: [
            [1, 2],
            [3]
            ])
        let ds2 = PlainDataSource(list: [4, 4, 4])
        let ds3 = PlainDataSource(element: 5)
        
        let ds = DataSource.combined(of: [ds1, ds2, ds3])
        
        XCTAssertEqual(ds.numberOfSections(), 4)
        XCTAssertEqual(ds.numberOfItemsInSection(0), 2)
        XCTAssertEqual(ds.numberOfItemsInSection(1), 1)
        XCTAssertEqual(ds.numberOfItemsInSection(2), 3)
        XCTAssertEqual(ds.numberOfItemsInSection(3), 1)
    }
    
    func testCreateEmptyCombinedDataSource() {
     
        let ds: DataSource<Int> = DataSource.combined()
        
        XCTAssertEqual(ds.numberOfSections(), 0)
        XCTAssertEqual(ds.numberOfItemsInSection(0), 0)
    }
    
    func testUsingMapFunction() {
        
        let ds = DataSource.of([4, 6, 1]).map { String($0) }
        
        XCTAssertEqual(ds.numberOfSections(), 1)
        XCTAssertEqual(ds.numberOfItemsInSection(0), 3)
        XCTAssertEqual(ds.numberOfItemsInSection(1), 0)
        
        XCTAssertEqual(ds.item(at: IndexPath(item: 0, section: 0)), "4")
        XCTAssertEqual(ds.item(at: IndexPath(item: 1, section: 0)), "6")
        XCTAssertEqual(ds.item(at: IndexPath(item: 2, section: 0)), "1")
    }
    
    func testUsingAsPlainFunction() {

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
        
        let plain = ds.asPlain()
        
        plain.forEach { (indexPath, value, stop) in
            modify(&result, with: value, at: indexPath)
        }
        
        XCTAssertEqual(input, result)
    }
    
    private func modify<T>(_ input: inout [[T]], with value: T, at indexPath: IndexPath) {
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
}
