from types.Binding import Binding

type Parameters {
    sender : Binding
    receiver : Binding
}

service User ( params : Parameters ) {

    execution:sequential
    
    inputPort Users {
        location: params.users.location
        protocol: params.users.protocol
        interfaces: 
    }

    inputPort UsersWithAuth {
        location: params.users.location
        protocol: params.users.protocol
        interfaces: 
    }

    outputPort Client {
        location: params.client.location
        protocol: params.client.protocol
        interfaces: SenderInterface   // EDIT
    }
  
    outputPort Authenticator {
        location: params.auth.location
        protocol: params.auth.protocol
        interfaces: ReceiverInterface   // EDIT
    }

}