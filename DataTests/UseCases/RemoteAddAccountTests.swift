//
//  DataTests.swift
//  DataTests
//
//  Created by William on 20/03/22.
//

import XCTest
import Domain
import Data
 
class RemoteAddAccountTests: XCTestCase {
    
    func test_post_should_be_same_url() {
        let url = URL(string: "www.google.com.br")!
        let (sut, httpClientSpy) = makeSut(url: url)
        let addAccountModel = makeAddAccountModel()
        sut.add(requestModel: addAccountModel)
        XCTAssertEqual(httpClientSpy.urls, [url])
    }
    
    func test_post_should_be_same_data() {
        let addAccountModel = makeAddAccountModel()
        let (sut, httpClientSpy) = makeSut()
        sut.add(requestModel: makeAddAccountModel())
        XCTAssertEqual(httpClientSpy.data, addAccountModel.toData())
    }
}

// Principio Liskov Substitution Principle
// A interface só precisa ter os metodos necessarios para sua implementaçao, torna mais composable
// Se necessario, o spy herda de vários protocolos


extension RemoteAddAccountTests {
    class HttpClientSpy: HttpPostClient {
        var urls = [URL]()
        var data: Data?
        
        func post(to url: URL, with data: Data?){
            self.urls.append(url)
            self.data = data
        }
    }
    //DesignPattern FACTORY
    func makeAddAccountModel() -> AddAccountModel {
        return AddAccountModel(name: "xx", email: "xx", password: "xx", passwordConfirmation: "xx")
    }
    
    func makeSut(url: URL = URL(string: "www.google.com.br")!) -> (sut: RemoteAddAccount, httpClientSpy: HttpClientSpy){
        let httpClientSpy = HttpClientSpy()
        let sut = RemoteAddAccount(to: url, httpClient: httpClientSpy)
        
        return (sut, httpClientSpy)
    }
}

