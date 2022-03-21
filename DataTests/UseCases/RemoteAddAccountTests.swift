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
        sut.add(requestModel: addAccountModel){ _ in }
        XCTAssertEqual(httpClientSpy.urls, [url])
    }
    
    func test_post_should_be_same_data() {
        let addAccountModel = makeAddAccountModel()
        let (sut, httpClientSpy) = makeSut()
        sut.add(requestModel: makeAddAccountModel()){ _ in }
        XCTAssertEqual(httpClientSpy.data, addAccountModel.toData())
    }

func test_add_should_complete_with_error_if_client_fails() {
    let (sut, httpClientSpy) = makeSut()
    let exp = expectation(description: "waiting")
    sut.add(requestModel: makeAddAccountModel()){ error in
        XCTAssertEqual(error, .unexpected)
        exp.fulfill()
    }
    httpClientSpy.completeWithError(.noConnection)
    
    // wait volta ao callback e espera ele executar
    wait(for: [exp], timeout: 1)
}
}

// Principio Liskov Substitution Principle
// A interface só precisa ter os metodos necessarios para sua implementaçao -> torna mais COMPOSABLE
// Se necessario, o spy vai herdar de vários protocolos
extension RemoteAddAccountTests {
    class HttpClientSpy: HttpPostClient {
        var urls = [URL]()
        var data: Data?
        var onComplete: ((HttpError) -> Void)?
        
        func post(to url: URL, with data: Data?, onComplete: @escaping (HttpError) -> Void){
            self.urls.append(url)
            self.data = data
            self.onComplete = onComplete
        }
        func completeWithError(_ error: HttpError){
            onComplete?(.noConnection)
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

