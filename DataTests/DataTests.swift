//
//  DataTests.swift
//  DataTests
//
//  Created by William on 20/03/22.
//

import XCTest
 

class RemoteAddAccount {
    private let url : URL
    private let httpClient : HttpPostClient?
    
    init(to url: URL, httpClient: HttpPostClient){
        self.url = url
        self.httpClient = httpClient
    }
    
    func add(){
        httpClient?.post(to: url)
    }
}

// Principio Liskov Substitution Principle
// A interface só precisa ter os metodos necessarios para sua implementaçao, torna mais composable
// Se necessario, o spy herda de vários protocolos

protocol HttpPostClient {
    func post(to url: URL)
}


class HTTPClientSpy: HttpPostClient {
    var url: URL?
    
    func post(to url: URL){
        self.url = url
    }
   
}


class DataTests: XCTestCase {
    
    func test_post_should_be_same_url() {

        let url = URL(string: "www.google.com.br")!
        let httpClientSpy = HTTPClientSpy()
        let sut = RemoteAddAccount(to: url, httpClient: httpClientSpy)
        sut.add()
        XCTAssertEqual(httpClientSpy.url, url)
    }
    
}
