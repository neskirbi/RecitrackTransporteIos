//
//  ContentView.swift
//  GPS
//
//  Created by Johnne Lemand on 08/04/22.
//

import SwiftUI
import FirebaseAuth

class AppViewModel: ObservableObject{
    
    let auth = Auth.auth()
    
    @Published var signedIn = false
    
    var isSignedIn: Bool {
        return auth.currentUser != nil
    }
    
    func signIn(email: String, password:String) {
        auth.signIn(withEmail: email,
                    password: password) {[ weak self] result, error in
            guard result != nil, error == nil else {
                return
            }
            DispatchQueue.main.async {
                
                //Success
                self?.signedIn = true
            }
           
        }
    }
    func signUp(email: String, password:String) {
        auth.createUser(withEmail: email,
                        password: password) {[weak self] result, error in
            guard result != nil, error == nil else {
                return
            }
            DispatchQueue.main.async {
                
                //Success
                self?.signedIn = true
            }
        }
    }
}

struct ContentView: View{
    @State var email = ""
    @State var password = ""
    
    @EnvironmentObject var viewModel: AppViewModel
    
    var body : some View{
        NavigationView{
            VStack{
                Image("logotransporte")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                    .padding()
                    
                VStack{
                    TextField("Teléfono", text: $email)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        
                    
                    SecureField("Contraseña", text: $password)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                    
                        
                    
                    Button(action: {
                        
                        guard !email.isEmpty, !password.isEmpty else{
                            return
                        }
                        
                        viewModel.signIn(email: email, password: password)
                        
                    }, label: {
                        Text("Enviar")
                            .foregroundColor(Color.white)
                            .frame(width: 200, height: 50)
                            .cornerRadius(8)
                            .background(Color.blue)
                            .padding()
                    })
                }
                .padding()
                
                Spacer()
            }
            
        }
    }
}

struct SignInView: View{
    @State var email = ""
    @State var password = ""
    
    @EnvironmentObject var viewModel: AppViewModel
    
    var body : some View{
        NavigationView{
            VStack{
                Image("logotransporte")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                    .padding()
                    
                VStack{
                    TextField("Teléfono", text: $email)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        
                    
                    SecureField("Contraseña", text: $password)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                    
                        
                    
                    Button(action: {
                        
                        guard !email.isEmpty, !password.isEmpty else{
                            return
                        }
                        
                        viewModel.signIn(email: email, password: password)
                        
                    }, label: {
                        Text("Enviar")
                            .foregroundColor(Color.white)
                            .frame(width: 200, height: 50)
                            .cornerRadius(8)
                            .background(Color.blue)
                            .padding()
                    })
                    
                    NavigationLink("Registrar", destination: SignUpView())
                        .padding()
                }
                .padding()
                
                Spacer()
            }
            
        }
    }
}


struct SignUpView: View{
    @State var email = ""
    @State var password = ""
    
    @EnvironmentObject var viewModel: AppViewModel
    
    var body : some View{
        NavigationView{
            VStack{
                Image("logotransporte")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                    .padding()
                    
                VStack{
                    TextField("Teléfono", text: $email)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        
                    
                    SecureField("Contraseña", text: $password)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                    
                        
                    
                    Button(action: {
                        
                        guard !email.isEmpty, !password.isEmpty else{
                            return
                        }
                        
                        viewModel.signUp(email: email, password: password)
                        
                    }, label: {
                        Text("Registrar")
                            .foregroundColor(Color.white)
                            .frame(width: 200, height: 50)
                            .cornerRadius(8)
                            .background(Color.blue)
                            .padding()
                    })
                }
                .padding()
                
                Spacer()
            }
            
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
        }
    }


