//
//  API.swift
//  JFoudationRepository
//
//  Created by João Pedro Fabiano Franco on 07.09.23.
//

import Foundation

public enum RemoteDataSourceError: Error {
  case invalidRequest
  case decodeError
  case requestFailed
}

public class RemoteDataSource: DataSourceProtocol {
  let session: URLSession

  public init(session: URLSession = .shared) {
    self.session = session
  }

  public func fetch<T>(request: Requestable) async throws -> T where T: Decodable {
    guard let request = request.request else {
      throw RemoteDataSourceError.invalidRequest
    }

    let (data, _) = try await session.data(for: request)
    let decoder = JSONDecoder()

    do {
      return try decoder.decode(T.self, from: data)
    } catch {
      throw RemoteDataSourceError.decodeError
    }
  }

  public func post(request: Requestable) async throws {
    guard let request = request.request else {
      throw RemoteDataSourceError.invalidRequest
    }

    do {
      let (data, _) = try await session.data(for: request)
      if data.isEmpty { throw RemoteDataSourceError.requestFailed }
    } catch {
      throw RemoteDataSourceError.requestFailed
    }
  }
}
