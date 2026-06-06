//
//  HomeViewModel.swift
//  Andrea
//
//  Created by AlexGI on 05/06/2026.
//
import Foundation

@MainActor
@Observable
class HomeViewModel{
    private var repo: HomeRepository = HomeRepositoryImpl()
    var isLoading: Bool = false
    var data: [UserDTO] = []
    var me: UserDTO?
    
    init() {
        Task{
            await getMeData()
        }
    }
    
    
    func getData() async {
        isLoading = true

        do{
            let result = try await repo.feed()
            data = result
        }catch{
            print (error)
        }

        isLoading = false
    }
    
    func getMeData() async {
        do{
            let result = try await repo.me()
            me = result
        }catch{
            print (error)
        }
    }
}
