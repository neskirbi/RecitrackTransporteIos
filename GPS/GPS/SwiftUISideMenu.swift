//
//  SwiftUIView.swift
//  GPS
//
//  Created by Johnne Lemand on 26/04/22.
//

import SwiftUI

struct MenuItem: Identifiable{
    var id = UUID()
    let text: String
    let imageName : String
    let handler:() -> Void = {
        print("Tapped item")
    }
}

struct MenuContent : View{
    
    let items: [MenuItem] = [
        MenuItem(text: "Home", imageName : "house"),
        MenuItem(text: "Transportar",imageName : "bus"),
        MenuItem(text: "Viajes",imageName : "list.number"),
        MenuItem(text: "Salir",imageName : "arrow.right.square.fill"),
        
    ]
        
    var body: some View{
        VStack{
            Image("logotransporte")
                .resizable()
                .scaledToFit()
                .frame(width: 145, height: 145, alignment: .bottom)
                .padding(.top,35)
                Text("Recitrack Transporte")
                    .bold()
                    
        
        ZStack{
            Color(UIColor(red: 33/255.0, green: 33/255.0, blue: 33/255.0, alpha: 1))
            
            VStack(alignment: .leading, spacing: 0){
                ForEach(items) {item in
                    HStack{
                        Image(systemName: item.imageName)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(.white)
                            .frame(width: 24, height: 24, alignment: .center)
                        
                        Text(item.text)
                            .foregroundColor(Color.white)
                            .bold()
                            .font(.system(size: 22))
                            .multilineTextAlignment(.leading)
                        
                            Spacer()
                        }
                    .onTapGesture{
                        
                    }
                    .padding()
                    
                    Divider()
                    
                    }
                
                Spacer()
                }
            
            .padding(.top, 25)
            
            }
    
        }
    }
}
struct SideMenu : View{
    let width:  CGFloat
    let menuOpened: Bool
    let toggleMenu: () -> Void
    
    var body: some View{
        ZStack{
            //Dimmed background view
            GeometryReader{ _ in
                EmptyView ()
                
            }
            .background(Color.gray.opacity(0.10))
            .opacity(self.menuOpened ? 1: 0)
            .animation(Animation.easeIn.delay(0.25))
            .onTapGesture{
                self.toggleMenu()
            }
            
            //Menu Content
            HStack{
                MenuContent()
                    .frame(width: width)
                    .offset(x: menuOpened ? -0 : -width)
                    .animation(.default)
                
                Spacer()
            }
        }
        
    }
}

struct SwiftUIView: View {
 
@State var menuOpened = false
    
    var body: some View {
        ZStack{
            if !menuOpened{
            Button(action: {
                //open menu
                self.menuOpened.toggle()
            }, label: {
                Text("Open Menu")
                    .bold()
                    .foregroundColor(Color.white)
                    .frame(width: 200, height: 50, alignment: .center)
                    .background(Color(.systemBlue))
                
            })
            
            }
            
            SideMenu(width: UIScreen.main.bounds.width/1.6,
                     menuOpened: menuOpened,
                     toggleMenu: toggleMenu)
        }
        
        .edgesIgnoringSafeArea(.all)
        
    }
    func toggleMenu(){
        menuOpened.toggle()
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
            .preferredColorScheme(.dark)
    }
}
