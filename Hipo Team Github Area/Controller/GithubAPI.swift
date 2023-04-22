//
//  GithubAPI.swift
//  Hipo Team Github Area
//
//  Created by Kaan Uslu on 21.04.2023.
//

import Foundation

class GitHubAPI {
    private let baseURL = "https://api.github.com/users/"
    
    func fetchUserInfo(username: String, completion: @escaping (Result<UserInfo, Error>) -> Void) {
        let userInfoURL = "\(baseURL)\(username)"
        
        guard let url = URL(string: userInfoURL) else {
            completion(.failure(GitHubAPIError.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(GitHubAPIError.noData))
                return
            }
            
            do {
                let userInfo = try JSONDecoder().decode(UserInfo.self, from: data)
                print(userInfo)
                completion(.success(userInfo))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    func fetchPublicRepos(username: String, completion: @escaping (Result<[Repository], Error>) -> Void) {
        let reposURL = "\(baseURL)\(username)/repos"
        
        guard let url = URL(string: reposURL) else {
            completion(.failure(GitHubAPIError.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(GitHubAPIError.noData))
                return
            }
            
            do {
                let repositories = try JSONDecoder().decode([Repository].self, from: data)
                completion(.success(repositories))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }

    
    enum GitHubAPIError: Error {
        case invalidURL
        case noData
    }
}
