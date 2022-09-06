//
//  LoginView.swift
//  inzoGame
//
//  Created by Yunus Gündüz on 6.09.2022.
//

import SwiftUI
import Alamofire
struct LoginView: View {
    
    @State private var username:String = ""
    @State private var password:String = ""
    @State private var sayfaGecis:Bool = false
    @State private var showModal = false
    var body: some View {
        NavigationView{
            Form{
               
                TextField("username",text:$username)
                
                SecureField("password",text:$password)
               
                    Button("GIRIS YAP") {
                        print("Debug Username : \(username)")
                        print("Debug Password : \(password)")
                        AF.request("http://yunusgunduz.site/inzoApi/public/api/login?username=\(username)&password=\(password)", method:.post,encoding: JSONEncoding.default) .responseJSON { [self] (response) in
                            
                            
                            if response.response?.statusCode == 200{
                                let data = response.data!
                                
                                let object = try? JSONSerialization.jsonObject(with: data, options: [])

                                let jsonObject =  object as? [String: Any]

                                let tokenField   = jsonObject?["access_token"] as? String
                                
                                let stateField   = jsonObject?["message"] as? String
                                
                               
                                if stateField == "success"{
                                    
                                    sayfaGecis = true
                                   
                        }
                    }
                    }
                        
                    }
                
               
               
                
            }.navigationTitle("Login").fullScreenCover(isPresented: $sayfaGecis) { MainView() }
            
        }
        
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
