//
//  PagingTableViewDelegate.swift
//  Zag
//
//  Created by thanos kottaridis on 3/3/22.
//

import UIKit
import Domain

public protocol PagingTableViewDelegate: UITableViewDelegate {
    var shouldIgnorePaging: Bool { get set }
    var pageSize: Int { get }
    
    func pagedTableView(
        _ tableView: UITableView,
        willDisplay cell: UITableViewCell,
        forRowAt indexPath: IndexPath
    )
    
    func loadNext()
    func loadPrevious()
}

extension PagingTableViewDelegate {
    
    public func pagedTableView(
        _ tableView: UITableView,
        willDisplay cell: UITableViewCell,
        forRowAt indexPath: IndexPath
    ) { }
    
    public func reloadDataAndKeepOffset(_ tableView: UITableView) {
        // stop scrolling
        tableView.setContentOffset(tableView.contentOffset, animated: false)
        
        // calculate the offset and reloadData
        let beforeContentSize = tableView.contentSize
        shouldIgnorePaging = true
//        DispatchQueue.main.async {[weak self] in

            tableView.reloadData()
            
            // # And then
            //  - Layout if needed
            // - And update content Offser
            tableView.layoutIfNeeded()
            let afterContentSize = tableView.contentSize
            
            // reset the contentOffset after data is updated
            let newOffset = CGPoint(
                x: tableView.contentOffset.x,
                y: tableView.contentOffset.y + (afterContentSize.height - beforeContentSize.height))
            
            print("PAGINATION DEBUG: reloadDataAndKeepOffset: newOffset: \(newOffset) beforeContentSize: \(beforeContentSize), afterContentSize: \(afterContentSize)")

            
            tableView.setContentOffset(newOffset, animated: false)
            
            self.shouldIgnorePaging = false
//        }
    }
    
    public func handlePagination(_ tableView: UITableView, forRowAt indexPath: IndexPath) {
        
        let testPageSize = self.pageSize
        var rows = 0
        var flattenRowPos = 0
        
        for section in 0..<tableView.numberOfSections {
            
            if section == indexPath.section {
                flattenRowPos = rows + indexPath.row
            }
            
            rows += tableView.numberOfRows(inSection: section)
        }
        
        let rowsAfter = rows - flattenRowPos - 1
        let rowsBefore = flattenRowPos
        
        // print debug
        print("SNAPSHOT DEBUG: PAGINATION DEBUG: willDisplay \(indexPath) totalRows: \(rows), rowsAfter: \(rowsAfter), rowsBefore: \(rowsBefore)")
        
        // check to load next page
        if rowsAfter < testPageSize {
            self.loadNext()
        }
        
        // check to load previous page
        if rowsBefore < testPageSize {
            self.loadPrevious()
        }
    }
}

/**
 # PagingDataSourceDelegate
 
 This Protocol is mostly conformed by viewModels that want to use pagination and provide them with all the necessary methods to communicate with PagingDataSource.
 */
public protocol PagingDataSourceDelegate: AnyObject {
    
    associatedtype Value
    
    func loadData(
        pageToFetch: Int,
        pageSize: Int,
        successCallback: @escaping ((PagedListResult<Value>) -> Void)
    )
    
    func loadInitial(result: PagedListResult<Value>)
    func loadNext(result: PagedListResult<Value>)
    func loadPrevious(result: PagedListResult<Value>)
}

/**
 # PagingDataSource
 
 This class is used in order to handle all business logic needed for a view model to perform pagination. Is able to perform both directional pagination by keeping track of most top and bottom pages. In order to be able to communicate with viewModels PagingDataSource requires an instance of PagingDataSourceDelegate with the same associated type the same type as the generic type of this class `Delegate.Value == Value`. In order to Create a configure a PagingDataSource instance properly use the `Builder` class provided by PagingDataSource
 */
public class PagingDataSource<Value, Delegate: PagingDataSourceDelegate>: NSObject where Delegate.Value == Value {
    
    private weak var delegate: Delegate?
    
    /// make configuration properties accessible to tableViewDelegate.
    public let pageSize: Int
    public let initialPageSize: Int
    public var initialPage: Int
    public let currentPage: PagedListResult<Value>
    
    private var topLoader: Bool = false
    private var topPage: PagedListResult<Value> = PagedListResult()
    private var bottomLoader: Bool = false
    private var bottomPage: PagedListResult<Value> = PagedListResult()
    
    /// # Initializer
    /// The initializer method requires all the configurations needed to perform pagination
    ///
    /// - Parameter delegate:  An object that conforms PagingDataSourceDelegate protocol and has as associated type the same type as the generic type of this class `Delegate.Value == Value`
    /// - Parameter pageSize: The number of items per page
    /// - Parameter initialPageSize: The number of items
    /// - Parameter currentPage: Current displayed page
    public init(
        delegate: Delegate?,
        pageSize: Int,
        initialPageSize: Int,
        initialPage: Int,
        currentPage: PagedListResult<Value>
    ) {
        self.delegate = delegate
        self.pageSize = pageSize
        self.initialPageSize = initialPageSize
        self.initialPage = initialPage
        self.currentPage = currentPage
    }
    
    /**
     # Load Data
     
     Load Data method called from loadInitial, loadPrevious and loadNext methods to fetch data from server or local DB. This method uses PagingDataSourceDelegate.loadData() method to perform the request
     */
    public func loadData(
        pageToFetch: Int,
        pagesize: Int? = nil,
        successCallback: @escaping ((PagedListResult<Value>) -> Void)
    ) {
        delegate?.loadData(
            pageToFetch: pageToFetch,
            pageSize: pagesize ?? pageSize, successCallback: { result in
                print("PAGINATION DEBUG: result pageToFetch: \(pageToFetch), pagesize: \(pagesize)")
                successCallback(result)
            }
        )
    }
    
    /**
     # Load Initial
     
     Load initial method called to fetch the initial data of the datasource (e.g on first run or after reload) It fetches the first / initial page from server or db using load data method. And then performs prefetching to fetch one next and one previous page (if exists). PagingDataSource target is to be always one page ahead from user scrolling in both directions.
     */
    public func loadInitial() {
        // reset top and bottom loaders
        topLoader = false
        bottomLoader = false
        
        print("PAGINATION DEBUG: Load initial called")
        loadData(
            pageToFetch: initialPage, pagesize: initialPageSize) { [weak self] response in
                // cache first and last page
                self?.topPage = response
                self?.bottomPage = response
                
                var totalData = response.results
                
                let group = DispatchGroup()
                group.enter()
                self?.loadInitialNext(successCallback: { response in
                    if let results = response?.results {
                        totalData += results
                    }
                    group.leave()
                })
                group.enter()
                self?.loadInitialPrevious(successCallback: { response in
                    if let results = response?.results {
                        totalData = results + totalData
                    }
                    group.leave()
                })
                
                
                group.notify(queue: .main) {
                    let result = PagedListResult(results: totalData, next: self?.bottomPage.next, previous: self?.topPage.previous, current: self?.initialPage, total: totalData.count)
                    self?.delegate?.loadInitial(result: result)
                }
            }
    }
    
    /**
     # Load Next
     
     This method is used to fetch the next page using loadData method if datasource not already performing another next request, caches the response in `bottomPage` and notify datasource delegate that next page fetched.
     */
    public func loadNext() {
        print("PAGINATION DEBUG: Load next called")
        guard let next = bottomPage.next, next != bottomPage.current, !bottomLoader
        else {
            print("PAGINATION DEBUG: load next canceled bottomLoader in progress")
            return
        }
        bottomLoader = true
        loadData(pageToFetch: next) { [weak self] response in
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                
                // cache first and last page
                self.bottomPage = response
                
                // update delegate that load next completed
                self.delegate?.loadNext(result: response)
                
                // stop next loader
                self.bottomLoader = false
            }
        }
    }
    
    /**
     # Load Previous
     
     This method is used to fetch the previous page using loadData method if datasource not already performing another previous request, caches the response in `topPage` and notify datasource delegate that previous page fetched.
     */
    public func loadPrevious() {
        print("PAGINATION DEBUG: Load previous called")
        guard let previous = topPage.previous, previous != topPage.current, !topLoader
        else {
            print("PAGINATION DEBUG: load Previous canceled topLoader in progress")
            return
        }
        
        topLoader = true
        
        loadData(pageToFetch: previous) { [weak self] response in
    
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                // cache first and last page
                self.topPage = response
                
                // update delegate that load previous completed
                self.delegate?.loadPrevious(result: response)
                
                // stop previous loader
                self.topLoader = false
            }
        }
    }
    
    // MARK: - Builder
    /// This Builder class is a helper in order to create a PagingDataSource object with proper configurations.
    /// Builder requires delegate to exist
    public class Builder {
        private weak var delegate: Delegate?
        private var pageSize: Int = 20
        private var initialPageSize: Int = 20
        private var initialPage: Int = 0
        private var currentPage: PagedListResult<Value> = PagedListResult()
        
        public init(delegate: Delegate) {
            self.delegate = delegate
        }
        
        public func setPageSize(pageSize: Int) -> Self {
            self.pageSize = pageSize
            return self
        }
        
        public func setInitialPageSize(initialPageSize: Int) -> Self {
            self.initialPageSize = initialPageSize
            return self
        }
        
        public func setInitialPage(initialPage: Int) -> Self {
            self.initialPage = initialPage
            return self
        }
        
        public func setCurrentPage(
            currentPage:  PagedListResult<Value>) -> Self {
            self.currentPage = currentPage
            return self
        }
        
        public func build() -> PagingDataSource {
            return PagingDataSource(
                delegate: delegate,
                pageSize: pageSize,
                initialPageSize: initialPageSize,
                initialPage: initialPage,
                currentPage: currentPage
            )
        }
    }
}

extension PagingDataSource {
    private func loadInitialNext(successCallback: @escaping ((PagedListResult<Value>?) -> Void)) {
        print("PAGINATION DEBUG: Load next called")
        guard let next = bottomPage.next, next != bottomPage.current, !bottomLoader
        else {
            print("PAGINATION DEBUG: load next canceled bottomLoader in progress")
            successCallback(nil)
            return
        }
        bottomLoader = true
        loadData(pageToFetch: next) { [weak self] response in
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                
                // cache first and last page
                self.bottomPage = response
                
                successCallback(response)
                
                // stop next loader
                self.bottomLoader = false
            }
        }
    }
    
    /**
     # Load Previous
     
     This method is used to fetch the previous page using loadData method if datasource not already performing another previous request, caches the response in `topPage` and notify datasource delegate that previous page fetched.
     */
    private func loadInitialPrevious(successCallback: @escaping ((PagedListResult<Value>?) -> Void)) {
        print("PAGINATION DEBUG: Load previous called")
        guard let previous = topPage.previous, previous != topPage.current, !topLoader
        else {
            print("PAGINATION DEBUG: load Previous canceled topLoader in progress")
            successCallback(nil)
            return
        }
        
        topLoader = true
        
        loadData(pageToFetch: previous) { [weak self] response in
    
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                // cache first and last page
                self.topPage = response
                
                successCallback(response)
                
                // stop previous loader
                self.topLoader = false
            }
        }
    }
}

public enum PagingLoadType: String, Equatable {
    case initial
    case next
    case previous
    case none
}
