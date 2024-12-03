from types.Binding import Binding

type Parameters {
    sender : Binding
    receiver : Binding
}

service Authenticator ( params : Parameters ) {
    execution:sequential
    
    inputPort auth {
        location: params.auth.location
        protocol: params.auth.protocol
        interfaces: 
    }

    outputPort ShopList {
        location: params.shoplist.location
        protocol: params.shoplist.protocol
        interfaces: SenderInterface   // EDIT
    }
  
    outputPort Users {
        location: params.users.location
        protocol: params.users.protocol
        interfaces: ReceiverInterface   // EDIT
    }

}