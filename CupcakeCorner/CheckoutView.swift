//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by Taijaun Pitt on 18/03/2025.
//

import SwiftUI

struct CheckoutView: View {
    var order: Order
    
    @State private var confirmationMessage = ""
    @State private var showingConfirmation = false
    @State private var orderFailed = false
    
    
    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: URL(string: "https://hws.dev/img/cupcakes@3x.jpg"), scale: 3) { image in
                    
                    image
                        .resizable()
                        .scaledToFit()
                    
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 233)
                
                Text("Your total cost is \(order.cost, format: .currency(code: "GBP"))")
                    .font(.title)
                
                Button("Place Order"){
                    Task {
                        await placeOrder()
                    }
                }
                    .padding()
            }
        }
        .navigationTitle("Check out")
        .navigationBarTitleDisplayMode(.inline)
        .scrollBounceBehavior(.basedOnSize)
        .alert("Thank you!", isPresented: $showingConfirmation){
            Button("Ok!"){}
        } message: {
            Text(confirmationMessage)
        }
        .alert("Something went wrong", isPresented: $orderFailed){
            Button("Ok!"){}
        } message: {
            Text(confirmationMessage)
        }
    }
    
    func placeOrder() async {
        
        guard let encoded = try? JSONEncoder().encode(order) else {
            print("Failed to encode order")
            return
        }
        
        // create new url Request, configure to send json using Post request
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        //request.httpMethod = "POST"
        
        // Make post request
        do {
            let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)
            // handle result
            let decodedOrder = try JSONDecoder().decode(Order.self, from: data)
            confirmationMessage = "Your order for \(decodedOrder.quantity)x \(Order.types[decodedOrder.type].lowercased()) cupcakes is on its way!"
            showingConfirmation = true
        } catch {
            print("Check out failed: \(error.localizedDescription)")
            orderFailed = true
            confirmationMessage = "Check out has failed: \(error.localizedDescription)"
        }
    }
}

#Preview {
    CheckoutView(order: Order())
}
