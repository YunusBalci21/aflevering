from types.Binding import Binding

type Parameters {
  sender : Binding
  receiver : Binding
}

service Computation ( params : Parameters ) {
  execution:sequential
  
  embed Console as console
  embed StringUtils as stringUtils
  embed Database as database

  inputPort ComputationIP {
    location: params.computation.location
    protocol: params.computation.protocol
    interfaces: SenderInterface   // EDIT
  }

  outputPort DBHandler {
    location: params.dbhandler.location
    protocol: params.dbhandler.protocol
    interfaces: 
  }
  
}