//
//  File.swift
//  
//
//  Created by Joao Pedro Franco on 15/07/24.
//

import Foundation

public protocol FlickrServiceProtocol {
	func getImage() async throws -> String
}

public class FlickrService: FlickrServiceProtocol {
	var dataSource: RemoteDataSource
	
	public init(dataSource: RemoteDataSource = RemoteDataSource()) {
		self.dataSource = dataSource
	}
	
	public func getImage() async throws -> String {
		"workers"
	}
}
