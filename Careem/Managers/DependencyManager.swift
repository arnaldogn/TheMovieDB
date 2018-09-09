//
//  DependencyManager.swift
//  Careem
//
//  Created by Arnaldo on 9/4/18.
//  Copyright © 2018 Arnaldo. All rights reserved.
//

import Swinject

public class DependencyManager {
    
    private lazy var container: Container = {
        let container = Container()
        container.register(APIManagerProtocol.self) { _ in APIManager() }.inObjectScope(.weak)
        container.register(SearchMoviesServiceProtocol.self) { _ in SearchMoviesService() }
        container.register(MovieCascadeManagerProtocol.self) {
            MovieCascadeManager(service: $0.resolve(SearchMoviesServiceProtocol.self)!)
        }
        container.register(SuggestionManagerProtocol.self) { _ in SuggestionsManager() }
        return container
    }()
    
    public static let shared = DependencyManager()
    
    public func bind<T>(interface: T.Type, to assembly: T) {
        container.register(interface) { _ in assembly }
    }
    
    public func resolve<T>(interface: T.Type) -> T! {
        return container.resolve(interface)
    }
    
    init() {}
}

public extension DependencyManager {
    
    static func bind<T>(interface: T.Type, to assembly: T) {
        DependencyManager.shared.bind(interface: interface, to: assembly)
    }
    
    static func resolve<T>(interface: T.Type) -> T! {
        return DependencyManager.shared.resolve(interface: interface)
    }
}

