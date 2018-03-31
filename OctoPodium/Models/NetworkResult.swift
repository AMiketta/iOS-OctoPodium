//
//  NetworkResult.swift
//  OctoPodium
//
//  Created by Nuno Gonçalves on 31/03/2018.
//  Copyright © 2018 Nuno Gonçalves. All rights reserved.
//

enum NetworkResult<T> {

    case success(_: T)
    case failure(_: ApiResponse)
}

