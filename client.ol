from types.Binding import Binding

type Parameters {
  sender : Binding
  receiver : Binding
}

service Client ( params : Parameters ) {
  execution:sequential
  
  embed Console as console
  embed StringUtils as stringUtils
  embed Database as database

  outputPort Authenticator {
    location: params.auth.location
    protocol: params.auth.protocol
    interfaces: SenderInterface   // EDIT
  }
  
  outputPort Users {
    location: params.users.location
    protocol: params.users.protocol
    interfaces: ReceiverInterface   // EDIT
  }

}