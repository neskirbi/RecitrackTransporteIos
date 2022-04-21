//
//  ContentView.swift
//  GPS
//
//  Created by Johnne Lemand on 08/04/22.
//

import SwiftUI
import FirebaseAuth

class AppViewModel: ObservableObject {
    
    
    let auth = Auth.auth()
    
    @Published var signedIn = false
    
    var isSignedIn: Bool {
        return auth.currentUser != nil
    }
    
    func signIn(email: String, password: String){
        auth.signIn(withEmail: email,
                    password: password) { [weak self] result, error in
            guard result != nil,error == nil else{
                return
            }
            
            DispatchQueue.main.async {
               
                self?.signedIn = true
            }
            
        }
    }
    
    func signUp(email: String, password: String){
        auth.createUser(withEmail: email, password: password) { [weak self] result, error in
            guard result != nil,error == nil else{
                return
            }
            
            DispatchQueue.main.async {
                //success
                self?.signedIn = true
            }
        }
    }
    
    func signOut() {
        try? auth.signOut()
        
        self.signedIn = false
    }
}



struct ContentView: View {
    @EnvironmentObject var viewModel: AppViewModel
    
    var body: some View {
        NavigationView{
            if viewModel.signedIn{
                VStack{
                Text("Registro Exitoso")
                
                Button(action: {
                    viewModel.signOut()
                }, label: {
                    Text("Sign Out")
                        .frame(width: 200, height: 50)
                        .background(Color.green)
                        .foregroundColor(Color.blue)
                        .padding()
                    })
                }
            }
            else{
                SignInView()
            }
        }
        
        .onAppear {
            viewModel.signedIn = viewModel.isSignedIn
        }
    }
}

struct SignInView: View {
    @State var email: String = ""
    @State var password: String = ""
    
    @EnvironmentObject var viewModel: AppViewModel
    
   
    
    var body: some View {
        VStack{
                Image("logotransporte")
                    
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                    .padding()
                    
                
                VStack{
                    TextField("Teléfono", text:$email )
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .padding()
                    
                    SecureField("Contraseña", text:$password )
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .padding()
                        
                    
                    
                    Button(action: {
                        
                        guard !email.isEmpty, !password.isEmpty else{
                            return
                        }
                        
                        viewModel.signIn(email: email, password: password)
                        
                    }, label: {
                        Text("Enviar")
                            .foregroundColor(Color.white)
                            .frame(width: 200, height: 50)
                            .background(Color.blue)
                            .cornerRadius(10)
                            .padding()
                    })
                    
                    NavigationLink("Registrar", destination: SignUpView())
                        .padding()
                    
                }
                .padding()
                
                
                Spacer()
            }
             
            .navigationTitle("")
            
        
    }
}

struct SignUpView: View {
    
    @EnvironmentObject var viewModel: AppViewModel
    
    @State var email: String = ""
    @State var password: String = ""
    
    var body: some View {
        VStack{
                Image("logotransporte")
                    
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                    .padding()
                    
                
                VStack{
                    TextField("Teléfono", text:$email )
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .padding()
                    
                    SecureField("Contraseña", text:$password )
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .padding()
                        
                    
                    
                    Button(action: {
                        
                        guard !email.isEmpty, !password.isEmpty else{
                            return
                        }
                        
                        viewModel.signUp(email: email, password: password)
                        
                    }, label: {
                        Text("Registar")
                            .foregroundColor(Color.white)
                            .frame(width: 200, height: 50)
                            .background(Color.blue)
                            .cornerRadius(10)
                            .padding()
                    })
                    
                }
                .padding()
                
                
                Spacer()
            }
             
            .navigationTitle("")
            
        
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
        }
    }

