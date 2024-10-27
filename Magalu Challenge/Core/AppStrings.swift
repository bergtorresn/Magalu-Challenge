//
//  AppStrings.swift
//  Magalu Challenge
//
//  Created by Rosemberg Torres on 26/10/24.
//

import Foundation

class AppStrings {
    
    // ========== STATE STRINGS
    static let stateLoading = "Loading"
    
    // ========== API STRINGS
    static let baseURL: String = "https://api.github.com/"
    static let endpointpopularRepositories: String = "search/repositories"
    static let endpointPullRequests: String = "repos/ownerName/repositoryName/pulls"
    static let decodeError: String = "Decode Error"
    static let notFoundError: String = "Not Found"
    static let serverError: String = "Server Error"
    static let unknownError: String = "Unknown Error"
    
    
    // ========== PULL REQUEST VIEW STRINGS
    
    static let navigationTitle: String = "Repositories"

}
